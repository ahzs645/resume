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
#let keep_sections_together = false
#let keep_entries_together = true
#let prevent_orphaned_headers = true

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

  text(
    size: 13pt,
    weight: "bold",
    upper(title)
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

// Header matching LaTeX formatting exactly
#text(
  size: 26pt,
  weight: "bold",
  "Ahmad Jalil"
)

#v(-16pt)  // Match LaTeX \vspace{6pt}

// Contact information with proper spacing around pipes and correct phone formatting
#text(size: 14pt)[
  #text("me@ahmadjalil.com")#text(" | ")
  #text("(778) 267-9144")#text(" | ")
  #text("Prince George, BC")#text(" | ")
  #text(fill: black)[#link("https://ahmadjalil.com/")[ahmadjalil.com]]
]

#v(-10pt)  // Reduced spacing before horizontal line
#line(length: 100%, stroke: 0.4pt)
#v(-10pt)  // Reduced spacing after horizontal line

#section_heading("Experience")

// No additional spacing here - section_heading already includes the correct 4pt spacing

// Updated template for Experience and Volunteer sections
// Now supports positions array structure with auto-calculated company dates

// Import macros

// Initialize variables

// Calculate date range - check for positions array first, then fall back to entry dates
  // Manual calculation to avoid Jinja2 scoping issues
    // Hard-coded for Northern Analytical Laboratory Services with 2 positions



// Format the calculated dates using the macro

// Wrap entire entry in entry_content to keep it together
#entry_content({
  // Company header - always show for new positions structure
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(weight: "bold", "Northern Analytical Laboratory Services"),
    text(weight: "bold", "November 2020 – Present")
  )
  v(design_experience_after_company_header)

  // Handle positions array or single position
      // Format position dates using the macro

      // Position line with individual dates
      grid(
        columns: (1fr, auto),
        align: (left, right),
        text(style: "italic", "Research Assistant | September 2022 – Present"),
        text(style: "italic", "Prince George, BC")
      )

      // Bullet points
      v(design_experience_before_highlights);
      bullet_line([Work both independently and in a team in a laboratory environment, performing tasks that involve collection and processing of samples using various instruments while maintaining and calibrating them]);
      v(design_experience_between_highlights);
      bullet_line([Revamped invoicing system to automate payment tracking processes, reducing customer inquiries and improving overall customer satisfaction]);
      v(design_experience_between_highlights);
      bullet_line([Streamlined and optimized laboratory workflow by implementing new methods and protocols, resulting in an increase in sample processing efficiency]);
      v(design_experience_between_highlights);
      bullet_line([Authored and disseminated scientific papers and reports, contributing to the lab's knowledge base]);
      v(design_experience_between_highlights);

      // Spacing between positions within same company
      v(design_experience_between_positions_same_company)
      // Format position dates using the macro

      // Position line with individual dates
      grid(
        columns: (1fr, auto),
        align: (left, right),
        text(style: "italic", "Student Research Assistant | November 2020 – September 2022"),
        text(style: "italic", "Prince George, BC")
      )

      // Bullet points
      v(design_experience_before_highlights);
      bullet_line([Organize, review, and correct research data, creating illustrative graphs and charts for reports]);
      v(design_experience_between_highlights);
      bullet_line([Process data using statistical software including Excel, Prism, and Rstudio, to facilitate thorough data analysis]);
      v(design_experience_between_highlights);
      bullet_line([Apply graphic design skills (Photoshop, Illustrator, InDesign) to create various materials for the Northern Analytical Laboratory Services]);
      v(design_experience_between_highlights);

      // Spacing between positions within same company
})

// Spacing after company entry
  #v(design_experience_between_companies)

#v(design-entries-vertical-space-between-entries)
// Updated template for Experience and Volunteer sections
// Now supports positions array structure with auto-calculated company dates

// Import macros

// Initialize variables

// Calculate date range - check for positions array first, then fall back to entry dates
  // Fallback for entries without positions array

// Format the calculated dates using the macro

// Wrap entire entry in entry_content to keep it together
#entry_content({
  // Company header - always show for new positions structure
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(weight: "bold", "Relentless Pursuit Ventures"),
    text(weight: "bold", "May 2024 – August 2024")
  )
  v(design_experience_after_company_header)

  // Handle positions array or single position
    // Fallback for old structure

      grid(
        columns: (1fr, auto),
        align: (left, right),
        text(style: "italic", "Health Technology Research Analyst (Intern)"),
        text(style: "italic", "Remote")
      )

    v(design_experience_before_highlights);
    bullet_line([Conducted comprehensive research on health technology innovations for seniors in rural and remote communities across Canada]);
    v(design_experience_between_highlights);
    bullet_line([Identified and analyzed key stakeholders in the age-tech and healthcare sectors, including government agencies, healthcare providers, technology companies, and advocacy groups]);
    v(design_experience_between_highlights);
})

// Spacing after company entry
  #v(design_experience_between_companies)

#v(design-entries-vertical-space-between-entries)
// Updated template for Experience and Volunteer sections
// Now supports positions array structure with auto-calculated company dates

// Import macros

// Initialize variables

// Calculate date range - check for positions array first, then fall back to entry dates
  // Manual calculation to avoid Jinja2 scoping issues
    // Hard-coded for Northern Analytical Laboratory Services with 2 positions



// Format the calculated dates using the macro

