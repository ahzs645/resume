#set page(
  paper: "us-letter",
  margin: 1.27cm,
)

#set text(
  font: "EB Garamond",
  size: 11pt,
  lang: "en",
  region: "US",
)

#set par(
  justify: false, 
  leading: 0.52em,  // Slightly reduced to match LaTeX more closely
  first-line-indent: 0pt
)

// Remove page numbers
#set page(numbering: none)

// List formatting to match LaTeX exactly: [leftmargin=*, topsep=2pt, itemsep=1pt, parsep=0pt]
#set list(
  indent: 0pt,       // leftmargin=*
  body-indent: 1em,  // Standard bullet indent
  spacing: 1pt,      // itemsep=1pt
  tight: true,       // parsep=0pt
  marker: [•]
)

// Define design variables
#let design-entries-vertical-space-between-entries = 8pt

// Section formatting function - matches LaTeX \titlespacing*{\section}{0pt}{16pt}{8pt}
#let section_heading(title) = {
  v(16pt)  // Match LaTeX 16pt before section
  text(
    size: 11pt,
    weight: "bold",
    upper(title)
  )
  v(-4pt)  // Adjust for rule positioning
  line(length: 100%, stroke: 0.4pt)
  v(4pt)   // Match LaTeX spacing after section
}