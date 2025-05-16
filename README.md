# MacGTD-Google

A collection of macOS Automator workflows for implementing Getting Things Done (GTD) with Google Workspace applications.

## Overview

This project provides a set of macOS Automator workflows that help implement the GTD methodology using Google Workspace applications:

- Google Tasks for tasks and next actions
- Google Keep for quick notes and capture
- Google Docs for project notes and reference materials
- Google Calendar for scheduled events and deadlines
- Gmail for email processing
- Google Drive for file storage and organization

## Included Workflows

### Google-GTD-QuickCapture

Quickly capture thoughts, ideas, and tasks into your Google Keep without disrupting your current workflow.

## Installation

1. Clone this repository
2. Double-click on the workflow files to install them in Automator
3. Optional: Assign keyboard shortcuts to workflows in System Preferences > Keyboard > Shortcuts > Services
4. Set up Git hooks: `./setup-hooks.sh`

## Usage

Each workflow is documented with usage instructions within the Automator interface.

## Development

### Git Hooks

This repository includes Git hooks to ensure code quality:

- **Pre-commit hook**: Validates workflow files, checks XML syntax, and runs tests

To install the hooks, run:

```bash
./setup-hooks.sh
```

### Testing

This project includes comprehensive test coverage:

- **Unit Tests**: Validate the structure and syntax of the workflow files
- **Integration Tests**: Simulate running the workflows with various inputs
- **URL Encoding Tests**: Verify correct encoding of special characters for web requests
- **CI/CD**: GitHub Actions workflow automatically runs tests on push/PR

To run tests locally:

```bash
cd tests
./test_workflow.sh     # Run unit tests
./integration_test.sh  # Run integration tests
```

See the [tests/README.md](tests/README.md) file for more details on testing.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

MIT