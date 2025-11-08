// Normal entry (for professional development, awards, etc.) matching LaTeX
((* from 'ahmadstyle/components/date_formatter.j2.typ' import format_date *))

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
    ((* if formatted_entry_date and lowercase_section_title in ["awards", "projects", "professional development", "presentations"] *))
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
    text(style: "italic", "<<entry.summary|replace('\\(', '(')|replace('\\)', ')')>>"),
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
  // Awards section - has highlights/descriptions
  ((* set skip_next_highlight = False *))
  ((* for highlight in entry.highlights *))
    ((* if skip_next_highlight *))
      ((* set skip_next_highlight = False *))
    ((* else *))
      ((* set trimmed_highlight = highlight|trim *))
      ((* set normalized_highlight = trimmed_highlight|replace('\r\n', '\n')|replace('\r', '\n') *))
      ((* set lowered_multiline_highlight = normalized_highlight|lower *))
      ((* set single_line_highlight = ' '.join(normalized_highlight.split()) *))
      ((* set lowered_highlight = single_line_highlight|lower *))
      ((* set next_highlight = entry.highlights[loop.index0 + 1] if not loop.last else "" *))

      ((* if lowered_highlight == "technologies" and next_highlight *))
      ((* set next_value = next_highlight|trim|replace('\r\n', '\n')|replace('\r', '\n') *))
      ((* set next_value = ' '.join(next_value.split()) *))
      ((* set tech_line = "Technologies - " ~ next_value *))
      detail_line([<<tech_line|replace('\\(', '(')|replace('\\)', ')')>>]);
      ((* set skip_next_highlight = True *))
      ((* elif lowered_multiline_highlight.startswith("technologies\n") *))
      ((* set tech_split = normalized_highlight.split('\n', 1) *))
      ((* if tech_split|length > 1 *))
      ((* set tech_body = ' '.join(tech_split[1].split()) *))
      ((* set tech_body = tech_body.lstrip('-')|trim *))
      ((* if tech_body *))
      ((* set tech_line = "Technologies - " ~ tech_body *))
      ((* else *))
      ((* set tech_line = "Technologies" *))
      ((* endif *))
      ((* else *))
      ((* set tech_line = single_line_highlight *))
      ((* endif *))
      detail_line([<<tech_line|replace('\\(', '(')|replace('\\)', ')')>>]);
      ((* elif lowered_highlight.startswith("technologies:") *))
      ((* set tech_parts = single_line_highlight.split(":", 1) *))
      ((* if tech_parts|length > 1 *))
      ((* set tech_label = tech_parts[0]|trim *))
      ((* set tech_value = tech_parts[1]|trim *))
      ((* set tech_line = tech_label ~ ": " ~ tech_value *))
      ((* else *))
      ((* set tech_line = single_line_highlight *))
      ((* endif *))
      detail_line([<<tech_line|replace('\\(', '(')|replace('\\)', ')')>>]);
      ((* elif lowered_highlight.startswith("technologies -") *))
      detail_line([<<single_line_highlight|replace('\\(', '(')|replace('\\)', ')')>>]);
      ((* else *))
      bullet_line([<<single_line_highlight|replace('\\(', '(')|replace('\\)', ')')>>]);
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
