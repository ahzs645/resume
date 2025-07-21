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

// EXPERIENCE SECTION SPACING - EXPLICIT AND CLEAR
#let design_experience_between_companies = -4pt                   // Gap between different companies
#let design_experience_between_positions_same_company = 0pt     // Tight gap: between positions at same company
#let design_experience_after_company_header = -4pt              // Space after company name line
#let design_experience_before_highlights = -4pt                 // Space before bullet points
#let design_experience_between_highlights = -6pt                // Space between bullet points

// OTHER SECTION SPACING CONTROLS
#let design-entries-vertical-space-between-entries = 12pt
#let design_certifications_skills_between_entries = -8pt        // Negative spacing between certifications and skills
#let design_section_ending_spacing = 4pt
#let design_normal_entry_paragraph_spacing = 1pt
#let design_normal_entry_between_entries = -6pt
#let design_professional_dev_after_name = -6pt        
#let design_professional_dev_after_summary = -4pt     
#let design_professional_dev_between_entries = -6pt    
#let design_awards_after_name = -6pt                   
#let design_awards_after_summary = -4pt                
#let design_awards_paragraph_spacing = -6pt            
#let design_awards_between_entries = -4pt              
#let design_education_after_institution = -6pt
#let design_education_before_highlights = -4pt
#let design_education_between_highlights = -6pt
#let design_education_after_entry = -4pt
#let design_presentation_after_title = -6pt            
#let design_presentation_before_highlights = -4pt      
#let design_presentation_between_highlights = -6pt     
#let design_presentation_between_entries = -4pt        
#let design_publication_spacing = 8pt
#let design_publication_after_title = -6pt
#let design_publication_after_journal = -6pt
#let design_publication_after_authors = -4pt

// Section formatting function - tighter spacing after section header
#let section_heading(title) = {
  v(16pt)  // Space before section title
  text(
    size: 11pt,
    weight: "bold",
    upper(title)
  )
  v(-10pt)  // Adjust for rule positioning
  line(length: 100%, stroke: 0.4pt)
  v(-2pt)  // Reduced spacing after section (closer to first entry)
}