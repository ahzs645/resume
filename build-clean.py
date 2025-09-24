#!/usr/bin/env python3

import yaml
import subprocess
import sys
import shutil
from pathlib import Path
from collections import OrderedDict

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
    """Filter out entries with show: false."""
    if isinstance(entry, dict) and entry.get('show', True) is False:
        return None
    
    entry = entry.copy()
    
    # Check all the sub fields to see if they have the flavors keyword
    for field_name, field_value in entry.items():
        if isinstance(field_value, dict) and 'flavors' in field_value:
            entry[field_name] = flavor_filter(field_value, flavor)
        

    required_tags = entry.get('tags', None)
    if  required_tags and tags and not (set(tags) & set(required_tags)):
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
    output_folder = f"{variant_name}_resume"
    print(f"  Rendering to {output_folder}...")
    result = subprocess.run([
        'rendercv', 'render', temp_yaml, '--output-folder-name', output_folder
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
    """Load variant configurations from JSON file."""
    config_file = "resume-variants.json"
    
    if not Path(config_file).exists():
        print(f"Error: Configuration file {config_file} not found!")
        sys.exit(1)
    
    try:
        with open(config_file, 'r', encoding='utf-8') as f:
            config = yaml.safe_load(f)  # JSON is valid YAML
        return config['variants']
    except Exception as e:
        print(f"Error reading configuration: {e}")
        sys.exit(1)

def main():
    base_yaml = "test.yaml"
    
    if not Path(base_yaml).exists():
        print(f"Error: {base_yaml} not found!")
        sys.exit(1)
    
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
        result = subprocess.run([
            'rendercv', 'render', temp_yaml, '--output-folder-name', 'full_resume'
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