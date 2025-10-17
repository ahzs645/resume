// Date formatting macro
// Converts date strings like "2024-03" to "March 2024"
// Handles "present" as a special case
((* macro format_date(date_string) -*))
((* if date_string == 'present' -*))
Present
((*- elif date_string -*))
((* set parts = date_string.split('-') -*))
((* if parts[1] == '01' -*))January <<parts[0]>>
((*- elif parts[1] == '02' -*))February <<parts[0]>>
((*- elif parts[1] == '03' -*))March <<parts[0]>>
((*- elif parts[1] == '04' -*))April <<parts[0]>>
((*- elif parts[1] == '05' -*))May <<parts[0]>>
((*- elif parts[1] == '06' -*))June <<parts[0]>>
((*- elif parts[1] == '07' -*))July <<parts[0]>>
((*- elif parts[1] == '08' -*))August <<parts[0]>>
((*- elif parts[1] == '09' -*))September <<parts[0]>>
((*- elif parts[1] == '10' -*))October <<parts[0]>>
((*- elif parts[1] == '11' -*))November <<parts[0]>>
((*- elif parts[1] == '12' -*))December <<parts[0]>>
((*- endif -*))
((*- endif -*))
((*- endmacro *))
