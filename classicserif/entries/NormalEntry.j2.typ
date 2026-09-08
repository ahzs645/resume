{% from 'classicserif/components/entry.j2.typ' import aligned_entry with context %}
{% if design.templates.normal_entry.main_column == '**NAME**\nSUMMARY\nHIGHLIGHTS' and design.templates.normal_entry.date_and_location_column == 'DATE\n*LOCATION*' %}
{# Keep the title/description and date/location in independent stacks. A bounded metadata column
   gives long presentation titles the remaining page width. #}
{% set raw_date = entry.date|string if entry.date else '' %}
{% set year_only = raw_date|length == 4 and raw_date.isdigit() %}
#regular-entry(
  [ ], [ ],
  main-column-second-row: [
    #grid(columns: (1fr, calc.min({{ design.entries.date_and_location_width }}, 1.25in)), column-gutter: 1em,
      align: (left + top, right + top),
      [
        #text(size: 1.095em, weight: "bold")[{% if entry.url %}#link({{ entry.url|tojson }})[{% endif %}{{ entry.name }}{% if entry.url %}]{% endif %}{% if entry.technologies %} | #text(size: 0.913em, weight: "regular", style: "italic")[{{ entry.technologies }}]{% endif %}]
{% if entry.summary %}
        #linebreak()
        {{ entry.summary }}
{% endif %}
      ],
      [
        #grid(columns: (1fr,), row-gutter: 0.4em, align: right,
{% if entry.date or entry.start_date or entry.end_date %}
          [{{ raw_date if year_only else entry.date_and_location_column.splitlines()[0] }}],
{% endif %}
{% if entry.location %}
          [#emph[{{ entry.location }}]],
{% endif %}
        )
      ],
    )
{% for highlight in entry.highlights or [] %}
    - {{ highlight }}
{% endfor %}
  ],
)
{% else %}
{{ aligned_entry(entry, 1, 'normal') }}
{% endif %}
