#!/bin/bash

# Enhanced Maestro Test Runner with Dynamic Environment and Tag Support
# This script allows you to run tests with configurable environment and test scope parameters

set -e

# Default values
DEFAULT_PLATFORM="android"
DEFAULT_MODE="lite"
DEFAULT_PIN_ITERATIONS="9"
DEFAULT_TEST_FILE="tests"
DEFAULT_APP_PATH="apps/bitfinex-android.apk"
DEFAULT_ENVIRONMENT="staging"
DEFAULT_TEST_SCOPE="smoke"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Setup logging
LOG_DIR="../reports"
LOG_FILE="$LOG_DIR/test_run_$(date +%Y%m%d_%H%M%S).log"
mkdir -p "$LOG_DIR"

# Function to log messages
log_message() {
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    local message="$1"
    echo "[$timestamp] $message" >> "$LOG_FILE"
}

# Function to log with both console and file output
log_and_print() {
    local level="$1"
    local message="$2"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    
    # Log to file
    log_message "[$level] $message"
    
    # Print to console with colors
    case $level in
        "INFO")
            echo -e "${GREEN}[INFO]${NC} $message"
            ;;
        "WARNING")
            echo -e "${YELLOW}[WARNING]${NC} $message"
            ;;
        "ERROR")
            echo -e "${RED}[ERROR]${NC} $message"
            ;;
        "SUCCESS")
            echo -e "${GREEN}[SUCCESS]${NC} $message"
            ;;
        "HEADER")
            echo -e "${BLUE}================================${NC}"
            echo -e "${BLUE}$message${NC}"
            echo -e "${BLUE}================================${NC}"
            ;;
    esac
}

# Function to print usage
print_usage() {
    log_and_print "HEADER" "Enhanced Maestro Test Runner with Dynamic Environment Support"
    echo ""
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  -t, --test-file FILE     Test file to run (default: $DEFAULT_TEST_FILE)"
    echo "  -p, --platform PLATFORM  Platform: ios or android (default: $DEFAULT_PLATFORM)"
    echo "  -m, --mode MODE          App mode: lite or full (default: $DEFAULT_MODE)"
    echo "  -i, --pin-iterations N   Number of PIN iterations (default: $DEFAULT_PIN_ITERATIONS)"
    echo "  -d, --device DEVICE      Device ID to run on"
    echo "  -e, --env ENV            Environment: staging, prod (default: $DEFAULT_ENVIRONMENT)"
    echo "  -s, --scope SCOPE        Test scope: smoke, full (default: $DEFAULT_TEST_SCOPE)"
    echo "  -a, --app-path PATH      Path to app file (default: $DEFAULT_APP_PATH)"
    echo "  --tags TAGS              Comma-separated tags to include"
    echo "  --exclude-tags TAGS      Comma-separated tags to exclude"
    echo "  --debug                  Enable debug output"
    echo "  --help                   Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0                                    # Run default smoke tests on staging"
    echo "  $0 -e prod -s full                   # Run full test suite on production"
    echo "  $0 -e staging -s smoke               # Run smoke tests on staging"
    echo "  $0 -p ios -m full -i 5               # Run on iOS with Full mode and 5 PIN iterations"
    echo "  $0 -p android -d emulator-5554       # Run on specific Android device"
    echo "  $0 --tags smoke,login --exclude-tags slow  # Run with tag filters"
    echo ""
    log_message "Usage information displayed to user"
}

# Function to validate parameters
validate_params() {
    log_message "Validating parameters..."
    
    if [[ "$PLATFORM" != "ios" && "$PLATFORM" != "android" ]]; then
        log_and_print "ERROR" "Platform must be 'ios' or 'android'"
        log_message "Parameter validation FAILED - invalid platform: $PLATFORM"
        exit 1
    fi
    
    if [[ "$MODE" != "lite" && "$MODE" != "full" ]]; then
        log_and_print "ERROR" "Mode must be 'lite' or 'full'"
        log_message "Parameter validation FAILED - invalid mode: $MODE"
        exit 1
    fi
    
    if [[ "$ENVIRONMENT" != "staging" && "$ENVIRONMENT" != "prod" ]]; then
        log_and_print "ERROR" "Environment must be 'staging' or 'prod'"
        log_message "Parameter validation FAILED - invalid environment: $ENVIRONMENT"
        exit 1
    fi
    
    if [[ "$TEST_SCOPE" != "smoke" && "$TEST_SCOPE" != "full" ]]; then
        log_and_print "ERROR" "Test scope must be 'smoke' or 'full'"
        log_message "Parameter validation FAILED - invalid test scope: $TEST_SCOPE"
        exit 1
    fi
    
    if ! [[ "$PIN_ITERATIONS" =~ ^[0-9]+$ ]]; then
        log_and_print "ERROR" "PIN iterations must be a number"
        log_message "Parameter validation FAILED - invalid PIN iterations: $PIN_ITERATIONS"
        exit 1
    fi
    
    if [[ "$PIN_ITERATIONS" -lt 1 || "$PIN_ITERATIONS" -gt 20 ]]; then
        log_and_print "WARNING" "PIN iterations should be between 1 and 20"
        log_message "Parameter validation WARNING - PIN iterations out of recommended range: $PIN_ITERATIONS"
    fi
    
    log_message "Parameter validation PASSED"
}

