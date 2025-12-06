// Date formatting macro
// Converts strings like "2024-03" to "March 2024" and gracefully handles:
//   - "present" (any casing)
//   - bare years like "2024"
//   - missing/blank dates by returning an empty string
((* macro format_date(date_string) -*))
((* set normalized = (date_string|string).strip() if date_string else "" -*))
((* if not normalized -*))
""
((*- elif normalized|lower == 'present' -*))
Present
((*- else -*))
((* set parts = normalized.split('-') -*))
((* if parts|length == 1 -*))
<<parts[0]>>
((*- elif parts|length >= 2 -*))
((* set month = parts[1].zfill(2) -*))
((* set year = parts[0] -*))
((* if month == '01' -*))January <<year>>
((*- elif month == '02' -*))February <<year>>
((*- elif month == '03' -*))March <<year>>
((*- elif month == '04' -*))April <<year>>
((*- elif month == '05' -*))May <<year>>
((*- elif month == '06' -*))June <<year>>
((*- elif month == '07' -*))July <<year>>
((*- elif month == '08' -*))August <<year>>
((*- elif month == '09' -*))September <<year>>
((*- elif month == '10' -*))October <<year>>
((*- elif month == '11' -*))November <<year>>
((*- elif month == '12' -*))December <<year>>
((*- else -*))
<<normalized>>
((*- endif -*))
((*- else -*))
<<normalized>>
((*- endif -*))
((*- endif -*))
((*- endmacro *))
