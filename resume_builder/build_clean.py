import os
import re
import subprocess
import sys
from collections import OrderedDict
from functools import cache
from pathlib import Path
from typing import Any, Dict, List, Optional

import yaml
import yaml.resolver
from dotenv import load_dotenv


def markdown_to_typst(text: Any) -> Any:
    """
    Convert markdown formatting to Typst syntax.

    Supported conversions:
        **bold** or __bold__     → #strong[bold]
        *italic* or _italic_     → #emph[italic]
        ***bold italic***        → #strong[#emph[bold italic]]
        [text](url)              → #link("url")[text]

    Args:
        text: Input text to convert. Non-string values are returned unchanged.

    Returns:
        Converted text with Typst markup, or original value if not a string.
    """
    if not isinstance(text, str):
        return text

    # Order matters: process triple markers before single/double
    # Bold + italic: ***text*** or ___text___
    text = re.sub(r"\*\*\*([^*]+)\*\*\*", r"#strong[#emph[\1]]", text)
    text = re.sub(r"___([^_]+)___", r"#strong[#emph[\1]]", text)

    # Bold: **text** or __text__
    text = re.sub(r"\*\*([^*]+)\*\*", r"#strong[\1]", text)
    text = re.sub(r"__([^_]+)__", r"#strong[\1]", text)

    # Italic: *text* or _text_
    text = re.sub(r"\*([^*]+)\*", r"#emph[\1]", text)
    # Underscore italic: requires non-whitespace, handles single char (_a_) and multi-char (_text_)
    text = re.sub(r"_([^_\s](?:[^_]*[^_\s])?)_", r"#emph[\1]", text)

    # Links: [text](url)
    text = re.sub(r"\[([^\]]+)\]\(([^)]+)\)", r'#link("\2")[\1]', text)

    return text


def process_markdown_in_entry(entry: Dict[str, Any]) -> Dict[str, Any]:
    """
    Apply markdown-to-Typst conversion to description fields in an entry.

    Processes: highlights, summary, bullet, details
    """
    entry = entry.copy()

    # Process highlights array
    if "highlights" in entry and isinstance(entry["highlights"], list):
        entry["highlights"] = [markdown_to_typst(h) for h in entry["highlights"]]

    # Process summary field
    if "summary" in entry and isinstance(entry["summary"], str):
        entry["summary"] = markdown_to_typst(entry["summary"])

    # Process bullet field (for BulletEntry)
    if "bullet" in entry and isinstance(entry["bullet"], str):
        entry["bullet"] = markdown_to_typst(entry["bullet"])

    # Process details field (for OneLineEntry)
    if "details" in entry and isinstance(entry["details"], str):
        entry["details"] = markdown_to_typst(entry["details"])

    return entry


def expand_positions(entry: Dict[str, Any]) -> List[Dict[str, Any]]:
    """
    Expand an entry with nested positions into multiple separate entries.

    For rendercv 2.6 compatibility, converts entries like:
        company: Acme Corp
        positions:
          - title: Senior Dev
            start_date: 2022-01
            ...
          - title: Junior Dev
            start_date: 2020-01
            ...

    Into separate entries:
        - company: Acme Corp
          position: Senior Dev
          start_date: 2022-01
          _is_first_position: true
          ...
        - company: Acme Corp
          position: Junior Dev
          start_date: 2020-01
          _is_continuation: true
          ...
    """
    if "positions" not in entry or not isinstance(entry["positions"], list):
        return [entry]

    positions = entry["positions"]
    expanded = []

    for i, pos in enumerate(positions):
        new_entry = entry.copy()
        # Remove the positions array
        del new_entry["positions"]

        # Copy position fields to entry level
        new_entry["position"] = pos.get("title", pos.get("position", ""))
        if "start_date" in pos:
            new_entry["start_date"] = pos["start_date"]
        if "end_date" in pos:
            new_entry["end_date"] = pos["end_date"]
        if "highlights" in pos:
            new_entry["highlights"] = [markdown_to_typst(h) for h in pos["highlights"]]

        # Add markers for template styling
        if i == 0:
            new_entry["_is_first_position"] = True
        else:
            new_entry["_is_continuation"] = True
            # Don't repeat company name for continuation entries
            new_entry["_hide_company"] = True

        expanded.append(new_entry)

    return expanded


