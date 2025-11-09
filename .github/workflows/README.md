# GitHub Actions Workflow Setup

This directory previously contained a `build-resumes.yml` workflow that was used to build resume variants directly in this repository.

## Current Setup

Resume builds are now handled by the deployment repository at `/Users/ahmadjalil/Github/resumerr/`.

## Setting Up a Build Workflow (Optional)

If you want to set up automated builds in this source repository, here's the recommended workflow configuration:

### Option 1: Using External Reusable Workflow (Recommended for Source Repos)

This approach uses a reusable workflow from the `resume_builder` repository:

**File:** `.github/workflows/build-resume.yml`

```yaml
name: Build Resume Variants

on:
  push:
    branches: [ main ]
  workflow_dispatch:
    inputs:
      variants:
        description: Comma-separated resume variants to build
        required: false
        default: full
      release_tag:
        description: Release tag (leave blank to auto-generate)
        required: false
        default: ''
      release_name:
        description: Release title (optional)
        required: false
        default: ''
      release_body:
        description: Release notes (optional)
        required: false
        default: ''

jobs:
  render:
    permissions:
      contents: write
    uses: ahzs645/resume/.github/workflows/render-from-caller.yml@main  # Pin to a tag/SHA in production
    with:
      yaml_path: CV.yaml
      variants: ${{ inputs.variants != '' && inputs.variants || 'full' }}
      python_version: '3.13'
      upload_artifacts: 'true'
      publish_release: 'true'
      release_tag: ${{ github.event_name == 'workflow_dispatch' && (inputs.release_tag != '' && inputs.release_tag || format('resume-{0}', github.run_id)) || format('resume-{0}', github.sha) }}
      release_name: "${{ github.event_name == 'workflow_dispatch' && (inputs.release_name != '' && inputs.release_name || format('Resume build #{0}', github.run_number)) || 'Latest Resume' }}"
      release_body: ${{ github.event_name == 'workflow_dispatch' && (inputs.release_body != '' && inputs.release_body || 'Manual resume build.') || format('Automated build from {0} ({1}).', github.ref_name, github.sha) }}
```

**Benefits:**
- No need to maintain build infrastructure in this repo
- Uses centralized, maintained workflow from `ahzs645/resume_builder`
- Source repo focuses on content (CV.yaml, templates, config)
- Automatically publishes releases to this repository

### Option 2: Using Local Reusable Workflow (For Deployment Repos)

For deployment repositories that include the full build infrastructure:

```yaml
jobs:
  render:
    permissions:
      contents: write
    uses: ./.github/workflows/render-from-caller.yml  # Local workflow
    with:
      yaml_path: CV.yaml
      variants: ${{ inputs.variants != '' && inputs.variants || 'full' }}
      variants_yaml_path: resume-variants.yaml
      python_version: '3.13'
      upload_artifacts: 'true'
      publish_release: 'true'
      # ... additional parameters
```

**Note:** This requires maintaining a local copy of `render-from-caller.yml` in `.github/workflows/`.

### Workflow Flow

1. **Trigger**: Runs on push to main or manual workflow dispatch with custom inputs
2. **Build**: Calls the reusable `render-from-caller.yml` workflow
3. **Variants**: Builds specified variants (defaults to 'full')
4. **Artifacts**: Uploads PDFs as GitHub Actions artifacts
5. **Release**: Publishes PDFs as GitHub releases
   - **Automatic pushes**: Overwrites `resume-latest` tag
   - **Manual triggers**: Creates unique tags (e.g., `resume-12345`)

### Features

- **Manual Triggers**: Use workflow_dispatch to:
  - Build specific variants (comma-separated)
  - Customize release tag, name, and description
- **Automatic Releases**: Every push to main updates the `resume-latest` release
- **Artifacts**: Build artifacts retained for download
- **Permissions**: Requires `contents: write` for creating releases

### When to Use This Workflow

- **Production Builds**: Automated release publishing for deployment
- **Version Control**: Track resume versions with Git tags
- **Distribution**: Share resume PDFs via GitHub releases
- **Deployment Repos**: Primary workflow for repositories that publish resumes

### Integration with Source Repository

If using separate source and deployment repositories:

1. **Source Repo** (`resume`): Edit CV.yaml, templates, and configuration
2. **Deployment Repo** (`resumerr`): Sync changes and publish releases using this workflow

The deployment repo handles building and releasing, making this workflow optional for the source repo.
