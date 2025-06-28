// Publication entry - matching ExperienceEntry pattern exactly

#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(weight: "bold", "<<entry.title>>"),
  "<<entry.date>>"
)

#v(design_publication_after_title)

#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(style: "italic", "<<entry.journal>>"),
  ""
)

#v(design_publication_after_journal)

<<entry.authors|join(', ')>>

#v(design_publication_after_authors)

DOI: <<entry.doi>>

#v(design_publication_spacing)