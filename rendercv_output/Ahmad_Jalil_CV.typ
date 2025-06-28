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
  #link("https://ahmadjalil.com/")[ahmadjalil.com]]

#v(-4pt)  // Match LaTeX \vspace{-4pt}
#line(length: 100%, stroke: 0.4pt)
#v(-4pt)  // Match LaTeX \vspace{-4pt}

#section_heading("Experience")

// No additional spacing here - section_heading already includes the correct 4pt spacing

// Experience entry with automatic date formatting matching LaTeX exactly

// Format start date

// Format end date


// Company header - only show if this is the first position at a company
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(weight: "bold", "Northern Analytical Laboratory Services"),
  "November 2020 – Present"
)
#v(design_experience_after_company_header)
// Position line - use raw Jinja2 output to prevent escaping
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(style: "italic", "Research Assistant" + " | " + "November 2020 – Present"),
  "Prince George, BC"
)

// Bullet points with LaTeX-matching spacing
#v(design_experience_before_highlights)
• Work both independently and in a team in a laboratory environment, performing tasks that involve collection and processing of samples using various instruments while maintaining and calibrating them
#v(design_experience_between_highlights)
• Revamped invoicing system to automate payment tracking processes, reducing customer inquiries and improving overall customer satisfaction
#v(design_experience_between_highlights)
• Streamlined and optimized laboratory workflow by implementing new methods and protocols, resulting in an increase in sample processing efficiency
#v(design_experience_between_highlights)
• Authored and disseminated scientific papers and reports, contributing to the lab's knowledge base
#v(design_experience_between_highlights)

// Simple spacing control - two clear variables
#v(design_experience_new_company_spacing)  // Space between different companies

#v(design-entries-vertical-space-between-entries)
// Experience entry with automatic date formatting matching LaTeX exactly

// Format start date

// Format end date


// Company header - only show if this is the first position at a company
#v(design_experience_after_company_header)
// Position line - use raw Jinja2 output to prevent escaping
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(style: "italic", "Student Research Assistant" + " | " + "November 2020 – September 2022"),
  "Prince George, BC"
)

// Bullet points with LaTeX-matching spacing
#v(design_experience_before_highlights)
• Organize, review, and correct research data, creating illustrative graphs and charts for reports
#v(design_experience_between_highlights)
• Process data using statistical software including Excel, Prism, and Rstudio, to facilitate thorough data analysis
#v(design_experience_between_highlights)
• Apply graphic design skills \(Photoshop, Illustrator, InDesign\) to create various materials for the Northern Analytical Laboratory Services
#v(design_experience_between_highlights)

// Simple spacing control - two clear variables
#v(design_experience_between_positions_same_company)  // Space between positions at same company

#v(design-entries-vertical-space-between-entries)
// Experience entry with automatic date formatting matching LaTeX exactly

// Format start date

// Format end date


// Company header - only show if this is the first position at a company
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(weight: "bold", "Relentless Pursuit Ventures"),
  "May 2024 – August 2024"
)
#v(design_experience_after_company_header)
// Position line - use raw Jinja2 output to prevent escaping
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(style: "italic", "Health Technology Research Analyst \(Intern\)" + " | " + "May 2024 – August 2024"),
  "Remote"
)

// Bullet points with LaTeX-matching spacing
#v(design_experience_before_highlights)
• Conducted comprehensive research on health technology innovations for seniors in rural and remote communities across Canada
#v(design_experience_between_highlights)
• Identified and analyzed key stakeholders in the age-tech and healthcare sectors, including government agencies, healthcare providers, technology companies, and advocacy groups
#v(design_experience_between_highlights)

// Simple spacing control - two clear variables
#v(design_experience_new_company_spacing)  // Space between different companies

#v(design-entries-vertical-space-between-entries)
// Experience entry with automatic date formatting matching LaTeX exactly

// Format start date

// Format end date


// Company header - only show if this is the first position at a company
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(weight: "bold", "Northern Health"),
  "May 2024 – Present"
)
#v(design_experience_after_company_header)
// Position line - use raw Jinja2 output to prevent escaping
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(style: "italic", "Informatics Specialists" + " | " + "May 2024 – Present"),
  "Prince George, BC"
)

