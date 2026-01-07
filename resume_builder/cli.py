import subprocess
import sys
from pathlib import Path

import click
import yaml
import yaml.resolver

from . import build_clean


def variant_callback(ctx: click.Context, param: click.Parameter, value: str) -> str:
    variants = build_clean.load_variants()
    if value not in variants:
        raise click.BadParameter(
            f"Variant '{value}' not found. Available variants: {', '.join(variants.keys())}"
        )
    return value


@click.command()
@click.option(
    "--variant",
    help="Resume variant to build",
    default="full",
)
def main(
    variant: str,
) -> None:
    # Get YAML file from .env configuration
    base_yaml = build_clean.get_yaml_file()

    # Load variants from JSON config
    variants = build_clean.load_variants()

    config = variants[variant]

    click.echo(f"Building {variant} resume: {config['description']}")

    if variant == "full":
        # Filter out entries with show: false even for full variant
        with open(base_yaml, "r", encoding="utf-8") as f:
            cv_data = yaml.load(f, Loader=yaml.SafeLoader)

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
            yaml.dump(
                cv_data,
                f,
                default_flow_style=False,
                allow_unicode=True,
                sort_keys=False,
            )

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
