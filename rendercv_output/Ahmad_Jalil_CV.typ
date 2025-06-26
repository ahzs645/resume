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

// Header matching LaTeX formatting exactly
#text(
  size: 26pt, 
  weight: "bold",
  "Ahmad Jalil"
)

#v(6pt)

// Contact information matching LaTeX 14pt size
#text(size: 14pt)[
  #text("me@ahmadjalil.com")| tel:+1-778-267-9144| Prince George, BC| #link("https://ahmadjalil.com/")[ahmadjalil.com/]]

#v(-4pt)
#line(length: 100%, stroke: 0.4pt)
#v(-4pt)

#section_heading("Experience")

#v(4pt)

// Experience entry with automatic date formatting matching LaTeX exactly

// Format start date

// Format end date


// Company header - only show if this is the first position at a company
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(weight: "bold", "Northern Analytical Laboratory Services"),
  "September 2022 – Present"
)

// Position line - same format whether company header shown or not
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(style: "italic", raw("Research Assistant") + " | " + "September 2022 – Present"),
  "Prince George, BC"
)

// Bullet points with LaTeX-matching spacing
#v(2pt)
• Work both independently and in a team in a laboratory environment, performing tasks that involve collection and processing of samples using various instruments while maintaining and calibrating them
#v(1pt)
• Revamped invoicing system to automate payment tracking processes, reducing customer inquiries and improving overall customer satisfaction
#v(1pt)
• Streamlined and optimized laboratory workflow by implementing new methods and protocols, resulting in an increase in sample processing efficiency
#v(1pt)
• Authored and disseminated scientific papers and reports, contributing to the lab's knowledge base
#v(1pt)

// Spacing control - match LaTeX exactly
#v(8pt)  // Full spacing for new companies

#v(design-entries-vertical-space-between-entries)
// Experience entry with automatic date formatting matching LaTeX exactly

// Format start date

// Format end date


// Company header - only show if this is the first position at a company
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(weight: "bold", "Northern Analytical Laboratory Services"),
  "November 2020 – September 2022"
)

// Position line - same format whether company header shown or not
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(style: "italic", raw("Student Research Assistant") + " | " + "November 2020 – September 2022"),
  "Prince George, BC"
)

// Bullet points with LaTeX-matching spacing
#v(2pt)
• Organize, review, and correct research data, creating illustrative graphs and charts for reports
#v(1pt)
• Process data using statistical software including Excel, Prism, and Rstudio, to facilitate thorough data analysis
#v(1pt)
• Apply graphic design skills \(Photoshop, Illustrator, InDesign\) to create various materials for the Northern Analytical Laboratory Services
#v(1pt)

// Spacing control - match LaTeX exactly
#v(8pt)  // Full spacing for new companies

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

// Position line - same format whether company header shown or not
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(style: "italic", raw("Health Technology Research Analyst \(Intern\)") + " | " + "May 2024 – August 2024"),
  "Remote"
)

// Bullet points with LaTeX-matching spacing
#v(2pt)
• Conducted comprehensive research on health technology innovations for seniors in rural and remote communities across Canada
#v(1pt)
• Identified and analyzed key stakeholders in the age-tech and healthcare sectors, including government agencies, healthcare providers, technology companies, and advocacy groups
#v(1pt)

// Spacing control - match LaTeX exactly
#v(8pt)  // Full spacing for new companies

#v(design-entries-vertical-space-between-entries)
// Experience entry with automatic date formatting matching LaTeX exactly

// Format start date

// Format end date


// Company header - only show if this is the first position at a company
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(weight: "bold", "Northern Health"),
  "December 2024 – Present"
)

// Position line - same format whether company header shown or not
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(style: "italic", raw("Informatics Specialists") + " | " + "December 2024 – Present"),
  "Prince George, BC"
)

// Bullet points with LaTeX-matching spacing
#v(2pt)
• Led the integration and optimization of health information technologies, improving access to patient\/client information and enhancing evidence-based practices across Northern Health regions
#v(1pt)
• Collaborated with clinical leaders, HIM leaders, and physicians to align healthcare systems with operational needs, while designing and maintaining health information management content
#v(1pt)
• Directed change initiatives and provided leadership in recruiting, coaching, and evaluating staff, fostering innovation and supporting the adoption of international coding standards
#v(1pt)

