#set page(
  paper: "us-letter",
  margin: (top: 1.27cm, bottom: 1.27cm, left: 1.27cm, right: 1.27cm),
)

#set text(
  font: "Times New Roman",
  size: 11pt,
  lang: "en",
  region: "EN",
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

// Header with name and contact information
#text(size: 26pt, weight: "bold")[Ahmad Jalil]

#v(6pt)

// Contact information line
#text(size: 14pt)[
  #raw("me@ahmadjalil.com")| tel:+1-778-267-9144| Prince George, BC| #link("https://ahmadjalil.com/")]

#v(-4pt)
#line(length: 100%, stroke: 0.4pt)
#v(-4pt)

#section_heading("Experience")

#v(4pt)

// Organization header with date range and location
#grid(
  columns: (1fr, auto),
  align: (left, right),
  strong("Northern Analytical Laboratory Services"),
  "Sept 2022 – present"
)

// Position line with location  
#grid(
  columns: (1fr, auto),
  align: (left, right),
  emph("Research Assistant"),
  "Prince George, BC"
)

// Bullet points for highlights
• Work both independently and in a team in a laboratory environment, performing tasks that involve collection and processing of samples using various instruments while maintaining and calibrating them

• Revamped invoicing system to automate payment tracking processes, reducing customer inquiries and improving overall customer satisfaction

• Streamlined and optimized laboratory workflow by implementing new methods and protocols, resulting in an increase in sample processing efficiency

• Authored and disseminated scientific papers and reports, contributing to the lab's knowledge base



#v(design-entries-vertical-space-between-entries)
// Organization header with date range and location
#grid(
  columns: (1fr, auto),
  align: (left, right),
  strong("Northern Analytical Laboratory Services"),
  "Nov 2020 – Sept 2022"
)

// Position line with location  
#grid(
  columns: (1fr, auto),
  align: (left, right),
  emph("Student Research Assistant"),
  "Prince George, BC"
)

// Bullet points for highlights
• Organize, review, and correct research data, creating illustrative graphs and charts for reports

• Process data using statistical software including Excel, Prism, and Rstudio, to facilitate thorough data analysis

• Apply graphic design skills \(Photoshop, Illustrator, InDesign\) to create various materials for the Northern Analytical Laboratory Services



#v(design-entries-vertical-space-between-entries)
// Organization header with date range and location
#grid(
  columns: (1fr, auto),
  align: (left, right),
  strong("Relentless Pursuit Ventures"),
  "May 2024 – Aug 2024"
)

// Position line with location  
#grid(
  columns: (1fr, auto),
  align: (left, right),
  emph("Health Technology Research Analyst \(Intern\)"),
  "Remote"
)

// Bullet points for highlights
• Conducted comprehensive research on health technology innovations for seniors in rural and remote communities across Canada

• Identified and analyzed key stakeholders in the age-tech and healthcare sectors, including government agencies, healthcare providers, technology companies, and advocacy groups



#v(design-entries-vertical-space-between-entries)
// Organization header with date range and location
#grid(
  columns: (1fr, auto),
  align: (left, right),
  strong("Northern Health"),
  "Dec 2024 – present"
)

// Position line with location  
#grid(
  columns: (1fr, auto),
  align: (left, right),
  emph("Informatics Specialists"),
  "Prince George, BC"
)

// Bullet points for highlights
• Led the integration and optimization of health information technologies, improving access to patient\/client information and enhancing evidence-based practices across Northern Health regions

• Collaborated with clinical leaders, HIM leaders, and physicians to align healthcare systems with operational needs, while designing and maintaining health information management content

• Directed change initiatives and provided leadership in recruiting, coaching, and evaluating staff, fostering innovation and supporting the adoption of international coding standards



#v(design-entries-vertical-space-between-entries)
// Organization header with date range and location
#grid(
  columns: (1fr, auto),
  align: (left, right),
  strong("Northern Health"),
  "May 2024 – Dec 2024"
)

// Position line with location  
#grid(
  columns: (1fr, auto),
  align: (left, right),
  emph("PICS Intern"),
  "Prince George, BC"
)

// Bullet points for highlights
• Utilize Geographic Information Systems \(GIS\) software to analyze and map data relevant to public health concerns across Northern Health regions

• Created and presented comprehensive GIS-based reports to high-level decision-makers to support informed decision-making on public health concerns

• Developed a standardized database to track and analyze provincial-wide systems, enhancing data consistency and accessibility across Northern Health regions



