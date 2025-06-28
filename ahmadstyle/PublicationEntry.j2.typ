// Publication entry - matching ExperienceEntry pattern exactly

#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(weight: "bold", "<<entry.title>>"),
  "<<entry.date>>"
)

#v(-6pt)

#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(style: "italic", "<<entry.journal>>"),
  ""
)

#v(-6pt)

((*- for author in entry.authors -*))
<<author>>((*- if not loop.last -*)), ((*- endif -*))
((*- endfor -*))

#v(-4pt)

DOI: <<entry.doi>>

#v(8pt)