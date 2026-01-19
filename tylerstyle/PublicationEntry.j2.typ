// Publication entry - matching ExperienceEntry pattern exactly
((* from 'ahmadstyle/components/date_formatter.j2.typ' import format_date *))

((* set publication_date_display = "" *))
((* if entry.date *))
  ((* set publication_date_display = format_date(entry.date) *))
((* elif entry.date_string *))
  ((* set publication_date_display = entry.date_string *))
((* endif *))

// Wrap entire entry in entry_content to keep it together
#entry_content({
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(weight: "bold", "<<entry.title|replace('\\(', '(')|replace('\\)', ')')>>"),
    text(weight: "bold", "<<publication_date_display>>")
  )

  v(design_publication_after_title)

  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(style: "italic", "<<entry.journal|replace('\\(', '(')|replace('\\)', ')')>>"),
    ""
  )

  v(design_publication_after_journal)

  [<<entry.authors|join(', ')>>];

  v(design_publication_after_authors);

  [DOI: <<entry.doi>>]
})

#v(design_publication_spacing)