// Wrap entire entry in entry_content to keep it together
#entry_content({
  // Company header - always show for new positions structure
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(weight: "bold", "Northern Health"),
    text(weight: "bold", "May 2024 – Present")
  )
  v(design_experience_after_company_header)

  // Handle positions array or single position
      // Format position dates using the macro

      // Position line with individual dates
      grid(
        columns: (1fr, auto),
        align: (left, right),
        text(style: "italic", "Informatics Specialists | December 2024 – Present"),
        text(style: "italic", "Prince George, BC")
      )

      // Bullet points
      v(design_experience_before_highlights);
      bullet_line([Led the integration and optimization of health information technologies, improving access to patient/client information and enhancing evidence-based practices across Northern Health regions]);
      v(design_experience_between_highlights);
      bullet_line([Collaborated with clinical leaders, HIM leaders, and physicians to align healthcare systems with operational needs, while designing and maintaining health information management content]);
      v(design_experience_between_highlights);
      bullet_line([Directed change initiatives and provided leadership in recruiting, coaching, and evaluating staff, fostering innovation and supporting the adoption of international coding standards]);
      v(design_experience_between_highlights);

      // Spacing between positions within same company
      v(design_experience_between_positions_same_company)
      // Format position dates using the macro

      // Position line with individual dates
      grid(
        columns: (1fr, auto),
        align: (left, right),
        text(style: "italic", "PICS Intern | May 2024 – December 2024"),
        text(style: "italic", "Prince George, BC")
      )

      // Bullet points
      v(design_experience_before_highlights);
      bullet_line([Utilize Geographic Information Systems (GIS) software to analyze and map data relevant to public health concerns across Northern Health regions]);
      v(design_experience_between_highlights);
      bullet_line([Created and presented comprehensive GIS-based reports to high-level decision-makers to support informed decision-making on public health concerns]);
      v(design_experience_between_highlights);
      bullet_line([Developed a standardized database to track and analyze provincial-wide systems, enhancing data consistency and accessibility across Northern Health regions]);
      v(design_experience_between_highlights);

      // Spacing between positions within same company
})

// Spacing after company entry
  #v(design_experience_between_companies)

#v(design-entries-vertical-space-between-entries)
// Updated template for Experience and Volunteer sections
// Now supports positions array structure with auto-calculated company dates

// Import macros

// Initialize variables

// Calculate date range - check for positions array first, then fall back to entry dates
  // Fallback for entries without positions array

// Format the calculated dates using the macro

// Wrap entire entry in entry_content to keep it together
#entry_content({
  // Company header - always show for new positions structure
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(weight: "bold", "University of Northern British Columbia"),
    text(weight: "bold", "January 2024 – December 2024")
  )
  v(design_experience_after_company_header)

  // Handle positions array or single position
    // Fallback for old structure

      grid(
        columns: (1fr, auto),
        align: (left, right),
        text(style: "italic", "Teaching Assistant"),
        text(style: "italic", "Prince George, BC")
      )

    v(design_experience_before_highlights);
    bullet_line([Contributed to the creation of an online resource hub for nutrition students, providing access to lecture notes, study guides, and additional learning materials]);
    v(design_experience_between_highlights);
})

// Spacing after company entry
  #v(design_experience_between_companies)


// Section ending - negative spacing to reduce gap before next section
#v(design_section_ending_spacing)
#section_heading("Volunteer")

// No additional spacing here - section_heading already includes the correct 4pt spacing

// Updated template for Experience and Volunteer sections
// Now supports positions array structure with auto-calculated company dates

// Import macros

// Initialize variables

// Calculate date range - check for positions array first, then fall back to entry dates
  // Fallback for entries without positions array

// Format the calculated dates using the macro

// Wrap entire entry in entry_content to keep it together
#entry_content({
  // Company header - always show for new positions structure
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(weight: "bold", "St. Vincent De Paul"),
    text(weight: "bold", "December 2020 – Present")
  )
  v(design_experience_after_company_header)

  // Handle positions array or single position
    // Fallback for old structure

      grid(
        columns: (1fr, auto),
        align: (left, right),
        text(style: "italic", "Service Volunteer"),
        text(style: "italic", "Prince George, BC")
      )

    v(design_experience_before_highlights);
    bullet_line([Prepared and served meals to those in need, promoted community wellness, and efficiently managed the distribution of donated goods]);
    v(design_experience_between_highlights);
})

// Spacing after company entry
  #v(design_experience_between_companies)

#v(design-entries-vertical-space-between-entries)
// Updated template for Experience and Volunteer sections
// Now supports positions array structure with auto-calculated company dates

// Import macros

// Initialize variables

// Calculate date range - check for positions array first, then fall back to entry dates
  // Fallback for entries without positions array

// Format the calculated dates using the macro

// Wrap entire entry in entry_content to keep it together
#entry_content({
  // Company header - always show for new positions structure
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(weight: "bold", "Rural eMentoring BC"),
    text(weight: "bold", "September 2020 – Present")
  )
  v(design_experience_after_company_header)

  // Handle positions array or single position
    // Fallback for old structure

      grid(
        columns: (1fr, auto),
        align: (left, right),
        text(style: "italic", "Highschool Mentor"),
        text(style: "italic", "Remote")
      )

    v(design_experience_before_highlights);
    bullet_line([Cultivated a confidential, supportive mentorship with a high school mentee, providing guidance on personal and academic challenges to foster personal and educational development]);
    v(design_experience_between_highlights);
})

// Spacing after company entry
  #v(design_experience_between_companies)

#v(design-entries-vertical-space-between-entries)
// Updated template for Experience and Volunteer sections
// Now supports positions array structure with auto-calculated company dates

// Import macros

// Initialize variables

// Calculate date range - check for positions array first, then fall back to entry dates
  // Fallback for entries without positions array

// Format the calculated dates using the macro

