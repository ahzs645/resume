// Unescape macro for removing backslashes from special characters
// RenderCV automatically escapes special characters for Typst
// This macro unescapes them back to normal characters
((* macro unescape(text) -*))
<<text|replace('\\(', '(')|replace('\\)', ')')|replace('\\/', '/')>>
((*- endmacro *))
