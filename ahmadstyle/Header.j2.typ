// Header matching LaTeX formatting exactly
#text(
  size: 26pt, 
  weight: "bold",
  "<<cv.name>>"
)

#v(-16pt)  // Match LaTeX \vspace{6pt}

// Contact information matching LaTeX 14pt size
#text(size: 14pt)[
  #text("<<cv.email>>") 
  ((*- if cv.phone -*))
   | (<<cv.phone|string|replace('tel:', '')|replace('+1-', '')|replace('-', ') ', 1)>>) 
  ((*- endif -*))
  ((*- if cv.location -*))
   | <<cv.location>> 
  ((*- endif -*))
  ((*- if cv.website -*))
   | #link("<<cv.website>>")[<<cv.website|string|replace('https://', '')|replace('http://', '')>>] 
  ((*- endif -*))
]

#v(-4pt)  // Match LaTeX \vspace{-4pt}
#line(length: 100%, stroke: 0.4pt)
#v(-4pt)  // Match LaTeX \vspace{-4pt}