// Wrap entire entry in entry_content to keep it together
#entry_content({
  // Company header - always show for new positions structure
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(weight: "bold", "Over The Edge Newspaper Society"),
    text(weight: "bold", "March 2024 – Present")
  )
  v(design_experience_after_company_header)

  // Handle positions array or single position
    // Fallback for old structure

      grid(
        columns: (1fr, auto),
        align: (left, right),
        text(style: "italic", "Acting Editor-in-Chief"),
        text(style: "italic", "Prince George, BC")
      )

    v(design_experience_before_highlights);
    bullet_line([Negotiated a printing deal with the main newsprint supplier in Prince George, securing the production of 22,000 copies per issue]);
    v(design_experience_between_highlights);
    bullet_line([Redesigned the newspaper's logo and brand image to modernize and align with current media trends]);
    v(design_experience_between_highlights);
    bullet_line([Conducted audience research to identify preferences and tailored content to increase engagement]);
    v(design_experience_between_highlights);
    bullet_line([Centralized information structures to streamline communication and enhance workflow efficiency]);
    v(design_experience_between_highlights);
})

// Spacing after company entry
  #v(design_experience_between_companies)

#v(design-entries-vertical-space-between-entries)
// Updated template for Experience and Volunteer sections
// Now supports positions array structure with auto-calculated company dates

// Import macros

// Initialize variables

// Calculate date range - check for positions array first, then fall back to entry dates
  // Fallback for entries without positions array

// Format the calculated dates using the macro

// Wrap entire entry in entry_content to keep it together
#entry_content({
  // Company header - always show for new positions structure
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(weight: "bold", "Sparklab"),
    text(weight: "bold", "September 2023 – Present")
  )
  v(design_experience_after_company_header)

  // Handle positions array or single position
    // Fallback for old structure

      grid(
        columns: (1fr, auto),
        align: (left, right),
        text(style: "italic", "Technical Analyst"),
        text(style: "italic", "Prince George, BC")
      )

    v(design_experience_before_highlights);
    bullet_line([Engage with researchers to understand their specific needs and challenges in laboratory and field environments]);
    v(design_experience_between_highlights);
    bullet_line([Design customized solutions using CAD (Computer-Aided Design) software to address the unique requirements of various research projects]);
    v(design_experience_between_highlights);
})

// Spacing after company entry
  #v(design_experience_between_companies)

#v(design-entries-vertical-space-between-entries)
// Updated template for Experience and Volunteer sections
// Now supports positions array structure with auto-calculated company dates

// Import macros

// Initialize variables

// Calculate date range - check for positions array first, then fall back to entry dates
  // Fallback for entries without positions array

// Format the calculated dates using the macro

// Wrap entire entry in entry_content to keep it together
#entry_content({
  // Company header - always show for new positions structure
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(weight: "bold", "University of Northern British Columbia"),
    text(weight: "bold", "September 2022 – Present")
  )
  v(design_experience_after_company_header)

  // Handle positions array or single position
    // Fallback for old structure

      grid(
        columns: (1fr, auto),
        align: (left, right),
        text(style: "italic", "Research Ambassador"),
        text(style: "italic", "Prince George, BC")
      )

    v(design_experience_before_highlights);
    bullet_line([Act as a primary liaison between students and the research community at UNBC, promoting engagement and participation in research activities]);
    v(design_experience_between_highlights);
    bullet_line([Organize and lead informational sessions and workshops to educate students about the research process, opportunities, and the significance of research contributions]);
    v(design_experience_between_highlights);
})

// Spacing after company entry
  #v(design_experience_between_companies)

#v(design-entries-vertical-space-between-entries)
// Updated template for Experience and Volunteer sections
// Now supports positions array structure with auto-calculated company dates

// Import macros

// Initialize variables

// Calculate date range - check for positions array first, then fall back to entry dates
  // Fallback for entries without positions array

// Format the calculated dates using the macro

// Wrap entire entry in entry_content to keep it together
#entry_content({
  // Company header - always show for new positions structure
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(weight: "bold", "Northern Health"),
    text(weight: "bold", "April 2023 – Present")
  )
  v(design_experience_after_company_header)

  // Handle positions array or single position
    // Fallback for old structure

      grid(
        columns: (1fr, auto),
        align: (left, right),
        text(style: "italic", "Activity Volunteer"),
        text(style: "italic", "Prince George, BC")
      )

    v(design_experience_before_highlights);
    bullet_line([Assist recreation therapists and engage in activities with residents at Rainbow Lodge & Gateway, a long-term care home and facilities, enhancing their daily lives and well-being]);
    v(design_experience_between_highlights);
    bullet_line([Provide emotional support and reassurance to dementia patients, helping them feel more secure and oriented in their environment]);
    v(design_experience_between_highlights);
    bullet_line([Deepen my understanding of patient-centered medicine through direct interactions, learning about residents' needs and perspectives]);
    v(design_experience_between_highlights);
})

// Spacing after company entry
  #v(design_experience_between_companies)


// Section ending - negative spacing to reduce gap before next section
#v(design_section_ending_spacing)
#section_heading("Projects")

// No additional spacing here - section_heading already includes the correct 4pt spacing

// Normal entry (for professional development, awards, projects, etc.) matching LaTeX


