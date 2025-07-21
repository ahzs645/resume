# Resume Builder

This repository contains Ahmad Jalil's resume with a flexible build system for generating different resume variants.

## Files

- `Ahmad_Jalil_CV.yaml` - Master resume file (single source of truth)
- `resume-variants.json` - Configuration for different resume variants
- `build-clean.py` - Python script that creates resume variants
- `build-resume` - Simple shell wrapper for easier usage
- `ahmadstyle/` - Custom RenderCV theme

## Usage

### Quick Build Commands

```bash
# Build different resume variants
./build-resume full      # Complete resume with all sections
./build-resume academic  # Academic focus (no projects)
./build-resume minimal   # Essential sections only
./build-resume industry  # Industry focus (no volunteer/presentations/publications)
./build-resume tech      # Tech-focused (core technical sections only)
```

### Adding New Variants

Edit `resume-variants.json` to add new resume variants:

```json
{
  "variants": {
    "your_variant": {
      "description": "Description of your variant",
      "exclude_sections": ["section1", "section2"]
    }
  }
}
```

Available sections to exclude: `projects`, `volunteer`, `presentations`, `publications`, `professional_development`, `awards`, `certifications_skills`

## Output

- Generated resumes are saved to `{variant}_resume/` folders
- Each folder contains PDF, PNG, HTML, and Typst files
- All output folders are git-ignored

## Requirements

- Python 3.6+
- Virtual environment (recommended)
- Dependencies from `requirements.txt`

## Setup

1. **Create and activate virtual environment:**
   ```bash
   python -m venv venv
   source venv/bin/activate  # On macOS/Linux
   ```

2. **Install dependencies:**
   ```bash
   pip install -r requirements.txt
   ```

3. **Build resumes:**
   ```bash
   ./build-resume full
   ```

## How It Works

1. The Python script loads variant configurations from JSON
2. Creates a temporary YAML file with excluded sections removed
3. Uses RenderCV to generate the PDF and other formats
4. Preserves original section ordering using OrderedDict
5. Cleans up temporary files automatically