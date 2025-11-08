#!/usr/bin/env python3

import yaml
import subprocess
import sys
import shutil
import os
from pathlib import Path
from collections import OrderedDict
from dotenv import load_dotenv

def flavor_filter(field_value, flavor):
    
    list = []
    flavors_dict = field_value['flavors']
    for flavors in flavor:
        if flavors_dict.get(flavors):
            value = flavors_dict.get(flavors)
            list = list + value

    # If there was no match on flavors, pick the first one.
    if not list:
        list = next(iter(flavors_dict.values()), None)
            
    return list



def subfilter(entry, tags=None, flavor=None):
    # To avoid issues with mutable default arguments
    tags = tags or []
    flavor = flavor or []
    
    
    
    entry = entry.copy()
    
    # Check all the sub fields to see if they have the flavors keyword
    for field_name, field_value in entry.items():
        if isinstance(field_value, dict) and 'flavors' in field_value:
            entry[field_name] = flavor_filter(field_value, flavor)
        
    inverse_tags = entry.get('itags', [])
    if inverse_tags and (set(tags) & set(inverse_tags)):
        print(f"  Skipping entry due to I-tags: {inverse_tags}")
        return None
    required_tags = entry.get('tags', [])
    if required_tags and not (set(tags) & set(required_tags)):
        print(f"  Skipping entry due to tags: {required_tags}")
        return None

    if required_tags:
        entry = entry.copy()
        entry.pop('tags', None)

    return entry

def filter_entries(entries, tags=None, flavor=None):
    """Filter out entries with show: false."""
    filtered = []
    for entry in entries:
        # Also check positions within an entry
        if isinstance(entry, dict) and 'positions' in entry:
            filtered_positions = []
            for pos in entry['positions']:
                filtered_pos = subfilter(pos, tags, flavor)
                if filtered_pos:
                    filtered_positions.append(filtered_pos)
            if filtered_positions:  # Only include entry if it has visible positions
                entry = entry.copy()
                entry['positions'] = filtered_positions
        
        entry = subfilter(entry, tags, flavor)          
        if entry:
            filtered.append(entry)

    return filtered

def get_rendercv_command():
    """Get the rendercv command path, preferring venv if available."""
    # Check if venv/bin/rendercv exists
    venv_rendercv = Path('venv') / 'bin' / 'rendercv'
    if venv_rendercv.exists():
        return str(venv_rendercv)
    # Fall back to system rendercv
    return 'rendercv'

def get_output_folder(variant_name):
    """Get the output folder path based on .env configuration."""
    output_dir = os.getenv('OUTPUT_DIR', '.')
    output_folder_template = os.getenv('OUTPUT_FOLDER_NAME', '{variant}_resume')
    output_folder_name = output_folder_template.format(variant=variant_name)

    # Combine output_dir and output_folder_name
    if output_dir == '.':
        return output_folder_name
    else:
        return str(Path(output_dir) / output_folder_name)

def create_variant(base_yaml, variant_name, config):
    """Create a CV variant by excluding specified sections."""
    exclude_sections = config['exclude_sections']

    # Use a custom YAML loader that preserves order
    def ordered_load(stream, Loader=yaml.SafeLoader, object_pairs_hook=OrderedDict):
        class OrderedLoader(Loader):
            pass
        def construct_mapping(loader, node):
            loader.flatten_mapping(node)
            return object_pairs_hook(loader.construct_pairs(node))
        OrderedLoader.add_constructor(yaml.resolver.BaseResolver.DEFAULT_MAPPING_TAG, construct_mapping)
        return yaml.load(stream, OrderedLoader)
    
    # Custom YAML dumper that preserves order
    def ordered_dump(data, stream=None, Dumper=yaml.SafeDumper, **kwds):
        class OrderedDumper(Dumper):
            pass
        def _dict_representer(dumper, data):
            return dumper.represent_mapping(yaml.resolver.BaseResolver.DEFAULT_MAPPING_TAG, data.items())
        OrderedDumper.add_representer(OrderedDict, _dict_representer)
        return yaml.dump(data, stream, OrderedDumper, **kwds)
    
    # Load the original YAML preserving order
    with open(base_yaml, 'r', encoding='utf-8') as f:
        cv_data = ordered_load(f)
    
    # Remove excluded sections and filter entries with show: false
    if 'cv' in cv_data and 'sections' in cv_data['cv']:
        sections = cv_data['cv']['sections']
        for section in exclude_sections:
            if section in sections:
                print(f"  Removing {section} section...")
                del sections[section]
        
        # Filter out entries with show: false in remaining sections
        for section_name, section_entries in sections.items():
            if isinstance(section_entries, list):
                sections[section_name] = filter_entries(section_entries, config['tags'], config['flavors'])
    
    # Create temporary YAML file
    temp_yaml = f"temp_{variant_name}_cv.yaml"
    with open(temp_yaml, 'w', encoding='utf-8') as f:
        ordered_dump(cv_data, f, default_flow_style=False, allow_unicode=True)
    
    # Render the CV
    output_folder = get_output_folder(variant_name)
    rendercv_cmd = get_rendercv_command()
    print(f"  Rendering to {output_folder}...")
    result = subprocess.run([
        rendercv_cmd, 'render', temp_yaml, '--output-folder-name', output_folder
    ], capture_output=True, text=True)
    
    # Clean up temp file
    Path(temp_yaml).unlink()
    
    if result.returncode == 0:
        print(f"  ✓ {variant_name.title()} resume created successfully!")
    else:
        print(f"  ✗ Error creating {variant_name} resume:")
        print(result.stderr)
    
    return result.returncode == 0

