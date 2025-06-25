// Header with name and contact information
#text(size: 26pt, weight: "bold")[<<cv.name>>]

#v(6pt)

// Contact information line
#text(size: 14pt)[
  <<cv.email>>
  ((*- if cv.phone -*))
   | <<cv.phone>>
  ((*- endif -*))
  ((*- if cv.location -*))
   | <<cv.location>>
  ((*- endif -*))
  ((*- if cv.website -*))
   | <<cv.website|make_a_url_clean>>
  ((*- endif -*))
]

#v(-4pt)
#line(length: 100%, stroke: 0.4pt)
#v(-4pt)