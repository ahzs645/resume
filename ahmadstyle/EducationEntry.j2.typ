// Education entry matching LaTeX formatting exactly

// Institution header with date range (bold institution name)
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(weight: "bold", "<<entry.institution>>"),
  "<<entry.date_string>>"
)

// Degree and area with location (italic degree/area)
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(style: "italic", "<<entry.degree>>, <<entry.area>>"),
  "<<entry.location>>"
)

((*- if entry.highlights -*))
// Bullet points for highlights with LaTeX-matching spacing
#v(2pt)
((*- for highlight in entry.highlights -*))
• <<highlight>>
#v(1pt)
((*- endfor -*))
((*- endif -*))

((*- if entry.summary -*))
• <<entry.summary>>
((*- endif -*))

#v(8pt)  // Standard spacing after education entries