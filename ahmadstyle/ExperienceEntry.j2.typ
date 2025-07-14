// Shared template for Experience and Volunteer sections
// Uses explicit spacing control via spacing_after field

// Format start date
((* if entry.start_date *))
  ((* set start_parts = entry.start_date.split('-') *))
  ((* if start_parts[1] == '01' *))((* set start_month = 'January' *))
  ((* elif start_parts[1] == '02' *))((* set start_month = 'February' *))
  ((* elif start_parts[1] == '03' *))((* set start_month = 'March' *))
  ((* elif start_parts[1] == '04' *))((* set start_month = 'April' *))
  ((* elif start_parts[1] == '05' *))((* set start_month = 'May' *))
  ((* elif start_parts[1] == '06' *))((* set start_month = 'June' *))
  ((* elif start_parts[1] == '07' *))((* set start_month = 'July' *))
  ((* elif start_parts[1] == '08' *))((* set start_month = 'August' *))
  ((* elif start_parts[1] == '09' *))((* set start_month = 'September' *))
  ((* elif start_parts[1] == '10' *))((* set start_month = 'October' *))
  ((* elif start_parts[1] == '11' *))((* set start_month = 'November' *))
  ((* elif start_parts[1] == '12' *))((* set start_month = 'December' *))
  ((* endif *))
  ((* set formatted_start = start_month + ' ' + start_parts[0] *))
((* endif *))

// Format end date
((* if entry.end_date == 'present' *))
  ((* set formatted_end = 'Present' *))
((* elif entry.end_date *))
  ((* set end_parts = entry.end_date.split('-') *))
  ((* if end_parts[1] == '01' *))((* set end_month = 'January' *))
  ((* elif end_parts[1] == '02' *))((* set end_month = 'February' *))
  ((* elif end_parts[1] == '03' *))((* set end_month = 'March' *))
  ((* elif end_parts[1] == '04' *))((* set end_month = 'April' *))
  ((* elif end_parts[1] == '05' *))((* set end_month = 'May' *))
  ((* elif start_parts[1] == '06' *))((* set end_month = 'June' *))
  ((* elif end_parts[1] == '07' *))((* set end_month = 'July' *))
  ((* elif end_parts[1] == '08' *))((* set end_month = 'August' *))
  ((* elif end_parts[1] == '09' *))((* set end_month = 'September' *))
  ((* elif end_parts[1] == '10' *))((* set end_month = 'October' *))
  ((* elif end_parts[1] == '11' *))((* set end_month = 'November' *))
  ((* elif end_parts[1] == '12' *))((* set end_month = 'December' *))
  ((* endif *))
  ((* set formatted_end = end_month + ' ' + end_parts[0] *))
((* endif *))

((* set date_range = formatted_start + ' – ' + formatted_end *))

// Company header - show if company is specified and we want to show it
((* set show_company_header = false *))
((* if entry.show_company_header is defined *))
  ((* set show_company_header = entry.show_company_header *))
((* else *))
  // Default: show company header if company is specified
  ((* if entry.company and entry.company != "" *))
    ((* set show_company_header = true *))
  ((* endif *))
((* endif *))

((* if show_company_header *))
  // Use company_date_range if specified, otherwise use individual entry dates
  ((* if entry.company_date_range is defined *))
    ((* set company_date_display = entry.company_date_range *))
  ((* else *))
    ((* set company_date_display = date_range *))
  ((* endif *))
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(weight: "bold", "<<entry.company|replace('\\(', '(')|replace('\\)', ')')>>"),
  "<<company_date_display>>"
)
#v(design_experience_after_company_header)
((* endif *))

// Position line - use explicit show_date_in_position flag
((* if entry.show_date_in_position is defined *))
  ((* if entry.show_date_in_position *))
    // Show date in position line
    #grid(
      columns: (1fr, auto),
      align: (left, right),
      text(style: "italic", "<<entry.position|replace('\\(', '(')|replace('\\)', ')')>>" + " | " + "<<date_range>>"),
      "<<entry.location>>"
    )
  ((* else *))
    // Don't show date in position line
    #grid(
      columns: (1fr, auto),
      align: (left, right),
      text(style: "italic", "<<entry.position|replace('\\(', '(')|replace('\\)', ')')>>"),
      "<<entry.location>>"
    )
  ((* endif *))
((* else *))
  // Fallback to old logic for backwards compatibility
  ((* if entry.company and entry.company != "" *))
    // Single position company - no date in position line
    #grid(
      columns: (1fr, auto),
      align: (left, right),
      text(style: "italic", "<<entry.position|replace('\\(', '(')|replace('\\)', ')')>>"),
      "<<entry.location>>"
    )
  ((* else *))
    // Multiple position company - include date in position line  
    #grid(
      columns: (1fr, auto),
      align: (left, right),
      text(style: "italic", "<<entry.position|replace('\\(', '(')|replace('\\)', ')')>>" + " | " + "<<date_range>>"),
      "<<entry.location>>"
    )
  ((* endif *))
((* endif *))

// Bullet points with LaTeX-matching spacing
((* if entry.highlights *))
#v(design_experience_before_highlights)
((* for highlight in entry.highlights *))
• <<highlight|replace('\\(', '(')|replace('\\)', ')')>>
#v(design_experience_between_highlights)
((* endfor *))
((* endif *))

// EXPLICIT SPACING CONTROL - Much cleaner!
((* if entry.spacing_after is defined *))
  ((* if entry.spacing_after == "same_company" *))
    #v(design_experience_between_positions_same_company)
  ((* elif entry.spacing_after == "different_company" *))
    #v(design_experience_between_companies)
  ((* else *))
    // Fallback to default
    #v(design_experience_between_companies)
  ((* endif *))
((* else *))
  // Fallback to old logic if spacing_after not specified
  ((* if entry.company and entry.company != "" *))
    #v(design_experience_between_positions_same_company)
  ((* else *))
    #v(design_experience_between_companies)
  ((* endif *))
((* endif *))