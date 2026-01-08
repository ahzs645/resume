"""Tests for markdown-to-Typst conversion functionality."""

import pytest
from resume_builder.build_clean import markdown_to_typst, process_markdown_in_entry


class TestMarkdownToTypst:
    """Test the markdown_to_typst function."""

    def test_bold_double_asterisks(self):
        assert markdown_to_typst("**bold**") == "#strong[bold]"
        assert markdown_to_typst("text **bold** more") == "text #strong[bold] more"

    def test_bold_double_underscores(self):
        assert markdown_to_typst("__bold__") == "#strong[bold]"
        assert markdown_to_typst("text __bold__ more") == "text #strong[bold] more"

    def test_italic_single_asterisk(self):
        assert markdown_to_typst("*italic*") == "#emph[italic]"
        assert markdown_to_typst("text *italic* more") == "text #emph[italic] more"

    def test_italic_single_underscore(self):
        assert markdown_to_typst("_italic text_") == "#emph[italic text]"
        assert markdown_to_typst("text _italic_ more") == "text #emph[italic] more"

    def test_bold_italic_triple_asterisks(self):
        assert markdown_to_typst("***bold italic***") == "#strong[#emph[bold italic]]"

    def test_bold_italic_triple_underscores(self):
        assert markdown_to_typst("___bold italic___") == "#strong[#emph[bold italic]]"

    def test_link(self):
        result = markdown_to_typst("[Click here](https://example.com)")
        assert result == '#link("https://example.com")[Click here]'

    def test_link_with_text(self):
        result = markdown_to_typst("Check out [my project](https://github.com/user/repo)!")
        assert result == 'Check out #link("https://github.com/user/repo")[my project]!'

    def test_mixed_formatting(self):
        text = "Built **scalable** APIs using *microservices* architecture"
        expected = "Built #strong[scalable] APIs using #emph[microservices] architecture"
        assert markdown_to_typst(text) == expected

    def test_no_conversion_needed(self):
        text = "Plain text without formatting"
        assert markdown_to_typst(text) == text

    def test_non_string_input(self):
        assert markdown_to_typst(123) == 123
        assert markdown_to_typst(None) is None

    def test_empty_string(self):
        assert markdown_to_typst("") == ""

    def test_underscore_in_identifier_not_converted(self):
        # Single underscores in identifiers like variable_name should not convert
        # The regex requires non-whitespace chars on both sides
        text = "variable_name"
        # This should not be converted because there's nothing after the closing _
        assert markdown_to_typst(text) == "variable_name"


class TestProcessMarkdownInEntry:
    """Test the process_markdown_in_entry function."""

    def test_highlights_conversion(self):
        entry = {
            "company": "Acme Corp",
            "highlights": [
                "Built **scalable** systems",
                "Used *microservices* architecture",
            ],
        }
        result = process_markdown_in_entry(entry)
        assert result["highlights"][0] == "Built #strong[scalable] systems"
        assert result["highlights"][1] == "Used #emph[microservices] architecture"
        assert result["company"] == "Acme Corp"  # Unchanged

    def test_summary_conversion(self):
        entry = {
            "name": "Project",
            "summary": "A **great** project with *innovative* features",
        }
        result = process_markdown_in_entry(entry)
        assert result["summary"] == "A #strong[great] project with #emph[innovative] features"
        assert result["name"] == "Project"  # Unchanged

    def test_bullet_conversion(self):
        entry = {"bullet": "Achieved **100%** test coverage"}
        result = process_markdown_in_entry(entry)
        assert result["bullet"] == "Achieved #strong[100%] test coverage"

    def test_details_conversion(self):
        entry = {"label": "Skills", "details": "Python, **Django**, *FastAPI*"}
        result = process_markdown_in_entry(entry)
        assert result["details"] == "Python, #strong[Django], #emph[FastAPI]"
        assert result["label"] == "Skills"  # Unchanged

    def test_positions_highlights_conversion(self):
        entry = {
            "company": "Tech Corp",
            "positions": [
                {
                    "title": "Senior Developer",
                    "highlights": ["Led **team** of 5", "Improved *performance* by 50%"],
                },
                {
                    "title": "Junior Developer",
                    "highlights": ["Learned **best practices**"],
                },
            ],
        }
        result = process_markdown_in_entry(entry)
        assert result["positions"][0]["highlights"][0] == "Led #strong[team] of 5"
        assert result["positions"][0]["highlights"][1] == "Improved #emph[performance] by 50%"
        assert result["positions"][1]["highlights"][0] == "Learned #strong[best practices]"

    def test_entry_without_markdown_fields(self):
        entry = {"name": "Test", "date": "2024"}
        result = process_markdown_in_entry(entry)
        assert result == entry

    def test_original_entry_not_modified(self):
        original = {"highlights": ["**bold**"]}
        result = process_markdown_in_entry(original)
        assert original["highlights"][0] == "**bold**"  # Original unchanged
        assert result["highlights"][0] == "#strong[bold]"  # Result converted
