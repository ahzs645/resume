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

// Define design variables for consistent spacing
#let design-entries-vertical-space-between-entries = 8pt
#let design_experience_new_company_spacing = 6pt
#let design_experience_same_company_spacing = 4pt
#let design_experience_after_company_header = -6pt
#let design_experience_before_highlights = -4pt
#let design_experience_between_highlights = -6pt
#let design_section_ending_spacing = -8pt
#let design_normal_entry_paragraph_spacing = 1pt     // Restored to original for awards/other sections
#let design_normal_entry_between_entries = -6pt      // Restored to original for awards/other sections
#let design_professional_dev_paragraph_spacing = -6pt  // Matches other highlight spacing
#let design_professional_dev_between_entries = -8pt    // Matches education after-entry spacing
#let design_education_after_institution = -6pt
#let design_education_before_highlights = -4pt
#let design_education_between_highlights = -6pt  // Now matches experience spacing
#let design_education_after_entry = -4pt

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