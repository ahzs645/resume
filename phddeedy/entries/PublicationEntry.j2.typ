#content-area[
{% for line in entry.main_column.splitlines() %}
  {{ line|indent(2) }}

{% endfor %}
]
