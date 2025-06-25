// Normal entry (for professional development, awards, etc.)
#grid(
  columns: (1fr, auto),
  align: (left, right),
  strong("<<entry.name>>"),
  "<<entry.date_string>>"
)

((*- if entry.summary -*))
_<<entry.summary>>_
((*- endif -*))

((*- if entry.location -*))
#h(1fr) <<entry.location>>
((*- endif -*))

((*- if entry.highlights -*))
((*- for highlight in entry.highlights -*))

<<highlight>>
((*- endfor -*))
((*- endif -*))

#v(8pt)