def flavor_filter(field_value: Dict[str, Any], flavor: List[str]) -> Any:
    flavor_values = []
    flavors_dict = field_value["flavors"]
    for flavors in flavor:
        if flavors_dict.get(flavors):
            value = flavors_dict.get(flavors)
            flavor_values.extend(value)

    # If there was no match on flavors, pick the first one.
    if not flavor_values:
        flavor_values = next(iter(flavors_dict.values()), None)

    return flavor_values


def subfilter(
    entry: Dict[str, Any],
    tags: Optional[List[str]] = None,
    flavor: Optional[List[str]] = None,
) -> Optional[Dict[str, Any]]:
    # To avoid issues with mutable default arguments
    tags = tags or []
    flavor = flavor or []

    entry = entry.copy()

    # Check all the sub fields to see if they have the flavors keyword
    for field_name, field_value in entry.items():
        if isinstance(field_value, dict) and "flavors" in field_value:
            entry[field_name] = flavor_filter(field_value, flavor)

    inverse_tags = entry.get("itags", [])
    if inverse_tags and (set(tags) & set(inverse_tags)):
        print(f"  Skipping entry due to I-tags: {inverse_tags}")
        return None
    required_tags = entry.get("tags", [])
    if required_tags and not (set(tags) & set(required_tags)):
        print(f"  Skipping entry due to tags: {required_tags}")
        return None

    if required_tags:
        entry = entry.copy()
        entry.pop("tags", None)

    return entry


def filter_entries(
    entries: List[Dict[str, Any]],
    tags: Optional[List[str]] = None,
    flavor: Optional[List[str]] = None,
) -> List[Dict[str, Any]]:
    """Filter out entries with show: false, apply markdown conversion, and expand positions."""
    filtered = []
    for entry in entries:
        # Handle TextEntry (plain strings)
        if isinstance(entry, str):
            filtered.append(markdown_to_typst(entry))
            continue

        # Also check positions within an entry
        if isinstance(entry, dict) and "positions" in entry:
            filtered_positions = []
            for pos in entry["positions"]:
                filtered_pos = subfilter(pos, tags, flavor)
                if filtered_pos:
                    filtered_positions.append(filtered_pos)
            if filtered_positions:  # Only include entry if it has visible positions
                entry = entry.copy()
                entry["positions"] = filtered_positions
            else:
                continue  # Skip if no positions remain after filtering

        entry = subfilter(entry, tags, flavor)
        if entry:
            # Expand entries with nested positions into separate entries
            expanded_entries = expand_positions(entry)
            for exp_entry in expanded_entries:
                # Apply markdown-to-Typst conversion to description fields
                exp_entry = process_markdown_in_entry(exp_entry)
                # Remove custom fields that rendercv doesn't understand
                exp_entry.pop("_is_first_position", None)
                exp_entry.pop("_is_continuation", None)
                exp_entry.pop("_hide_company", None)
                exp_entry.pop("show_date_in_position", None)
                filtered.append(exp_entry)

    return filtered


def get_rendercv_command() -> str:
    """Get the rendercv command path, preferring venv if available."""
    # Check if venv/bin/rendercv exists
    venv_rendercv = Path("venv") / "bin" / "rendercv"
    if venv_rendercv.exists():
        return str(venv_rendercv)
    # Fall back to system rendercv
    return "rendercv"


def get_output_folder(variant_name: str) -> str:
    """Get the output folder path based on .env configuration."""
    output_dir = os.getenv("OUTPUT_DIR", ".")
    output_folder_template = os.getenv("OUTPUT_FOLDER_NAME", "{variant}_resume")
    output_folder_name = output_folder_template.format(variant=variant_name)

    # Combine output_dir and output_folder_name
    if output_dir == ".":
        return output_folder_name
    else:
        return str(Path(output_dir) / output_folder_name)


