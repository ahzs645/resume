// Institution header with date range
#grid(
  columns: (1fr, auto),
  align: (left, right),
  strong("<<entry.institution>>"),
  "<<entry.date_string>>"
)

// Degree and area with location
#grid(
  columns: (1fr, auto),
  align: (left, right),
  emph("<<entry.degree>>, <<entry.area>>"),
  "<<entry.location>>"
)

((*- if entry.highlights -*))
// Bullet points for highlights
((*- for highlight in entry.highlights -*))
• <<highlight>>

((*- endfor -*))
((*- endif -*))

((*- if entry.summary -*))
• <<entry.summary>>

((*- endif -*))

#v(8pt)