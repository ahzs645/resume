// Header matching LaTeX formatting exactly
#text(
  size: 26pt, 
  weight: "bold",
  "<<cv.name>>"
)

#v(6pt)

// Contact information in 14pt like LaTeX
#text(size: 14pt)[
  #raw("<<cv.email>>")
  ((*- if cv.phone -*))
   | <<cv.phone>>
  ((*- endif -*))
  ((*- if cv.location -*))
   | <<cv.location>>
  ((*- endif -*))
  ((*- if cv.website -*))
   | #raw("<<cv.website|string|replace('https://', '')|replace('http://', '')>>")
  ((*- endif -*))
]

#v(-4pt)
#line(length: 100%, stroke: 0.4pt)
#v(-4pt)