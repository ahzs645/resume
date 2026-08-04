"""
Tyler Style theme for RenderCV.

A Carlito-set sibling of ahmadstyle: same entry layouts, tighter vertical
rhythm, upright (rather than italic) secondary lines, and a few extra knobs --
a configurable body font size, a blue/black header link toggle, and per-section
page breaks.

Inherits from ClassicTheme to get all standard design fields required by
RenderCV's rendering pipeline, then adds the tylerstyle-specific options.
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


class TylerstyleTheme(ClassicTheme):
    """Custom theme that extends ClassicTheme with tylerstyle-specific options."""

    theme: Literal["tylerstyle"] = "tylerstyle"  # type: ignore[assignment]

    # Custom tylerstyle-specific fields
    font_size: str = Field(
        default="11pt",
        title="Font Size",
        description="The body font size of the CV. The default value is 11pt.",
    )
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
        description="Color of the header links. 'blue' for hyperlink style, 'black' to match body text. Default is black.",
    )
    pagebreak_before_sections: list[str] = Field(
        default=[],
        title="Pagebreak Before Sections",
        description="Section titles that should start on a new page.",
    )
    custom_entries: EntriesConfig = Field(
        default_factory=EntriesConfig,
        title="Custom Entries Configuration",
        description="Configuration for custom entry components.",
    )
