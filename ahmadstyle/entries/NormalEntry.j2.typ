// Normal entry template - simplified for RenderCV v2.6

// Wrap entire entry in entry_content to keep it together
#entry_content({
{% if entry.name %}
  // Main entry with bold name
  grid(
    columns: (1fr, auto),
    align: (left, right),
    [#text(weight: "bold")[{{ entry.name }}]],
    text(weight: "bold", "{{ entry.DATE.split('\n')[0] if entry.DATE else '' }}")
  )
{% endif %}

{% if entry.summary %}
  v(design_professional_dev_after_name)
  grid(
    columns: (1fr, auto),
    align: (left, right),
    [#text(style: "italic")[{{ entry.summary }}]],
    {% if entry.location %}
    text(style: "italic", "{{ entry.location }}")
    {% else %}
    ""
    {% endif %}
  )
  v(design_professional_dev_after_summary)
{% elif entry.location %}
  grid(
    columns: (1fr, auto),
    align: (left, right),
    "",
    text(style: "italic", "{{ entry.location }}")
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

#v(design_professional_dev_between_entries)
