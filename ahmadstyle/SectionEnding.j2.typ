// Section ending - negative spacing to reduce gap before next section
#v(design_section_ending_spacing)
// Each entry type ends with its own spacing (the gap between companies, between
// paragraphs, between skill lines). Even that out so the next heading always
// sits the same distance below the section above it.
{% if entry_type == "ExperienceEntry" %}
#v(design_section_ending_after_experience)
{% elif entry_type == "TextEntry" %}
#v(design_section_ending_after_text)
{% elif entry_type == "OneLineEntry" %}
#v(design_section_ending_after_one_line)
{% endif %}
