// Experience entry template
// Uses pre-processed DATE field from RenderCV

// Wrap entire entry in entry_content to keep it together
#entry_content({
{% if entry.company %}
  // Company header
  grid(
    columns: (1fr, auto),
    align: (left, right),
    [#text(weight: "bold")[{{ entry.company }}]],
    text(weight: "bold", "{{ entry.DATE.split('\n')[0] if entry.DATE else '' }}")
  )
  v(design_experience_after_company_header)
{% endif %}

{% if entry.position %}
  // Position line
  grid(
    columns: (1fr, auto),
    align: (left, right),
    [#text(style: "italic")[{{ entry.position }}]],
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
  bullet_line([{{ highlight }}])
  v(design_experience_between_highlights)
{% endfor %}
{% endif %}
})

#v(design_experience_between_companies)
