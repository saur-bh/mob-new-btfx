#!/bin/bash

# Maestro Test Runner with Platform-Specific Test Data
# This script allows you to run tests with configurable parameters

set -e

# Default values
DEFAULT_PLATFORM="android"
DEFAULT_MODE="lite"
DEFAULT_PIN_ITERATIONS="9"
DEFAULT_TEST_FILE="tests"
DEFAULT_APP_PATH="apps/bitfinex-android.apk"

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
    log_and_print "HEADER" "Maestro Test Runner with Platform-Specific Test Data"
    echo ""
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  -t, --test-file FILE     Test file to run (default: $DEFAULT_TEST_FILE)"
    echo "  -p, --platform PLATFORM  Platform: ios or android (default: $DEFAULT_PLATFORM)"
    echo "  -m, --mode MODE          App mode: lite or full (default: $DEFAULT_MODE)"
    echo "  -i, --pin-iterations N   Number of PIN iterations (default: $DEFAULT_PIN_ITERATIONS)"
    echo "  -d, --device DEVICE      Device ID to run on"
    echo "  -e, --env ENV            Environment: dev, staging, prod (default: prod)"
    echo "  -a, --app-path PATH      Path to app file (default: $DEFAULT_APP_PATH)"
    echo "  --tags TAGS              Comma-separated tags to include"
    echo "  --exclude-tags TAGS      Comma-separated tags to exclude"
    echo "  --debug                  Enable debug output"
    echo "  --help                   Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0                                    # Run default test on Android"
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

# Function to check prerequisites
check_prerequisites() {
    log_message "Checking prerequisites..."
    
    if ! command -v maestro &> /dev/null; then
        log_and_print "ERROR" "Maestro is not installed"
        log_message "Prerequisites check FAILED - Maestro not found"
        echo "Install Maestro: curl -Ls 'https://get.maestro.mobile.dev' | bash"
        exit 1
    else
        local maestro_version=$(maestro --version)
        log_message "Maestro found: $maestro_version"
    fi
    
    if ! command -v adb &> /dev/null; then
        log_and_print "ERROR" "ADB not found. Android device management requires ADB."
        log_message "Prerequisites check FAILED - ADB not found"
        echo "Install Android SDK and add platform-tools to PATH"
        exit 1
    else
        local adb_version=$(adb version | head -1)
        log_message "ADB found: $adb_version"
    fi
    
    if ! command -v emulator &> /dev/null; then
        log_and_print "WARNING" "Android emulator not found. Device auto-start may not work."
        log_message "Prerequisites check WARNING - Android emulator not found in PATH"
        echo "   Add to PATH: export PATH=\$PATH:$android_home/emulator"
        log_message "Android emulator PATH fix instruction provided"
    else
        log_message "Android emulator found"
    fi
    
    log_message "Prerequisites check completed"
}

# Function to check if Android device is running
check_android_device() {
    log_message "Checking Android device status..."
    
    local devices=$(adb devices | grep -v "List of devices" | grep -v "^$" | wc -l)
    if [[ $devices -gt 0 ]]; then
        log_and_print "SUCCESS" "Android device(s) found"
        local device_list=$(adb devices | grep -v "List of devices" | grep -v "^$")
        echo "$device_list"
        log_message "Android devices found: $device_list"
        return 0
    else
        log_and_print "WARNING" "No Android devices found"
        log_message "Android device check FAILED - no devices found"
        return 1
    fi
}

# Function to start Android emulator
start_android_emulator() {
    log_and_print "INFO" "Starting Android emulator..."
    log_message "Starting Android emulator process"
    
    # Check if emulator command exists
    if ! command -v emulator &> /dev/null; then
        log_and_print "ERROR" "Android emulator not found"
        log_message "Android emulator start FAILED - emulator command not found"
        echo "Please install Android Studio and set up an AVD"
        exit 1
    fi
    
    # List available AVDs
    local avds=$(emulator -list-avds)
    log_message "Available AVDs: $avds"
    
    if [[ -z "$avds" ]]; then
        log_and_print "ERROR" "No Android Virtual Devices (AVDs) found"
        log_message "Android emulator start FAILED - no AVDs found"
        echo "Please create an AVD using Android Studio"
        exit 1
    fi
    
    # Use the first available AVD
    local avd_name=$(echo "$avds" | head -n 1)
    log_and_print "INFO" "Starting AVD: $avd_name"
    log_message "Selected AVD for startup: $avd_name"
    
    # Start emulator in background
    emulator -avd "$avd_name" -no-snapshot-load &
    local emulator_pid=$!
    log_message "Emulator started with PID: $emulator_pid"
    
    log_and_print "INFO" "Waiting for emulator to boot..."
    
    # Wait for emulator to be ready
    local max_attempts=60
    local attempt=0
    
    while [[ $attempt -lt $max_attempts ]]; do
        if adb devices | grep -q "emulator"; then
            log_and_print "SUCCESS" "Emulator started successfully"
            log_message "Emulator startup completed successfully after $attempt attempts"
            return 0
        fi
        sleep 5
        attempt=$((attempt + 1))
        echo -n "."
    done
    
    log_and_print "ERROR" "Emulator failed to start within timeout"
    log_message "Emulator startup FAILED - timeout after $max_attempts attempts"
    kill $emulator_pid 2>/dev/null || true
    log_message "Emulator process killed due to timeout"
    exit 1
}

