// Organization header with date range and location
#grid(
  columns: (1fr, auto),
  align: (left, right),
  strong("<<entry.company>>"),
  "<<entry.date_string>>"
)

// Position line with location
#grid(
  columns: (1fr, auto),
  align: (left, right),
  emph("<<entry.position>>"),
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