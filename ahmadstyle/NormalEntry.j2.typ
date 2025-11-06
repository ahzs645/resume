// Normal entry (for professional development, awards, etc.) matching LaTeX

((* if section_title == "Media" *))
// Customized layout for Media Links section
#entry_content({
  // Bold media title without bullet marker
  grid(
    columns: (1fr),
    align: (left),
    text(weight: "bold", "<<entry.name|replace('\\(', '(')|replace('\\)', ')')>>")
  )

  // Optional summary/descriptor line
  ((* if entry.summary *))
  v(design_media_between_lines)
  grid(
    columns: (1fr),
    align: (left),
    text(style: "italic", "<<entry.summary|replace('\\(', '(')|replace('\\)', ')')>>")
  )
  ((* endif *))

  // Dedicated line for the media URL
  ((* if entry.url *))
  v(design_media_between_lines)
  grid(
    columns: (1fr),
    align: (left),
    link("<<entry.url>>")[<<entry.url|string>>]
  )
  ((* endif *))
})
#v(design_media_between_entries)

((* else *))
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
  ((* set skip_next_highlight = False *))
  ((* for highlight in entry.highlights *))
    ((* if skip_next_highlight *))
      ((* set skip_next_highlight = False *))
    ((* else *))
      ((* set trimmed_highlight = highlight|trim *))
      ((* set lowered_highlight = trimmed_highlight|lower *))
      ((* set next_highlight = entry.highlights[loop.index0 + 1] if not loop.last else "" *))

      ((* if lowered_highlight == "technologies" and next_highlight *))
      [
        #text(weight: "bold", "Technologies - ")
        <<next_highlight|trim|replace('\\(', '(')|replace('\\)', ')')>>
      ];
      ((* set skip_next_highlight = True *))
      ((* elif trimmed_highlight[:12]|lower == "technologies" and ":" in trimmed_highlight *))
      ((* set tech_parts = trimmed_highlight.split(":", 1) *))
      [
        #text(weight: "bold", "<<tech_parts[0]|replace('\\(', '(')|replace('\\)', ')')>> - ")
        <<tech_parts[1]|trim|replace('\\(', '(')|replace('\\)', ')')>>
      ];
      ((* else *))
      bullet_line([<<highlight|replace('\\(', '(')|replace('\\)', ')')>>]);
      ((* endif *))

      v(design_awards_paragraph_spacing);  // Uses awards-specific spacing
    ((* endif *))
  ((* endfor *))
  ((* endif *))
})

// Conditional spacing based on entry type
((* if entry.highlights *))
#v(design_awards_between_entries)  // Awards spacing between entries
((* else *))
#v(design_professional_dev_between_entries)  // Professional development spacing between entries
((* endif *))
((* endif *))
