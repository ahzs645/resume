// Combined Certifications & Skills section template
// Groups all certifications and skills into two lines without bullets

// One line entry (for combined certifications & skills) - no bullet points
{% if entry.label|trim %}*{{ entry.label }}:* {% endif %}{{ entry.details|replace('\\(', '(')|replace('\\)', ')') }}
#v(design_certifications_skills_between_entries)