# Function to get testdata file based on environment
get_testdata_file() {
    local environment="$1"
    case $environment in
        "staging")
            echo "../../testdata/testdata-staging.js"
            ;;
        "prod")
            echo "../../testdata/testdata-prod.js"
            ;;
        *)
            log_and_print "ERROR" "Unknown environment: $environment"
            exit 1
            ;;
    esac
}

# Function to get tags based on test scope
get_scope_tags() {
    local scope="$1"
    case $scope in
        "smoke")
            echo "smoke"
            ;;
        "full")
            echo "smoke,regression,end-to-end"
            ;;
        *)
            log_and_print "ERROR" "Unknown test scope: $scope"
            exit 1
            ;;
    esac
}

# Function to update test files with dynamic testdata
update_test_files_for_environment() {
    local environment="$1"
    local testdata_file=$(get_testdata_file "$environment")
    
    log_message "Updating test files for environment: $environment"
    log_message "Using testdata file: $testdata_file"
    
    # Find all test files and update them
    find tests -name "*.yaml" -type f | while read -r test_file; do
        if grep -q "runScript:" "$test_file"; then
            # Create backup
            cp "$test_file" "${test_file}.bak"
            
            # Update testdata reference
            sed -i "" "s|runScript: '../../testdata/testdata-[^']*'|runScript: '$testdata_file'|g" "$test_file"
            
            log_message "Updated $test_file with $testdata_file"
        fi
    done
    
    log_and_print "SUCCESS" "Test files updated for $environment environment"
}

# Function to restore test files from backup
restore_test_files() {
    log_message "Restoring test files from backup"
    
    find tests -name "*.yaml.bak" -type f | while read -r backup_file; do
        original_file="${backup_file%.bak}"
        mv "$backup_file" "$original_file"
        log_message "Restored $original_file"
    done
    
    log_and_print "INFO" "Test files restored from backup"
}

# Parse command line arguments
log_message "Parsing command line arguments..."
while [[ $# -gt 0 ]]; do
    case $1 in
        -t|--test-file)
            TEST_FILE="$2"
            log_message "Argument - test file: $2"
            shift 2
            ;;
        -p|--platform)
            PLATFORM="$2"
            log_message "Argument - platform: $2"
            shift 2
            ;;
        -m|--mode)
            MODE="$2"
            log_message "Argument - mode: $2"
            shift 2
            ;;
        -i|--pin-iterations)
            PIN_ITERATIONS="$2"
            log_message "Argument - PIN iterations: $2"
            shift 2
            ;;
        -d|--device)
            DEVICE="$2"
            log_message "Argument - device: $2"
            shift 2
            ;;
        -e|--env)
            ENVIRONMENT="$2"
            log_message "Argument - environment: $2"
            shift 2
            ;;
        -s|--scope)
            TEST_SCOPE="$2"
            log_message "Argument - test scope: $2"
            shift 2
            ;;
        -a|--app-path)
            APP_PATH="$2"
            log_message "Argument - app path: $2"
            shift 2
            ;;
        --tags)
            INCLUDE_TAGS="$2"
            log_message "Argument - include tags: $2"
            shift 2
            ;;
        --exclude-tags)
            EXCLUDE_TAGS="$2"
            log_message "Argument - exclude tags: $2"
            shift 2
            ;;
        --debug)
            DEBUG="true"
            log_message "Argument - debug mode enabled"
            shift
            ;;
        -h|--help)
            print_usage
            exit 0
            ;;
        *)
            log_and_print "ERROR" "Unknown option: $1"
            log_message "Argument parsing FAILED - unknown option: $1"
            print_usage
            exit 1
            ;;
    esac
done

