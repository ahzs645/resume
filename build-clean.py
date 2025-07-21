#!/usr/bin/env python3

import yaml
import subprocess
import sys
import shutil
from pathlib import Path
from collections import OrderedDict

def create_variant(base_yaml, variant_name, exclude_sections):
    """Create a CV variant by excluding specified sections."""
    
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
    
    # Remove excluded sections while preserving order
    if 'cv' in cv_data and 'sections' in cv_data['cv']:
        sections = cv_data['cv']['sections']
        for section in exclude_sections:
            if section in sections:
                print(f"  Removing {section} section...")
                del sections[section]
    
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
    base_yaml = "Ahmad_Jalil_CV.yaml"
    
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
        # Just render the original file
        result = subprocess.run([
            'rendercv', 'render', base_yaml, '--output-folder-name', 'full_resume'
        ])
        sys.exit(result.returncode)
    else:
        # Create variant with excluded sections
        success = create_variant(base_yaml, variant, config['exclude_sections'])
        sys.exit(0 if success else 1)

if __name__ == "__main__":
    main()