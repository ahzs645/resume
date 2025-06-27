// Experience entry with automatic date formatting matching LaTeX exactly

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

// Company header - only show if this is the first position at a company
((* if entry.company and entry.company != "" *))
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(weight: "bold", "<<entry.company>>"),
  "<<date_range>>"
)
((* endif *))
#v(-6pt)
// Position line - use raw Jinja2 output to prevent escaping
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(style: "italic", "<<entry.position|safe>>" + " | " + "<<date_range>>"),
  "<<entry.location>>"
)

// Bullet points with LaTeX-matching spacing
((* if entry.highlights *))
#v(-4pt)
((* for highlight in entry.highlights *))
• <<highlight>>
#v(-6pt)
((* endfor *))
((* endif *))

// Spacing control - match LaTeX exactly
((* if entry.company and entry.company != "" *))
#v(8pt)  // Full spacing for new companies
((* else *))
#v(1pt)  // Minimal spacing for additional positions at same company
((* endif *))