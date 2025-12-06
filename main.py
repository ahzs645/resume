#!/usr/bin/env python3

import subprocess
import sys
from pathlib import Path


def main():
    # Determine the correct Python executable based on platform
    if sys.platform == "win32":
        venv_python = Path("venv") / "Scripts" / "python.exe"
    else:
        venv_python = Path("venv") / "bin" / "python3"

    # Use venv Python if it exists, otherwise fall back to system Python
    if venv_python.exists():
        python_cmd = str(venv_python)
    else:
        python_cmd = "python3" if sys.platform != "win32" else "python"

    # Run build-clean.py with all passed arguments
    result = subprocess.run(
        [python_cmd, "./resume_builder/build-clean.py"] + sys.argv[1:]
    )
    sys.exit(result.returncode)


if __name__ == "__main__":
    main()
