// Education entry matching LaTeX formatting exactly

// Wrap entire entry in entry_content to keep it together
#entry_content({
  // Institution header with date range (bold institution name)
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(weight: "bold", "<<entry.institution|replace('\\(', '(')|replace('\\)', ')')>>"),
    "<<entry.date_string>>"
  )

  v(design_education_after_institution)

  // Degree and area with location (italic degree/area)
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(style: "italic", "<<entry.degree|replace('\\(', '(')|replace('\\)', ')')>>, <<entry.area|replace('\\(', '(')|replace('\\)', ')')>>"),
    "<<entry.location>>"
  )

  ((*- if entry.highlights -*))
  // Bullet points for highlights with LaTeX-matching spacing
  v(design_education_before_highlights);
  ((*- for highlight in entry.highlights *))
  bullet_line([<<highlight|replace('\\(', '(')|replace('\\)', ')')>>]);
  v(design_education_between_highlights);
  ((*- endfor -*))
  ((*- endif -*))

  ((*- if entry.summary -*))
  bullet_line([<<entry.summary|replace('\\(', '(')|replace('\\)', ')')>>])
  ((*- endif *))
})

#v(design_education_after_entry)  // Standard spacing after education entries
