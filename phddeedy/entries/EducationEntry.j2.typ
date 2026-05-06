#content-area[
#set list(indent: 0.25cm, body-indent: 0.35em, spacing: 0pt)
{% for line in entry.main_column.splitlines() %}
  {{ line|indent(2) }}

{% endfor %}
]