#v(design-entries-vertical-space-between-entries)
// Organization header with date range and location
#grid(
  columns: (1fr, auto),
  align: (left, right),
  strong("University of Northern British Columbia"),
  "Jan 2024 – Dec 2024"
)

// Position line with location  
#grid(
  columns: (1fr, auto),
  align: (left, right),
  emph("Teaching Assistant"),
  "Prince George, BC"
)

// Bullet points for highlights
• Contributed to the creation of an online resource hub for nutrition students, providing access to lecture notes, study guides, and additional learning materials




// Section ending - minimal spacing
#section_heading("Volunteer")

#v(4pt)

// Organization header with date range and location
#grid(
  columns: (1fr, auto),
  align: (left, right),
  strong("St. Vincent De Paul"),
  "Dec 2020 – present"
)

// Position line with location  
#grid(
  columns: (1fr, auto),
  align: (left, right),
  emph("Service Volunteer"),
  "Prince George, BC"
)

// Bullet points for highlights
• Prepared and served meals to those in need, promoted community wellness, and efficiently managed the distribution of donated goods



#v(design-entries-vertical-space-between-entries)
// Organization header with date range and location
#grid(
  columns: (1fr, auto),
  align: (left, right),
  strong("Rural eMentoring BC"),
  "Sept 2020 – present"
)

// Position line with location  
#grid(
  columns: (1fr, auto),
  align: (left, right),
  emph("Highschool Mentor"),
  "Remote"
)

// Bullet points for highlights
• Cultivated a confidential, supportive mentorship with a high school mentee, providing guidance on personal and academic challenges to foster personal and educational development



#v(design-entries-vertical-space-between-entries)
// Organization header with date range and location
#grid(
  columns: (1fr, auto),
  align: (left, right),
  strong("Over The Edge Newspaper Society"),
  "Mar 2024 – present"
)

// Position line with location  
#grid(
  columns: (1fr, auto),
  align: (left, right),
  emph("Acting Editor-in-Chief"),
  "Prince George, BC"
)

// Bullet points for highlights
• Negotiated a printing deal with the main newsprint supplier in Prince George, securing the production of 22,000 copies per issue

• Redesigned the newspaper's logo and brand image to modernize and align with current media trends

• Conducted audience research to identify preferences and tailored content to increase engagement

• Centralized information structures to streamline communication and enhance workflow efficiency



#v(design-entries-vertical-space-between-entries)
// Organization header with date range and location
#grid(
  columns: (1fr, auto),
  align: (left, right),
  strong("Sparklab"),
  "Sept 2023 – present"
)

// Position line with location  
#grid(
  columns: (1fr, auto),
  align: (left, right),
  emph("Technical Analyst"),
  "Prince George, BC"
)

// Bullet points for highlights
• Engage with researchers to understand their specific needs and challenges in laboratory and field environments

• Design customized solutions using CAD \(Computer-Aided Design\) software to address the unique requirements of various research projects



#v(design-entries-vertical-space-between-entries)
// Organization header with date range and location
#grid(
  columns: (1fr, auto),
  align: (left, right),
  strong("University of Northern British Columbia"),
  "Sept 2022 – present"
)

// Position line with location  
#grid(
  columns: (1fr, auto),
  align: (left, right),
  emph("Research Ambassador"),
  "Prince George, BC"
)

// Bullet points for highlights
• Act as a primary liaison between students and the research community at UNBC, promoting engagement and participation in research activities

• Organize and lead informational sessions and workshops to educate students about the research process, opportunities, and the significance of research contributions



#v(design-entries-vertical-space-between-entries)
// Organization header with date range and location
#grid(
  columns: (1fr, auto),
  align: (left, right),
  strong("Northern Health"),
  "Apr 2023 – present"
)

// Position line with location  
#grid(
  columns: (1fr, auto),
  align: (left, right),
  emph("Activity Volunteer"),
  "Prince George, BC"
)

// Bullet points for highlights
• Assist recreation therapists and engage in activities with residents at Rainbow Lodge & Gateway, a long-term care home and facilities, enhancing their daily lives and well-being

• Provide emotional support and reassurance to dementia patients, helping them feel more secure and oriented in their environment

• Deepen my understanding of patient-centered medicine through direct interactions, learning about residents' needs and perspectives




// Section ending - minimal spacing
#section_heading("Education")

#v(4pt)

// Institution header with date range
#grid(
  columns: (1fr, auto),
  align: (left, right),
  strong("University of Northern British Columbia"),
  "Sept 2023 – Sept 2026"
)

