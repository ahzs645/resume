"""
Ahmad's custom theme for RenderCV.

Inherits from ClassicTheme to get all standard design fields required by
RenderCV's rendering pipeline, then adds custom fields for ahmadstyle-specific options.
"""

from typing import Literal

from pydantic import Field

from rendercv.schema.models.base import BaseModelWithoutExtraKeys
from rendercv.schema.models.design.classic_theme import ClassicTheme


class EntriesConfig(BaseModelWithoutExtraKeys):
    """Configuration for entries."""

    show_time_span: list[str] = Field(
        default=[],
        title="Show Time Span",
        description="Sections where time span should be shown.",
    )


class AhmadstyleTheme(ClassicTheme):
    """Custom theme that extends ClassicTheme with ahmad-specific options."""

    theme: Literal["ahmadstyle"] = "ahmadstyle"  # type: ignore[assignment]

    # Custom ahmadstyle-specific fields
    keep_sections_together: bool = Field(
        default=False,
        title="Keep Sections Together",
        description="Prevent page breaks within sections to keep content together. Default is False.",
    )
    keep_entries_together: bool = Field(
        default=True,
        title="Keep Entries Together",
        description="Prevent page breaks within individual entries (e.g., keep a job entry and its highlights together). Default is True.",
    )
    prevent_orphaned_headers: bool = Field(
        default=True,
        title="Prevent Orphaned Section Headers",
        description="Prevent section headers from appearing alone at the bottom of a page without their first entry. Default is True.",
    )
    section_heading_size: str = Field(
        default="11pt",
        title="Section Heading Size",
        description="Font size for section headers (e.g., EXPERIENCE). Default is 11pt.",
    )
    website_link_color: Literal["blue", "black"] = Field(
        default="black",
        title="Website Link Color",
        description="Color of the website link in the header. 'blue' for hyperlink style, 'black' to match text. Default is black.",
    )
    custom_entries: EntriesConfig = Field(
        default_factory=EntriesConfig,
        title="Custom Entries Configuration",
        description="Configuration for custom entry components.",
    )
