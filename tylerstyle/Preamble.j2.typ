#set page(
  paper: "us-letter",
  margin: 1.27cm,
)

#set text(
  font: "GoogleSansFlex_9pt",
  size: <<design.font_size>>,
  lang: "en",
  region: "US",
)

#set par(
  justify: false,
  leading: 0.52em,  // Slightly reduced to match LaTeX more closely
  first-line-indent: 0pt
)

// Configure headings for PDF outline without affecting visual layout
// We handle all visual styling in section_heading function
#set heading(numbering: none)
#show heading: it => it.body  // Strip default heading styling, we apply our own

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
#let design_experience_after_company_header = -6pt              // Space after company name line
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
#let design_media_between_lines = -4pt
#let design_media_between_entries = -6pt
#let design_certifications_between_entries = -18pt
#let design_skills_between_entries = -18pt
#let design_bullet_gap = 6pt
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

// Page break control - set to false to allow sections to break across pages
#let keep_sections_together = <<design.keep_sections_together|lower>>
#let keep_entries_together = <<design.keep_entries_together|lower>>
#let prevent_orphaned_headers = <<design.prevent_orphaned_headers|lower>>

// Helper function to wrap content with optional page break prevention
#let section_content(body) = {
  if keep_sections_together {
    block(breakable: false, body)
  } else {
    body
  }
}

// Helper function to wrap individual entries with optional page break prevention
#let entry_content(body) = {
  if keep_entries_together {
    block(breakable: false, body)
  } else {
    body
  }
}

// Section formatting function - tighter spacing after section header
// Uses heading element for PDF outline/bookmark support
#let section_heading(title) = {
  // Add a weak page break before sections when keep_sections_together is enabled
  // This encourages page breaks between sections rather than within them
  if keep_sections_together {
    pagebreak(weak: true)
  }

  // Prevent orphaned headers by adding page break avoidance before the header
  // This makes the header stick to the content that follows it
  if prevent_orphaned_headers {
    // Encourage page break before the header if needed, but keep header with content below
    v(16pt, weak: false)  // Space before section title - not weak, so it sticks
  } else {
    v(16pt)  // Space before section title
  }

  // Use heading element for PDF outline/navigation support
  // outlined: true adds it to PDF bookmarks, bookmarked: true ensures it appears in navigation
  heading(
    level: 1,
    outlined: true,
    bookmarked: true,
    text(
      size: <<design.section_heading_size>>,
      weight: "bold",
      upper(title)
    )
  )
  v(-10pt)  // Adjust for rule positioning
  line(length: 100%, stroke: 0.4pt)

  // This is the key: make the spacing after the header non-breakable
  if prevent_orphaned_headers {
    v(-2pt, weak: false)  // Reduced spacing after section - keep header with first entry
  } else {
    v(-2pt)  // Reduced spacing after section (closer to first entry)
  }
}

// Consistent bullet layout helper
#let bullet_line(body) = grid(
  columns: (auto, 1fr),
  gutter: design_bullet_gap,
  align: (top, top),
  text("•"),
  body
)

// Left-aligned helper (same spacing as normal text, no bullet indent)
#let detail_line(body) = grid(
  columns: (1fr),
  align: (top),
  body
)
