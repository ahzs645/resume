// Simplified Publication entry - matching other template patterns

// Title in bold with date
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(weight: "bold", "<<entry.title>>"),
  ((*- if entry.date -*))
  "<<entry.date>>"
  ((*- else -*))
  ""
  ((*- endif -*))
)

#v(-6pt)

// Journal in italics
((*- if entry.journal -*))
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(style: "italic", "<<entry.journal>>"),
  ""
)
#v(-6pt)
((*- endif -*))

// Authors
((*- if entry.authors -*))
#text(
  ((*- for author in entry.authors -*))
  "<<author>>"((*- if not loop.last -*)), ((*- endif -*))
  ((*- endfor -*))
)
((*- endif -*))

((*- if entry.doi -*))
#v(-4pt)
DOI: <<entry.doi>>
((*- endif -*))

#v(8pt)