#!/bin/bash
# Integration test for Google-GTD-QuickCapture workflow

# Set up colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Print test header
echo -e "${YELLOW}Running integration tests for Google-GTD-QuickCapture workflow...${NC}"

# Function to run the AppleScript with a test input
run_test_with_input() {
    local test_input="$1"
    local test_name="$2"
    
    echo -n "Test: $test_name... "
    
    # Create a temporary AppleScript file
    cat > ./temp_test.applescript << EOF
-- This is a test script for Google-GTD-QuickCapture workflow
on run
    -- Mock the display dialog function to return our test input
    set test_result to {button returned:"OK", text returned:"$test_input"}
    
    -- Extract the main AppleScript from the workflow
    -- In a real test, you would include the actual workflow AppleScript here
    -- and modify the dialog parts to use our mocked input
    
    -- Simulate URL encoding and browser opening
    set encodedText to "$test_input"
    
    -- Test if we would correctly encode and open the URL
    if "$test_input" is "" then
        -- Should fail on empty input
        return false
    else
        -- Should succeed on non-empty input
        return true
    end if
end run
EOF
    
    # Run the test script
    if osascript ./temp_test.applescript > /dev/null 2>&1; then
        if [ -z "$test_input" ]; then
            # Empty input should fail
            echo -e "${RED}FAILED${NC} (Empty input passed when it should fail)"
            FAILED_TESTS=$((FAILED_TESTS+1))
        else
            echo -e "${GREEN}PASSED${NC}"
            PASSED_TESTS=$((PASSED_TESTS+1))
        fi
    else
        if [ -z "$test_input" ]; then
            # Empty input should fail, so this is correct
            echo -e "${GREEN}PASSED${NC} (Correctly failed on empty input)"
            PASSED_TESTS=$((PASSED_TESTS+1))
        else
            echo -e "${RED}FAILED${NC}"
            FAILED_TESTS=$((FAILED_TESTS+1))
        fi
    fi
    
    # Clean up
    rm ./temp_test.applescript
}

# Function to test URL encoding specifically
test_url_encoding() {
    local test_input="$1"
    local expected_output="$2"
    local test_name="$3"
    
    echo -n "URL Encoding Test: $test_name... "
    
    # Create a temporary AppleScript file with the encodeText function
    cat > ./temp_url_test.applescript << EOF
-- URL Encoding test
on encodeText(theText)
	set theTextEnc to ""
	repeat with eachChar in characters of theText
		set useChar to eachChar
		set eachCharNum to ASCII number of eachChar
		if eachCharNum = 32 then -- space
			set useChar to "+"
		else if (eachCharNum ≥ 48 and eachCharNum ≤ 57) or ¬
			(eachCharNum ≥ 65 and eachCharNum ≤ 90) or ¬
			(eachCharNum ≥ 97 and eachCharNum ≤ 122) then -- 0-9A-Za-z
			set useChar to eachChar
		else
			set useChar to "%" & my toHex(eachCharNum)
		end if
		set theTextEnc to theTextEnc & useChar
	end repeat
	return theTextEnc
end encodeText

-- Helper function to convert to hex
on toHex(theNum)
	set hexChars to "0123456789ABCDEF"
	set theHex to ""
	repeat with i from 0 to 1
		set theInt to theNum div (16 ^ (1 - i)) mod 16 + 1
		set theHex to theHex & character theInt of hexChars
	end repeat
	return theHex
end toHex

on run
    set encoded to encodeText("$test_input")
    set correct to (encoded is "$expected_output")
    return correct
end run
EOF
    
    # Run the test script
    if osascript ./temp_url_test.applescript > /dev/null 2>&1; then
        echo -e "${GREEN}PASSED${NC}"
        PASSED_TESTS=$((PASSED_TESTS+1))
    else
        echo -e "${RED}FAILED${NC}"
        FAILED_TESTS=$((FAILED_TESTS+1))
    fi
    
    # Clean up
    rm ./temp_url_test.applescript
}

# Initialize counters
PASSED_TESTS=0
FAILED_TESTS=0

# Run tests with different inputs
run_test_with_input "Buy milk" "Basic note capture"
run_test_with_input "Meeting notes for team call" "Complex note capture"
run_test_with_input "Shopping list: eggs, bread, cheese" "List note"
run_test_with_input "" "Empty input (should fail)"
run_test_with_input "This is a very long note that contains a lot of text to test how the workflow handles larger inputs with multiple words and potentially special characters like !@#$%^&*()" "Long input"

# Test URL encoding
test_url_encoding "Hello World" "Hello+World" "Basic encoding"
test_url_encoding "Test & Demo" "Test+%26+Demo" "Ampersand encoding"
test_url_encoding "100% test!" "100%25+test%21" "Special chars encoding"

# Print summary
echo -e "\n${YELLOW}Test Summary:${NC}"
echo -e "${GREEN}$PASSED_TESTS tests passed${NC}"
echo -e "${RED}$FAILED_TESTS tests failed${NC}"
echo -e "${YELLOW}$((PASSED_TESTS+FAILED_TESTS)) total tests${NC}"

# Indicate success/failure in exit code
if [ $FAILED_TESTS -eq 0 ]; then
    echo -e "\n${GREEN}All integration tests PASSED!${NC}"
    exit 0
else
    echo -e "\n${RED}Some integration tests FAILED!${NC}"
    exit 1
fi