// Bullet points with LaTeX-matching spacing
#v(design_experience_before_highlights)
• Led the integration and optimization of health information technologies, improving access to patient\/client information and enhancing evidence-based practices across Northern Health regions
#v(design_experience_between_highlights)
• Collaborated with clinical leaders, HIM leaders, and physicians to align healthcare systems with operational needs, while designing and maintaining health information management content
#v(design_experience_between_highlights)
• Directed change initiatives and provided leadership in recruiting, coaching, and evaluating staff, fostering innovation and supporting the adoption of international coding standards
#v(design_experience_between_highlights)

// Simple spacing control - two clear variables
#v(design_experience_new_company_spacing)  // Space between different companies

#v(design-entries-vertical-space-between-entries)
// Experience entry with automatic date formatting matching LaTeX exactly

// Format start date

// Format end date


// Company header - only show if this is the first position at a company
#v(design_experience_after_company_header)
// Position line - use raw Jinja2 output to prevent escaping
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(style: "italic", "PICS Intern" + " | " + "May 2024 – December 2024"),
  "Prince George, BC"
)

// Bullet points with LaTeX-matching spacing
#v(design_experience_before_highlights)
• Utilize Geographic Information Systems \(GIS\) software to analyze and map data relevant to public health concerns across Northern Health regions
#v(design_experience_between_highlights)
• Created and presented comprehensive GIS-based reports to high-level decision-makers to support informed decision-making on public health concerns
#v(design_experience_between_highlights)
• Developed a standardized database to track and analyze provincial-wide systems, enhancing data consistency and accessibility across Northern Health regions
#v(design_experience_between_highlights)

// Simple spacing control - two clear variables
#v(design_experience_between_positions_same_company)  // Space between positions at same company

#v(design-entries-vertical-space-between-entries)
// Experience entry with automatic date formatting matching LaTeX exactly

// Format start date

// Format end date


// Company header - only show if this is the first position at a company
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(weight: "bold", "University of Northern British Columbia"),
  "January 2024 – December 2024"
)
#v(design_experience_after_company_header)
// Position line - use raw Jinja2 output to prevent escaping
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(style: "italic", "Teaching Assistant" + " | " + "January 2024 – December 2024"),
  "Prince George, BC"
)

// Bullet points with LaTeX-matching spacing
#v(design_experience_before_highlights)
• Contributed to the creation of an online resource hub for nutrition students, providing access to lecture notes, study guides, and additional learning materials
#v(design_experience_between_highlights)

// Simple spacing control - two clear variables
#v(design_experience_new_company_spacing)  // Space between different companies


// Section ending - negative spacing to reduce gap before next section
#v(design_section_ending_spacing)
#section_heading("Volunteer")

// No additional spacing here - section_heading already includes the correct 4pt spacing

// Experience entry with automatic date formatting matching LaTeX exactly

// Format start date

// Format end date


// Company header - only show if this is the first position at a company
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(weight: "bold", "St. Vincent De Paul"),
  "December 2020 – Present"
)
#v(design_experience_after_company_header)
// Position line - use raw Jinja2 output to prevent escaping
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(style: "italic", "Service Volunteer" + " | " + "December 2020 – Present"),
  "Prince George, BC"
)

// Bullet points with LaTeX-matching spacing
#v(design_experience_before_highlights)
• Prepared and served meals to those in need, promoted community wellness, and efficiently managed the distribution of donated goods
#v(design_experience_between_highlights)

// Simple spacing control - two clear variables
#v(design_experience_new_company_spacing)  // Space between different companies

#v(design-entries-vertical-space-between-entries)
// Experience entry with automatic date formatting matching LaTeX exactly

// Format start date

// Format end date


// Company header - only show if this is the first position at a company
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(weight: "bold", "Rural eMentoring BC"),
  "September 2020 – Present"
)
#v(design_experience_after_company_header)
// Position line - use raw Jinja2 output to prevent escaping
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(style: "italic", "Highschool Mentor" + " | " + "September 2020 – Present"),
  "Remote"
)