// Wrap entire entry in entry_content to keep it together
#entry_content({
  // Main entry with bold name (hyperlinked if URL available)
  grid(
    columns: (1fr, auto),
    align: (left, right),
    link("https://github.com/ahzs645/WhisperDesk")[#text(weight: "bold", "Whisperdesk")],
    text(weight: "bold", "2024")
  )

  // Add spacing after name - different for Awards vs Professional Development
  v(design_awards_after_name)  // Awards: spacing after name

  // Italic summary line (like institution/organization)
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(style: "italic", "A powerful desktop transcription application powered by native whisper.cpp with persistent state management and real-time progress feedback"),
    ""
  )

  // Add spacing after summary - different for Awards vs Professional Development
  v(design_awards_after_summary)  // Awards: spacing after summary


  // Conditional rendering: bullets for awards, plain text for projects
      // Projects section - plain text without bullets
      [Technologies
    \- C++, Whisper.cpp, Desktop Development];
      v(-6pt);
})

// Conditional spacing based on entry type
#v(design_awards_between_entries)  // Awards spacing between entries

#v(design-entries-vertical-space-between-entries)
// Normal entry (for professional development, awards, projects, etc.) matching LaTeX


// Wrap entire entry in entry_content to keep it together
#entry_content({
  // Main entry with bold name (hyperlinked if URL available)
  grid(
    columns: (1fr, auto),
    align: (left, right),
    link("https://github.com/ahzs645/aethmodular")[#text(weight: "bold", "Aethalometer Analysis")],
    text(weight: "bold", "2024")
  )

  // Add spacing after name - different for Awards vs Professional Development
  v(design_awards_after_name)  // Awards: spacing after name

  // Italic summary line (like institution/organization)
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(style: "italic", "Repository script kit to process aethalometer data from micro aeth for air quality research and environmental monitoring"),
    ""
  )

  // Add spacing after summary - different for Awards vs Professional Development
  v(design_awards_after_summary)  // Awards: spacing after summary


  // Conditional rendering: bullets for awards, plain text for projects
      // Projects section - plain text without bullets
      [Technologies
    \- Python, Data Processing, Environmental Analysis];
      v(-6pt);
})

// Conditional spacing based on entry type
#v(design_awards_between_entries)  // Awards spacing between entries

#v(design-entries-vertical-space-between-entries)
// Normal entry (for professional development, awards, projects, etc.) matching LaTeX


// Wrap entire entry in entry_content to keep it together
#entry_content({
  // Main entry with bold name (hyperlinked if URL available)
  grid(
    columns: (1fr, auto),
    align: (left, right),
    link("https://github.com/ahzs645/whisperdesk-diarization")[#text(weight: "bold", "Whisperdesk Diarization")],
    text(weight: "bold", "2024")
  )

  // Add spacing after name - different for Awards vs Professional Development
  v(design_awards_after_name)  // Awards: spacing after name

  // Italic summary line (like institution/organization)
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(style: "italic", "Advanced Multi-Speaker Diarization Engine with cross-platform C++ implementation using PyAnnote 3.0 ONNX models"),
    ""
  )

  // Add spacing after summary - different for Awards vs Professional Development
  v(design_awards_after_summary)  // Awards: spacing after summary


  // Conditional rendering: bullets for awards, plain text for projects
      // Projects section - plain text without bullets
      [Technologies
    \- C++, ONNX, Machine Learning, Audio Processing];
      v(-6pt);
})

// Conditional spacing based on entry type
#v(design_awards_between_entries)  // Awards spacing between entries

#v(design-entries-vertical-space-between-entries)
// Normal entry (for professional development, awards, projects, etc.) matching LaTeX


// Wrap entire entry in entry_content to keep it together
#entry_content({
  // Main entry with bold name (hyperlinked if URL available)
  grid(
    columns: (1fr, auto),
    align: (left, right),
    link("https://github.com/ahzs645/UNBCDoor")[#text(weight: "bold", "UNBC Door Sign Generator")],
    text(weight: "bold", "2024")
  )

  // Add spacing after name - different for Awards vs Professional Development
  v(design_awards_after_name)  // Awards: spacing after name

  // Italic summary line (like institution/organization)
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(style: "italic", "A web-based tool for generating standardized door signs for the University of Northern British Columbia (UNBC)"),
    ""
  )

  // Add spacing after summary - different for Awards vs Professional Development
  v(design_awards_after_summary)  // Awards: spacing after summary


  // Conditional rendering: bullets for awards, plain text for projects
      // Projects section - plain text without bullets
      [Technologies
    \- Web Development, Design Tools];
      v(-6pt);
})

// Conditional spacing based on entry type
#v(design_awards_between_entries)  // Awards spacing between entries

#v(design-entries-vertical-space-between-entries)
// Normal entry (for professional development, awards, projects, etc.) matching LaTeX


// Wrap entire entry in entry_content to keep it together
#entry_content({
  // Main entry with bold name (hyperlinked if URL available)
  grid(
    columns: (1fr, auto),
    align: (left, right),
    link("https://github.com/ahzs645/printercalibration")[#text(weight: "bold", "Card Printer Calibration")],
    text(weight: "bold", "2024")
  )

  // Add spacing after name - different for Awards vs Professional Development
  v(design_awards_after_name)  // Awards: spacing after name

  // Italic summary line (like institution/organization)
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(style: "italic", "Color management and calibration system specifically designed for ID card printing workflows, ensuring consistent and accurate color reproduction across different printing devices and conditions"),
    ""
  )

  // Add spacing after summary - different for Awards vs Professional Development
  v(design_awards_after_summary)  // Awards: spacing after summary


  // Conditional rendering: bullets for awards, plain text for projects
      // Projects section - plain text without bullets
      [Technologies
    \- Color Management, Calibration Systems, Print Technology];
      v(-6pt);
})

// Conditional spacing based on entry type
#v(design_awards_between_entries)  // Awards spacing between entries

#v(design-entries-vertical-space-between-entries)
// Normal entry (for professional development, awards, projects, etc.) matching LaTeX


