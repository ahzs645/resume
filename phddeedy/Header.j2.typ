{% macro image() %}
#pad(left: {{ design.header.photo_space_left }}, right: {{ design.header.photo_space_right }}, image("{{ cv.photo.name }}", width: {{ design.header.photo_width }}))
{% endmacro %}

{% if cv.photo %}
{% set photo = "image(\"" + cv.photo|string + "\", width: "+ design.header.photo_width + ")" %}
#grid(
{% if design.header.photo_position == "left" %}
  columns: (auto, 1fr),
{% else %}
  columns: (1fr, auto),
{% endif %}
  column-gutter: 0cm,
  align: horizon + left,
{% if design.header.photo_position == "left" %}
  [{{ image() }}],
  [
{% else %}
  [
{% endif %}
{% endif %}
{% if cv.name %}
#grid(
  columns: (1fr, auto, 1fr),
  align: (left, center, right),
  [],
  [#text(font: "Lato", weight: 300, size: 21pt, fill: rgb("#5A5A5A"))[{{ cv.name }}]],
  [#text(font: "Raleway", weight: 500, size: 7.5pt, fill: rgb("#333333"))[Last Updated on 24th March 2026]],
)
{% endif %}

#align(center)[
  #text(font: "Raleway", weight: 600, size: 8.5pt, fill: rgb("#333333"))[
{% if cv.website %}
    limhyungtae.github.io
{% endif %}
{% if cv.website and cv.email %} | {% endif %}
{% if cv.email %}
    {{ cv.email|string|replace("@", "\\@") }}
{% endif %}
{% if cv.custom_connections %} | Google Scholar{% endif %}
  ]
]
#v(0.28cm)
#line(length: 100%, stroke: 0.45pt + rgb("#333333"))
#v(0.12cm)
{% if cv.photo %}
{% if design.header.photo_position == "left" %}
  ]
)
{% else %}
  ],
  [{{ image() }}],
)
{% endif %}
{% endif %}
