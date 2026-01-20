// Normal entry (for professional development, awards, projects, etc.) matching LaTeX
((* from 'ahmadstyle/components/date_formatter.j2.typ' import format_date *))
((* from 'ahmadstyle/components/unescape.j2.typ' import unescape *))

((* set lowercase_section_title = section_title|lower *))
((* set formatted_entry_date = "" *))
((* if entry.date *))
  ((* set formatted_entry_date = format_date(entry.date) *))
((* elif entry.date_string *))
  ((* set formatted_entry_date = entry.date_string *))
((* endif *))

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

((* elif lowercase_section_title == "presentations" *))
// Custom layout for presentations to keep dates aligned with last line
#entry_content({
  grid(
    columns: (1fr, auto),
    align: (left, bottom),
    ((* if entry.url *))
    link("<<entry.url>>")[#text(weight: "bold", "<<entry.name|replace('\\(', '(')|replace('\\)', ')')>>")],
    ((* else *))
    text(weight: "bold", "<<entry.name|replace('\\(', '(')|replace('\\)', ')')>>"),
    ((* endif *))
    ((* if formatted_entry_date *))
    text(weight: "bold", "<<formatted_entry_date>>")
    ((* elif entry.date *))
    #text(weight: "bold", "<<entry.date>>")
    ((* else *))
    ""
    ((* endif *))
  )

  ((* if entry.summary *))
  v(design_professional_dev_after_name)
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(style: "italic", "<<entry.summary|replace('\\(', '(')|replace('\\)', ')')>>"),
    ((* if entry.location *))
    text(style: "italic", "<<entry.location>>")
    ((* else *))
    ""
    ((* endif *))
  )
  v(design_professional_dev_after_summary)
  ((* elif entry.location *))
  grid(
    columns: (1fr, auto),
    align: (left, right),
    "",
    text(style: "italic", "<<entry.location>>")
  )
  ((* endif *))

  ((* if entry.highlights *))
  v(design_professional_dev_after_summary)
  ((* for highlight in entry.highlights *))
  bullet_line([<<highlight|replace('\\(', '(')|replace('\\)', ')')>>]);
  v(design_professional_dev_between_entries);
  ((* endfor *))
  ((* endif *))
})
#v(design_professional_dev_between_entries)

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
    ((* if formatted_entry_date and lowercase_section_title in ["awards", "projects", "professional development", "presentations", "achievements"] *))
    text(weight: "bold", "<<formatted_entry_date>>")
    ((* else *))
    "<<formatted_entry_date>>"
    ((* endif *))
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
    text(size: 10pt, "<<entry.summary|replace('\\(', '(')|replace('\\)', ')')>>"),
    ((* if entry.location *))
    text(style: "italic", "<<entry.location>>")
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
  // Conditional rendering: bullets for awards, plain text for projects
    ((* if section_title|lower == "projects" *))
      // Projects section - plain text without bullets
      ((* for highlight in entry.highlights *))
      [<<unescape(highlight)|replace('- ', '\\- ')>>];
      v(-6pt);
      ((* endfor *))
    ((* else *))
      // Awards section - plain text without bullets
      ((* for highlight in entry.highlights *))
      [<<unescape(highlight)>>];
      v(design_awards_paragraph_spacing);
      ((* endfor *))
    ((* endif *))
  ((* endif *))
})

// Conditional spacing based on entry type
((* if entry.highlights *))
#v(design_awards_between_entries)  // Awards spacing between entries
((* else *))
#v(design_professional_dev_between_entries)  // Professional development spacing between entries
((* endif *))
((* endif *))
