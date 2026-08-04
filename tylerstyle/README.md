# Tyler Style Theme for RenderCV

A denser, sans-serif sibling of `ahmadstyle`. Same entry layouts and section
structure, but set in **Carlito**, with a tighter vertical rhythm, upright
(rather than italic) secondary lines, and a few extra knobs of its own.

## Directory Structure

```
tylerstyle/
├── __init__.py                  # Theme configuration and options
├── README.md                    # This file
│
├── Layout Templates
│   ├── Header.j2.typ            # Name, contact line, social links
│   ├── Preamble.j2.typ          # Document setup, fonts, spacing constants
│   ├── SectionBeginning.j2.typ  # Section headers (+ optional page breaks)
│   └── SectionEnding.j2.typ     # Section footers
│
├── entries/                     # One template per RenderCV entry type.
│   │                            # RenderCV 2.x resolves entry templates from
│   │                            # here only -- never from the theme root.
│   ├── ExperienceEntry.j2.typ
│   ├── EducationEntry.j2.typ
│   ├── NormalEntry.j2.typ
│   ├── OneLineEntry.j2.typ
│   ├── PublicationEntry.j2.typ
│   ├── PresentationEntry.j2.typ
│   ├── ProfessionalDevelopmentEntry.j2.typ
│   ├── CertificationsEntry.j2.typ
│   ├── CertificationsSkillsEntry.j2.typ
│   ├── SkillsEntry.j2.typ
│   ├── TextEntry.j2.typ
│   ├── BulletEntry.j2.typ
│   ├── NumberedEntry.j2.typ
│   └── ReversedNumberedEntry.j2.typ
│
├── components/
│   ├── date.j2.typ              # Date rendering
│   ├── date_formatter.j2.typ    # "2024-03" -> "March 2024"
│   └── unescape.j2.typ          # Undo RenderCV's Typst escaping
│
└── fonts/
    └── Carlito-*.ttf            # Carlito (Regular/Bold/Italic/BoldItalic)
```

## How it differs from `ahmadstyle`

| | ahmadstyle | tylerstyle |
|---|---|---|
| Body font | EB Garamond (serif) | Carlito (sans) |
| Body size | fixed 11pt | `font_size` option |
| Secondary lines (position, degree, location, summary) | italic | upright |
| Entry summary in Normal entries | body size | 10pt |
| Project highlights | plain text, no bullets | indented bullets, with a bullet-less `Technologies - ` lead-in |
| Header links | any hex colour | `blue` or `black` |
| Page breaks | automatic only | plus `pagebreak_before_sections` |
| Vertical rhythm | roomier | tighter throughout |

## Theme Options

Set under `design:` in your CV YAML. Every
[ClassicTheme](https://docs.rendercv.com) option is available too, since
`TylerstyleTheme` extends it.

| Option | Default | Description |
|---|---|---|
| `font_size` | `11pt` | Body font size. |
| `section_heading_size` | `11pt` | Font size for section headers (e.g. EXPERIENCE). |
| `website_link_color` | `black` | `blue` for a hyperlink look, `black` to match body text. |
| `keep_sections_together` | `false` | Prevent page breaks within a section. |
| `keep_entries_together` | `true` | Keep an entry and its highlights on one page. |
| `prevent_orphaned_headers` | `true` | Keep a section header with its first entry. |
| `pagebreak_before_sections` | `[]` | Section titles that should start on a new page. |
| `custom_entries.show_time_span` | `[]` | Sections where entry time spans are shown. |

```yaml
design:
  theme: tylerstyle
  font_size: 11pt
  section_heading_size: 12pt
  website_link_color: blue
  pagebreak_before_sections:
    - Publications
```

## Fonts

Carlito is not part of `rendercv-fonts`, so the TTFs ship with the theme. For
CLI renders RenderCV looks for a `fonts/` folder next to the input file (or in
the working directory) -- the repo root `fonts/` folder carries a copy for that
reason. The web app serves them from `static/cdn/fonts/Carlito/`.

## A note on the spacing constants

`Preamble.j2.typ` holds the vertical rhythm as named `#let design_*` constants.
Most carry the values from the original Tyler Style theme verbatim. Five
between-entry constants (`design_education_after_entry`,
`design_awards_between_entries`, `design_professional_dev_between_entries`,
`design_media_between_entries`, `design_presentation_between_entries`) were
authored against an older template set that carried less built-in spacing;
applied as-is to the current templates they collapse the gap between entries
entirely, so they were relaxed to the tightest value that still separates
entries visibly.

## Development

Edit `*.j2.typ` for layout, `__init__.py` for options.
`fixtures/tylerstyle.yaml` exercises every entry type and every theme option at
once. RenderCV resolves both the theme folder and the `fonts/` folder relative
to the input file, so render it from the repo root:

```bash
cp fixtures/tylerstyle.yaml . && rendercv render tylerstyle.yaml && rm tylerstyle.yaml
```
