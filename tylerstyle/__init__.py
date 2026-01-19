"""
Will's mod of ahms custom theme for RenderCV.
"""

from typing import Literal

# might I recommend Pyrefly as your type checker
from pydantic import Field
from rendercv.data.models.base import RenderCVBaseModelWithoutExtraKeys


class EntriesConfig(RenderCVBaseModelWithoutExtraKeys):
    """Configuration for entries."""

    show_time_span: list[str] = Field(
        default=[],
        title="Show Time Span",
        description="Sections where time span should be shown.",
    )


class TylerstyleThemeOptions(RenderCVBaseModelWithoutExtraKeys):
    """This class is the data model of the theme options of the ahmadstyle theme."""

    theme: Literal["tylerstyle"]
    font_size: str = Field(
        default="11pt",
        title="Font Size",
        description="The font size of the CV. The default value is 11pt.",
    )
    page_size: str = Field(
        default="us-letter",
        title="Page Size",
        description="The page size of the CV. The default value is us-letter.",
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
        description="Color of the website link in the header. 'blue' for hyperlink style, 'black' to match text. Default is black.",
    )
    entries: EntriesConfig = Field(
        default=EntriesConfig(),
        title="Entries Configuration",
        description="Configuration for entry components.",
    )
    pagebreak_before_sections: list[str] = Field(
        default=[],
        title="Pagebreak Before Sections",
        description="List of section names that should start on a new page.",
    )


theme = TylerstyleThemeOptions