def create_variant(base_yaml: str, variant_name: str, config: Dict[str, Any]) -> bool:
    """Create a CV variant by excluding specified sections."""
    exclude_sections = config["exclude_sections"]

    # Load the original YAML preserving order
    with open(base_yaml, "r", encoding="utf-8") as f:
        cv_data = yaml.load(f, Loader=yaml.SafeLoader)

    # Remove excluded sections and filter entries with show: false
    if "cv" in cv_data and "sections" in cv_data["cv"]:
        sections = cv_data["cv"]["sections"]
        for section in exclude_sections:
            if section in sections:
                print(f"  Removing {section} section...")
                del sections[section]

        # Filter out entries with show: false in remaining sections
        for section_name, section_entries in sections.items():
            if isinstance(section_entries, list):
                sections[section_name] = filter_entries(
                    section_entries, config["tags"], config["flavors"]
                )

    # Create temporary YAML file
    temp_yaml = f"temp_{variant_name}_cv.yaml"
    with open(temp_yaml, "w", encoding="utf-8") as f:
        yaml.dump(
            cv_data,
            f,
            default_flow_style=False,
            allow_unicode=True,
            sort_keys=False,
        )

    # Render the CV
    output_folder = get_output_folder(variant_name)
    rendercv_cmd = get_rendercv_command()
    print(f"  Rendering to {output_folder}...")
    result = subprocess.run(
        [
            rendercv_cmd,
            "render",
            temp_yaml,
            "--output-folder-name",
            output_folder,
            "--typst-path",
            "ff/foonts",
        ],
        capture_output=True,
        text=True,
    )

    # Clean up temp file
    Path(temp_yaml).unlink()

    if result.returncode == 0:
        print(f"  ✓ {variant_name.title()} resume created successfully!")
    else:
        print(f"  ✗ Error creating {variant_name} resume:")
        print(result.stderr)

    return result.returncode == 0


@cache  # Cache the load so we don't read the file multiple times
def load_variants() -> Dict[str, Dict[str, Any]]:
    """Load variant configurations from YAML file."""
    # Try YAML first, fall back to JSON for backward compatibility
    yaml_config = "resume-variants.yaml"
    json_config = "resume-variants.json"

    config_file = yaml_config if Path(yaml_config).exists() else json_config

    if not Path(config_file).exists():
        print("Error: Configuration file not found!")
        print(f"  Looking for: {yaml_config} or {json_config}")
        sys.exit(1)

    try:
        with open(config_file, "r", encoding="utf-8") as f:
            config = yaml.safe_load(f)

        # Ensure each variant has the required fields (with defaults)
        variants = config["variants"]
        for variant_name, variant_config in variants.items():
            variant_config.setdefault("exclude_sections", [])
            variant_config.setdefault("tags", [])
            variant_config.setdefault("flavors", [])

        return variants
    except Exception as e:
        print(f"Error reading configuration: {e}")
        sys.exit(1)


def get_yaml_file() -> str:
    """Get the YAML file path based on .env configuration."""
    # Load environment variables
    load_dotenv()

    source_mode = os.getenv("SOURCE_MODE", "local")
    yaml_file = os.getenv("YAML_FILE", "CV.yaml")

    if source_mode == "local":
        # Use local file
        yaml_path = Path(yaml_file)
        if not yaml_path.exists():
            print(f"Error: Local YAML file '{yaml_file}' not found!")
            sys.exit(1)
        return str(yaml_path)

    elif source_mode == "remote":
        # Clone or update repository
        repo_url = os.getenv("REPO_URL")
        repo_branch = os.getenv("REPO_BRANCH", "main")
        repo_local_dir = os.getenv("REPO_LOCAL_DIR", ".resume-data")

        if not repo_url:
            print("Error: REPO_URL must be set when SOURCE_MODE=remote")
            sys.exit(1)

        repo_path = Path(repo_local_dir)

        # Clone or pull repository
        if repo_path.exists():
            print(f"Updating repository in {repo_local_dir}...")
            result = subprocess.run(
                ["git", "-C", str(repo_path), "pull", "origin", repo_branch],
                capture_output=True,
                text=True,
            )
            if result.returncode != 0:
                print(f"Warning: Failed to update repository: {result.stderr}")
                print("Using existing local copy...")
        else:
            print(f"Cloning repository from {repo_url}...")
            result = subprocess.run(
                ["git", "clone", "-b", repo_branch, repo_url, str(repo_path)],
                capture_output=True,
                text=True,
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
        print(
            f"Error: Invalid SOURCE_MODE '{source_mode}'. Must be 'local' or 'remote'"
        )
        sys.exit(1)
