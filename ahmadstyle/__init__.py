"""
Ahmad's custom theme for RenderCV.
"""

from typing import Literal

import pydantic

from rendercv.data.models.base import RenderCVBaseModelWithoutExtraKeys


class EntriesConfig(RenderCVBaseModelWithoutExtraKeys):
    """Configuration for entries."""
    show_time_span: list[str] = pydantic.Field(
        default=[],
        title="Show Time Span",
        description="Sections where time span should be shown.",
    )


class AhmadstyleThemeOptions(RenderCVBaseModelWithoutExtraKeys):
    """This class is the data model of the theme options of the ahmadstyle theme."""

    theme: Literal["ahmadstyle"]
    font_size: str = pydantic.Field(
        default="11pt",
        title="Font Size",
        description="The font size of the CV. The default value is 11pt.",
    )
    page_size: str = pydantic.Field(
        default="letterpaper",
        title="Page Size", 
        description="The page size of the CV. The default value is letterpaper.",
    )
    entries: EntriesConfig = pydantic.Field(
        default=EntriesConfig(),
        title="Entries Configuration",
        description="Configuration for entry components.",
    )


theme = AhmadstyleThemeOptions