// Wrap entire entry in entry_content to keep it together
#entry_content({
  // Main entry with bold name (hyperlinked if URL available)
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(weight: "bold", "Markdown Milker"),
    text(weight: "bold", "2024")
  )

  // Add spacing after name - different for Awards vs Professional Development
  v(design_awards_after_name)  // Awards: spacing after name

  // Italic summary line (like institution/organization)
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(style: "italic", "Collaborative markdown editor enabling multiple users to edit markdown files together in real-time, with drag-and-drop file organization and integrated image management"),
    ""
  )

  // Add spacing after summary - different for Awards vs Professional Development
  v(design_awards_after_summary)  // Awards: spacing after summary


  // Conditional rendering: bullets for awards, plain text for projects
      // Projects section - plain text without bullets
      [Technologies
    \- Real-time Collaboration, Markdown, Web Development];
      v(-6pt);
})

// Conditional spacing based on entry type
#v(design_awards_between_entries)  // Awards spacing between entries


// Section ending - negative spacing to reduce gap before next section
#v(design_section_ending_spacing)
#section_heading("Education")

// No additional spacing here - section_heading already includes the correct 4pt spacing

// Education entry matching LaTeX formatting exactly




// Wrap entire entry in entry_content to keep it together
#entry_content({
  // Institution header with date range (bold institution name)
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(weight: "bold", "University of Northern British Columbia"),
    text(weight: "bold", "")
  )

  v(design_education_after_institution)

  // Degree and area with location (italic degree/area)
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(style: "italic", "PhD, Natural Resources and Environmental Studies"),
    text(style: "italic", "Prince George, BC")
  )// Bullet points for highlights with LaTeX-matching spacing
  v(design_education_before_highlights);  bullet_line([Focus on air quality and environmental health]);
  v(design_education_between_highlights);})

#v(design_education_after_entry)  // Standard spacing after education entries
#v(design-entries-vertical-space-between-entries)
// Education entry matching LaTeX formatting exactly




// Wrap entire entry in entry_content to keep it together
#entry_content({
  // Institution header with date range (bold institution name)
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(weight: "bold", "University of Northern British Columbia"),
    text(weight: "bold", "")
  )

  v(design_education_after_institution)

  // Degree and area with location (italic degree/area)
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(style: "italic", "M.Sc., Natural Resources and Environmental Studies"),
    text(style: "italic", "Prince George, BC")
  )// Bullet points for highlights with LaTeX-matching spacing
  v(design_education_before_highlights);  bullet_line([Focus on air quality and environmental health]);
  v(design_education_between_highlights);  bullet_line([Continued to PhD]);
  v(design_education_between_highlights);})

#v(design_education_after_entry)  // Standard spacing after education entries
#v(design-entries-vertical-space-between-entries)
// Education entry matching LaTeX formatting exactly




// Wrap entire entry in entry_content to keep it together
#entry_content({
  // Institution header with date range (bold institution name)
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(weight: "bold", "University of Northern British Columbia"),
    text(weight: "bold", "")
  )

  v(design_education_after_institution)

  // Degree and area with location (italic degree/area)
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(style: "italic", "B.HSc., Biomedical Studies (Honours)"),
    text(style: "italic", "Prince George, BC")
  )// Bullet points for highlights with LaTeX-matching spacing
  v(design_education_before_highlights);  bullet_line([Minor: Natural Resource Planning and Operations (Forestry)]);
  v(design_education_between_highlights);  bullet_line([The Lieutenant Governor's Medal for Inclusion, Democracy and Reconciliation]);
  v(design_education_between_highlights);})

#v(design_education_after_entry)  // Standard spacing after education entries

// Section ending - negative spacing to reduce gap before next section
#v(design_section_ending_spacing)
#section_heading("Professional Development")

// No additional spacing here - section_heading already includes the correct 4pt spacing

// Normal entry (for professional development, awards, projects, etc.) matching LaTeX


// Wrap entire entry in entry_content to keep it together
#entry_content({
  // Main entry with bold name (hyperlinked if URL available)
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(weight: "bold", "DGT 170 AI Essentials - Building Fluency and Productivity with Modern AI Tools"),
    text(weight: "bold", "February 2025")
  )

  // Add spacing after name - different for Awards vs Professional Development
  v(design_professional_dev_after_name)  // Professional Dev: spacing after name

  // Italic summary line (like institution/organization)
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(style: "italic", "University of Calgary"),
    text(style: "italic", "Remote")
  )

  // Add spacing after summary - different for Awards vs Professional Development
  v(design_professional_dev_after_summary)  // Professional Dev: spacing after summary


})

// Conditional spacing based on entry type
#v(design_professional_dev_between_entries)  // Professional development spacing between entries

#v(design-entries-vertical-space-between-entries)
// Normal entry (for professional development, awards, projects, etc.) matching LaTeX


// Wrap entire entry in entry_content to keep it together
#entry_content({
  // Main entry with bold name (hyperlinked if URL available)
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(weight: "bold", "Digital Twins - Fundamentals, Techniques & Approaches"),
    text(weight: "bold", "March 2024")
  )

  // Add spacing after name - different for Awards vs Professional Development
  v(design_professional_dev_after_name)  // Professional Dev: spacing after name

  // Italic summary line (like institution/organization)
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(style: "italic", "Mohawk College"),
    text(style: "italic", "Remote")
  )

  // Add spacing after summary - different for Awards vs Professional Development
  v(design_professional_dev_after_summary)  // Professional Dev: spacing after summary


})

// Conditional spacing based on entry type
#v(design_professional_dev_between_entries)  // Professional development spacing between entries

