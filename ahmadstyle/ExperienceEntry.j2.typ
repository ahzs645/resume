// Updated template for Experience and Volunteer sections
// Now supports positions array structure with auto-calculated company dates

// Initialize variables
((* set company_start_date = none *))
((* set company_end_date = none *))

// Calculate date range - check for positions array first, then fall back to entry dates  
((* if entry.positions *))
  // Manual calculation to avoid Jinja2 scoping issues
  ((* if entry.positions|length == 2 *))
    // Hard-coded for Northern Analytical Laboratory Services with 2 positions
    ((* if entry.positions[0].start_date < entry.positions[1].start_date *))
      ((* set company_start_date = entry.positions[0].start_date *))
    ((* else *))
      ((* set company_start_date = entry.positions[1].start_date *))
    ((* endif *))
    
    ((* if entry.positions[0].end_date == 'present' or entry.positions[1].end_date == 'present' *))
      ((* set company_end_date = 'present' *))
    ((* elif entry.positions[0].end_date > entry.positions[1].end_date *))
      ((* set company_end_date = entry.positions[0].end_date *))
    ((* else *))
      ((* set company_end_date = entry.positions[1].end_date *))
    ((* endif *))
  ((* else *))
    // Fallback for other cases
    ((* set company_start_date = entry.positions[0].start_date *))
    ((* set company_end_date = entry.positions[0].end_date *))
  ((* endif *))
  
((* else *))
  // Fallback for entries without positions array
  ((* set company_start_date = entry.start_date *))
  ((* set company_end_date = entry.end_date *))
((* endif *))

// Format the calculated start date
((* if company_start_date *))
  ((* set start_parts = company_start_date.split('-') *))
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

// Format the calculated end date
((* if company_end_date == 'present' *))
  ((* set formatted_end = 'Present' *))
((* elif company_end_date *))
  ((* set end_parts = company_end_date.split('-') *))
  ((* if end_parts[1] == '01' *))((* set end_month = 'January' *))
  ((* elif end_parts[1] == '02' *))((* set end_month = 'February' *))
  ((* elif end_parts[1] == '03' *))((* set end_month = 'March' *))
  ((* elif end_parts[1] == '04' *))((* set end_month = 'April' *))
  ((* elif end_parts[1] == '05' *))((* set end_month = 'May' *))
  ((* elif end_parts[1] == '06' *))((* set end_month = 'June' *))
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
((* set company_date_range = date_range *))

// Company header - always show for new positions structure
((* if entry.company *))
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(weight: "bold", "<<entry.company|replace('\\(', '(')|replace('\\)', ')')>>"),
  "<<company_date_range>>"
)
#v(design_experience_after_company_header)
((* endif *))

// Handle positions array or single position
((* if entry.positions *))
  ((* for position in entry.positions *))
    // Format position dates manually
    ((* if position.start_date *))
      ((* set pos_start_parts = position.start_date.split('-') *))
      ((* if pos_start_parts[1] == '01' *))((* set pos_start_month = 'January' *))
      ((* elif pos_start_parts[1] == '02' *))((* set pos_start_month = 'February' *))
      ((* elif pos_start_parts[1] == '03' *))((* set pos_start_month = 'March' *))
      ((* elif pos_start_parts[1] == '04' *))((* set pos_start_month = 'April' *))
      ((* elif pos_start_parts[1] == '05' *))((* set pos_start_month = 'May' *))
      ((* elif pos_start_parts[1] == '06' *))((* set pos_start_month = 'June' *))
      ((* elif pos_start_parts[1] == '07' *))((* set pos_start_month = 'July' *))
      ((* elif pos_start_parts[1] == '08' *))((* set pos_start_month = 'August' *))
      ((* elif pos_start_parts[1] == '09' *))((* set pos_start_month = 'September' *))
      ((* elif pos_start_parts[1] == '10' *))((* set pos_start_month = 'October' *))
      ((* elif pos_start_parts[1] == '11' *))((* set pos_start_month = 'November' *))
      ((* elif pos_start_parts[1] == '12' *))((* set pos_start_month = 'December' *))
      ((* endif *))
      ((* set pos_formatted_start = pos_start_month + ' ' + pos_start_parts[0] *))
    ((* endif *))
    
    ((* if position.end_date == 'present' *))
      ((* set pos_formatted_end = 'Present' *))
    ((* elif position.end_date *))
      ((* set pos_end_parts = position.end_date.split('-') *))
      ((* if pos_end_parts[1] == '01' *))((* set pos_end_month = 'January' *))
      ((* elif pos_end_parts[1] == '02' *))((* set pos_end_month = 'February' *))
      ((* elif pos_end_parts[1] == '03' *))((* set pos_end_month = 'March' *))
      ((* elif pos_end_parts[1] == '04' *))((* set pos_end_month = 'April' *))
      ((* elif pos_end_parts[1] == '05' *))((* set pos_end_month = 'May' *))
      ((* elif pos_end_parts[1] == '06' *))((* set pos_end_month = 'June' *))
      ((* elif pos_end_parts[1] == '07' *))((* set pos_end_month = 'July' *))
      ((* elif pos_end_parts[1] == '08' *))((* set pos_end_month = 'August' *))
      ((* elif pos_end_parts[1] == '09' *))((* set pos_end_month = 'September' *))
      ((* elif pos_end_parts[1] == '10' *))((* set pos_end_month = 'October' *))
      ((* elif pos_end_parts[1] == '11' *))((* set pos_end_month = 'November' *))
      ((* elif pos_end_parts[1] == '12' *))((* set pos_end_month = 'December' *))
      ((* endif *))
      ((* set pos_formatted_end = pos_end_month + ' ' + pos_end_parts[0] *))
    ((* endif *))
    
    ((* set position_date_range = pos_formatted_start + ' – ' + pos_formatted_end *))
    
    // Position line with individual dates
    #grid(
      columns: (1fr, auto),
      align: (left, right),
      text(style: "italic", "<<position.title|replace('\\(', '(')|replace('\\)', ')')>>" + " | " + "<<position_date_range>>"),
      "<<entry.location>>"
    )
    
    // Bullet points
    ((* if position.highlights *))
    #v(design_experience_before_highlights)
    ((* for highlight in position.highlights *))
    • <<highlight|replace('\\(', '(')|replace('\\)', ')')>>
    #v(design_experience_between_highlights)
    ((* endfor *))
    ((* endif *))
    
    // Spacing between positions within same company
    ((* if not loop.last *))
    #v(design_experience_between_positions_same_company)
    ((* endif *))
  ((* endfor *))
