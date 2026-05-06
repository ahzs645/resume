{% if entry_type in ["ReversedNumberedEntry"] %}
  ],
)
{% endif %}
{% set deedy_two_column = "Skills" in cv.sections and "Experience" in cv.sections and "Awards" in cv.sections %}
{% if deedy_two_column and section_title == "Awards" %}
])
{% endif %}