// Bullet points with LaTeX-matching spacing
#v(design_experience_before_highlights)
• Cultivated a confidential, supportive mentorship with a high school mentee, providing guidance on personal and academic challenges to foster personal and educational development
#v(design_experience_between_highlights)

// Simple spacing control - two clear variables
#v(design_experience_new_company_spacing)  // Space between different companies

#v(design-entries-vertical-space-between-entries)
// Experience entry with automatic date formatting matching LaTeX exactly

// Format start date

// Format end date


// Company header - only show if this is the first position at a company
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(weight: "bold", "Over The Edge Newspaper Society"),
  "March 2024 – Present"
)
#v(design_experience_after_company_header)
// Position line - use raw Jinja2 output to prevent escaping
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(style: "italic", "Acting Editor-in-Chief" + " | " + "March 2024 – Present"),
  "Prince George, BC"
)

// Bullet points with LaTeX-matching spacing
#v(design_experience_before_highlights)
• Negotiated a printing deal with the main newsprint supplier in Prince George, securing the production of 22,000 copies per issue
#v(design_experience_between_highlights)
• Redesigned the newspaper's logo and brand image to modernize and align with current media trends
#v(design_experience_between_highlights)
• Conducted audience research to identify preferences and tailored content to increase engagement
#v(design_experience_between_highlights)
• Centralized information structures to streamline communication and enhance workflow efficiency
#v(design_experience_between_highlights)

// Simple spacing control - two clear variables
#v(design_experience_new_company_spacing)  // Space between different companies

#v(design-entries-vertical-space-between-entries)
// Experience entry with automatic date formatting matching LaTeX exactly

// Format start date

// Format end date


// Company header - only show if this is the first position at a company
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(weight: "bold", "Sparklab"),
  "September 2023 – Present"
)
#v(design_experience_after_company_header)
// Position line - use raw Jinja2 output to prevent escaping
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(style: "italic", "Technical Analyst" + " | " + "September 2023 – Present"),
  "Prince George, BC"
)

// Bullet points with LaTeX-matching spacing
#v(design_experience_before_highlights)
• Engage with researchers to understand their specific needs and challenges in laboratory and field environments
#v(design_experience_between_highlights)
• Design customized solutions using CAD \(Computer-Aided Design\) software to address the unique requirements of various research projects
#v(design_experience_between_highlights)

// Simple spacing control - two clear variables
#v(design_experience_new_company_spacing)  // Space between different companies

#v(design-entries-vertical-space-between-entries)
// Experience entry with automatic date formatting matching LaTeX exactly

// Format start date

// Format end date


// Company header - only show if this is the first position at a company
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(weight: "bold", "University of Northern British Columbia"),
  "September 2022 – Present"
)
#v(design_experience_after_company_header)
// Position line - use raw Jinja2 output to prevent escaping
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(style: "italic", "Research Ambassador" + " | " + "September 2022 – Present"),
  "Prince George, BC"
)

// Bullet points with LaTeX-matching spacing
#v(design_experience_before_highlights)
• Act as a primary liaison between students and the research community at UNBC, promoting engagement and participation in research activities
#v(design_experience_between_highlights)
• Organize and lead informational sessions and workshops to educate students about the research process, opportunities, and the significance of research contributions
#v(design_experience_between_highlights)

// Simple spacing control - two clear variables
#v(design_experience_new_company_spacing)  // Space between different companies

#v(design-entries-vertical-space-between-entries)
// Experience entry with automatic date formatting matching LaTeX exactly

// Format start date

// Format end date


// Company header - only show if this is the first position at a company
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(weight: "bold", "Northern Health"),
  "April 2023 – Present"
)
#v(design_experience_after_company_header)
// Position line - use raw Jinja2 output to prevent escaping
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(style: "italic", "Activity Volunteer" + " | " + "April 2023 – Present"),
  "Prince George, BC"
)

