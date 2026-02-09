// Publication entry - simplified for RenderCV v2.6

// Wrap entire entry in entry_content to keep it together
#entry_content({
  grid(
    columns: (1fr, auto),
    align: (left, right),
    [#text(weight: "bold")[{{ entry.title }}]],
    text(weight: "bold", "{{ entry.DATE.split('\n')[0] if entry.DATE else '' }}")
  )

  v(design_publication_after_title)

{% if entry.journal %}
  grid(
    columns: (1fr, auto),
    align: (left, right),
    [#text(style: "italic")[{{ entry.journal }}]],
    ""
  )

  v(design_publication_after_journal)
{% endif %}

{% if entry.AUTHORS %}
  [{{ entry.AUTHORS }}]

  v(design_publication_after_authors)
{% endif %}

{% if entry.doi %}
  [DOI: {{ entry.doi }}]
{% endif %}
})

#v(design_publication_spacing)