#v(design-entries-vertical-space-between-entries)
// Normal entry (for professional development, awards, projects, etc.) matching LaTeX


// Wrap entire entry in entry_content to keep it together
#entry_content({
  // Main entry with bold name (hyperlinked if URL available)
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(weight: "bold", "Applied Internet of Things (IoT)"),
    text(weight: "bold", "May 2023")
  )

  // Add spacing after name - different for Awards vs Professional Development
  v(design_professional_dev_after_name)  // Professional Dev: spacing after name

  // Italic summary line (like institution/organization)
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(style: "italic", "British Columbia Institute of Technology"),
    text(style: "italic", "Vancouver, BC")
  )

  // Add spacing after summary - different for Awards vs Professional Development
  v(design_professional_dev_after_summary)  // Professional Dev: spacing after summary


})

// Conditional spacing based on entry type
#v(design_professional_dev_between_entries)  // Professional development spacing between entries

#v(design-entries-vertical-space-between-entries)
// Normal entry (for professional development, awards, projects, etc.) matching LaTeX


// Wrap entire entry in entry_content to keep it together
#entry_content({
  // Main entry with bold name (hyperlinked if URL available)
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(weight: "bold", "Building Envelope Science"),
    text(weight: "bold", "June 2022")
  )

  // Add spacing after name - different for Awards vs Professional Development
  v(design_professional_dev_after_name)  // Professional Dev: spacing after name

  // Italic summary line (like institution/organization)
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(style: "italic", "Holland College"),
    text(style: "italic", "Remote")
  )

  // Add spacing after summary - different for Awards vs Professional Development
  v(design_professional_dev_after_summary)  // Professional Dev: spacing after summary


})

// Conditional spacing based on entry type
#v(design_professional_dev_between_entries)  // Professional development spacing between entries

#v(design-entries-vertical-space-between-entries)
// Normal entry (for professional development, awards, projects, etc.) matching LaTeX


// Wrap entire entry in entry_content to keep it together
#entry_content({
  // Main entry with bold name (hyperlinked if URL available)
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(weight: "bold", "Covid-19 Contact Tracer"),
    text(weight: "bold", "December 2021")
  )

  // Add spacing after name - different for Awards vs Professional Development
  v(design_professional_dev_after_name)  // Professional Dev: spacing after name

  // Italic summary line (like institution/organization)
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(style: "italic", "John Hopkins University"),
    text(style: "italic", "Remote")
  )

  // Add spacing after summary - different for Awards vs Professional Development
  v(design_professional_dev_after_summary)  // Professional Dev: spacing after summary


})

// Conditional spacing based on entry type
#v(design_professional_dev_between_entries)  // Professional development spacing between entries


// Section ending - negative spacing to reduce gap before next section
#v(design_section_ending_spacing)
#section_heading("Certifications & Skills")

// No additional spacing here - section_heading already includes the correct 4pt spacing

// One line entry (for skills/certifications) with section-aware formatting

*Certifications:* OFA Level 1; TCPS 2; Environmental Professional in Training (EPt)
#v(design_certifications_skills_between_entries)


#v(design-entries-vertical-space-between-entries)
// One line entry (for skills/certifications) with section-aware formatting

*Skills:* Power BI; Research Skills; GIS; R Studio; Brand Identity Maps; Analytical Nature; Adobe Suite; Business Process Reengineering; SPSS; Logistics; Fluent in Arabic; Powerful Decision-Making Expertise; Grant Proposal
#v(design_certifications_skills_between_entries)



// Section ending - negative spacing to reduce gap before next section
#v(design_section_ending_spacing)
#section_heading("Awards")

// No additional spacing here - section_heading already includes the correct 4pt spacing

// Normal entry (for professional development, awards, projects, etc.) matching LaTeX


// Wrap entire entry in entry_content to keep it together
#entry_content({
  // Main entry with bold name (hyperlinked if URL available)
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(weight: "bold", "Canada Graduate Scholarships – Michael Smith Foreign Study Supplements"),
    text(weight: "bold", "January 2025")
  )

  // Add spacing after name - different for Awards vs Professional Development
  v(design_awards_after_name)  // Awards: spacing after name

  // Italic summary line (like institution/organization)
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(style: "italic", "Canadian Institutes of Health Research"),
    ""
  )

  // Add spacing after summary - different for Awards vs Professional Development
  v(design_awards_after_summary)  // Awards: spacing after summary


  // Conditional rendering: bullets for awards, plain text for projects
      // Awards section - plain text without bullets
      [The Government of Canada launched this program in 2008 to support high-calibre graduate students in building global linkages and international networks through the pursuit of exceptional research experiences at research institutions outside of Canada. By accessing international scientific research and training, CGS-MSFSS recipients will contribute to strengthening the potential for collaboration between Canadian and international universities and affiliated research institutions.];
      v(design_awards_paragraph_spacing);
})

// Conditional spacing based on entry type
#v(design_awards_between_entries)  // Awards spacing between entries

#v(design-entries-vertical-space-between-entries)
// Normal entry (for professional development, awards, projects, etc.) matching LaTeX


// Wrap entire entry in entry_content to keep it together
#entry_content({
  // Main entry with bold name (hyperlinked if URL available)
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(weight: "bold", "Canada Graduate Scholarships"),
    text(weight: "bold", "April 2024")
  )

  // Add spacing after name - different for Awards vs Professional Development
  v(design_awards_after_name)  // Awards: spacing after name

  // Italic summary line (like institution/organization)
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(style: "italic", "Canadian Institutes of Health Research"),
    ""
  )

  // Add spacing after summary - different for Awards vs Professional Development
  v(design_awards_after_summary)  // Awards: spacing after summary


  // Conditional rendering: bullets for awards, plain text for projects
      // Awards section - plain text without bullets
      [The Canada Graduate Scholarships is designed to enhance the research skills and training of highly qualified personnel in health, natural sciences, engineering, and social sciences. This prestigious program is jointly administered by Canada's three granting agencies CIHR, NSERC, and SSHRC, supporting students annually across all disciplines. The program selects scholars through a rigorous evaluation of their academic excellence, research potential, and personal competencies.];
      v(design_awards_paragraph_spacing);
})