# Function to install app on Android device
install_android_app() {
    local app_path="$1"
    log_message "Starting Android app installation: $app_path"
    
    if [[ ! -f "$app_path" ]]; then
        log_and_print "WARNING" "App file not found at $app_path"
        log_message "App installation SKIPPED - file not found: $app_path"
        echo "Skipping app installation. Make sure to install the app manually."
        return 0
    fi
    
    log_and_print "INFO" "Installing app: $app_path"
    
    # Check if app is already installed
    local package_name="com.bitfinex.mobileapp.dev"
    if adb shell pm list packages | grep -q "$package_name"; then
        log_and_print "WARNING" "App already installed, uninstalling first..."
        log_message "App already installed, uninstalling package: $package_name"
        adb uninstall "$package_name" || true
    fi
    
    # Install the app
    log_message "Installing app via ADB: $app_path"
    if adb install "$app_path"; then
        log_and_print "SUCCESS" "App installed successfully"
        log_message "App installation completed successfully"
    else
        log_and_print "ERROR" "Failed to install app"
        log_message "App installation FAILED - ADB install command failed"
        exit 1
    fi
}

# Function to manage Android device
manage_android_device() {
    log_and_print "INFO" "Managing Android device..."
    log_message "Starting Android device management"
    
    # Check if device is already running
    if check_android_device; then
        log_and_print "SUCCESS" "Using existing Android device"
        log_message "Android device management - using existing device"
    else
        log_and_print "INFO" "No Android device found, starting emulator..."
        log_message "Android device management - starting new emulator"
        start_android_emulator
        
        # Wait a bit more for device to be fully ready
        log_message "Waiting additional 10 seconds for device to be fully ready"
        sleep 10
        
        # Verify device is ready
        if ! check_android_device; then
            log_and_print "ERROR" "Device not ready after starting emulator"
            log_message "Android device management FAILED - device not ready after startup"
            exit 1
        fi
    fi
    
    # Install app if specified
    if [[ -n "$APP_PATH" ]]; then
        log_message "App path specified, installing app: $APP_PATH"
        install_android_app "$APP_PATH"
    else
        log_message "No app path specified, skipping app installation"
    fi
    
    log_message "Android device management completed successfully"
}

# Function to list available devices
list_devices() {
    log_and_print "INFO" "Available devices:"
    log_message "Listing available devices"
    
    if command -v adb &> /dev/null; then
        echo "Android devices:"
        local android_devices=$(adb devices)
        echo "$android_devices"
        log_message "Android devices: $android_devices"
    else
        log_message "ADB not found - cannot list Android devices"
    fi
    
    if command -v xcrun &> /dev/null; then
        echo "iOS simulators:"
        local ios_devices=$(xcrun simctl list devices booted)
        echo "$ios_devices"
        log_message "iOS simulators: $ios_devices"
    else
        log_message "xcrun not found - cannot list iOS simulators"
    fi
}

# Function to build maestro command
build_maestro_command() {
    log_message "Building Maestro command..."
    
    local cmd="maestro test"
    
    # Add test file
    cmd="$cmd $TEST_FILE"
    log_message "Maestro command - test file: $TEST_FILE"
    
    # Add device if specified
    if [[ -n "$DEVICE" ]]; then
        cmd="$cmd --device $DEVICE"
        log_message "Maestro command - device: $DEVICE"
    fi
    
    # Add debug output if requested
    if [[ "$DEBUG" == "true" ]]; then
        cmd="$cmd --debug-output ./debug"
        log_message "Maestro command - debug output enabled"
    fi
    
    # Add tag filters
    if [[ -n "$INCLUDE_TAGS" ]]; then
        cmd="$cmd --include-tags $INCLUDE_TAGS"
        log_message "Maestro command - include tags: $INCLUDE_TAGS"
    fi
    
    if [[ -n "$EXCLUDE_TAGS" ]]; then
        cmd="$cmd --exclude-tags $EXCLUDE_TAGS"
        log_message "Maestro command - exclude tags: $EXCLUDE_TAGS"
    fi
    
    log_message "Final Maestro command: $cmd"
    echo "$cmd"
}

