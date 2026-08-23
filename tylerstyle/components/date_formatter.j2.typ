// Date formatting macro
// Converts strings like "2024-03" to "March 2024" using the active locale's
// month names, so a CV rendered in another language does not get English
// dates. Gracefully handles:
//   - "present" (any casing), translated via the locale
//   - bare years like "2024"
//   - missing/blank dates by returning an empty string
//
// Imported `with context` so `locale` (the RenderCV locale model) resolves
// from the template being rendered.
{% macro format_date(date_string) -%}
{% set normalized = (date_string|string).strip() if date_string else "" -%}
{% if not normalized -%}
""
{%- elif normalized|lower == 'present' -%}
{{ locale.present|capitalize }}
{%- else -%}
{% set parts = normalized.split('-') -%}
{% if parts|length == 1 -%}
{{ parts[0] }}
{%- elif parts|length >= 2 and parts[1]|int >= 1 and parts[1]|int <= 12 -%}
{{ locale.month_names[parts[1]|int - 1] }} {{ parts[0] }}
{%- else -%}
{{ normalized }}
{%- endif -%}
{%- endif -%}
{%- endmacro %}
