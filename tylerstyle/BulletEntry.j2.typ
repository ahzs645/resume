// Bullet entry with section-aware spacing
#entry_content({
  bullet_line([<<entry.bullet|replace('\\(', '(')|replace('\\)', ')')>>])
})

((* if section_title|lower == "skills" *))
#v(design_skills_between_entries)
((* endif *))
