// Normal entry (for professional development, awards, etc.)
#grid(
  columns: (1fr, auto),
  align: (left, right),
  [
    *<<entry.name>>*
    ((* if entry.summary *))
    \ _<<entry.summary>>_
    ((* endif *))
  ],
  "<<entry.date_string>>"
)

((* if entry.location *))
#grid(
  columns: (1fr, auto),
  align: (left, right),
  "",
  "<<entry.location>>"
)
((* endif *))

((* if entry.highlights *))
((* for highlight in entry.highlights *))

<<highlight>>
((* endfor *))
((* endif *))