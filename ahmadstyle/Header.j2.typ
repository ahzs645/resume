// Header matching LaTeX formatting exactly
#text(
  size: 26pt,
  weight: "bold",
  "<<cv.name>>"
)

#v(-16pt)  // Match LaTeX \vspace{6pt}

// Contact information with proper spacing around pipes and correct phone formatting
#text(size: 14pt)[
  #text("<<cv.email>>")
  ((*- if cv.phone -*))
  #text(" | ")
  #text("(<<cv.phone|string|replace('tel:', '')|replace('+1-', '')|replace('-', ') ', 1)>>")
  ((*- endif -*))
  ((*- if cv.location -*))
  #text(" | ")
  #text("<<cv.location>>")
  ((*- endif -*))
  ((*- if cv.website -*))
  #text(" | ")
  ((* if design.website_link_color == "blue" *))
  #text(fill: blue)[#link("<<cv.website>>")[<<cv.website|string|replace('https://', '')|replace('http://', '')|replace('/', '')>>]]
  ((* else *))
  #text(fill: black)[#link("<<cv.website>>")[<<cv.website|string|replace('https://', '')|replace('http://', '')|replace('/', '')>>]]
  ((* endif *))
  ((*- endif -*))
]

#v(-10pt)  // Reduced spacing before horizontal line
#line(length: 100%, stroke: 0.4pt)
#v(-10pt)  // Reduced spacing after horizontal line
