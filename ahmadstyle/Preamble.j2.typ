#set page(
  paper: "<<design.page_size>>",
  margin: (top: 1.27cm, bottom: 1.27cm, left: 1.27cm, right: 1.27cm),
)

#set text(
  font: "Times New Roman",
  size: <<design.font_size>>,
  lang: "<<locale.language>>",
  region: "<<locale.language.upper()>>",
)

#set par(justify: false, leading: 0.65em)

// Remove page numbers
#set page(numbering: none)

// Define design variables
#let design-entries-vertical-space-between-entries = 8pt

// Section formatting
#let section_heading(title) = {
  v(16pt)
  upper(strong(title))
  v(-4pt)
  line(length: 100%, stroke: 0.4pt)
  v(-4pt)
}

// Organization header with date range
#let org_header(company, total_dates, location) = {
  v(8pt)
  grid(
    columns: (1fr, auto),
    align: (left, right),
    strong(company),
    [#total_dates \ #location]
  )
}

// Position with dates
#let position_line(position, dates, location: none) = {
  if location != none {
    grid(
      columns: (1fr, auto),
      align: (left, right),
      emph(position),
      [#dates \ #location]
    )
  } else {
    grid(
      columns: (1fr, auto), 
      align: (left, right),
      emph(position),
      dates
    )
  }
}

// Bullet list formatting
#let bullet_list(items) = {
  for item in items {
    [• #item]
    linebreak()
  }
}