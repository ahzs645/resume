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
= {{ cv.name }}
{% endif %}

{% if cv.headline %}
  #headline([{{ cv.headline }}])

{% endif %}
{% if cv.location %}
#align(center)[#text(size: 8pt, style: "italic")[{{ cv.location }}]]
#v(0.1cm)
{% endif %}
#connections(
{% for connection in cv._connections %}
{% if not (cv.location and loop.index0 == 0) %}
  [{{ connection }}],
{% endif %}
{% endfor %}
)
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
