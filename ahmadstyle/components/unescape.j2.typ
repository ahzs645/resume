// Unescape macro for removing backslashes from parentheses
// RenderCV automatically escapes ( and ) to \( and \) for Typst
// This macro unescapes them back to normal parentheses
((* macro unescape(text) -*))
<<text|replace('\\(', '(')|replace('\\)', ')')>>
((*- endmacro *))
