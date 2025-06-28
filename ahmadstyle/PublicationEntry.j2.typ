// Publication entry template - handles ONE publication entry
// Authors list
((*- for author in entry.authors -*))
<<author>>((*- if not loop.last -*)), ((*- endif -*))
((*- endfor -*)).
((*- if entry.date -*)) (<<entry.date>>). ((*- endif -*))
*<<entry.title>>*.
((*- if entry.journal -*)) _<<entry.journal>>_((*- endif -*)).
((*- if entry.doi -*)) <<entry.doi>>((*- endif -*)).

#v(design-entries-vertical-space-between-entries)