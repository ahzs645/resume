# AhmadStyle Theme for RenderCV

Custom RenderCV theme with Ahmad's styling preferences.

## Directory Structure

```
ahmadstyle/
├── __init__.py                  # Theme configuration and options
├── README.md                    # This file
│
├── Layout Templates
│   ├── Header.j2.typ           # Resume header with name and contact info
│   ├── Preamble.j2.typ         # Document setup and styling
│   ├── SectionBeginning.j2.typ # Section headers
│   └── SectionEnding.j2.typ    # Section footers
│
├── Entry Templates
│   ├── ExperienceEntry.j2.typ           # Work experience entries
│   ├── EducationEntry.j2.typ            # Education entries
│   ├── PublicationEntry.j2.typ          # Publications
│   ├── PresentationEntry.j2.typ         # Conference presentations
│   ├── ProfessionalDevelopmentEntry.j2.typ  # Training/courses
│   ├── CertificationsEntry.j2.typ       # Certifications
│   ├── CertificationsSkillsEntry.j2.typ # Combined certs/skills
│   ├── SkillsEntry.j2.typ               # Skills section
│   ├── NormalEntry.j2.typ               # Generic entries
│   ├── OneLineEntry.j2.typ              # Single-line entries
│   ├── TextEntry.j2.typ                 # Text-only entries
│   ├── BulletEntry.j2.typ               # Bulleted lists
│   ├── NumberedEntry.j2.typ             # Numbered lists
│   └── ReversedNumberedEntry.j2.typ     # Reverse-numbered lists
│
├── components/
│   └── date.j2.typ              # Date formatting component
│
└── fonts/
    └── EBGaramond-*.ttf         # EB Garamond font family (10 files)
```

## Theme Configuration

Theme options are defined in `__init__.py`:

- `font_size`: Document font size (default: `11pt`)
- `page_size`: Page dimensions (default: `us-letter`)
- `entries.show_time_span`: Sections where date ranges are displayed

## Template File Naming

Template files follow RenderCV's naming convention:
- `<EntryType>.j2.typ` - Jinja2 templates that generate Typst code
- Files must be in the root theme directory for RenderCV to find them

## Usage

The theme is automatically loaded when building resumes with:
```bash
python3 build.py <variant>
```

## Customization

To customize styling:
1. Edit template files (`*.j2.typ`) for layout changes
2. Modify `__init__.py` for configuration options
3. Update fonts in the `fonts/` directory
4. Test changes by building a resume variant