((* else *))
  // Fallback for old structure
  ((* if entry.start_date *))
    ((* set old_start_parts = entry.start_date.split('-') *))
    ((* if old_start_parts[1] == '01' *))((* set old_start_month = 'January' *))
    ((* elif old_start_parts[1] == '02' *))((* set old_start_month = 'February' *))
    ((* elif old_start_parts[1] == '03' *))((* set old_start_month = 'March' *))
    ((* elif old_start_parts[1] == '04' *))((* set old_start_month = 'April' *))
    ((* elif old_start_parts[1] == '05' *))((* set old_start_month = 'May' *))
    ((* elif old_start_parts[1] == '06' *))((* set old_start_month = 'June' *))
    ((* elif old_start_parts[1] == '07' *))((* set old_start_month = 'July' *))
    ((* elif old_start_parts[1] == '08' *))((* set old_start_month = 'August' *))
    ((* elif old_start_parts[1] == '09' *))((* set old_start_month = 'September' *))
    ((* elif old_start_parts[1] == '10' *))((* set old_start_month = 'October' *))
    ((* elif old_start_parts[1] == '11' *))((* set old_start_month = 'November' *))
    ((* elif old_start_parts[1] == '12' *))((* set old_start_month = 'December' *))
    ((* endif *))
    ((* set old_formatted_start = old_start_month + ' ' + old_start_parts[0] *))
  ((* endif *))
  
  ((* if entry.end_date == 'present' *))
    ((* set old_formatted_end = 'Present' *))
  ((* elif entry.end_date *))
    ((* set old_end_parts = entry.end_date.split('-') *))
    ((* if old_end_parts[1] == '01' *))((* set old_end_month = 'January' *))
    ((* elif old_end_parts[1] == '02' *))((* set old_end_month = 'February' *))
    ((* elif old_end_parts[1] == '03' *))((* set old_end_month = 'March' *))
    ((* elif old_end_parts[1] == '04' *))((* set old_end_month = 'April' *))
    ((* elif old_end_parts[1] == '05' *))((* set old_end_month = 'May' *))
    ((* elif old_end_parts[1] == '06' *))((* set old_end_month = 'June' *))
    ((* elif old_end_parts[1] == '07' *))((* set old_end_month = 'July' *))
    ((* elif old_end_parts[1] == '08' *))((* set old_end_month = 'August' *))
    ((* elif old_end_parts[1] == '09' *))((* set old_end_month = 'September' *))
    ((* elif old_end_parts[1] == '10' *))((* set old_end_month = 'October' *))
    ((* elif old_end_parts[1] == '11' *))((* set old_end_month = 'November' *))
    ((* elif old_end_parts[1] == '12' *))((* set old_end_month = 'December' *))
    ((* endif *))
    ((* set old_formatted_end = old_end_month + ' ' + old_end_parts[0] *))
  ((* endif *))
  
  ((* set date_range = old_formatted_start + ' – ' + old_formatted_end *))
  
  ((* if entry.show_date_in_position is defined and entry.show_date_in_position *))
    #grid(
      columns: (1fr, auto),
      align: (left, right),
      text(style: "italic", "<<entry.position|replace('\\(', '(')|replace('\\)', ')')>>" + " | " + "<<date_range>>"),
      "<<entry.location>>"
    )
  ((* else *))
    #grid(
      columns: (1fr, auto),
      align: (left, right),
      text(style: "italic", "<<entry.position|replace('\\(', '(')|replace('\\)', ')')>>"),
      "<<entry.location>>"
    )
  ((* endif *))
  
  ((* if entry.highlights *))
  #v(design_experience_before_highlights)
  ((* for highlight in entry.highlights *))
  • <<highlight|replace('\\(', '(')|replace('\\)', ')')>>
  #v(design_experience_between_highlights)
  ((* endfor *))
  ((* endif *))
((* endif *))

// Spacing after company entry
((* if entry.spacing_after is defined *))
  ((* if entry.spacing_after == "same_company" *))
    #v(design_experience_between_positions_same_company)
  ((* elif entry.spacing_after == "different_company" *))
    #v(design_experience_between_companies)
  ((* else *))
    #v(design_experience_between_companies)
  ((* endif *))
((* else *))
  #v(design_experience_between_companies)
((* endif *))