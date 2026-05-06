{% set deedy_two_column = "Skills" in cv.sections and "Experience" in cv.sections and "Awards" in cv.sections %}
{% if deedy_two_column and section_title == "Skills" %}
#grid(columns: (33fr, 66fr), column-gutter: 0.2cm, align: (top, top), [
{% elif deedy_two_column and section_title == "Experience" %}
], [
{% endif %}
== {{section_title|upper}}
{% if entry_type in ["ReversedNumberedEntry"] %}

#reversed-numbered-entries(
  [
{% endif %}