// Bullet points with LaTeX-matching spacing
#v(design_experience_before_highlights)
• Assist recreation therapists and engage in activities with residents at Rainbow Lodge & Gateway, a long-term care home and facilities, enhancing their daily lives and well-being
#v(design_experience_between_highlights)
• Provide emotional support and reassurance to dementia patients, helping them feel more secure and oriented in their environment
#v(design_experience_between_highlights)
• Deepen my understanding of patient-centered medicine through direct interactions, learning about residents' needs and perspectives
#v(design_experience_between_highlights)

// Simple spacing control - two clear variables
#v(design_experience_new_company_spacing)  // Space between different companies


// Section ending - negative spacing to reduce gap before next section
#v(design_section_ending_spacing)
#section_heading("Education")

// No additional spacing here - section_heading already includes the correct 4pt spacing

// Education entry matching LaTeX formatting exactly

// Institution header with date range (bold institution name)
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(weight: "bold", "University of Northern British Columbia"),
  "Sept 2023 – Sept 2026"
)

#v(design_education_after_institution)

// Degree and area with location (italic degree/area)
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(style: "italic", "PhD, Natural Resources and Environmental Studies"),
  "Prince George, BC"
)// Bullet points for highlights with LaTeX-matching spacing
#v(design_education_before_highlights)• Focus on air quality and environmental health
#v(design_education_between_highlights)#v(design_education_after_entry)  // Standard spacing after education entries
#v(design-entries-vertical-space-between-entries)
// Education entry matching LaTeX formatting exactly

// Institution header with date range (bold institution name)
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(weight: "bold", "University of Northern British Columbia"),
  "Sept 2023 – Aug 2024"
)

#v(design_education_after_institution)

// Degree and area with location (italic degree/area)
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(style: "italic", "M.Sc., Natural Resources and Environmental Studies"),
  "Prince George, BC"
)// Bullet points for highlights with LaTeX-matching spacing
#v(design_education_before_highlights)• Focus on air quality and environmental health
#v(design_education_between_highlights)• Continued to PhD
#v(design_education_between_highlights)#v(design_education_after_entry)  // Standard spacing after education entries
#v(design-entries-vertical-space-between-entries)
// Education entry matching LaTeX formatting exactly

// Institution header with date range (bold institution name)
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(weight: "bold", "University of Northern British Columbia"),
  "Sept 2019 – May 2023"
)

#v(design_education_after_institution)

// Degree and area with location (italic degree/area)
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(style: "italic", "B.HSc., Biomedical Studies \(Honours\)"),
  "Prince George, BC"
)// Bullet points for highlights with LaTeX-matching spacing
#v(design_education_before_highlights)• Minor: Natural Resource Planning and Operations \(Forestry\)
#v(design_education_between_highlights)• The Lieutenant Governor's Medal for Inclusion, Democracy and Reconciliation
#v(design_education_between_highlights)#v(design_education_after_entry)  // Standard spacing after education entries

// Section ending - negative spacing to reduce gap before next section
#v(design_section_ending_spacing)
#section_heading("Professional Development")

// No additional spacing here - section_heading already includes the correct 4pt spacing

// Normal entry (for professional development, awards, etc.) matching LaTeX

// Main entry with bold name
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(weight: "bold", "Digital Twins - Fundamentals, Techniques & Approaches"),
  "Mar 2024"
)

// Add spacing after name - different for Awards vs Professional Development
#v(design_professional_dev_after_name)  // Professional Dev: spacing after name

// Italic summary line (like institution/organization)
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(style: "italic", "Mohawk College"),
  "Remote"
)

// Add spacing after summary - different for Awards vs Professional Development
#v(design_professional_dev_after_summary)  // Professional Dev: spacing after summary



// Conditional spacing based on entry type
#v(design_professional_dev_between_entries)  // Professional development spacing between entries  

#v(design-entries-vertical-space-between-entries)
// Normal entry (for professional development, awards, etc.) matching LaTeX

// Main entry with bold name
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(weight: "bold", "Applied Internet of Things \(IoT\)"),
  "May 2023"
)

// Add spacing after name - different for Awards vs Professional Development
#v(design_professional_dev_after_name)  // Professional Dev: spacing after name

// Italic summary line (like institution/organization)
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(style: "italic", "British Columbia Institute of Technology"),
  "Vancouver, BC"
)

