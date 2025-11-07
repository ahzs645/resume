// Education entry matching LaTeX formatting exactly


// Import macros
((* from 'ahmadstyle/components/date_formatter.j2.typ' import format_date *))

// Initialize variables
((* set formatted_start_date = format_date(entry.start_date) *))
((* set formatted_end_date = format_date(entry.end_date) *))
((* set date_range = formatted_start_date + ' - ' + formatted_end_date *))

// Wrap entire entry in entry_content to keep it together
#entry_content({
  // Institution header with date range (bold institution name)
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(weight: "bold", "<<entry.institution|replace('\\(', '(')|replace('\\)', ')')>>"),
    text(weight: "bold", "<<date_range>>")
  )

  v(design_education_after_institution)

  // Degree and area with location (italic degree/area)
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(style: "italic", "<<entry.degree|replace('\\(', '(')|replace('\\)', ')')>>, <<entry.area|replace('\\(', '(')|replace('\\)', ')')>>"),
    ((* if entry.location *))
    text(style: "italic", "<<entry.location>>")
    ((* else *))
    ""
    ((* endif *))
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