// Conditional spacing based on entry type
#v(design_awards_between_entries)  // Awards spacing between entries

#v(design-entries-vertical-space-between-entries)
// Normal entry (for professional development, awards, projects, etc.) matching LaTeX


// Wrap entire entry in entry_content to keep it together
#entry_content({
  // Main entry with bold name (hyperlinked if URL available)
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(weight: "bold", "British Columbia Graduate Scholarship"),
    text(weight: "bold", "April 2024")
  )

  // Add spacing after name - different for Awards vs Professional Development
  v(design_awards_after_name)  // Awards: spacing after name

  // Italic summary line (like institution/organization)
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(style: "italic", "The Ministry of Advanced Education, Skills and Training"),
    ""
  )

  // Add spacing after summary - different for Awards vs Professional Development
  v(design_awards_after_summary)  // Awards: spacing after summary


  // Conditional rendering: bullets for awards, plain text for projects
      // Awards section - plain text without bullets
      [The British Columbia Graduate Scholarship supports exceptional students at public post-secondary institutions across the province, with a focus on STEM and professional fields. Valued at \$17,500 the scholarships are merit-based and aim to attract top talent who contribute significantly to their disciplines. This initiative helps reduce financial barriers and promote educational innovation in British Columbia.];
      v(design_awards_paragraph_spacing);
})

// Conditional spacing based on entry type
#v(design_awards_between_entries)  // Awards spacing between entries

#v(design-entries-vertical-space-between-entries)
// Normal entry (for professional development, awards, projects, etc.) matching LaTeX


// Wrap entire entry in entry_content to keep it together
#entry_content({
  // Main entry with bold name (hyperlinked if URL available)
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(weight: "bold", "Lieutenant-Governor's Medal for Inclusion, Democracy and Reconciliation"),
    text(weight: "bold", "May 2023")
  )

  // Add spacing after name - different for Awards vs Professional Development
  v(design_awards_after_name)  // Awards: spacing after name

  // Italic summary line (like institution/organization)
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(style: "italic", "Lieutenant Governor of British Columbia"),
    ""
  )

  // Add spacing after summary - different for Awards vs Professional Development
  v(design_awards_after_summary)  // Awards: spacing after summary


  // Conditional rendering: bullets for awards, plain text for projects
      // Awards section - plain text without bullets
      [The Lieutenant-governor's Medal for Inclusion, Democracy and Reconciliation recognizes outstanding contributions from UNBC's graduating class of over 700 students to promoting inclusion, democracy, and reconciliation within the UNBC community. The award recognizes exceptional leadership, advocacy, and commitment to creating a more inclusive and equitable campus environment.];
      v(design_awards_paragraph_spacing);
})

// Conditional spacing based on entry type
#v(design_awards_between_entries)  // Awards spacing between entries

#v(design-entries-vertical-space-between-entries)
// Normal entry (for professional development, awards, projects, etc.) matching LaTeX


// Wrap entire entry in entry_content to keep it together
#entry_content({
  // Main entry with bold name (hyperlinked if URL available)
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(weight: "bold", "Undergraduate Student Research Award"),
    text(weight: "bold", "April 2023")
  )

  // Add spacing after name - different for Awards vs Professional Development
  v(design_awards_after_name)  // Awards: spacing after name

  // Italic summary line (like institution/organization)
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(style: "italic", "Natural Sciences and Engineering Research Council of Canada"),
    ""
  )

  // Add spacing after summary - different for Awards vs Professional Development
  v(design_awards_after_summary)  // Awards: spacing after summary


  // Conditional rendering: bullets for awards, plain text for projects
      // Awards section - plain text without bullets
      [Natural Sciences and Engineering Research Council of Canada Undergraduate Student Research Award, awarded for outstanding research contributions in the natural sciences and engineering fields. The award recognizes exceptional research skills, creativity, and potential for future contributions to the field.];
      v(design_awards_paragraph_spacing);
})

// Conditional spacing based on entry type
#v(design_awards_between_entries)  // Awards spacing between entries

#v(design-entries-vertical-space-between-entries)
// Normal entry (for professional development, awards, projects, etc.) matching LaTeX


// Wrap entire entry in entry_content to keep it together
#entry_content({
  // Main entry with bold name (hyperlinked if URL available)
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(weight: "bold", "BC Northern Real Estate Board Award"),
    text(weight: "bold", "August 2021")
  )

  // Add spacing after name - different for Awards vs Professional Development
  v(design_awards_after_name)  // Awards: spacing after name

  // Italic summary line (like institution/organization)
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(style: "italic", "BC Northern Real Estate Board"),
    ""
  )

  // Add spacing after summary - different for Awards vs Professional Development
  v(design_awards_after_summary)  // Awards: spacing after summary


  // Conditional rendering: bullets for awards, plain text for projects
      // Awards section - plain text without bullets
      [The award is for recipients whose home town must be within the geographical boundaries defined by the Yukon border to the north, 70 Mile House to the south, Haida Gwaii Islands to the west, and the Alberta border to the east, including the communities of Dawson Creek, Chetwynd, and Tumbler Ridge. Meeting the criteria for good academic standing is the primary basis for selection.];
      v(design_awards_paragraph_spacing);
})