// Add spacing after summary - different for Awards vs Professional Development
#v(design_professional_dev_after_summary)  // Professional Dev: spacing after summary



// Conditional spacing based on entry type
#v(design_professional_dev_between_entries)  // Professional development spacing between entries  

#v(design-entries-vertical-space-between-entries)
// Normal entry (for professional development, awards, etc.) matching LaTeX

// Main entry with bold name
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(weight: "bold", "Building Envelope Science"),
  "June 2022"
)

// Add spacing after name - different for Awards vs Professional Development
#v(design_professional_dev_after_name)  // Professional Dev: spacing after name

// Italic summary line (like institution/organization)
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(style: "italic", "Holland College"),
  "Remote"
)

// Add spacing after summary - different for Awards vs Professional Development
#v(design_professional_dev_after_summary)  // Professional Dev: spacing after summary



// Conditional spacing based on entry type
#v(design_professional_dev_between_entries)  // Professional development spacing between entries  

#v(design-entries-vertical-space-between-entries)
// Normal entry (for professional development, awards, etc.) matching LaTeX

// Main entry with bold name
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(weight: "bold", "Covid-19 Contact Tracer"),
  "Dec 2021"
)

// Add spacing after name - different for Awards vs Professional Development
#v(design_professional_dev_after_name)  // Professional Dev: spacing after name

// Italic summary line (like institution/organization)
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(style: "italic", "John Hopkins University"),
  "Remote"
)

// Add spacing after summary - different for Awards vs Professional Development
#v(design_professional_dev_after_summary)  // Professional Dev: spacing after summary



// Conditional spacing based on entry type
#v(design_professional_dev_between_entries)  // Professional development spacing between entries  


// Section ending - negative spacing to reduce gap before next section
#v(design_section_ending_spacing)
#section_heading("Certifications and Skills")

// No additional spacing here - section_heading already includes the correct 4pt spacing

// Text entry (for presentations, awards with descriptions) 
// Matches LaTeX formatting with proper spacing

#strong[Certifications:] OFA Level 1; TCPS 2; Environmental Professional in Training \(EPt\)  

#strong[Skills:] Power BI; Research Skills; GIS; R Studio; Brand Identity Maps; Analytical Nature; Adobe Suite; Business Process Reengineering; SPSS; logistics; Fluent in Arabic; Powerful Decision-Making Expertise; Grant Proposal

#v(design-entries-vertical-space-between-entries)  // Standard spacing between text entries

// Section ending - negative spacing to reduce gap before next section
#v(design_section_ending_spacing)
#section_heading("Awards")

// No additional spacing here - section_heading already includes the correct 4pt spacing

// Normal entry (for professional development, awards, etc.) matching LaTeX

// Main entry with bold name
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(weight: "bold", "Canada Graduate Scholarships – Michael Smith Foreign Study Supplements"),
  "Jan 2025"
)

// Add spacing after name - different for Awards vs Professional Development
#v(design_awards_after_name)  // Awards: spacing after name

// Italic summary line (like institution/organization)
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(style: "italic", "Canadian Institutes of Health Research"),
  ""
)

// Add spacing after summary - different for Awards vs Professional Development
#v(design_awards_after_summary)  // Awards: spacing after summary


// Awards section - has highlights/descriptions
The Government of Canada launched this program in 2008 to support high-calibre graduate students in building global linkages and international networks through the pursuit of exceptional research experiences at research institutions outside of Canada. By accessing international scientific research and training, CGS-MSFSS recipients will contribute to strengthening the potential for collaboration between Canadian and international universities and affiliated research institutions.
#v(design_awards_paragraph_spacing)  // Uses awards-specific spacing

// Conditional spacing based on entry type
#v(design_awards_between_entries)  // Awards spacing between entries

#v(design-entries-vertical-space-between-entries)
// Normal entry (for professional development, awards, etc.) matching LaTeX

// Main entry with bold name
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(weight: "bold", "Canada Graduate Scholarships"),
  "Apr 2024"
)

// Add spacing after name - different for Awards vs Professional Development
#v(design_awards_after_name)  // Awards: spacing after name

