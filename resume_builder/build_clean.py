import os
import re
import shutil
import subprocess
import sys
from collections import OrderedDict
from functools import cache
from pathlib import Path
from typing import Any, Dict, List, Optional

import yaml
import yaml.resolver
from dotenv import load_dotenv
import rendercv_fonts
import typst

POSITION_SPACING_SAME_MARKER = "RCVSPACINGSAME:"
POSITION_SPACING_DIFF_MARKER = "RCVSPACINGDIFF:"

MONTH_NAMES = {
    "01": "January",
    "02": "February",
    "03": "March",
    "04": "April",
    "05": "May",
    "06": "June",
    "07": "July",
    "08": "August",
    "09": "September",
    "10": "October",
    "11": "November",
    "12": "December",
}


def format_date_for_display(date_string: Any) -> str:
    """Format dates like 2024-03 to March 2024 and normalize present."""
    if not date_string:
        return ""

    normalized = str(date_string).strip()
    if not normalized:
        return ""

    if normalized.lower() == "present":
        return "Present"

    parts = normalized.split("-")
    if len(parts) == 1:
        return parts[0]

    if len(parts) >= 2:
        year = parts[0]
        month = parts[1].zfill(2)
        month_name = MONTH_NAMES.get(month)
        if month_name:
            return f"{month_name} {year}"

    return normalized


def format_date_range_for_display(start_date: Any, end_date: Any) -> str:
    """Build a formatted date range with long month names."""
    start = format_date_for_display(start_date)
    end = format_date_for_display(end_date)
    if start and end:
        return f"{start} – {end}"
    return start or end


def normalize_position_title(pos: Dict[str, Any]) -> str:
    """Get position title from either title or position keys."""
    return str(pos.get("title", pos.get("position", "")))


def select_company_start_date(positions: List[Dict[str, Any]]) -> Any:
    """Pick the earliest start date from nested positions."""
    start_dates = [pos.get("start_date") for pos in positions if pos.get("start_date")]
    if not start_dates:
        return None
    return min(str(d) for d in start_dates)


def select_company_end_date(positions: List[Dict[str, Any]]) -> Any:
    """Pick the latest end date from nested positions; present wins."""
    end_dates = [pos.get("end_date") for pos in positions if pos.get("end_date")]
    if not end_dates:
        return None

    normalized_end_dates = [str(d) for d in end_dates]
    if any(d.lower() == "present" for d in normalized_end_dates):
        return "present"

    return max(normalized_end_dates)


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

    # Process nested positions highlights when called directly in tests/utility usage.
    if "positions" in entry and isinstance(entry["positions"], list):
        processed_positions = []
        for pos in entry["positions"]:
            pos = pos.copy()
            if "highlights" in pos and isinstance(pos["highlights"], list):
                pos["highlights"] = [markdown_to_typst(h) for h in pos["highlights"]]
            processed_positions.append(pos)
        entry["positions"] = processed_positions

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
    company_start_date = select_company_start_date(positions)
    company_end_date = select_company_end_date(positions)

    include_position_level_dates = len(positions) > 1 or bool(
        entry.get("show_date_in_position", False)
    )

    for i, pos in enumerate(positions):
        new_entry = entry.copy()
        # Remove the positions array
        del new_entry["positions"]

        # Only include position-level dates when there are multiple visible positions
        # (or if explicitly requested) to avoid duplicating the company date range.
        position_title = normalize_position_title(pos)
        position_text = position_title
        if include_position_level_dates:
            position_date_range = format_date_range_for_display(
                pos.get("start_date"), pos.get("end_date")
            )
            if position_date_range:
                position_text = f"{position_title} | {position_date_range}"

        spacing_marker = (
            POSITION_SPACING_SAME_MARKER
            if i < len(positions) - 1
            else POSITION_SPACING_DIFF_MARKER
        )
        new_entry["position"] = f"{spacing_marker}{position_text}"

        # First position keeps the company header and company-wide date range.
        if i == 0:
            if company_start_date:
                new_entry["start_date"] = company_start_date
            elif "start_date" in pos:
                new_entry["start_date"] = pos["start_date"]

            if company_end_date:
                new_entry["end_date"] = company_end_date
            elif "end_date" in pos:
                new_entry["end_date"] = pos["end_date"]
        else:
            # Continuation rows should not repeat the company header.
            new_entry["company"] = ""
            if "start_date" in pos:
                new_entry["start_date"] = pos["start_date"]
            if "end_date" in pos:
                new_entry["end_date"] = pos["end_date"]

        if "highlights" in pos:
            new_entry["highlights"] = [markdown_to_typst(h) for h in pos["highlights"]]

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
                # Optionally include date in position for single-position entries.
                if exp_entry.pop("show_date_in_position", False):
                    position_text = exp_entry.get("position", "")
                    if (
                        isinstance(position_text, str)
                        and position_text
                        and POSITION_SPACING_SAME_MARKER not in position_text
                        and POSITION_SPACING_DIFF_MARKER not in position_text
                    ):
                        range_text = format_date_range_for_display(
                            exp_entry.get("start_date"), exp_entry.get("end_date")
                        )
                        if range_text:
                            exp_entry["position"] = (
                                f"{POSITION_SPACING_DIFF_MARKER}{position_text} | "
                                f"{range_text}"
                            )

                # Ensure all positions have a spacing marker for template parsing.
                position_text = exp_entry.get("position")
                if (
                    isinstance(position_text, str)
                    and position_text
                    and POSITION_SPACING_SAME_MARKER not in position_text
                    and POSITION_SPACING_DIFF_MARKER not in position_text
                ):
                    exp_entry["position"] = (
                        f"{POSITION_SPACING_DIFF_MARKER}{position_text}"
                    )

                # Apply markdown-to-Typst conversion to description fields
                exp_entry = process_markdown_in_entry(exp_entry)
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