// Spacing control - match LaTeX exactly
#v(8pt)  // Full spacing for new companies

#v(design-entries-vertical-space-between-entries)
// Experience entry with automatic date formatting matching LaTeX exactly

// Format start date

// Format end date


// Company header - only show if this is the first position at a company
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(weight: "bold", "Northern Health"),
  "May 2024 – December 2024"
)

// Position line - same format whether company header shown or not
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(style: "italic", raw("PICS Intern") + " | " + "May 2024 – December 2024"),
  "Prince George, BC"
)

// Bullet points with LaTeX-matching spacing
#v(2pt)
• Utilize Geographic Information Systems \(GIS\) software to analyze and map data relevant to public health concerns across Northern Health regions
#v(1pt)
• Created and presented comprehensive GIS-based reports to high-level decision-makers to support informed decision-making on public health concerns
#v(1pt)
• Developed a standardized database to track and analyze provincial-wide systems, enhancing data consistency and accessibility across Northern Health regions
#v(1pt)

// Spacing control - match LaTeX exactly
#v(8pt)  // Full spacing for new companies

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

// Position line - same format whether company header shown or not
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(style: "italic", raw("Teaching Assistant") + " | " + "January 2024 – December 2024"),
  "Prince George, BC"
)

// Bullet points with LaTeX-matching spacing
#v(2pt)
• Contributed to the creation of an online resource hub for nutrition students, providing access to lecture notes, study guides, and additional learning materials
#v(1pt)

// Spacing control - match LaTeX exactly
#v(8pt)  // Full spacing for new companies


// Section ending - minimal spacing
#v(8pt)
#section_heading("Volunteer")

#v(4pt)

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

// Position line - same format whether company header shown or not
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(style: "italic", raw("Service Volunteer") + " | " + "December 2020 – Present"),
  "Prince George, BC"
)

// Bullet points with LaTeX-matching spacing
#v(2pt)
• Prepared and served meals to those in need, promoted community wellness, and efficiently managed the distribution of donated goods
#v(1pt)

// Spacing control - match LaTeX exactly
#v(8pt)  // Full spacing for new companies

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

// Position line - same format whether company header shown or not
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(style: "italic", raw("Highschool Mentor") + " | " + "September 2020 – Present"),
  "Remote"
)

// Bullet points with LaTeX-matching spacing
#v(2pt)
• Cultivated a confidential, supportive mentorship with a high school mentee, providing guidance on personal and academic challenges to foster personal and educational development
#v(1pt)

// Spacing control - match LaTeX exactly
#v(8pt)  // Full spacing for new companies

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

// Position line - same format whether company header shown or not
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(style: "italic", raw("Acting Editor-in-Chief") + " | " + "March 2024 – Present"),
  "Prince George, BC"
)

// Bullet points with LaTeX-matching spacing
#v(2pt)
• Negotiated a printing deal with the main newsprint supplier in Prince George, securing the production of 22,000 copies per issue
#v(1pt)
• Redesigned the newspaper's logo and brand image to modernize and align with current media trends
#v(1pt)
• Conducted audience research to identify preferences and tailored content to increase engagement
#v(1pt)
• Centralized information structures to streamline communication and enhance workflow efficiency
#v(1pt)

// Spacing control - match LaTeX exactly
#v(8pt)  // Full spacing for new companies

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

// Position line - same format whether company header shown or not
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(style: "italic", raw("Technical Analyst") + " | " + "September 2023 – Present"),
  "Prince George, BC"
)

// Bullet points with LaTeX-matching spacing
#v(2pt)
• Engage with researchers to understand their specific needs and challenges in laboratory and field environments
#v(1pt)
• Design customized solutions using CAD \(Computer-Aided Design\) software to address the unique requirements of various research projects
#v(1pt)

// Spacing control - match LaTeX exactly
#v(8pt)  // Full spacing for new companies

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

// Position line - same format whether company header shown or not
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(style: "italic", raw("Research Ambassador") + " | " + "September 2022 – Present"),
  "Prince George, BC"
)

