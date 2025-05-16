# Test Suite for MacGTD-Google

This directory contains tests for the MacGTD-Google Automator workflows.

## Available Tests

### `test_workflow.sh`

This script tests the Google-GTD-QuickCapture workflow functionality:

1. **File Existence Test**: Checks if workflow files exist
2. **XML Syntax Test**: Validates the workflow XML syntax
3. **AppleScript Syntax Test**: Validates the AppleScript syntax
4. **Google Keep Integration Test**: Verifies integration with Google Keep
5. **URL Encoding Test**: Verifies URL encoding functionality
6. **Browser Integration Test**: Verifies web browser integration
7. **Notification Test**: Verifies notification functionality

## Running Tests

From the tests directory, run:

```bash
./test_workflow.sh
```

### Prerequisites

- `xmllint` for XML validation (usually pre-installed on macOS)
- macOS 10.14 or higher
- Web browser (Safari is used by default)

## Adding New Tests

When adding new workflows, create corresponding test scripts that follow the same pattern.

## Manual Testing

For full workflow functionality, manual testing is recommended:

1. Double-click the workflow file to install it in Automator
2. Run the service from the Services menu
3. Verify the browser opens to Google Keep with the correct content
4. Verify that notifications appear as expected

## Test Coverage

Current test coverage focuses on:

- File integrity
- Syntax validation
- Core functionality presence
- URL handling

Future test improvements may include:
- UI automation
- Integration with CI systems
- Browser compatibility testing
- Mocking of Google services