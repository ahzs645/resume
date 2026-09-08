"""Compatibility alias; all defaults and rendering live in classicserif."""
from typing import Literal
import importlib.util
from pathlib import Path

# RenderCV loads custom schemas by filename, so do not rely on the caller's sys.path.
_spec = importlib.util.spec_from_file_location("classicserif", Path(__file__).resolve().parent.parent / "classicserif" / "__init__.py")
_module = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(_module)

class PhdjakesTheme(_module.ClassicserifTheme):
    theme: Literal["phdjakes"] = "phdjakes"
    preset: Literal["jake", "carolyn"] = "jake"