// Bullet points with LaTeX-matching spacing
#v(2pt)
• Act as a primary liaison between students and the research community at UNBC, promoting engagement and participation in research activities
#v(1pt)
• Organize and lead informational sessions and workshops to educate students about the research process, opportunities, and the significance of research contributions
#v(1pt)

// Spacing control - match LaTeX exactly
#v(8pt)  // Full spacing for new companies

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

// Position line - same format whether company header shown or not
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(style: "italic", raw("Activity Volunteer") + " | " + "April 2023 – Present"),
  "Prince George, BC"
)

// Bullet points with LaTeX-matching spacing
#v(2pt)
• Assist recreation therapists and engage in activities with residents at Rainbow Lodge & Gateway, a long-term care home and facilities, enhancing their daily lives and well-being
#v(1pt)
• Provide emotional support and reassurance to dementia patients, helping them feel more secure and oriented in their environment
#v(1pt)
• Deepen my understanding of patient-centered medicine through direct interactions, learning about residents' needs and perspectives
#v(1pt)

// Spacing control - match LaTeX exactly
#v(8pt)  // Full spacing for new companies


// Section ending - minimal spacing
#v(8pt)
#section_heading("Education")

#v(4pt)

// Education entry matching LaTeX formatting exactly

// Institution header with date range (bold institution name)
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(weight: "bold", "University of Northern British Columbia"),
  "Sept 2023 – Sept 2026"
)

// Degree and area with location (italic degree/area)
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(style: "italic", "PhD, Natural Resources and Environmental Studies"),
  "Prince George, BC"
)// Bullet points for highlights with LaTeX-matching spacing
#v(2pt)• Focus on air quality and environmental health
#v(1pt)#v(8pt)  // Standard spacing after education entries
#v(design-entries-vertical-space-between-entries)
// Education entry matching LaTeX formatting exactly

// Institution header with date range (bold institution name)
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(weight: "bold", "University of Northern British Columbia"),
  "Sept 2023 – Aug 2024"
)

// Degree and area with location (italic degree/area)
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(style: "italic", "M.Sc., Natural Resources and Environmental Studies"),
  "Prince George, BC"
)// Bullet points for highlights with LaTeX-matching spacing
#v(2pt)• Focus on air quality and environmental health
#v(1pt)• Continued to PhD
#v(1pt)#v(8pt)  // Standard spacing after education entries
#v(design-entries-vertical-space-between-entries)
// Education entry matching LaTeX formatting exactly

// Institution header with date range (bold institution name)
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(weight: "bold", "University of Northern British Columbia"),
  "Sept 2019 – May 2023"
)

// Degree and area with location (italic degree/area)
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(style: "italic", "B.HSc., Biomedical Studies \(Honours\)"),
  "Prince George, BC"
)// Bullet points for highlights with LaTeX-matching spacing
#v(2pt)• Minor: Natural Resource Planning and Operations \(Forestry\)
#v(1pt)• The Lieutenant Governor's Medal for Inclusion, Democracy and Reconciliation
#v(1pt)#v(8pt)  // Standard spacing after education entries

// Section ending - minimal spacing
#v(8pt)
#section_heading("Professional Development")

#v(4pt)

// Normal entry (for professional development, awards, etc.) matching LaTeX

// Main entry with bold name
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(weight: "bold", "Digital Twins - Fundamentals, Techniques & Approaches"),
  "Mar 2024"
)

// Italic summary line (like institution/organization)
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(style: "italic", "Mohawk College"),
  "Remote"
)


#v(8pt)  // Standard spacing between entries
#v(design-entries-vertical-space-between-entries)
// Normal entry (for professional development, awards, etc.) matching LaTeX

// Main entry with bold name
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(weight: "bold", "Applied Internet of Things \(IoT\)"),
  "May 2023"
)

// Italic summary line (like institution/organization)
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(style: "italic", "British Columbia Institute of Technology"),
  "Vancouver, BC"
)


#v(8pt)  // Standard spacing between entries
#v(design-entries-vertical-space-between-entries)
// Normal entry (for professional development, awards, etc.) matching LaTeX

// Main entry with bold name
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(weight: "bold", "Building Envelope Science"),
  "June 2022"
)

