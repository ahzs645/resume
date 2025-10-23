// Publication entry - matching ExperienceEntry pattern exactly

// Wrap entire entry in entry_content to keep it together
#entry_content({
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(weight: "bold", "<<entry.title|replace('\\(', '(')|replace('\\)', ')')>>"),
    "<<entry.date>>"
  )

  v(design_publication_after_title)

  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(style: "italic", "<<entry.journal|replace('\\(', '(')|replace('\\)', ')')>>"),
    ""
  )

  v(design_publication_after_journal)

  [<<entry.authors|join(', ')>>]

  v(design_publication_after_authors)

  [DOI: <<entry.doi>>]
})

#v(design_publication_spacing)
