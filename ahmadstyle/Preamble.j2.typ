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
  leading: 0.55em,
  first-line-indent: 0pt
)

// Remove page numbers
#set page(numbering: none)

// List formatting to match LaTeX exactly
#set list(
  indent: 0pt,
  body-indent: 1em,
  spacing: 1pt,
  tight: true,
  marker: [•]
)

// Define design variables
#let design-entries-vertical-space-between-entries = 8pt

// Section formatting function
#let section_heading(title) = {
  v(16pt)
  text(
    size: 11pt,
    weight: "bold",
    upper(title)
  )
  v(-4pt)
  line(length: 100%, stroke: 0.4pt)
  v(4pt)
}