// Conditional spacing based on entry type
#v(design_awards_between_entries)  // Awards spacing between entries

#v(design-entries-vertical-space-between-entries)
// Normal entry (for professional development, awards, projects, etc.) matching LaTeX


// Wrap entire entry in entry_content to keep it together
#entry_content({
  // Main entry with bold name (hyperlinked if URL available)
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(weight: "bold", "Governor General's Academic Medal"),
    text(weight: "bold", "July 2018")
  )

  // Add spacing after name - different for Awards vs Professional Development
  v(design_awards_after_name)  // Awards: spacing after name

  // Italic summary line (like institution/organization)
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(style: "italic", "The Governor General of Canada"),
    ""
  )

  // Add spacing after summary - different for Awards vs Professional Development
  v(design_awards_after_summary)  // Awards: spacing after summary


  // Conditional rendering: bullets for awards, plain text for projects
      // Awards section - plain text without bullets
      [I was awarded the Governor General's Academic Medal in recognition of my outstanding academic achievement. This prestigious award is given to the student with the highest academic standing in their graduating class. I received this honor for achieving the highest overall average in my school, demonstrating exceptional dedication and excellence in my studies. The Governor General's Academic Medal is a national recognition of academic excellence and is highly regarded in the academic community.];
      v(design_awards_paragraph_spacing);
})

// Conditional spacing based on entry type
#v(design_awards_between_entries)  // Awards spacing between entries


// Section ending - negative spacing to reduce gap before next section
#v(design_section_ending_spacing)
#section_heading("Presentations")

// No additional spacing here - section_heading already includes the correct 4pt spacing

// Normal entry (for professional development, awards, projects, etc.) matching LaTeX


// Custom layout for presentations to keep dates aligned with last line
#entry_content({
  grid(
    columns: (1fr, auto),
    align: (left, bottom),
    text(weight: "bold", "Black Carbon (BC) Measurements in Addis Ababa: Reconciling Aethalometer BC with Filter Based BC and FTIR-EC Measurements"),
    text(weight: "bold", "2025")
  )

  v(design_professional_dev_after_name)
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(style: "italic", "AAAR 43rd Annual Conference"),
    text(style: "italic", "Buffalo, NY")
  )
  v(design_professional_dev_after_summary)

})
#v(design_professional_dev_between_entries)


#v(design-entries-vertical-space-between-entries)
// Normal entry (for professional development, awards, projects, etc.) matching LaTeX


// Custom layout for presentations to keep dates aligned with last line
#entry_content({
  grid(
    columns: (1fr, auto),
    align: (left, bottom),
    text(weight: "bold", "Assessing the health impacts of particulate bound metals in downtown Prince George: A health indexing study on the differential effects of high and low dust days"),
    text(weight: "bold", "2024")
  )

  v(design_professional_dev_after_name)
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(style: "italic", "Cascadia Symposium on Environmental, Occupational, and Population Health 2024"),
    text(style: "italic", "Blaine, WA")
  )
  v(design_professional_dev_after_summary)

})
#v(design_professional_dev_between_entries)


#v(design-entries-vertical-space-between-entries)
// Normal entry (for professional development, awards, projects, etc.) matching LaTeX


// Custom layout for presentations to keep dates aligned with last line
#entry_content({
  grid(
    columns: (1fr, auto),
    align: (left, bottom),
    text(weight: "bold", "Particulate Matter-Bound Metals as an Assessment of Air Pollution in the City of Prince George"),
    text(weight: "bold", "2023")
  )

  v(design_professional_dev_after_name)
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(style: "italic", "UNBC Research Week"),
    text(style: "italic", "Prince George, BC")
  )
  v(design_professional_dev_after_summary)

})
#v(design_professional_dev_between_entries)


#v(design-entries-vertical-space-between-entries)
// Normal entry (for professional development, awards, projects, etc.) matching LaTeX


// Custom layout for presentations to keep dates aligned with last line
#entry_content({
  grid(
    columns: (1fr, auto),
    align: (left, bottom),
    text(weight: "bold", "Heavy metals and polycyclic aromatic hydrocarbons in ambient air during episodes of springtime road dust"),
    text(weight: "bold", "2021")
  )

  v(design_professional_dev_after_name)
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(style: "italic", "UNBC Research Week"),
    text(style: "italic", "Prince George, BC")
  )
  v(design_professional_dev_after_summary)

})
#v(design_professional_dev_between_entries)



// Section ending - negative spacing to reduce gap before next section
#v(design_section_ending_spacing)
#section_heading("Publications")

// No additional spacing here - section_heading already includes the correct 4pt spacing

// Publication entry - matching ExperienceEntry pattern exactly


// Wrap entire entry in entry_content to keep it together
#entry_content({
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(weight: "bold", "Characterization of the short-term temporal variability of road dust chemical mixtures and meteorological profiles in a near-road urban site in British Columbia"),
    text(weight: "bold", "2023")
  )

  v(design_publication_after_title)

  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(style: "italic", "Journal of the Air & Waste Management Association"),
    ""
  )

  v(design_publication_after_journal)

  [Eric S. Coker, Nikita Saha Turna, Mya Schouwenburg, Ahmad Jalil, Charles Bradshaw, Michael Kuo, Molly Mastel, Hossein Kazemian, Meghan Roushorne, Sarah B. Henderson];

  v(design_publication_after_authors);

  [DOI: 10.1080/10962247.2023.2197970]
})

#v(design_publication_spacing)

// Section ending - negative spacing to reduce gap before next section
#v(design_section_ending_spacing)
