# Virtual Environment Setup

## Quick Setup
```bash
# Create virtual environment
python -m venv venv

# Activate virtual environment
source venv/bin/activate  # On macOS/Linux
# or
venv\Scripts\activate     # On Windows

# Install dependencies
pip install -r requirements.txt
```

## Usage
```bash
# Always activate the environment before building
source venv/bin/activate

# Build resumes
./build-resume full
./build-resume academic
```

## Deactivate
```bash
deactivate
```
