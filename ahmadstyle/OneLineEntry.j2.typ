// One line entry (for skills) - conditional bullet points
((* if section_title == "Certifications Skills" or section_title == "certifications_skills" *))
*<<entry.label|safe>>:* <<entry.details|safe>>
#v(design_certifications_skills_between_entries)
((* else *))
• *<<entry.label|safe>>:* <<entry.details|safe>>
#v(design-entries-vertical-space-between-entries)
((* endif *))