// Degree and area with location
#grid(
  columns: (1fr, auto),
  align: (left, right),
  emph("PhD, Natural Resources and Environmental Studies"),
  "Prince George, BC"
)// Bullet points for highlights• Focus on air quality and environmental health
#v(design-entries-vertical-space-between-entries)
// Institution header with date range
#grid(
  columns: (1fr, auto),
  align: (left, right),
  strong("University of Northern British Columbia"),
  "Sept 2023 – Aug 2024"
)

// Degree and area with location
#grid(
  columns: (1fr, auto),
  align: (left, right),
  emph("M.Sc., Natural Resources and Environmental Studies"),
  "Prince George, BC"
)// Bullet points for highlights• Focus on air quality and environmental health• Continued to PhD
#v(design-entries-vertical-space-between-entries)
// Institution header with date range
#grid(
  columns: (1fr, auto),
  align: (left, right),
  strong("University of Northern British Columbia"),
  "Sept 2019 – May 2023"
)

// Degree and area with location
#grid(
  columns: (1fr, auto),
  align: (left, right),
  emph("B.HSc., Biomedical Studies \(Honours\)"),
  "Prince George, BC"
)// Bullet points for highlights• Minor: Natural Resource Planning and Operations \(Forestry\)• The Lieutenant Governor's Medal for Inclusion, Democracy and Reconciliation

// Section ending - minimal spacing
#section_heading("Professional Development")

#v(4pt)

// Normal entry (for professional development, awards, etc.)
#grid(
  columns: (1fr, auto),
  align: (left, right),
  strong("Digital Twins - Fundamentals, Techniques & Approaches"),
  "Mar 2024"
)


_Mohawk College_


#h(1fr) Remote


#v(design-entries-vertical-space-between-entries)
// Normal entry (for professional development, awards, etc.)
#grid(
  columns: (1fr, auto),
  align: (left, right),
  strong("Applied Internet of Things \(IoT\)"),
  "May 2023"
)


_British Columbia Institute of Technology_


#h(1fr) Vancouver, BC


#v(design-entries-vertical-space-between-entries)
// Normal entry (for professional development, awards, etc.)
#grid(
  columns: (1fr, auto),
  align: (left, right),
  strong("Building Envelope Science"),
  "June 2022"
)


_Holland College_


#h(1fr) Remote


#v(design-entries-vertical-space-between-entries)
// Normal entry (for professional development, awards, etc.)
#grid(
  columns: (1fr, auto),
  align: (left, right),
  strong("Covid-19 Contact Tracer"),
  "Dec 2021"
)


_John Hopkins University_


#h(1fr) Remote



// Section ending - minimal spacing
#section_heading("Certifications and Skills")

#v(4pt)

// Text entry (for presentations, awards with descriptions)
#strong[Certifications:] OFA Level 1; TCPS 2; Environmental Professional in Training \(EPt\)
#v(design-entries-vertical-space-between-entries)
// Text entry (for presentations, awards with descriptions)
#strong[Skills:] Power BI; Research Skills; GIS; R Studio; Brand Identity Maps; Analytical Nature; Adobe Suite; Business Process Reengineering; SPSS; logistics; Fluent in Arabic; Powerful Decision-Making Expertise; Grant Proposal

// Section ending - minimal spacing
#section_heading("Awards")

#v(4pt)

// Normal entry (for professional development, awards, etc.)
#grid(
  columns: (1fr, auto),
  align: (left, right),
  strong("Canada Graduate Scholarships – Michael Smith Foreign Study Supplements"),
  "Jan 2025"
)


_Canadian Institutes of Health Research_



The Government of Canada launched this program in 2008 to support high-calibre graduate students in building global linkages and international networks through the pursuit of exceptional research experiences at research institutions outside of Canada. By accessing international scientific research and training, CGS-MSFSS recipients will contribute to strengthening the potential for collaboration between Canadian and international universities and affiliated research institutions.

#v(design-entries-vertical-space-between-entries)
// Normal entry (for professional development, awards, etc.)
#grid(
  columns: (1fr, auto),
  align: (left, right),
  strong("Canada Graduate Scholarships"),
  "Apr 2024"
)


_Canadian Institutes of Health Research_



The Canada Graduate Scholarships is designed to enhance the research skills and training of highly qualified personnel in health, natural sciences, engineering, and social sciences. This prestigious program is jointly administered by Canada's three granting agencies CIHR, NSERC, and SSHRC, supporting students annually across all disciplines. The program selects scholars through a rigorous evaluation of their academic excellence, research potential, and personal competencies.

