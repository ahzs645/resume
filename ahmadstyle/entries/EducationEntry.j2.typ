// Education entry matching LaTeX formatting exactly

// Wrap entire entry in entry_content to keep it together
#entry_content({
  // Institution header with date range (bold institution name)
  grid(
    columns: (1fr, auto),
    align: (left, right),
    [#text(weight: "bold")[{{ entry.institution }}]],
    text(weight: "bold", "{{ entry.DATE.split('\n')[0] if entry.DATE else '' }}")
  )

  v(design_education_after_institution)

  // Degree and area with location (italic degree/area)
  grid(
    columns: (1fr, auto),
    align: (left, right),
    [#text(style: "italic")[{{ entry.degree }}, {{ entry.area }}]],
    {% if entry.location %}
    text(style: "italic", "{{ entry.location }}")
    {% else %}
    ""
    {% endif %}
  )

{% if entry.highlights %}
  // Bullet points for highlights with LaTeX-matching spacing
  v(design_education_before_highlights)
{% for highlight in entry.highlights %}
  bullet_line([{{ highlight }}])
  v(design_education_between_highlights)
{% endfor %}
{% endif %}

{% if entry.summary %}
  bullet_line([{{ entry.summary }}])
{% endif %}
})

#v(design_education_after_entry)  // Standard spacing after education entries
