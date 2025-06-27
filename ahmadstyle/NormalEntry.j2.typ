// Normal entry (for professional development, awards, etc.) matching LaTeX

// Main entry with bold name
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(weight: "bold", "<<entry.name>>"),
  "<<entry.date_string>>"
)

((* if entry.summary *))
// Italic summary line (like institution/organization)
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(style: "italic", "<<entry.summary>>"),
  ((* if entry.location *))
  "<<entry.location>>"
  ((* else *))
  ""
  ((* endif *))
)
((* elif entry.location *))
#grid(
  columns: (1fr, auto),
  align: (left, right),
  "",
  "<<entry.location>>"
)
((* endif *))

((* if entry.highlights *))
// Description text (not bullet points for awards)
((* for highlight in entry.highlights *))
<<highlight>>
#v(1pt)  // Small spacing between paragraphs in descriptions
((* endfor *))
((* endif *))

#v(-6pt)  // Match LaTeX \vspace{8pt} between entries