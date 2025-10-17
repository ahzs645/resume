# Resume Builder

This repository contains Ahmad Jalil's resume with a flexible build system for generating different resume variants.

## Files

- `CV.yaml` - Master resume file (single source of truth)
- `resume-variants.yaml` - Configuration for different resume variants
- `build-clean.py` - Python script that creates resume variants
- `build.py` - Cross-platform Python wrapper (auto-detects and uses venv)
- `build-resume` - Bash wrapper for macOS/Linux
- `build-resume.bat` - Batch wrapper for Windows
- `ahmadstyle/` - Custom RenderCV theme

## Available Resume Variants

| Variant | Description |
|---------|-------------|
| `full` | Complete resume with all sections |
| `academic` | Academic focus (no projects) |
| `minimal` | Essential sections only |
| `industry` | Industry focus (no volunteer/presentations/publications) |
| `tech` | Tech-focused (core technical sections only) |
| `mechatronics` | Mechatronics-focused with tag filtering |

### Adding New Variants

Edit `resume-variants.yaml` to add new resume variants:

```yaml
variants:
  your_variant:
    description: Description of your variant
    exclude_sections: [section1, section2]  # Remove entire sections
    tags: [tag1, tag2]                      # Only include entries with these tags
    # flavors: [flavor1]                    # Select specific flavor values
```

**Available sections to exclude:** `projects`, `volunteer`, `presentations`, `publications`, `professional_development`, `awards`, `certifications_skills`

**How variants work:**

- **`exclude_sections`**: Completely removes sections from the resume (e.g., remove "volunteer" section)
- **`tags`**: Filters individual entries within sections. Only entries tagged with at least one matching tag will be included
  - Add `tags: [mechatronics]` to an entry in `CV.yaml` to mark it for the mechatronics variant
  - Entries without tags appear in all variants (unless their section is excluded)
- **`flavors`**: Allows entries to have alternate values for different variants (e.g., different highlight points for tech vs. academic resumes)
  - Define multiple versions of a field in your CV entry, then select which version each variant uses

**Example: Using tags in CV.yaml**
```yaml
cv:
  sections:
    experience:
      - company: Robotics Lab
        position: Engineer
        tags: [mechatronics, tech]  # Only appears in mechatronics and tech variants
        highlights:
          - Designed control systems

      - company: General Company
        position: Manager
        # No tags = appears in all variants (unless experience section excluded)
        highlights:
          - Led team projects
```

**Example: Using flavors in CV.yaml**
```yaml
cv:
  sections:
    experience:
      - company: Tech Company
        position: Developer
        highlights:
          flavors:
            tech:
              - Built scalable microservices architecture
              - Implemented CI/CD pipelines
            academic:
              - Applied software engineering principles
              - Conducted code reviews and testing
```

## Output

- Generated resumes are saved to `{variant}_resume/` folders
- Each folder contains PDF, PNG, HTML, and Typst files
- All output folders are git-ignored

## Requirements

- **Python 3.10 - 3.13** (required by RenderCV)
  - Python 3.14 is not yet supported due to pydantic-core compatibility
  - Recommended: Python 3.13
- Virtual environment (required for automatic dependency management)
- Dependencies from `requirements.txt`

### Installing Python 3.13 (if needed)

**macOS (Homebrew):**
```bash
brew install python@3.13
```

