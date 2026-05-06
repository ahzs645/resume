#content-area[
#set list(indent: 0.25cm, body-indent: 0.35em, spacing: 0pt)
  - {{ entry.bullet|replace("\\[", "[")|replace("\\]", "]")|replace('\\"', '"') }}
]
