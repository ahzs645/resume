#content-area[
{% for line in entry.main_column.splitlines() %}
  {{ line|replace("\\[", "[")|replace("\\]", "]")|replace('\\"', '"')|indent(2) }}

{% endfor %}
]
