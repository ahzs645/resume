// Presentation entry matching other CV sections

// Title in bold (main presentation title)
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(weight: "bold", "<<entry.title|replace('\\(', '(')|replace('\\)', ')')>>"),
  "<<entry.date>>"
)

#v(design_presentation_after_title)

// Conference/venue in italics with location
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(style: "italic", "<<entry.conference|replace('\\(', '(')|replace('\\)', ')')>>"),
  "<<entry.location>>"
)

((* if entry.highlights *))
// Optional highlights/description
#v(design_presentation_before_highlights)
((* for highlight in entry.highlights *))
• <<highlight|replace('\\(', '(')|replace('\\)', ')')>>
#v(design_presentation_between_highlights)
((* endfor *))
((* endif *))

#v(design_presentation_between_entries)  // Spacing between presentations