{# Keep corresponding title/date and subtitle/location rows aligned even when
   one cell wraps. The shared regular-entry still controls bullets, indentation,
   spacing, and whether the whole entry can break across pages. #}
{% macro aligned_entry(entry, heading_rows, kind) %}
{% set main = entry.main_column.splitlines() %}
{% set group = namespace(nested=false, previous=none) %}
{% if kind == 'experience' and cv is defined and design.templates.experience_entry.main_column in ['**POSITION**\n*COMPANY*\nSUMMARY\nHIGHLIGHTS', '**COMPANY**\n*POSITION*\nSUMMARY\nHIGHLIGHTS'] %}
{% for section in cv.rendercv_sections %}
{% for candidate in section.entries %}
{% if candidate is sameas(entry) %}
{% set group.nested = not entry.company or (not loop.last and section.entries[loop.index].position is defined and not section.entries[loop.index].company) %}
{% if not loop.first %}{% set group.previous = section.entries[loop.index0 - 1] %}{% endif %}
{% endif %}
{% endfor %}
{% endfor %}
{% endif %}
{# Wrap individually processed fields so literal asterisks in company names do
   not become Markdown delimiters when surrounded by preset emphasis. #}
{% if kind == 'experience' %}
{% set emitted_headings = (1 if entry.position else 0) + (1 if entry.company else 0) %}
{% if design.templates.experience_entry.main_column == '**POSITION**\n*COMPANY*\nSUMMARY\nHIGHLIGHTS' %}
{% set main = ['#strong[' + entry.position + ']', '#emph[' + entry.company + ']'] + main[emitted_headings:] %}
{% elif design.templates.experience_entry.main_column == '**COMPANY**\n*POSITION*\nSUMMARY\nHIGHLIGHTS' %}
{% set main = ['#strong[' + entry.company + ']', '#emph[' + entry.position + ']'] + main[emitted_headings:] %}
{% endif %}
{% endif %}
{% set side = entry.date_and_location_column.splitlines() %}
{% if group.nested and design.templates.experience_entry.main_column in ['**POSITION**\n*COMPANY*\nSUMMARY\nHIGHLIGHTS', '**COMPANY**\n*POSITION*\nSUMMARY\nHIGHLIGHTS'] %}
{% set main = ['#emph[' + entry.position + ']'] + main[2:] %}
{% set heading_rows = 1 %}
{% set side = side[:1] if (entry.date or entry.start_date or entry.end_date) else [] %}
{% if not entry.company and entry.location and (not group.previous or entry.location != group.previous.location) %}
{% set main = [main[0], '#emph[' + entry.location + ']'] + main[1:] %}
{% set heading_rows = 2 %}
{% endif %}
{% endif %}
{% if side|length == 1 and heading_rows == 2 %}
{% if (kind == 'experience' and entry.location and not (entry.date or entry.start_date or entry.end_date)) or (kind == 'education' and not entry.location) %}
{% set side = [''] + side %}
{% endif %}
{% endif %}
#regular-entry(
  [ ],
  [ ],
  main-column-second-row: [
{% if group.nested and entry.company %}
    #block(sticky: true, below: 0.35em)[
      #grid(columns: (1fr, auto), column-gutter: 1em,
        [#text(size: 1.095em, weight: "bold")[{{ entry.company }}]],
        [#emph[{{ entry.location }}]],
      )
    ]
{% endif %}
{% if group.nested and design.indent_nested_jobs %}
    #pad(left: 0.12in)[
{% endif %}
    #grid(
      columns: {% if side %}(1fr, {{ design.entries.date_and_location_width }}){% else %}(1fr,){% endif %},
      column-gutter: {{ design.entries.space_between_columns }},
      row-gutter: {{ design.typography.line_spacing }},
      align: {% if side %}(left, {{ design.typography.date_and_location_column_alignment }}){% else %}(left,){% endif %},
{% for i in range(heading_rows) %}
      [{% if i == 0 and not group.nested %}#text(size: 1.095em)[{% endif %}{% if i == 0 and kind == 'normal' and entry.url %}#link({{ entry.url|tojson }})[{% endif %}{{ main[i] if i < main|length else '' }}{% if i == 0 and kind == 'normal' and entry.url %}]{% endif %}{% if i == 0 and kind == 'normal' and entry.technologies %} | #text(size: 0.913em, style: "italic")[{{ entry.technologies }}]{% endif %}{% if i == 0 and not group.nested %}]{% endif %}],
{% if side %}
      [{% if i == 0 and not group.nested %}#text(size: 1.095em)[{% endif %}{{ side[i] if i < side|length else '' }}{% if i == 0 and not group.nested %}]{% endif %}],
{% endif %}
{% endfor %}
{% for line in side[heading_rows:] %}
      [], [{{ line }}],
{% endfor %}
    )

{% for line in main[heading_rows:] %}
    {{ line|indent(4) }}

{% endfor %}
{% if group.nested and design.indent_nested_jobs %}
    ]
{% endif %}
  ],
)
{% endmacro %}