**Windows:**
Download from [python.org](https://www.python.org/downloads/)

**Linux:**
```bash
# Ubuntu/Debian
sudo apt update && sudo apt install python3.13

# Fedora
sudo dnf install python3.13
```

**Verify installation:**
```bash
python3.13 --version  # Should show 3.13.x
```

## Quick Start

1. **Install Python 3.13** (see above)
2. **Clone the repository:**
   ```bash
   git clone <your-repo-url>
   cd resume
   ```
3. **Create virtual environment:**
   ```bash
   python3.13 -m venv venv
   # or if python3.13 is your default:
   python3 -m venv venv
   ```
4. **Install dependencies:**
   ```bash
   # macOS/Linux
   venv/bin/pip install -r requirements.txt

   # Windows
   venv\Scripts\pip install -r requirements.txt
   ```
5. **Build your resume:**
   ```bash
   python3 build.py full
   ```

That's it! Your resume will be in the `full_resume/` folder.

## Detailed Setup

### 1. Configure Resume Source (Optional)

If you want to keep your resume data in a separate repository or customize output paths:

Copy `.env.example` to `.env` and configure:
```bash
cp .env.example .env
```

**Local mode (default):**
```env
SOURCE_MODE=local
YAML_FILE=CV.yaml
```

**Remote mode (fetch from git repository):**
```env
SOURCE_MODE=remote
YAML_FILE=CV.yaml
REPO_URL=git@github.com:username/resume-data.git
REPO_BRANCH=main
REPO_LOCAL_DIR=.resume-data
```

**Custom output paths:**
```env
OUTPUT_DIR=builds
OUTPUT_FOLDER_NAME={variant}_resume
```

This allows you to:
- Keep your resume data in a separate private repository
- Use different YAML files for different purposes
- Automatically pull latest changes from remote repository
- Customize where resume files are generated

### 2. Build Commands

```bash
# Basic usage (automatically uses venv)
python3 build.py <variant>

# Examples
python3 build.py full       # Complete resume
python3 build.py academic   # Academic focus
python3 build.py minimal    # Minimal version
python3 build.py tech       # Tech-focused

# Alternative methods
./build.py full            # Direct execution (if executable)
./build-resume full        # Bash wrapper (macOS/Linux)
build-resume.bat full      # Batch wrapper (Windows)
```

**Note:** All build scripts automatically detect and use the virtual environment. No need to manually activate it!

## How It Works

1. Loads configuration from `.env` (or uses defaults)
2. Fetches resume YAML from local file or remote repository
3. Loads variant configurations from `resume-variants.yaml`
4. Creates a temporary YAML file with:
   - Excluded sections removed
   - Entries filtered by tags (only matching tags included)
   - Flavor-based field substitutions applied
5. Uses RenderCV to generate the PDF and other formats
6. Preserves original section ordering using OrderedDict
7. Cleans up temporary files automatically

## Configuration Details

### Environment Variables Reference

Create a `.env` file to customize the build process:

#### Source Configuration

| Variable | Default | Description |
|----------|---------|-------------|
| `SOURCE_MODE` | `local` | Use `local` for filesystem or `remote` for git repository |
| `YAML_FILE` | `CV.yaml` | Path to your resume YAML file |
| `REPO_URL` | - | Git repository URL (required for remote mode) |
| `REPO_BRANCH` | `main` | Branch to use from repository |
| `REPO_LOCAL_DIR` | `.resume-data` | Local directory for cloned repository |

#### Output Configuration

| Variable | Default | Description |
|----------|---------|-------------|
| `OUTPUT_DIR` | `.` | Base output directory for generated resumes |
| `OUTPUT_FOLDER_NAME` | `{variant}_resume` | Output folder naming pattern (use `{variant}` for variant name) |
| `OUTPUT_FILENAME_PREFIX` | `resume` | Filename prefix (currently informational only) |

### Configuration Examples

**Example 1: Default (local file)**
No `.env` needed - uses `CV.yaml` from current directory.

**Example 2: Private resume data repository**
```env
SOURCE_MODE=remote
YAML_FILE=CV.yaml
REPO_URL=git@github.com:username/my-resume-private.git
REPO_BRANCH=main
```

**Example 3: Custom output directory**
```env
SOURCE_MODE=local
YAML_FILE=CV.yaml
OUTPUT_DIR=builds
OUTPUT_FOLDER_NAME={variant}_cv
```

**Example 4: Shared builder, personal data**
Fork this repo for the builder, keep your data in a separate private repo:
```env
SOURCE_MODE=remote
REPO_URL=git@github.com:username/my-resume-data.git
YAML_FILE=my_resume.yaml
OUTPUT_DIR=output
```

## Troubleshooting

**Python version issues:**
- Ensure you're using Python 3.10-3.13 (Python 3.14 not yet supported)
- Check version: `python3 --version`
- Specify version: `python3.13 -m venv venv`

**rendercv not found:**
- The build script automatically detects venv
- If issues persist, run: `venv/bin/python3 build-clean.py <variant>`

**Dependencies won't install:**
- Upgrade pip: `venv/bin/pip install --upgrade pip`
- Try Python 3.13: `brew install python@3.13` (macOS)