def prepare_output_folder(output_folder: str) -> None:
    """
    Remove stale render artifacts before each render.

    RenderCV does not always prune old page PNGs when page count shrinks, which can
    leave misleading leftovers (e.g., stale *_6.png). Clearing the folder avoids
    mixed outputs across runs.
    """
    output_path = Path(output_folder)
    if output_path.exists():
        shutil.rmtree(output_path)
    output_path.mkdir(parents=True, exist_ok=True)


def get_render_output_args(output_folder: str) -> list[str]:
    """
    Build RenderCV 2.6 output path arguments.

    RenderCV 2.6 removed --output-folder-name; each artifact path must be passed
    explicitly (or defaults to rendercv_output/*). We keep variant-specific output
    directories by setting all output paths with NAME_IN_SNAKE_CASE placeholders.
    """
    output_folder = output_folder.rstrip("/")
    return [
        "--typst-path",
        f"{output_folder}/NAME_IN_SNAKE_CASE_CV.typ",
        "--pdf-path",
        f"{output_folder}/NAME_IN_SNAKE_CASE_CV.pdf",
        "--markdown-path",
        f"{output_folder}/NAME_IN_SNAKE_CASE_CV.md",
        "--html-path",
        f"{output_folder}/NAME_IN_SNAKE_CASE_CV.html",
        "--png-path",
        f"{output_folder}/NAME_IN_SNAKE_CASE_CV.png",
    ]


def regenerate_pngs_at_150_dpi(output_folder: str) -> None:
    """
    Re-render PNGs from Typst at 150 DPI to match legacy RenderCV 2.0 output scale.

    RenderCV 2.6's default PNG export density differs from the old output users were
    comparing against. This keeps PDF generation untouched while making PNG previews
    visually consistent with the previous workflow.
    """
    output_path = Path(output_folder)
    typ_files = sorted(output_path.glob("*_CV.typ"))
    if not typ_files:
        return

    typ_path = typ_files[0]
    stem = typ_path.stem

    # Remove existing PNGs for this document before re-export.
    for png_file in output_path.glob(f"{stem}_*.png"):
        png_file.unlink()

    compiler = typst.Compiler(
        typ_path,
        font_paths=[
            *rendercv_fonts.paths_to_font_folders,
            Path.cwd() / "fonts",
        ],
    )
    png_bytes = compiler.compile(format="png", ppi=150)
    if not isinstance(png_bytes, list):
        png_bytes = [png_bytes]

    for index, png_content in enumerate(png_bytes, start=1):
        assert png_content is not None
        png_output = output_path / f"{stem}_{index}.png"
        png_output.write_bytes(png_content)


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
    prepare_output_folder(output_folder)
    rendercv_cmd = get_rendercv_command()
    print(f"  Rendering to {output_folder}...")
    render_args = [rendercv_cmd, "render", temp_yaml, *get_render_output_args(output_folder)]
    result = subprocess.run(render_args, capture_output=True, text=True)

    # Clean up temp file
    Path(temp_yaml).unlink()

    if result.returncode == 0:
        try:
            regenerate_pngs_at_150_dpi(output_folder)
        except Exception as e:  # pragma: no cover - best effort for preview parity
            print(f"  ! Warning: failed to regenerate PNGs at 150 DPI: {e}")
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
