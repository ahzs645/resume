#set page(
  paper: "us-letter",
  margin: 1.27cm,
)

#set text(
  font: "Times New Roman",
  size: 11pt,
  lang: "en",
  region: "US",
)

#set par(
  justify: false, 
  leading: 0.65em,
  first-line-indent: 0pt
)

// Remove page numbers
#set page(numbering: none)

// List formatting to match LaTeX
#set list(
  indent: 0pt,
  body-indent: 1em,
  spacing: 1pt,
  tight: true,
  marker: [•]
)

// Define design variables that might be referenced
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

// Company header formatting (matches LaTeX \textbf)
#let company_header(name, dates) = {
  v(8pt)
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(weight: "bold", name),
    dates
  )
}

// Position line formatting (matches LaTeX \textit)
#let position_line(title, dates, location) = {
  grid(
    columns: (1fr, auto),
    align: (left, right),
    if dates != "" {
      text(style: "italic", title + " | " + dates)
    } else {
      text(style: "italic", title)
    },
    location
  )
}

// Bullet list with specific spacing
#let experience_bullets(items) = {
  v(2pt)
  for item in items {
    [• #item]
    linebreak()
  }
}