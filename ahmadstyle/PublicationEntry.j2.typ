// Publication entry - academic citation format
((*- for author in entry.authors -*))
<<author>>((*- if not loop.last -*)), ((*- endif -*))
((*- endfor -*)).
((*- if entry.date -*)) (<<entry.date>>). ((*- endif -*))
**<<entry.title>>**.
((*- if entry.journal -*)) _<<entry.journal>>_((*- endif -*)).
((*- if entry.doi -*)) <<entry.doi>>((*- endif -*))..