// One line entry (for skills/certifications) with section-aware formatting
((* set lowercase_section_title = section_title|lower *))

((* if lowercase_section_title == "certifications skills" or lowercase_section_title == "certifications_skills" or lowercase_section_title == "skills"*))
*<<entry.label|safe>>:* <<entry.details|replace('\\(', '(')|replace('\\)', ')')|safe>>
#v(design_certifications_skills_between_entries)

((* elif lowercase_section_title == "certifications" *))
#entry_content({
  ((* set details_text = entry.details|default("", true)|trim *))
  ((* set has_id_prefix = (details_text|length > 0) and (details_text[:3]|lower == "id:") *))
  ((* if has_id_prefix and (":" in details_text) *))
    ((* set id_value = details_text.split(":", 1)[1]|trim *))
  ((* else *))
    ((* set id_value = details_text *))
  ((* endif *))

  bullet_line(
    grid(
      columns: (1fr, auto),
      align: (left, right),
      text("<<entry.label|replace('\\(', '(')|replace('\\)', ')')|safe>>"),
      ((* if details_text *))
        ((* if has_id_prefix *))
        text([
          #text(weight: "bold")[ID:]
          <<id_value|replace('\\(', '(')|replace('\\)', ')')|safe>>
        ])
        ((* else *))
        text("<<details_text|replace('\\(', '(')|replace('\\)', ')')|safe>>")
        ((* endif *))
      ((* else *))
      ""
      ((* endif *))
    )
  )
})
#v(design_certifications_between_entries)

((* else *))
• *<<entry.label|safe>>:* <<entry.details|replace('\\(', '(')|replace('\\)', ')')|safe>>
#v(design-entries-vertical-space-between-entries)
((* endif *))
