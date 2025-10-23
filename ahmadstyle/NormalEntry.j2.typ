// Normal entry (for professional development, awards, etc.) matching LaTeX

// Wrap entire entry in entry_content to keep it together
#entry_content({
  // Main entry with bold name (hyperlinked if URL available)
  grid(
    columns: (1fr, auto),
    align: (left, right),
    ((* if entry.url *))
    link("<<entry.url>>")[#text(weight: "bold", "<<entry.name|replace('\\(', '(')|replace('\\)', ')')>>")],
    ((* else *))
    text(weight: "bold", "<<entry.name|replace('\\(', '(')|replace('\\)', ')')>>"),
    ((* endif *))
    "<<entry.date_string>>"
  )

  // Add spacing after name - different for Awards vs Professional Development
  ((* if entry.highlights *))
  v(design_awards_after_name)  // Awards: spacing after name
  ((* else *))
  v(design_professional_dev_after_name)  // Professional Dev: spacing after name
  ((* endif *))

  ((* if entry.summary *))
  // Italic summary line (like institution/organization)
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(style: "italic", "<<entry.summary|replace('\\(', '(')|replace('\\)', ')')>>"),
    ((* if entry.location *))
    "<<entry.location>>"
    ((* else *))
    ""
    ((* endif *))
  )

  // Add spacing after summary - different for Awards vs Professional Development
  ((* if entry.highlights *))
  v(design_awards_after_summary)  // Awards: spacing after summary
  ((* else *))
  v(design_professional_dev_after_summary)  // Professional Dev: spacing after summary
  ((* endif *))

  ((* elif entry.location *))
  grid(
    columns: (1fr, auto),
    align: (left, right),
    "",
    "<<entry.location>>"
  )
  ((* endif *))

  ((* if entry.highlights *))
  // Awards section - has highlights/descriptions
  ((* for highlight in entry.highlights *))
  [<<highlight|replace('\\(', '(')|replace('\\)', ')')>>];
  v(design_awards_paragraph_spacing);  // Uses awards-specific spacing
  ((* endfor *))
  ((* endif *))
})

// Conditional spacing based on entry type
((* if entry.highlights *))
#v(design_awards_between_entries)  // Awards spacing between entries
((* else *))
#v(design_professional_dev_between_entries)  // Professional development spacing between entries
((* endif *))