# Set default values if not provided
TEST_FILE=${TEST_FILE:-$DEFAULT_TEST_FILE}
PLATFORM=${PLATFORM:-$DEFAULT_PLATFORM}
MODE=${MODE:-$DEFAULT_MODE}
PIN_ITERATIONS=${PIN_ITERATIONS:-$DEFAULT_PIN_ITERATIONS}
ENVIRONMENT=${ENVIRONMENT:-$DEFAULT_ENVIRONMENT}
TEST_SCOPE=${TEST_SCOPE:-$DEFAULT_TEST_SCOPE}
APP_PATH=${APP_PATH:-$DEFAULT_APP_PATH}

# Get scope-based tags if no specific tags provided
if [[ -z "$INCLUDE_TAGS" ]]; then
    INCLUDE_TAGS=$(get_scope_tags "$TEST_SCOPE")
fi

log_message "Final configuration values:"
log_message "  TEST_FILE: $TEST_FILE"
log_message "  PLATFORM: $PLATFORM"
log_message "  MODE: $MODE"
log_message "  PIN_ITERATIONS: $PIN_ITERATIONS"
log_message "  ENVIRONMENT: $ENVIRONMENT"
log_message "  TEST_SCOPE: $TEST_SCOPE"
log_message "  APP_PATH: $APP_PATH"
log_message "  DEVICE: $DEVICE"
log_message "  INCLUDE_TAGS: $INCLUDE_TAGS"
log_message "  EXCLUDE_TAGS: $EXCLUDE_TAGS"
log_message "  DEBUG: $DEBUG"

# Validate parameters
validate_params

# Show configuration
log_and_print "HEADER" "Enhanced Test Configuration"
echo "  Test File: $TEST_FILE"
echo "  Platform: $PLATFORM"
echo "  Mode: $MODE"
echo "  PIN Iterations: $PIN_ITERATIONS"
echo "  Environment: $ENVIRONMENT"
echo "  Test Scope: $TEST_SCOPE"
echo "  App Path: $APP_PATH"
if [[ -n "$DEVICE" ]]; then
    echo "  Device: $DEVICE"
fi
echo "  Include Tags: $INCLUDE_TAGS"
if [[ -n "$EXCLUDE_TAGS" ]]; then
    echo "  Exclude Tags: $EXCLUDE_TAGS"
fi
echo ""
log_message "Enhanced test configuration displayed to user"

# Update test files for the specified environment
update_test_files_for_environment "$ENVIRONMENT"

# Build maestro command
MAESTRO_CMD="maestro test $TEST_FILE"

if [[ -n "$DEVICE" ]]; then
    MAESTRO_CMD="$MAESTRO_CMD --device $DEVICE"
fi

if [[ -n "$INCLUDE_TAGS" ]]; then
    MAESTRO_CMD="$MAESTRO_CMD --include-tags $INCLUDE_TAGS"
fi

if [[ -n "$EXCLUDE_TAGS" ]]; then
    MAESTRO_CMD="$MAESTRO_CMD --exclude-tags $EXCLUDE_TAGS"
fi

log_message "Final Maestro command: $MAESTRO_CMD"

log_and_print "SUCCESS" "Running enhanced test with dynamic configuration..."
echo "Command: $MAESTRO_CMD"
echo ""
log_message "Executing enhanced Maestro command: $MAESTRO_CMD"

# Set environment variables and run
log_message "Setting environment variables for test execution"
log_message "  PLATFORM: $PLATFORM"
log_message "  APP_MODE: $MODE"
log_message "  PIN_ITERATIONS: $PIN_ITERATIONS"
log_message "  ENVIRONMENT: $ENVIRONMENT"
log_message "  TEST_SCOPE: $TEST_SCOPE"

# Setup cleanup trap
trap 'restore_test_files' EXIT

PLATFORM="$PLATFORM" \
APP_MODE="$MODE" \
PIN_ITERATIONS="$PIN_ITERATIONS" \
ENVIRONMENT="$ENVIRONMENT" \
TEST_SCOPE="$TEST_SCOPE" \
eval "$MAESTRO_CMD"

# Capture exit code
TEST_EXIT_CODE=$?
log_message "Enhanced test execution completed with exit code: $TEST_EXIT_CODE"

# Restore test files
restore_test_files

if [[ $TEST_EXIT_CODE -eq 0 ]]; then
    log_and_print "SUCCESS" "Enhanced test completed successfully!"
else
    log_and_print "ERROR" "Enhanced test failed with exit code: $TEST_EXIT_CODE"
fi

log_message "Enhanced test runner session completed"
exit $TEST_EXIT_CODE