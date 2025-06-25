// Normal entry (for professional development, awards, etc.)
((*- if entry.summary and entry.location -*))
// Professional development format: Course name, then Institution | Location
#grid(
  columns: (1fr, auto),
  align: (left, right),
  strong("<<entry.name>>"),
  "<<entry.date_string>>"
)
_<<entry.summary>>_ #h(1fr) <<entry.location>>

((*- else -*))
// Awards format: Award name, then organization and highlights
#grid(
  columns: (1fr, auto),
  align: (left, right),
  strong("<<entry.name>>"),
  "<<entry.date_string>>"
)

((*- if entry.summary -*))
_<<entry.summary>>_

((*- endif -*))

((*- if entry.highlights -*))
((*- for highlight in entry.highlights -*))
<<highlight>>

((*- endfor -*))
((*- endif -*))
((*- endif -*))

#v(8pt)