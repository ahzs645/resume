// Professional Development entry with dedicated spacing controls
((* from 'ahmadstyle/components/date_formatter.j2.typ' import format_date *))

((* set professional_dev_date = "" *))
((* if entry.date *))
  ((* set professional_dev_date = format_date(entry.date) *))
((* elif entry.date_string *))
  ((* set professional_dev_date = entry.date_string *))
((* endif *))

// Main entry with bold name
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(weight: "bold", "<<entry.name|safe>>"),
  "<<professional_dev_date>>"
)

((* if entry.summary *))
// Italic summary line (like institution/organization)
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(style: "italic", "<<entry.summary|safe>>"),
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
// Description text (not bullet points for professional development)
((* for highlight in entry.highlights *))

<<highlight|safe>>
#v(design_professional_dev_paragraph_spacing)  // Professional development specific spacing
((* endfor *))
((* endif *))

#v(design_professional_dev_between_entries)  // Professional development specific entry spacing
