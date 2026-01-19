
((* if section_title in design.pagebreak_before_sections *))
#pagebreak()
((* endif *))

((* if section_title == "Certifications Skills" *))
#section_heading("Certifications & Skills")
((* elif section_title == "Media" *))
#section_heading("Media Links")
((* else *))
#section_heading("<<section_title>>")
((* endif *))

// No additional spacing here - section_heading already includes the correct 4pt spacing
