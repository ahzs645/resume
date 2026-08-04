// Header matching LaTeX formatting exactly
{# Tyler Style keeps links to two choices: the Typst built-in `blue` for a
   hyperlink look, or `black` so they read as ordinary body text. #}
{% set header_link_color = "blue" if design.website_link_color == "blue" else "black" %}

#text(
  size: 26pt,
  weight: "bold",
  "{{ cv.name }}"
)

#v(-16pt)  // Match LaTeX \vspace{6pt}

// Contact information with proper spacing around pipes and correct phone formatting
#text(size: 14pt)[
  #text("{{ cv.email }}")
  {%- if cv.phone -%}
  #text(" | ")
  #text("({{ cv.phone|string|replace('tel:', '')|replace('+1-', '')|replace('-', ') ', 1) }}")
  {%- endif -%}
  {%- if cv.location -%}
  #text(" | ")
  #text("{{ cv.location }}")
  {%- endif -%}
  {%- if cv.website -%}
  #text(" | ")
  #text(fill: {{ header_link_color }})[#link("{{ cv.website }}")[{{ cv.website|string|replace('https://', '')|replace('http://', '')|replace('/', '') }}]]
  {%- endif -%}
  {%- for sn in cv.social_networks or [] -%}
  #text(" | ")
  #text(fill: {{ header_link_color }})[#link("{{ sn.url }}")[{{ sn.network }}]]
  {%- endfor -%}
  {%- for c in cv.custom_connections or [] -%}
  #text(" | ")
  {%- if c.url -%}
  #text(fill: {{ header_link_color }})[#link("{{ c.url }}")[{{ c.placeholder }}]]
  {%- else -%}
  #text("{{ c.placeholder }}")
  {%- endif -%}
  {%- endfor -%}
]

#v(-10pt)  // Reduced spacing before horizontal line
#line(length: 100%, stroke: 0.4pt)
#v(-10pt)  // Reduced spacing after horizontal line
