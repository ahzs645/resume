"""Tests for variant and tag filtering behavior."""

from pathlib import Path
import sys

sys.path.insert(0, str(Path(__file__).resolve().parents[2]))

from resume_builder.build_clean import subfilter


class TestVariantFiltering:
    """Test tag filtering rules used by resume variants."""

    def test_archived_entries_hidden_by_default(self):
        entry = {"company": "Archived Company", "tags": ["archived"]}

        assert subfilter(entry) is None

    def test_archived_entries_visible_when_archived_tag_selected(self):
        entry = {"company": "Archived Company", "tags": ["archived"]}

        result = subfilter(entry, tags=["archived"])

        assert result is not None
        assert result["company"] == "Archived Company"
        assert "tags" not in result
