// Add this to your main template file
((* if cv.sections.publications *))
#section_heading("Publications")

((* for entry in cv.sections.publications *))
((*- for author in entry.authors -*))
<<author>>((*- if not loop.last -*)), ((*- endif -*))
((*- endfor -*)).
((*- if entry.date -*)) (<<entry.date>>). ((*- endif -*))
*<<entry.title>>*.
((*- if entry.journal -*)) _<<entry.journal>>_((*- endif -*)).
((*- if entry.doi -*)) <<entry.doi>>((*- endif -*)).

((* endfor *))
((* endif *))