#v(design-entries-vertical-space-between-entries)
// Normal entry (for professional development, awards, etc.)
#grid(
  columns: (1fr, auto),
  align: (left, right),
  strong("British Columbia Graduate Scholarship"),
  "Apr 2024"
)


_The Ministry of Advanced Education, Skills and Training_



The British Columbia Graduate Scholarship supports exceptional students at public post-secondary institutions across the province, with a focus on STEM and professional fields. Valued at \$17,500 the scholarships are merit-based and aim to attract top talent who contribute significantly to their disciplines. This initiative helps reduce financial barriers and promote educational innovation in British Columbia.

#v(design-entries-vertical-space-between-entries)
// Normal entry (for professional development, awards, etc.)
#grid(
  columns: (1fr, auto),
  align: (left, right),
  strong("Lieutenant-Governor's Medal for Inclusion, Democracy and Reconciliation"),
  "May 2023"
)


_Lieutenant Governor of British Columbia_



The Lieutenant-governor's Medal for Inclusion, Democracy and Reconciliation recognizes outstanding contributions from UNBC's graduating class of over 700 students to promoting inclusion, democracy, and reconciliation within the UNBC community. The award recognizes exceptional leadership, advocacy, and commitment to creating a more inclusive and equitable campus environment.

#v(design-entries-vertical-space-between-entries)
// Normal entry (for professional development, awards, etc.)
#grid(
  columns: (1fr, auto),
  align: (left, right),
  strong("Undergraduate Student Research Award"),
  "Apr 2023"
)


_Natural Sciences and Engineering Research Council of Canada_



Natural Sciences and Engineering Research Council of Canada Undergraduate Student Research Award, awarded for outstanding research contributions in the natural sciences and engineering fields. The award recognizes exceptional research skills, creativity, and potential for future contributions to the field.

#v(design-entries-vertical-space-between-entries)
// Normal entry (for professional development, awards, etc.)
#grid(
  columns: (1fr, auto),
  align: (left, right),
  strong("BC Northern Real Estate Board Award"),
  "Aug 2021"
)


_BC Northern Real Estate Board_



The award is for recipients whose home town must be within the geographical boundaries defined by the Yukon border to the north, 70 Mile House to the south, Haida Gwaii Islands to the west, and the Alberta border to the east, including the communities of Dawson Creek, Chetwynd, and Tumbler Ridge. Meeting the criteria for good academic standing is the primary basis for selection.

#v(design-entries-vertical-space-between-entries)
// Normal entry (for professional development, awards, etc.)
#grid(
  columns: (1fr, auto),
  align: (left, right),
  strong("Governor General's Academic Medal"),
  "July 2018"
)


_The Governor General of Canada_



I was awarded the Governor General's Academic Medal in recognition of my outstanding academic achievement. This prestigious award is given to the student with the highest academic standing in their graduating class. I received this honor for achieving the highest overall average in my school, demonstrating exceptional dedication and excellence in my studies. The Governor General's Academic Medal is a national recognition of academic excellence and is highly regarded in the academic community.


// Section ending - minimal spacing
#section_heading("Presentations")

#v(4pt)

// Text entry (for presentations, awards with descriptions)
#strong[Assessing the health impacts of particulate bound metals in downtown Prince George: A health indexing study on the differential effects of high and low dust days]
\_Cascadia Symposium on Environmental, Occupational, and Population Health 2024\_ | Blaine, WA
#v(design-entries-vertical-space-between-entries)
// Text entry (for presentations, awards with descriptions)
#strong[Particulate Matter-Bound Metals as an Assessment of Air Pollution in the City of Prince George]
\_UNBC Research Week 2023\_ | Prince George, BC
#v(design-entries-vertical-space-between-entries)
// Text entry (for presentations, awards with descriptions)
#strong[Heavy metals and polycyclic aromatic hydrocarbons in ambient air during episodes of springtime road dust]
\_UNBC Research Week 2021\_ | Prince George, BC

// Section ending - minimal spacing
#section_heading("Publications")

#v(4pt)

// Publication entry - academic citation formatEric S. Coker,Nikita Saha Turna,Mya Schouwenburg,#strong[#emph[Ahmad Jalil]],Charles Bradshaw,Michael Kuo,Molly Mastel,Hossein Kazemian,Meghan Roushorne,Sarah B. Henderson.(2023).**Characterization of the short-term temporal variability of road dust chemical mixtures and meteorological profiles in a near-road urban site in British Columbia**._Journal of the Air & Waste Management Association_.10.1080/10962247.2023.2197970..

// Section ending - minimal spacing
