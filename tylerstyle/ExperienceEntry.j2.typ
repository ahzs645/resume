// Updated template for Experience and Volunteer sections
// Now supports positions array structure with auto-calculated company dates

// Import macros
((* from 'ahmadstyle/components/date_formatter.j2.typ' import format_date *))
((* from 'ahmadstyle/components/unescape.j2.typ' import unescape *))

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

// Format the calculated dates using the macro
((* set formatted_start = format_date(company_start_date) *))
((* set formatted_end = format_date(company_end_date) *))
((* set company_date_range = formatted_start + ' – ' + formatted_end *))

// Wrap entire entry in entry_content to keep it together
#entry_content({
  // Company header - always show for new positions structure
  ((* if entry.company *))
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(weight: "bold", "<<unescape(entry.company)>>"),
    text(weight: "bold", "<<company_date_range>>")
  )
  v(design_experience_after_company_header)
  ((* endif *))

  // Handle positions array or single position
  ((* if entry.positions *))
    ((* for position in entry.positions *))
      // Format position dates using the macro
      ((* set pos_formatted_start = format_date(position.start_date) *))
      ((* set pos_formatted_end = format_date(position.end_date) *))
      ((* set position_date_range = pos_formatted_start + ' – ' + pos_formatted_end *))

      // Position line with individual dates
      grid(
        columns: (1fr, auto),
        align: (left, right),
        text(style: "italic", "<<unescape(position.title)>> | <<position_date_range>>"),
        ((* if entry.location *))
        text(style: "italic", "<<entry.location>>")
        ((* else *))
        ""
        ((* endif *))
      )

      // Bullet points
      ((* if position.highlights *))
      v(design_experience_before_highlights);
      ((* for highlight in position.highlights *))
      bullet_line([<<unescape(highlight)>>]);
      v(design_experience_between_highlights);
      ((* endfor *))
      ((* endif *))

      // Spacing between positions within same company
      ((* if not loop.last *))
      v(design_experience_between_positions_same_company)
      ((* endif *))
    ((* endfor *))
  ((* else *))
    // Fallback for old structure
    ((* set old_formatted_start = format_date(entry.start_date) *))
    ((* set old_formatted_end = format_date(entry.end_date) *))
    ((* set date_range = old_formatted_start + ' – ' + old_formatted_end *))

    ((* if entry.show_date_in_position is defined and entry.show_date_in_position *))
      grid(
        columns: (1fr, auto),
        align: (left, right),
        text(style: "italic")[<<unescape(entry.position)>> | #text(weight: "bold")[<<date_range>>]],
        ((* if entry.location *))
        text(style: "italic", "<<entry.location>>")
        ((* else *))
        ""
        ((* endif *))
      )
    ((* else *))
      grid(
        columns: (1fr, auto),
        align: (left, right),
        text(style: "italic", "<<unescape(entry.position)>>"),
        ((* if entry.location *))
        text(style: "italic", "<<entry.location>>")
        ((* else *))
        ""
        ((* endif *))
      )
    ((* endif *))

    ((* if entry.highlights *))
    v(design_experience_before_highlights);
    ((* for highlight in entry.highlights *))
    bullet_line([<<unescape(highlight)>>]);
    v(design_experience_between_highlights);
    ((* endfor *))
    ((* endif *))
  ((* endif *))
})

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
