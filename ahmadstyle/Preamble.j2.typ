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
#let design_experience_new_company_spacing = 2pt                  // Space between different companies
#let design_experience_after_company_header = -8pt
#let design_experience_before_highlights = -4pt
#let design_experience_between_highlights = -6pt
#let design_experience_between_positions_same_company = -6pt      // Space between positions at same company
#let design_section_ending_spacing = -8pt
#let design_normal_entry_paragraph_spacing = 1pt
#let design_normal_entry_between_entries = -6pt
#let design_professional_dev_after_name = -6pt        // Spacing after name/title
#let design_professional_dev_after_summary = -4pt     // Spacing after summary/institution
#let design_professional_dev_between_entries = 0pt  // Spacing between different entries
#let design_awards_after_name = -6pt                   // Spacing after award name/title
#let design_awards_after_summary = -4pt                // Spacing after awarding body/summary
#let design_awards_paragraph_spacing = -6pt            // Spacing between highlight paragraphs
#let design_awards_between_entries = -4pt              // Spacing between different awards
#let design_education_after_institution = -6pt
#let design_education_before_highlights = -4pt
#let design_education_between_highlights = -6pt
#let design_education_after_entry = -4pt
#let design_presentation_after_title = -6pt            // Spacing after presentation title
#let design_presentation_before_highlights = -4pt      // Spacing before highlights (if any)
#let design_presentation_between_highlights = -6pt     // Spacing between highlight items
#let design_presentation_between_entries = -4pt        // Spacing between different presentations
#let design_publication_spacing = 8pt
#let design_publication_after_title = -6pt
#let design_publication_after_journal = -6pt
#let design_publication_after_authors = -4pt



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