// Italic summary line (like institution/organization)
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(style: "italic", "Holland College"),
  "Remote"
)


#v(8pt)  // Standard spacing between entries
#v(design-entries-vertical-space-between-entries)
// Normal entry (for professional development, awards, etc.) matching LaTeX

// Main entry with bold name
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(weight: "bold", "Covid-19 Contact Tracer"),
  "Dec 2021"
)

// Italic summary line (like institution/organization)
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(style: "italic", "John Hopkins University"),
  "Remote"
)


#v(8pt)  // Standard spacing between entries

// Section ending - minimal spacing
#v(8pt)
#section_heading("Certifications and Skills")

#v(4pt)

// Text entry (for presentations, awards with descriptions) 
// Matches LaTeX formatting with proper spacing

#strong[Certifications:] OFA Level 1; TCPS 2; Environmental Professional in Training \(EPt\)

#v(8pt)  // Standard spacing between text entries
#v(design-entries-vertical-space-between-entries)
// Text entry (for presentations, awards with descriptions) 
// Matches LaTeX formatting with proper spacing

#strong[Skills:] Power BI; Research Skills; GIS; R Studio; Brand Identity Maps; Analytical Nature; Adobe Suite; Business Process Reengineering; SPSS; logistics; Fluent in Arabic; Powerful Decision-Making Expertise; Grant Proposal

#v(8pt)  // Standard spacing between text entries

// Section ending - minimal spacing
#v(8pt)
#section_heading("Awards")

#v(4pt)

// Normal entry (for professional development, awards, etc.) matching LaTeX

// Main entry with bold name
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(weight: "bold", "Canada Graduate Scholarships – Michael Smith Foreign Study Supplements"),
  "Jan 2025"
)

// Italic summary line (like institution/organization)
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(style: "italic", "Canadian Institutes of Health Research"),
  ""
)

// Description text (not bullet points for awards)
The Government of Canada launched this program in 2008 to support high-calibre graduate students in building global linkages and international networks through the pursuit of exceptional research experiences at research institutions outside of Canada. By accessing international scientific research and training, CGS-MSFSS recipients will contribute to strengthening the potential for collaboration between Canadian and international universities and affiliated research institutions.


#v(8pt)  // Standard spacing between entries
#v(design-entries-vertical-space-between-entries)
// Normal entry (for professional development, awards, etc.) matching LaTeX

// Main entry with bold name
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(weight: "bold", "Canada Graduate Scholarships"),
  "Apr 2024"
)

// Italic summary line (like institution/organization)
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(style: "italic", "Canadian Institutes of Health Research"),
  ""
)

// Description text (not bullet points for awards)
The Canada Graduate Scholarships is designed to enhance the research skills and training of highly qualified personnel in health, natural sciences, engineering, and social sciences. This prestigious program is jointly administered by Canada's three granting agencies CIHR, NSERC, and SSHRC, supporting students annually across all disciplines. The program selects scholars through a rigorous evaluation of their academic excellence, research potential, and personal competencies.


#v(8pt)  // Standard spacing between entries
#v(design-entries-vertical-space-between-entries)
// Normal entry (for professional development, awards, etc.) matching LaTeX

// Main entry with bold name
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(weight: "bold", "British Columbia Graduate Scholarship"),
  "Apr 2024"
)

// Italic summary line (like institution/organization)
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(style: "italic", "The Ministry of Advanced Education, Skills and Training"),
  ""
)

// Description text (not bullet points for awards)
The British Columbia Graduate Scholarship supports exceptional students at public post-secondary institutions across the province, with a focus on STEM and professional fields. Valued at \$17,500 the scholarships are merit-based and aim to attract top talent who contribute significantly to their disciplines. This initiative helps reduce financial barriers and promote educational innovation in British Columbia.


#v(8pt)  // Standard spacing between entries
#v(design-entries-vertical-space-between-entries)
// Normal entry (for professional development, awards, etc.) matching LaTeX

// Main entry with bold name
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(weight: "bold", "Lieutenant-Governor's Medal for Inclusion, Democracy and Reconciliation"),
  "May 2023"
)

// Italic summary line (like institution/organization)
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(style: "italic", "Lieutenant Governor of British Columbia"),
  ""
)

