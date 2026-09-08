# Classic Serif

One shared layout with two visual presets. Both use New Computer Modern, a
centered header, small-cap section headings, full-width rules, clickable contact
links, aligned entry rows, and the same page-break behavior.

```yaml
design:
  theme: classicserif
  preset: jake # or carolyn
  experience_order: company_first # preset, position_first, or company_first
```

Jake emphasizes the role before the company. Its defaults have been relaxed from
the old PhD Jake layout: half-inch top/side margins, 11.5pt section titles,
0.5em leading, and visibly separated entries. Carolyn emphasizes the company,
uses 12pt section titles, and follows the supplied reference's spacing.

The shared schema and preset defaults live in `__init__.py`; all rendering
behavior lives in this package's Jinja templates. Explicit nested settings win
over preset defaults. For example, changing only `typography.font_size.body`
retains the preset's name size and spacing. Switching presets retains explicit
user overrides; remove an override to restore the preset's value.

```yaml
design:
  theme: classicserif
  preset: carolyn
  typography:
    font_size:
      body: 10pt
  entries:
    allow_page_break: false
```

Experience and education templates use their first two main-column lines as
heading rows. Project and media titles link to their URL when supplied. The experience order
control changes heading order without changing the selected preset’s typography
or spacing; explicit templates still win. Project entries use the first line and support an optional
`technologies` field. Wrapped headings keep matching dates/locations aligned.
The shared RenderCV entry wrapper handles highlights and entry page breaks;
section headings and page-break controls use the common RenderCV preamble.

`phdjakes` and `carolynstyle` remain thin compatibility aliases. Ship the
`classicserif` folder with either alias. Existing explicit YAML settings are
preserved, while missing settings adopt the revised defaults. The web theme
picker offers Classic Serif with a Jake/Carolyn preset control; selected legacy
names remain visible so saved resumes can still be edited.

Use RenderCV 2.8 and place the theme folder beside the input YAML. Regression
checks: `python -m pytest classicserif/tests`. `fixtures/classic-serif.yaml`
provides fictional content for wrapping, optional fields, and multi-page checks.

Nested `positions` are normalized by the web app and rendered under one company
heading, with italic roles, individual date ranges, and complete details. This
group hierarchy applies in both presets; standalone jobs retain the selected
company/position order. Custom experience templates retain their own layout.
Normal entries use independent title/summary and date/location stacks with a narrower, bounded
metadata column. Dates and locations stay tightly stacked at the top, regardless of
title wrapping; year-only dates remain years. This improves long presentation
titles without hard-coding a section name.

Nested roles align with their company heading by default. Enable
`design.indent_nested_jobs: true` (Design → Classic Serif → Indent nested jobs)
to indent roles and their details by 0.12 inches. Both presets default to off.
