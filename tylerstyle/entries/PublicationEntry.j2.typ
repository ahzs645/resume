// Publication entry - matching ExperienceEntry pattern exactly
{% from 'tylerstyle/components/date_formatter.j2.typ' import format_date with context %}

{% set publication_date_display = "" %}
{% if entry.date %}
  {% set publication_date_display = format_date(entry.date) %}
{% elif entry.date_string %}
  {% set publication_date_display = entry.date_string %}
{% endif %}

// Wrap entire entry in entry_content to keep it together
#entry_content({
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(weight: "bold", "{{ entry.title|replace('\\(', '(')|replace('\\)', ')') }}"),
    text(weight: "bold", "{{ publication_date_display }}")
  )

  v(design_publication_after_title)

  {% set vip = "" %}
  {% if entry.volume %}{% set vip = vip ~ entry.volume %}{% endif %}
  {% if entry.issue %}{% set vip = vip ~ "(" ~ entry.issue ~ ")" %}{% endif %}
  {% if entry.pages %}{% set vip = (vip ~ ", " if vip else "") ~ entry.pages %}{% endif %}
  {% if entry.journal %}{% set source = entry.journal ~ (", " ~ vip if vip else "") %}
  {% elif entry.institution %}{% set source = (entry.type ~ ", " if entry.type else "") ~ entry.institution %}
  {% elif entry.publisher %}{% set source = entry.publisher ~ (", " ~ vip if vip else "") %}
  {% else %}{% set source = "" %}{% endif %}
  {% if source %}
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(style: "italic", "{{ source|replace('\\(', '(')|replace('\\)', ')') }}"),
    ""
  )

  v(design_publication_after_journal)
  {% endif %}

  [{{ entry.authors|join(', ') }}];

  {% if entry.doi %}
  v(design_publication_after_authors);

  [DOI: {{ entry.doi }}]
  {% endif %}
})

#v(design_publication_spacing)
