#content-area[
#set list(indent: 0.48cm, body-indent: 0.52em, spacing: 0pt)
  {{ entry|replace("\\[", "[")|replace("\\]", "]")|replace('\\"', '"')|indent(2) }}
]
{% if "Student Best Paper Award" in entry %}
])
{% endif %}