// Italic summary line (like institution/organization)
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(style: "italic", "Canadian Institutes of Health Research"),
  ""
)

// Add spacing after summary - different for Awards vs Professional Development
#v(design_awards_after_summary)  // Awards: spacing after summary


// Awards section - has highlights/descriptions
The Canada Graduate Scholarships is designed to enhance the research skills and training of highly qualified personnel in health, natural sciences, engineering, and social sciences. This prestigious program is jointly administered by Canada's three granting agencies CIHR, NSERC, and SSHRC, supporting students annually across all disciplines. The program selects scholars through a rigorous evaluation of their academic excellence, research potential, and personal competencies.
#v(design_awards_paragraph_spacing)  // Uses awards-specific spacing

// Conditional spacing based on entry type
#v(design_awards_between_entries)  // Awards spacing between entries

#v(design-entries-vertical-space-between-entries)
// Normal entry (for professional development, awards, etc.) matching LaTeX

// Main entry with bold name
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(weight: "bold", "British Columbia Graduate Scholarship"),
  "Apr 2024"
)

// Add spacing after name - different for Awards vs Professional Development
#v(design_awards_after_name)  // Awards: spacing after name

// Italic summary line (like institution/organization)
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(style: "italic", "The Ministry of Advanced Education, Skills and Training"),
  ""
)

// Add spacing after summary - different for Awards vs Professional Development
#v(design_awards_after_summary)  // Awards: spacing after summary


// Awards section - has highlights/descriptions
The British Columbia Graduate Scholarship supports exceptional students at public post-secondary institutions across the province, with a focus on STEM and professional fields. Valued at \$17,500 the scholarships are merit-based and aim to attract top talent who contribute significantly to their disciplines. This initiative helps reduce financial barriers and promote educational innovation in British Columbia.
#v(design_awards_paragraph_spacing)  // Uses awards-specific spacing

// Conditional spacing based on entry type
#v(design_awards_between_entries)  // Awards spacing between entries

#v(design-entries-vertical-space-between-entries)
// Normal entry (for professional development, awards, etc.) matching LaTeX

// Main entry with bold name
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(weight: "bold", "Lieutenant-Governor's Medal for Inclusion, Democracy and Reconciliation"),
  "May 2023"
)

// Add spacing after name - different for Awards vs Professional Development
#v(design_awards_after_name)  // Awards: spacing after name

// Italic summary line (like institution/organization)
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(style: "italic", "Lieutenant Governor of British Columbia"),
  ""
)

// Add spacing after summary - different for Awards vs Professional Development
#v(design_awards_after_summary)  // Awards: spacing after summary


// Awards section - has highlights/descriptions
The Lieutenant-governor's Medal for Inclusion, Democracy and Reconciliation recognizes outstanding contributions from UNBC's graduating class of over 700 students to promoting inclusion, democracy, and reconciliation within the UNBC community. The award recognizes exceptional leadership, advocacy, and commitment to creating a more inclusive and equitable campus environment.
#v(design_awards_paragraph_spacing)  // Uses awards-specific spacing

// Conditional spacing based on entry type
#v(design_awards_between_entries)  // Awards spacing between entries

#v(design-entries-vertical-space-between-entries)
// Normal entry (for professional development, awards, etc.) matching LaTeX

// Main entry with bold name
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(weight: "bold", "Undergraduate Student Research Award"),
  "Apr 2023"
)

// Add spacing after name - different for Awards vs Professional Development
#v(design_awards_after_name)  // Awards: spacing after name

// Italic summary line (like institution/organization)
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(style: "italic", "Natural Sciences and Engineering Research Council of Canada"),
  ""
)

// Add spacing after summary - different for Awards vs Professional Development
#v(design_awards_after_summary)  // Awards: spacing after summary


// Awards section - has highlights/descriptions
Natural Sciences and Engineering Research Council of Canada Undergraduate Student Research Award, awarded for outstanding research contributions in the natural sciences and engineering fields. The award recognizes exceptional research skills, creativity, and potential for future contributions to the field.
#v(design_awards_paragraph_spacing)  // Uses awards-specific spacing

