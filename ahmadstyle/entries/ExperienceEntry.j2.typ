// Experience entry template for rendercv 2.6 compatibility.
// Uses position markers injected by preprocess to preserve old spacing behavior.
{% from 'ahmadstyle/components/date_formatter.j2.typ' import format_date %}
{% from 'ahmadstyle/components/unescape.j2.typ' import unescape %}

{% set marker_same = "RCVSPACINGSAME:" %}
{% set marker_diff = "RCVSPACINGDIFF:" %}
{% set raw_position = entry.position if entry.position else "" %}
{% set spacing_after = "different_company" %}
{% set display_position = raw_position %}
{% if raw_position.startswith(marker_same) %}
  {% set spacing_after = "same_company" %}
  {% set display_position = raw_position[marker_same|length:] %}
{% elif raw_position.startswith(marker_diff) %}
  {% set spacing_after = "different_company" %}
  {% set display_position = raw_position[marker_diff|length:] %}
{% endif %}

{% set formatted_start = format_date(entry.start_date) %}
{% set formatted_end = format_date(entry.end_date) %}
{% set company_date_range = "" %}
{% if formatted_start and formatted_end %}
  {% set company_date_range = formatted_start + " – " + formatted_end %}
{% elif formatted_start %}
  {% set company_date_range = formatted_start %}
{% elif formatted_end %}
  {% set company_date_range = formatted_end %}
{% endif %}

#entry_content({
{% if entry.company %}
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(weight: "bold", "{{ unescape(entry.company) }}"),
    text(weight: "bold", "{{ company_date_range }}")
  )
  v(design_experience_after_company_header)
{% endif %}

{% if display_position %}
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(style: "italic", "{{ unescape(display_position) }}"),
    {% if entry.location %}
    text(style: "italic", "{{ entry.location }}")
    {% else %}
    ""
    {% endif %}
  )
{% endif %}

{% if entry.highlights %}
  v(design_experience_before_highlights)
{% for highlight in entry.highlights %}
  bullet_line([{{ unescape(highlight) }}])
  v(design_experience_between_highlights)
{% endfor %}
{% endif %}
})

{% if spacing_after == "same_company" %}
#v(design_experience_between_positions_same_company)
{% else %}
#v(design_experience_between_companies)
#v(design-entries-vertical-space-between-entries)
{% endif %}