def load_variants():
    """Load variant configurations from YAML file."""
    # Try YAML first, fall back to JSON for backward compatibility
    yaml_config = "resume-variants.yaml"
    json_config = "resume-variants.json"

    config_file = yaml_config if Path(yaml_config).exists() else json_config

    if not Path(config_file).exists():
        print(f"Error: Configuration file not found!")
        print(f"  Looking for: {yaml_config} or {json_config}")
        sys.exit(1)

    try:
        with open(config_file, 'r', encoding='utf-8') as f:
            config = yaml.safe_load(f)

        # Ensure each variant has the required fields (with defaults)
        variants = config['variants']
        for variant_name, variant_config in variants.items():
            variant_config.setdefault('exclude_sections', [])
            variant_config.setdefault('tags', [])
            variant_config.setdefault('flavors', [])

        return variants
    except Exception as e:
        print(f"Error reading configuration: {e}")
        sys.exit(1)

def get_yaml_file():
    """Get the YAML file path based on .env configuration."""
    # Load environment variables
    load_dotenv()

    source_mode = os.getenv('SOURCE_MODE', 'local')
    yaml_file = os.getenv('YAML_FILE', 'CV.yaml')

    if source_mode == 'local':
        # Use local file
        yaml_path = Path(yaml_file)
        if not yaml_path.exists():
            print(f"Error: Local YAML file '{yaml_file}' not found!")
            sys.exit(1)
        return str(yaml_path)

    elif source_mode == 'remote':
        # Clone or update repository
        repo_url = os.getenv('REPO_URL')
        repo_branch = os.getenv('REPO_BRANCH', 'main')
        repo_local_dir = os.getenv('REPO_LOCAL_DIR', '.resume-data')

        if not repo_url:
            print("Error: REPO_URL must be set when SOURCE_MODE=remote")
            sys.exit(1)

        repo_path = Path(repo_local_dir)

        # Clone or pull repository
        if repo_path.exists():
            print(f"Updating repository in {repo_local_dir}...")
            result = subprocess.run(
                ['git', '-C', str(repo_path), 'pull', 'origin', repo_branch],
                capture_output=True,
                text=True
            )
            if result.returncode != 0:
                print(f"Warning: Failed to update repository: {result.stderr}")
                print("Using existing local copy...")
        else:
            print(f"Cloning repository from {repo_url}...")
            result = subprocess.run(
                ['git', 'clone', '-b', repo_branch, repo_url, str(repo_path)],
                capture_output=True,
                text=True
            )
            if result.returncode != 0:
                print(f"Error: Failed to clone repository: {result.stderr}")
                sys.exit(1)

        # Get YAML file from repository
        yaml_path = repo_path / yaml_file
        if not yaml_path.exists():
            print(f"Error: YAML file '{yaml_file}' not found in repository!")
            sys.exit(1)

        return str(yaml_path)

    else:
        print(f"Error: Invalid SOURCE_MODE '{source_mode}'. Must be 'local' or 'remote'")
        sys.exit(1)

def main():
    # Get YAML file from .env configuration
    base_yaml = get_yaml_file()

    # Load variants from JSON config
    variants = load_variants()
    
    # Parse command line arguments
    variant = sys.argv[1] if len(sys.argv) > 1 else "full"
    
    if variant not in variants:
        print("Usage: ./build-clean.py [variant]")
        print("Variants:")
        for name, info in variants.items():
            print(f"  {name:<12} - {info['description']}")
        sys.exit(1)
    
    config = variants[variant]
    print(f"Building {variant} resume: {config['description']}")
    
    if variant == "full":
        # Use a custom YAML loader that preserves order
        def ordered_load(stream, Loader=yaml.SafeLoader, object_pairs_hook=OrderedDict):
            class OrderedLoader(Loader):
                pass
            def construct_mapping(loader, node):
                loader.flatten_mapping(node)
                return object_pairs_hook(loader.construct_pairs(node))
            OrderedLoader.add_constructor(yaml.resolver.BaseResolver.DEFAULT_MAPPING_TAG, construct_mapping)
            return yaml.load(stream, OrderedLoader)
        
        # Custom YAML dumper that preserves order
        def ordered_dump(data, stream=None, Dumper=yaml.SafeDumper, **kwds):
            class OrderedDumper(Dumper):
                pass
            def _dict_representer(dumper, data):
                return dumper.represent_mapping(yaml.resolver.BaseResolver.DEFAULT_MAPPING_TAG, data.items())
            OrderedDumper.add_representer(OrderedDict, _dict_representer)
            return yaml.dump(data, stream, OrderedDumper, **kwds)
        
        # Filter out entries with show: false even for full variant
        with open(base_yaml, 'r', encoding='utf-8') as f:
            cv_data = ordered_load(f)
        
        # Filter entries in all sections
        if 'cv' in cv_data and 'sections' in cv_data['cv']:
            sections = cv_data['cv']['sections']
            for section_name, section_entries in sections.items():
                if isinstance(section_entries, list):
                    sections[section_name] = filter_entries(section_entries, config['tags'], config['flavors'])
        
        # Create temporary filtered YAML
        temp_yaml = "temp_full_cv.yaml"
        with open(temp_yaml, 'w', encoding='utf-8') as f:
            ordered_dump(cv_data, f, default_flow_style=False, allow_unicode=True)
        
        # Render the filtered CV
        output_folder = get_output_folder('full')
        rendercv_cmd = get_rendercv_command()
        result = subprocess.run([
            rendercv_cmd, 'render', temp_yaml, '--output-folder-name', output_folder
        ])
        
        # Clean up temp file
        Path(temp_yaml).unlink()
        sys.exit(result.returncode)
    else:
        # Create variant with excluded sections
        success = create_variant(base_yaml, variant, config)
        sys.exit(0 if success else 1)

if __name__ == "__main__":
    main()