# Function to prepare test file (no longer needs platform-specific updates)
prepare_test_file() {
    local test_file="$1"
    
    log_message "Preparing test file: $test_file"
    
    # Test files now use dynamic testdata selection via enhanced runner
    # No temporary file modification needed
    echo "$test_file"
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
            ENV="$2"
            log_message "Argument - environment: $2"
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
ENV=${ENV:-"prod"}
APP_PATH=${APP_PATH:-$DEFAULT_APP_PATH}

log_message "Final configuration values:"
log_message "  TEST_FILE: $TEST_FILE"
log_message "  PLATFORM: $PLATFORM"
log_message "  MODE: $MODE"
log_message "  PIN_ITERATIONS: $PIN_ITERATIONS"
log_message "  ENV: $ENV"
log_message "  APP_PATH: $APP_PATH"
log_message "  DEVICE: $DEVICE"
log_message "  INCLUDE_TAGS: $INCLUDE_TAGS"
log_message "  EXCLUDE_TAGS: $EXCLUDE_TAGS"
log_message "  DEBUG: $DEBUG"

# Validate parameters
validate_params

# Check prerequisites
check_prerequisites

# Show configuration
log_and_print "HEADER" "Test Configuration"
echo "  Test File: $TEST_FILE"
echo "  Platform: $PLATFORM"
echo "  Mode: $MODE"
echo "  PIN Iterations: $PIN_ITERATIONS"
echo "  Environment: $ENV"
echo "  App Path: $APP_PATH"
if [[ -n "$DEVICE" ]]; then
    echo "  Device: $DEVICE"
fi
if [[ -n "$INCLUDE_TAGS" ]]; then
    echo "  Include Tags: $INCLUDE_TAGS"
fi
if [[ -n "$EXCLUDE_TAGS" ]]; then
    echo "  Exclude Tags: $EXCLUDE_TAGS"
fi
echo ""
log_message "Test configuration displayed to user"

# Manage Android device if needed
if [[ "$PLATFORM" == "android" && -z "$DEVICE" ]]; then
    log_message "Android platform detected without specific device - managing device"
    manage_android_device
    echo ""
fi

# List devices if no device specified
if [[ -z "$DEVICE" ]]; then
    log_message "No specific device specified - listing available devices"
    list_devices
    echo ""
fi

# Prepare test file
log_message "Preparing test file for execution"
UPDATED_TEST_FILE=$(prepare_test_file "$TEST_FILE")
log_and_print "INFO" "Using test file: $TEST_FILE"

# Build and execute command
log_message "Building Maestro command for execution"
MAESTRO_CMD=$(build_maestro_command "$UPDATED_TEST_FILE")

log_and_print "SUCCESS" "Running test..."
echo "$MAESTRO_CMD"
echo ""
log_message "Executing Maestro command: $MAESTRO_CMD"

# Set environment variables and run
log_message "Setting environment variables for test execution"
log_message "  PLATFORM: $PLATFORM"
log_message "  APP_MODE: $MODE"
log_message "  PIN_ITERATIONS: $PIN_ITERATIONS"
log_message "  ENV: $ENV"

PLATFORM="$PLATFORM" \
APP_MODE="$MODE" \
PIN_ITERATIONS="$PIN_ITERATIONS" \
ENV="$ENV" \
eval "$MAESTRO_CMD"

# Capture exit code
TEST_EXIT_CODE=$?
log_message "Test execution completed with exit code: $TEST_EXIT_CODE"

# No temporary files to clean up
log_message "Test execution cleanup completed"

# Log final status
if [[ $TEST_EXIT_CODE -eq 0 ]]; then
    log_and_print "SUCCESS" "Test completed successfully!"
    log_message "Test run completed successfully"
else
    log_and_print "ERROR" "Test failed with exit code: $TEST_EXIT_CODE"
    log_message "Test run FAILED with exit code: $TEST_EXIT_CODE"
fi

log_message "Test run log file: $LOG_FILE"
log_message "=== Test run completed ==="