// Conditional spacing based on entry type
#v(design_awards_between_entries)  // Awards spacing between entries

#v(design-entries-vertical-space-between-entries)
// Normal entry (for professional development, awards, etc.) matching LaTeX

// Main entry with bold name
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(weight: "bold", "BC Northern Real Estate Board Award"),
  "Aug 2021"
)

// Add spacing after name - different for Awards vs Professional Development
#v(design_awards_after_name)  // Awards: spacing after name

// Italic summary line (like institution/organization)
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(style: "italic", "BC Northern Real Estate Board"),
  ""
)

// Add spacing after summary - different for Awards vs Professional Development
#v(design_awards_after_summary)  // Awards: spacing after summary


// Awards section - has highlights/descriptions
The award is for recipients whose home town must be within the geographical boundaries defined by the Yukon border to the north, 70 Mile House to the south, Haida Gwaii Islands to the west, and the Alberta border to the east, including the communities of Dawson Creek, Chetwynd, and Tumbler Ridge. Meeting the criteria for good academic standing is the primary basis for selection.
#v(design_awards_paragraph_spacing)  // Uses awards-specific spacing

// Conditional spacing based on entry type
#v(design_awards_between_entries)  // Awards spacing between entries

#v(design-entries-vertical-space-between-entries)
// Normal entry (for professional development, awards, etc.) matching LaTeX

// Main entry with bold name
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(weight: "bold", "Governor General's Academic Medal"),
  "July 2018"
)

// Add spacing after name - different for Awards vs Professional Development
#v(design_awards_after_name)  // Awards: spacing after name

// Italic summary line (like institution/organization)
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(style: "italic", "The Governor General of Canada"),
  ""
)

// Add spacing after summary - different for Awards vs Professional Development
#v(design_awards_after_summary)  // Awards: spacing after summary


// Awards section - has highlights/descriptions
I was awarded the Governor General's Academic Medal in recognition of my outstanding academic achievement. This prestigious award is given to the student with the highest academic standing in their graduating class. I received this honor for achieving the highest overall average in my school, demonstrating exceptional dedication and excellence in my studies. The Governor General's Academic Medal is a national recognition of academic excellence and is highly regarded in the academic community.
#v(design_awards_paragraph_spacing)  // Uses awards-specific spacing

// Conditional spacing based on entry type
#v(design_awards_between_entries)  // Awards spacing between entries


// Section ending - negative spacing to reduce gap before next section
#v(design_section_ending_spacing)
#section_heading("Presentations")

// No additional spacing here - section_heading already includes the correct 4pt spacing

// Text entry (for presentations, awards with descriptions) 
// Matches LaTeX formatting with proper spacing

#strong[Assessing the health impacts of particulate bound metals in downtown Prince George: A health indexing study on the differential effects of high and low dust days]
\_Cascadia Symposium on Environmental, Occupational, and Population Health 2024\_ | Blaine, WA

#v(design-entries-vertical-space-between-entries)  // Standard spacing between text entries
#v(design-entries-vertical-space-between-entries)
// Text entry (for presentations, awards with descriptions) 
// Matches LaTeX formatting with proper spacing

#strong[Particulate Matter-Bound Metals as an Assessment of Air Pollution in the City of Prince George]
\_UNBC Research Week 2023\_ | Prince George, BC

#v(design-entries-vertical-space-between-entries)  // Standard spacing between text entries
#v(design-entries-vertical-space-between-entries)
// Text entry (for presentations, awards with descriptions) 
// Matches LaTeX formatting with proper spacing

#strong[Heavy metals and polycyclic aromatic hydrocarbons in ambient air during episodes of springtime road dust]
\_UNBC Research Week 2021\_ | Prince George, BC

#v(design-entries-vertical-space-between-entries)  // Standard spacing between text entries

// Section ending - negative spacing to reduce gap before next section
#v(design_section_ending_spacing)
#section_heading("Publications")

// No additional spacing here - section_heading already includes the correct 4pt spacing

// Add this to your main template file


// Section ending - negative spacing to reduce gap before next section
#v(design_section_ending_spacing)
