import os
import subprocess
import sys
from collections import OrderedDict
from pathlib import Path
from typing import Any

import yaml
import yaml.resolver

from . import build_clean


def main() -> None:
    # Get YAML file from .env configuration
    base_yaml = build_clean.get_yaml_file()

    # Load variants from JSON config
    variants = build_clean.load_variants()

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
        def ordered_load(
            stream,
            Loader=yaml.SafeLoader,
            object_pairs_hook=OrderedDict,
        ):
            class OrderedLoader(yaml.SafeLoader):
                pass

            def construct_mapping(loader, node):
                loader.flatten_mapping(node)
                return object_pairs_hook(loader.construct_pairs(node))

            OrderedLoader.add_constructor(
                yaml.resolver.BaseResolver.DEFAULT_MAPPING_TAG, construct_mapping
            )
            return yaml.load(stream, OrderedLoader)

        # Custom YAML dumper that preserves order
        def ordered_dump(
            data: Any,
            stream=None,
            Dumper=yaml.SafeDumper,
            **kwds,
        ) -> bytes | str | None:
            class OrderedDumper(yaml.SafeDumper):
                pass

            def _dict_representer(dumper, data):
                return dumper.represent_mapping(
                    yaml.resolver.BaseResolver.DEFAULT_MAPPING_TAG, data.items()
                )

            OrderedDumper.add_representer(OrderedDict, _dict_representer)
            return yaml.dump(data, stream, OrderedDumper, **kwds)

        # Filter out entries with show: false even for full variant
        with open(base_yaml, "r", encoding="utf-8") as f:
            cv_data = ordered_load(f)

        # Filter entries in all sections
        if "cv" in cv_data and "sections" in cv_data["cv"]:
            sections = cv_data["cv"]["sections"]
            for section_name, section_entries in sections.items():
                if isinstance(section_entries, list):
                    sections[section_name] = build_clean.filter_entries(
                        section_entries, config["tags"], config["flavors"]
                    )

        # Create temporary filtered YAML
        temp_yaml = "temp_full_cv.yaml"
        with open(temp_yaml, "w", encoding="utf-8") as f:
            ordered_dump(cv_data, f, default_flow_style=False, allow_unicode=True)

        # Render the filtered CV
        output_folder = build_clean.get_output_folder("full")
        rendercv_cmd = build_clean.get_rendercv_command()
        result = subprocess.run(
            [rendercv_cmd, "render", temp_yaml, "--output-folder-name", output_folder]
        )

        # Clean up temp file
        Path(temp_yaml).unlink()
        sys.exit(result.returncode)
    else:
        # Create variant with excluded sections
        success = build_clean.create_variant(base_yaml, variant, config)
        sys.exit(0 if success else 1)
