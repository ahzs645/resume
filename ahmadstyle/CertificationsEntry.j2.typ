// Custom template for certifications section that combines certifications and skills
// This only renders content for the first certification entry

((* if loop.first *))
// Render combined certifications and skills content
*Certifications:* ((* for cert in cv.sections.certifications *))<<cert.name>>((* if not loop.last *)); ((* endif *))((* endfor *))

*Skills:* ((* for skill in cv.sections.skills *))<<skill.details|replace(', ', '; ')>>((* if not loop.last *)); ((* endif *))((* endfor *))
((* endif *))

// Don't render individual certification entries