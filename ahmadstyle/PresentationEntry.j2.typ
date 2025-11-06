// Presentation entry matching other CV sections

// Wrap entire entry in entry_content to keep it together
#entry_content({
  // Title in bold (main presentation title)
  ((* set presentation_date_display = entry.date_string if entry.date_string else entry.date *))

  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(weight: "bold", "<<entry.title|replace('\\(', '(')|replace('\\)', ')')>>"),
    text(weight: "bold", "<<presentation_date_display>>")
  )

  v(design_presentation_after_title)

  // Conference/venue in italics with location
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(style: "italic", "<<entry.conference|replace('\\(', '(')|replace('\\)', ')')>>"),
    ((* if entry.location *))
    text(style: "italic", "<<entry.location>>")
    ((* else *))
    ""
    ((* endif *))
  )

  ((* if entry.highlights *))
  // Optional highlights/description
  v(design_presentation_before_highlights);
  ((* for highlight in entry.highlights *))
  bullet_line([<<highlight|replace('\\(', '(')|replace('\\)', ')')>>]);
  v(design_presentation_between_highlights);
  ((* endfor *))
  ((* endif *))
})

#v(design_presentation_between_entries)  // Spacing between presentations