// Description text (not bullet points for awards)
The Lieutenant-governor's Medal for Inclusion, Democracy and Reconciliation recognizes outstanding contributions from UNBC's graduating class of over 700 students to promoting inclusion, democracy, and reconciliation within the UNBC community. The award recognizes exceptional leadership, advocacy, and commitment to creating a more inclusive and equitable campus environment.


#v(8pt)  // Standard spacing between entries
#v(design-entries-vertical-space-between-entries)
// Normal entry (for professional development, awards, etc.) matching LaTeX

// Main entry with bold name
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(weight: "bold", "Undergraduate Student Research Award"),
  "Apr 2023"
)

// Italic summary line (like institution/organization)
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(style: "italic", "Natural Sciences and Engineering Research Council of Canada"),
  ""
)

// Description text (not bullet points for awards)
Natural Sciences and Engineering Research Council of Canada Undergraduate Student Research Award, awarded for outstanding research contributions in the natural sciences and engineering fields. The award recognizes exceptional research skills, creativity, and potential for future contributions to the field.


#v(8pt)  // Standard spacing between entries
#v(design-entries-vertical-space-between-entries)
// Normal entry (for professional development, awards, etc.) matching LaTeX

// Main entry with bold name
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(weight: "bold", "BC Northern Real Estate Board Award"),
  "Aug 2021"
)

// Italic summary line (like institution/organization)
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(style: "italic", "BC Northern Real Estate Board"),
  ""
)

// Description text (not bullet points for awards)
The award is for recipients whose home town must be within the geographical boundaries defined by the Yukon border to the north, 70 Mile House to the south, Haida Gwaii Islands to the west, and the Alberta border to the east, including the communities of Dawson Creek, Chetwynd, and Tumbler Ridge. Meeting the criteria for good academic standing is the primary basis for selection.


#v(8pt)  // Standard spacing between entries
#v(design-entries-vertical-space-between-entries)
// Normal entry (for professional development, awards, etc.) matching LaTeX

// Main entry with bold name
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(weight: "bold", "Governor General's Academic Medal"),
  "July 2018"
)

// Italic summary line (like institution/organization)
#grid(
  columns: (1fr, auto),
  align: (left, right),
  text(style: "italic", "The Governor General of Canada"),
  ""
)

// Description text (not bullet points for awards)
I was awarded the Governor General's Academic Medal in recognition of my outstanding academic achievement. This prestigious award is given to the student with the highest academic standing in their graduating class. I received this honor for achieving the highest overall average in my school, demonstrating exceptional dedication and excellence in my studies. The Governor General's Academic Medal is a national recognition of academic excellence and is highly regarded in the academic community.


#v(8pt)  // Standard spacing between entries

// Section ending - minimal spacing
#v(8pt)
#section_heading("Presentations")

#v(4pt)

// Text entry (for presentations, awards with descriptions) 
// Matches LaTeX formatting with proper spacing

#strong[Assessing the health impacts of particulate bound metals in downtown Prince George: A health indexing study on the differential effects of high and low dust days]
\_Cascadia Symposium on Environmental, Occupational, and Population Health 2024\_ | Blaine, WA

#v(8pt)  // Standard spacing between text entries
#v(design-entries-vertical-space-between-entries)
// Text entry (for presentations, awards with descriptions) 
// Matches LaTeX formatting with proper spacing

#strong[Particulate Matter-Bound Metals as an Assessment of Air Pollution in the City of Prince George]
\_UNBC Research Week 2023\_ | Prince George, BC

#v(8pt)  // Standard spacing between text entries
#v(design-entries-vertical-space-between-entries)
// Text entry (for presentations, awards with descriptions) 
// Matches LaTeX formatting with proper spacing

#strong[Heavy metals and polycyclic aromatic hydrocarbons in ambient air during episodes of springtime road dust]
\_UNBC Research Week 2021\_ | Prince George, BC

#v(8pt)  // Standard spacing between text entries

// Section ending - minimal spacing
#v(8pt)
#section_heading("Publications")

#v(4pt)

// Add this to your main template file


// Section ending - minimal spacing
#v(8pt)
