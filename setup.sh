#!/bin/bash

# Maestro Mobile Automation Framework Setup Script
# This script sets up the complete framework environment

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Setup logging
LOG_DIR="reports"
LOG_FILE="$LOG_DIR/setup_$(date +%Y%m%d_%H%M%S).log"
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

# Function to print colored output (keeping original functions for compatibility)
print_status() {
    log_and_print "INFO" "$1"
}

print_warning() {
    log_and_print "WARNING" "$1"
}

print_error() {
    log_and_print "ERROR" "$1"
}

print_header() {
    log_and_print "HEADER" "$1"
}

print_success() {
    log_and_print "SUCCESS" "$1"
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check OS
get_os() {
    case "$(uname -s)" in
        Darwin*)    echo 'macos';;
        Linux*)     echo 'linux';;
        CYGWIN*)    echo 'windows';;
        MINGW*)     echo 'windows';;
        *)          echo 'unknown';;
    esac
}

# Function to check Java
check_java() {
    print_status "Checking Java installation..."
    log_message "Starting Java installation check"
    
    if command_exists java; then
        local java_version=$(java -version 2>&1 | head -1)
        print_success "Java found: $java_version"
        log_message "Java installation found: $java_version"
        
        # Check Java version
        local version=$(java -version 2>&1 | awk -F '"' '/version/ {print $2}' | cut -d'.' -f1)
        log_message "Java version detected: $version"
        
        if [[ "$version" -ge 11 ]]; then
            print_success "Java version is compatible (Java $version)"
            log_message "Java version check PASSED - version $version is compatible"
            return 0
        else
            print_warning "Java version $version detected. Java 11+ is recommended."
            log_message "Java version check FAILED - version $version is below recommended (11+)"
            return 1
        fi
    else
        print_error "Java not found!"
        log_message "Java installation check FAILED - Java not found in PATH"
        echo ""
        echo "📥 Download Java:"
        echo "   • macOS: brew install openjdk@11"
        echo "   • Linux: sudo apt-get install openjdk-11-jdk"
        echo "   • Manual: https://adoptium.net/"
        echo ""
        log_message "Java download instructions provided to user"
        return 1
    fi
}

# Function to check Node.js
check_nodejs() {
    print_status "Checking Node.js installation..."
    log_message "Starting Node.js installation check"
    
    if command_exists node; then
        local node_version=$(node --version)
        print_success "Node.js found: $node_version"
        log_message "Node.js installation found: $node_version"
        
        # Check Node.js version
        local version=$(node --version | cut -d'v' -f2 | cut -d'.' -f1)
        log_message "Node.js version detected: $version"
        
        if [[ "$version" -ge 16 ]]; then
            print_success "Node.js version is compatible (Node.js $version)"
            log_message "Node.js version check PASSED - version $version is compatible"
            return 0
        else
            print_warning "Node.js version $version detected. Node.js 16+ is recommended."
            log_message "Node.js version check FAILED - version $version is below recommended (16+)"
            return 1
        fi
    else
        print_error "Node.js not found!"
        log_message "Node.js installation check FAILED - Node.js not found in PATH"
        echo ""
        echo "📥 Download Node.js:"
        echo "   • macOS: brew install node"
        echo "   • Linux: curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -"
        echo "   • Manual: https://nodejs.org/"
        echo ""
        log_message "Node.js download instructions provided to user"
        return 1
    fi
}

# Function to check Maestro
check_maestro() {
    print_status "Checking Maestro installation..."
    log_message "Starting Maestro installation check"
    
    if command_exists maestro; then
        local maestro_version=$(maestro --version)
        print_success "Maestro found: $maestro_version"
        log_message "Maestro installation found: $maestro_version"
        return 0
    else
        print_error "Maestro not found!"
        log_message "Maestro installation check FAILED - Maestro not found in PATH"
        echo ""
        echo "📥 Install Maestro:"
        echo "   curl -Ls 'https://get.maestro.mobile.dev' | bash"
        echo ""
        log_message "Maestro installation instructions provided to user"
        return 1
    fi
}

# Function to check Android SDK
check_android_sdk() {
    print_status "Checking Android SDK installation..."
    log_message "Starting Android SDK installation check"
    
    local android_home=""
    local os=$(get_os)
    log_message "Detected OS for Android SDK check: $os"
    
    case $os in
        "macos")
            android_home="$HOME/Library/Android/sdk"
            ;;
        "linux")
            android_home="$HOME/Android/Sdk"
            ;;
        *)
            android_home="$ANDROID_HOME"
            ;;
    esac
    
    log_message "Checking Android SDK at: $android_home"
    
    if [[ -d "$android_home" ]]; then
        print_success "Android SDK found at: $android_home"
        log_message "Android SDK directory found at: $android_home"
        
        # Check ADB
        if command_exists adb; then
            local adb_version=$(adb version | head -1)
            print_success "ADB found: $adb_version"
            log_message "ADB found: $adb_version"
        else
            print_warning "ADB not found in PATH"
            log_message "ADB check FAILED - not found in PATH"
            echo "   Add to PATH: export PATH=\$PATH:$android_home/platform-tools"
            log_message "ADB PATH fix instruction provided"
        fi
        
        # Check emulator
        if command_exists emulator; then
            print_success "Android emulator found"
            log_message "Android emulator found in PATH"
        else
            print_warning "Android emulator not found in PATH"
            log_message "Android emulator check FAILED - not found in PATH"
            echo "   Add to PATH: export PATH=\$PATH:$android_home/emulator"
            log_message "Android emulator PATH fix instruction provided"
        fi
        
        # Check AVDs
        if command_exists emulator; then
            local avds=$(emulator -list-avds 2>/dev/null)
            if [[ -n "$avds" ]]; then
                print_success "Android Virtual Devices found:"
                log_message "Android Virtual Devices found:"
                echo "$avds" | sed 's/^/   • /'
                echo "$avds" | sed 's/^/   • /' >> "$LOG_FILE"
            else
                print_warning "No Android Virtual Devices (AVDs) found"
                log_message "AVD check FAILED - no virtual devices found"
                echo "   Create AVD: avdmanager create avd -n 'test_device' -k 'system-images;android-30;google_apis;x86_64'"
                log_message "AVD creation instruction provided"
            fi
        fi
        
        return 0
    else
        print_error "Android SDK not found!"
        log_message "Android SDK check FAILED - directory not found at: $android_home"
        echo ""
        echo "📥 Download Android Studio:"
        echo "   • Official: https://developer.android.com/studio"
        echo "   • macOS: brew install --cask android-studio"
        echo ""
        echo "After installation:"
        echo "   1. Open Android Studio"
        echo "   2. Go to Tools → SDK Manager"
        echo "   3. Install Android SDK"
        echo "   4. Create AVD in Tools → AVD Manager"
        echo ""
        log_message "Android Studio download and setup instructions provided"
        return 1
    fi
}

# Function to check Xcode (macOS only)
check_xcode() {
    local os=$(get_os)
    
    if [[ "$os" != "macos" ]]; then
        log_message "Skipping Xcode check - not on macOS (OS: $os)"
        return 0
    fi
    
    print_status "Checking Xcode installation..."
    log_message "Starting Xcode installation check (macOS detected)"
    
    if command_exists xcrun; then
        local xcode_version=$(xcodebuild -version | head -1)
        print_success "Xcode found: $xcode_version"
        log_message "Xcode installation found: $xcode_version"
        
        # Check iOS simulators
        local simulators=$(xcrun simctl list devices booted 2>/dev/null)
        if [[ -n "$simulators" ]]; then
            print_success "iOS simulators found"
            log_message "iOS simulators check PASSED - booted simulators found"
        else
            print_warning "No iOS simulators running"
            log_message "iOS simulators check FAILED - no booted simulators found"
            echo "   Start simulator: open -a Simulator"
            log_message "iOS simulator start instruction provided"
        fi
        
        return 0
    else
        print_error "Xcode not found!"
        log_message "Xcode installation check FAILED - xcrun command not found"
        echo ""
        echo "📥 Download Xcode:"
        echo "   • Mac App Store: Search for 'Xcode'"
        echo "   • Manual: https://developer.apple.com/xcode/"
        echo ""
        log_message "Xcode download instructions provided"
        return 1
    fi
}

# Function to check Homebrew (macOS only)
check_homebrew() {
    local os=$(get_os)
    
    if [[ "$os" != "macos" ]]; then
        log_message "Skipping Homebrew check - not on macOS (OS: $os)"
        return 0
    fi
    
    print_status "Checking Homebrew installation..."
    log_message "Starting Homebrew installation check (macOS detected)"
    
    if command_exists brew; then
        local brew_version=$(brew --version | head -1)
        print_success "Homebrew found: $brew_version"
        log_message "Homebrew installation found: $brew_version"
        return 0
    else
        print_warning "Homebrew not found!"
        log_message "Homebrew installation check FAILED - brew command not found"
        echo ""
        echo "📥 Install Homebrew:"
        echo "   /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
        echo ""
        log_message "Homebrew installation instructions provided"
        return 1
    fi
}

# Function to check framework files
check_framework_files() {
    print_status "Checking framework files..."
    log_message "Starting framework files check"
    
    local missing_files=()
    
    # Check essential directories
    local required_dirs=("flows" "testdata" "tests" "utils")
    for dir in "${required_dirs[@]}"; do
        if [[ ! -d "$dir" ]]; then
            missing_files+=("$dir/")
            log_message "Missing required directory: $dir/"
        else
            log_message "Required directory found: $dir/"
        fi
    done
    
    # Check essential files
    local required_files=(
        "flows/shared/app_setup.yaml"
        "flows/shared/login_flow.yaml"
        "flows/shared/pin_creation.yaml"
        "testdata/testdata-staging.js"
        "testdata/testdata-prod.js"
        "tests/login_test.yaml"
        "tests/navigation_test.yaml"
        "utils/run_test.sh"
        "utils/run_test_enhanced.sh"
        "Readme.md"
    )
    
    for file in "${required_files[@]}"; do
        if [[ ! -f "$file" ]]; then
            missing_files+=("$file")
            log_message "Missing required file: $file"
        else
            log_message "Required file found: $file"
        fi
    done
    
    if [[ ${#missing_files[@]} -eq 0 ]]; then
        print_success "All framework files found"
        log_message "Framework files check PASSED - all required files and directories found"
        return 0
    else
        print_warning "Missing framework files:"
        log_message "Framework files check FAILED - missing files:"
        for file in "${missing_files[@]}"; do
            echo "   • $file"
            log_message "   Missing: $file"
        done
        echo ""
        echo "Please ensure you have the complete framework files."
        log_message "User instructed to ensure complete framework files"
        return 1
    fi
}

# Function to check app files
check_app_files() {
    print_status "Checking app files..."
    log_message "Starting app files check"
    
    local missing_apps=()
    
    # Check Android app
    if [[ ! -f "apps/bitfinex-android.apk" ]]; then
        missing_apps+=("Android APK")
        log_message "Missing Android app: apps/bitfinex-android.apk"
    else
        print_success "Android app found: apps/bitfinex-android.apk"
        log_message "Android app found: apps/bitfinex-android.apk"
    fi
    
    # Check iOS app
    if [[ ! -f "apps/bitfinex-ios.app" ]] && [[ ! -f "apps/bitfinex-ios.ipa" ]]; then
        missing_apps+=("iOS app")
        log_message "Missing iOS app: apps/bitfinex-ios.app or apps/bitfinex-ios.ipa"
    else
        print_success "iOS app found"
        log_message "iOS app found"
    fi
    
    if [[ ${#missing_apps[@]} -eq 0 ]]; then
        print_success "All app files found"
        log_message "App files check PASSED - all app files found"
        return 0
    else
        print_warning "Missing app files:"
        log_message "App files check FAILED - missing apps:"
        for app in "${missing_apps[@]}"; do
            echo "   • $app"
            log_message "   Missing: $app"
        done
        echo ""
        echo "📥 Add app files to apps/ directory:"
        echo "   • Android: apps/bitfinex-android.apk"
        echo "   • iOS: apps/bitfinex-ios.app or apps/bitfinex-ios.ipa"
        echo ""
        log_message "App file installation instructions provided"
        return 1
    fi
}

# Function to setup environment variables
setup_environment() {
    print_status "Setting up environment variables..."
    log_message "Starting environment variables setup"
    
    local shell_profile=""
    if [[ -f ~/.zshrc ]]; then
        shell_profile=~/.zshrc
        log_message "Using shell profile: ~/.zshrc"
    elif [[ -f ~/.bashrc ]]; then
        shell_profile=~/.bashrc
        log_message "Using shell profile: ~/.bashrc"
    elif [[ -f ~/.bash_profile ]]; then
        shell_profile=~/.bash_profile
        log_message "Using shell profile: ~/.bash_profile"
    fi
    
    if [[ -n "$shell_profile" ]]; then
        local updated=false
        log_message "Configuring environment variables in: $shell_profile"
        
        # Add Java environment variables
        if ! grep -q "JAVA_HOME" "$shell_profile"; then
            echo "" >> "$shell_profile"
            echo "# Java Configuration" >> "$shell_profile"
            echo 'export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-11.jdk/Contents/Home' >> "$shell_profile"
            echo 'export PATH=$JAVA_HOME/bin:$PATH' >> "$shell_profile"
            updated=true
            log_message "Java environment variables added to $shell_profile"
        else
            log_message "Java environment variables already exist in $shell_profile"
        fi
        
        # Add Android environment variables
        if ! grep -q "ANDROID_HOME" "$shell_profile"; then
            echo "" >> "$shell_profile"
            echo "# Android Configuration" >> "$shell_profile"
            echo 'export ANDROID_HOME=$HOME/Library/Android/sdk' >> "$shell_profile"
            echo 'export PATH=$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools' >> "$shell_profile"
            updated=true
            log_message "Android environment variables added to $shell_profile"
        else
            log_message "Android environment variables already exist in $shell_profile"
        fi
        
        # Add Maestro environment variables
        if ! grep -q "MAESTRO" "$shell_profile"; then
            echo "" >> "$shell_profile"
            echo "# Maestro Configuration" >> "$shell_profile"
            echo 'export PATH="$PATH:$HOME/.maestro/bin"' >> "$shell_profile"
            updated=true
            log_message "Maestro environment variables added to $shell_profile"
        else
            log_message "Maestro environment variables already exist in $shell_profile"
        fi
        
        if [[ "$updated" == "true" ]]; then
            print_success "Environment variables added to $shell_profile"
            print_warning "Please run 'source $shell_profile' to apply changes"
            log_message "Environment variables setup completed - user instructed to source profile"
        else
            print_success "Environment variables already configured"
            log_message "Environment variables already configured - no changes needed"
        fi
    else
        print_warning "No shell profile found for environment variables"
        log_message "Environment variables setup FAILED - no shell profile found"
    fi
}

# Function to create necessary directories
create_directories() {
    print_status "Creating necessary directories..."
    log_message "Starting directory creation"
    
    mkdir -p reports/{android,ios,screenshots,recordings}
    mkdir -p apps
    mkdir -p logs
    mkdir -p debug
    
    print_success "Directories created successfully"
    log_message "Directory creation completed successfully"
}

# Function to generate timestamp for device naming
generate_timestamp() {
    date +%Y%m%d_%H%M%S
}

# Function to create Android test device
create_android_device() {
    local timestamp=$(generate_timestamp)
    local device_name="TestDevice_${timestamp}"
    
    print_status "Creating Android test device: $device_name"
    log_message "Starting Android device creation: $device_name"
    
    # Check if Android SDK tools are available
    if ! command_exists avdmanager; then
        print_error "avdmanager not found. Please ensure Android SDK tools are installed."
        log_message "Android device creation FAILED - avdmanager not found"
        return 1
    fi
    
    # Check available system images
    local system_image="system-images;android-30;google_apis_playstore;x86_64"
    if ! avdmanager list target | grep -q "android-30"; then
        print_warning "Android 30 system image not found, trying Android 29"
        system_image="system-images;android-29;google_apis_playstore;x86_64"
        log_message "Fallback to Android 29 system image"
    fi
    
    # Create AVD with error handling
    if avdmanager create avd -n "$device_name" -k "$system_image" --force >/dev/null 2>&1; then
        print_success "Android device created: $device_name"
        log_message "Android device creation SUCCESS: $device_name"
        
        # Configure device for Google account login
        local avd_config="$HOME/.android/avd/${device_name}.avd/config.ini"
        if [[ -f "$avd_config" ]]; then
            echo "PlayStore.enabled=true" >> "$avd_config"
            echo "hw.keyboard=yes" >> "$avd_config"
            echo "hw.mainKeys=no" >> "$avd_config"
            log_message "Android device configured for Google Play Store access"
        fi
        
        echo "$device_name"
        return 0
    else
        print_error "Failed to create Android device: $device_name"
        log_message "Android device creation FAILED: $device_name"
        return 1
    fi
}

# Function to create iOS test device
create_ios_device() {
    local os=$(get_os)
    
    if [[ "$os" != "macos" ]]; then
        print_warning "iOS device creation skipped - not on macOS"
        log_message "iOS device creation SKIPPED - not on macOS (OS: $os)"
        return 0
    fi
    
    local timestamp=$(generate_timestamp)
    local device_name="TestDevice_${timestamp}"
    
    print_status "Creating iOS test device: $device_name"
    log_message "Starting iOS device creation: $device_name"
    
    # Check if Xcode tools are available
    if ! command_exists xcrun; then
        print_error "xcrun not found. Please ensure Xcode is installed."
        log_message "iOS device creation FAILED - xcrun not found"
        return 1
    fi
    
    # Get available device types and runtimes
    local device_type="com.apple.CoreSimulator.SimDeviceType.iPhone-14"
    local runtime=$(xcrun simctl list runtimes | grep "iOS" | tail -1 | awk '{print $NF}' | tr -d '()')
    
    if [[ -z "$runtime" ]]; then
        print_error "No iOS runtime found"
        log_message "iOS device creation FAILED - no iOS runtime found"
        return 1
    fi
    
    # Create iOS simulator with error handling
    local device_id
    if device_id=$(xcrun simctl create "$device_name" "$device_type" "$runtime" 2>/dev/null); then
        print_success "iOS device created: $device_name (ID: $device_id)"
        log_message "iOS device creation SUCCESS: $device_name (ID: $device_id)"
        echo "$device_id"
        return 0
    else
        print_error "Failed to create iOS device: $device_name"
        log_message "iOS device creation FAILED: $device_name"
        return 1
    fi
}

# Function to boot Android device
boot_android_device() {
    local device_name="$1"
    
    if [[ -z "$device_name" ]]; then
        print_error "No Android device name provided for booting"
        log_message "Android device boot FAILED - no device name provided"
        return 1
    fi
    
    print_status "Booting Android device: $device_name"
    log_message "Starting Android device boot: $device_name"
    
    # Start emulator in background
    if command_exists emulator; then
        emulator -avd "$device_name" -no-audio -no-window &
        local emulator_pid=$!
        log_message "Android emulator started with PID: $emulator_pid"
        
        # Wait for device to be ready
        local timeout=120
        local count=0
        
        print_status "Waiting for Android device to boot (timeout: ${timeout}s)..."
        
        while [[ $count -lt $timeout ]]; do
            if adb devices | grep -q "emulator.*device"; then
                print_success "Android device booted successfully: $device_name"
                log_message "Android device boot SUCCESS: $device_name"
                
                # Wait a bit more for full boot
                sleep 10
                
                # Setup Google account login capability
                adb shell settings put global development_settings_enabled 1 >/dev/null 2>&1
                adb shell settings put global stay_on_while_plugged_in 3 >/dev/null 2>&1
                log_message "Android device configured for testing"
                
                return 0
            fi
            sleep 2
            ((count += 2))
        done
        
        print_error "Android device boot timeout: $device_name"
        log_message "Android device boot FAILED - timeout: $device_name"
        return 1
    else
        print_error "Android emulator command not found"
        log_message "Android device boot FAILED - emulator command not found"
        return 1
    fi
}

# Function to boot iOS device
boot_ios_device() {
    local device_id="$1"
    local os=$(get_os)
    
    if [[ "$os" != "macos" ]]; then
        print_warning "iOS device boot skipped - not on macOS"
        log_message "iOS device boot SKIPPED - not on macOS (OS: $os)"
        return 0
    fi
    
    if [[ -z "$device_id" ]]; then
        print_error "No iOS device ID provided for booting"
        log_message "iOS device boot FAILED - no device ID provided"
        return 1
    fi
    
    print_status "Booting iOS device: $device_id"
    log_message "Starting iOS device boot: $device_id"
    
    # Boot iOS simulator
    if xcrun simctl boot "$device_id" >/dev/null 2>&1; then
        print_success "iOS device booted successfully: $device_id"
        log_message "iOS device boot SUCCESS: $device_id"
        
        # Open Simulator app
        open -a Simulator >/dev/null 2>&1
        
        # Wait for device to be fully ready
        sleep 5
        
        return 0
    else
        print_error "Failed to boot iOS device: $device_id"
        log_message "iOS device boot FAILED: $device_id"
        return 1
    fi
}

# Function to cleanup test devices
cleanup_test_devices() {
    print_status "Cleaning up test devices..."
    log_message "Starting test device cleanup"
    
    local cleanup_errors=0
    
    # Cleanup Android devices
    if command_exists avdmanager; then
        print_status "Cleaning up Android test devices..."
        local android_devices=$(avdmanager list avd | grep "Name: TestDevice_" | awk '{print $2}' 2>/dev/null)
        
        if [[ -n "$android_devices" ]]; then
            while IFS= read -r device; do
                if [[ -n "$device" ]]; then
                    print_status "Deleting Android device: $device"
                    if avdmanager delete avd -n "$device" >/dev/null 2>&1; then
                        print_success "Deleted Android device: $device"
                        log_message "Android device cleanup SUCCESS: $device"
                    else
                        print_error "Failed to delete Android device: $device"
                        log_message "Android device cleanup FAILED: $device"
                        ((cleanup_errors++))
                    fi
                fi
            done <<< "$android_devices"
        else
            print_status "No Android test devices found to cleanup"
            log_message "No Android test devices found for cleanup"
        fi
    else
        log_message "Android device cleanup SKIPPED - avdmanager not found"
    fi
    
    # Cleanup iOS devices
    local os=$(get_os)
    if [[ "$os" == "macos" ]] && command_exists xcrun; then
        print_status "Cleaning up iOS test devices..."
        local ios_devices=$(xcrun simctl list devices | grep "TestDevice_" | awk -F'[()]' '{print $2}' 2>/dev/null)
        
        if [[ -n "$ios_devices" ]]; then
            while IFS= read -r device_id; do
                if [[ -n "$device_id" ]]; then
                    print_status "Deleting iOS device: $device_id"
                    if xcrun simctl delete "$device_id" >/dev/null 2>&1; then
                        print_success "Deleted iOS device: $device_id"
                        log_message "iOS device cleanup SUCCESS: $device_id"
                    else
                        print_error "Failed to delete iOS device: $device_id"
                        log_message "iOS device cleanup FAILED: $device_id"
                        ((cleanup_errors++))
                    fi
                fi
            done <<< "$ios_devices"
        else
            print_status "No iOS test devices found to cleanup"
            log_message "No iOS test devices found for cleanup"
        fi
    else
        log_message "iOS device cleanup SKIPPED - not on macOS or xcrun not found"
    fi
    
    # Kill any running emulators
    if command_exists adb; then
        print_status "Stopping Android emulators..."
        adb devices | grep emulator | awk '{print $1}' | while read emulator; do
            if [[ -n "$emulator" ]]; then
                adb -s "$emulator" emu kill >/dev/null 2>&1
                log_message "Stopped Android emulator: $emulator"
            fi
        done
    fi
    
    if [[ $cleanup_errors -eq 0 ]]; then
        print_success "Device cleanup completed successfully"
        log_message "Device cleanup completed successfully"
        return 0
    else
        print_warning "Device cleanup completed with $cleanup_errors errors"
        log_message "Device cleanup completed with $cleanup_errors errors"
        return 1
    fi
}

# Function to provision test devices
provision_test_devices() {
    print_header "Test Device Provisioning"
    log_message "=== Starting test device provisioning ==="
    
    local android_device=""
    local ios_device=""
    local provisioning_errors=0
    
    # Create and boot Android device
    if command_exists avdmanager && command_exists emulator; then
        if android_device=$(create_android_device); then
            if boot_android_device "$android_device"; then
                print_success "Android test device ready: $android_device"
                log_message "Android device provisioning SUCCESS: $android_device"
            else
                print_error "Failed to boot Android device: $android_device"
                log_message "Android device provisioning FAILED - boot failed: $android_device"
                ((provisioning_errors++))
            fi
        else
            print_error "Failed to create Android device"
            log_message "Android device provisioning FAILED - creation failed"
            ((provisioning_errors++))
        fi
    else
        print_warning "Android device provisioning skipped - tools not available"
        log_message "Android device provisioning SKIPPED - tools not available"
    fi
    
    # Create and boot iOS device
    local os=$(get_os)
    if [[ "$os" == "macos" ]] && command_exists xcrun; then
        if ios_device=$(create_ios_device); then
            if boot_ios_device "$ios_device"; then
                print_success "iOS test device ready: $ios_device"
                log_message "iOS device provisioning SUCCESS: $ios_device"
            else
                print_error "Failed to boot iOS device: $ios_device"
                log_message "iOS device provisioning FAILED - boot failed: $ios_device"
                ((provisioning_errors++))
            fi
        else
            print_error "Failed to create iOS device"
            log_message "iOS device provisioning FAILED - creation failed"
            ((provisioning_errors++))
        fi
    else
        print_warning "iOS device provisioning skipped - not on macOS or tools not available"
        log_message "iOS device provisioning SKIPPED - not on macOS or tools not available"
    fi
    
    echo ""
    if [[ $provisioning_errors -eq 0 ]]; then
        print_success "Test device provisioning completed successfully"
        log_message "Test device provisioning completed successfully"
        
        # Store device info for later use
        echo "ANDROID_TEST_DEVICE=$android_device" > .test_devices
        echo "IOS_TEST_DEVICE=$ios_device" >> .test_devices
        log_message "Test device info saved to .test_devices file"
        
        return 0
    else
        print_warning "Test device provisioning completed with $provisioning_errors errors"
        log_message "Test device provisioning completed with $provisioning_errors errors"
        return 1
    fi
}

# Function to run connectivity test
run_connectivity_test() {
    print_status "Testing device connectivity..."
    log_message "Starting connectivity tests"
    
    # Test ADB
    if command_exists adb; then
        if adb devices >/dev/null 2>&1; then
            print_success "ADB connectivity test passed"
            log_message "ADB connectivity test PASSED"
        else
            print_warning "ADB connectivity test failed"
            log_message "ADB connectivity test FAILED"
        fi
    else
        log_message "ADB connectivity test SKIPPED - ADB not found"
    fi
    
    # Test Maestro
    if command_exists maestro; then
        if maestro --version >/dev/null 2>&1; then
            print_success "Maestro connectivity test passed"
            log_message "Maestro connectivity test PASSED"
        else
            print_warning "Maestro connectivity test failed"
            log_message "Maestro connectivity test FAILED"
        fi
    else
        log_message "Maestro connectivity test SKIPPED - Maestro not found"
    fi
}

# Function to show installation summary
show_installation_summary() {
    print_header "Installation Summary"
    log_message "=== Installation Summary ==="
    
    echo ""
    echo "✅ Prerequisites Check:"
    log_message "Prerequisites Check Results:"
    
    local java_status=$(check_java >/dev/null 2>&1 && echo "✓" || echo "✗")
    local nodejs_status=$(check_nodejs >/dev/null 2>&1 && echo "✓" || echo "✗")
    local maestro_status=$(check_maestro >/dev/null 2>&1 && echo "✓" || echo "✗")
    local android_status=$(check_android_sdk >/dev/null 2>&1 && echo "✓" || echo "✗")
    local xcode_status=$(check_xcode >/dev/null 2>&1 && echo "✓" || echo "✗")
    local framework_status=$(check_framework_files >/dev/null 2>&1 && echo "✓" || echo "✗")
    local app_status=$(check_app_files >/dev/null 2>&1 && echo "✓" || echo "✗")
    
    echo "   • Java: $java_status"
    echo "   • Node.js: $nodejs_status"
    echo "   • Maestro: $maestro_status"
    echo "   • Android SDK: $android_status"
    echo "   • Xcode: $xcode_status"
    echo "   • Framework Files: $framework_status"
    echo "   • App Files: $app_status"
    
    log_message "   Java: $java_status"
    log_message "   Node.js: $nodejs_status"
    log_message "   Maestro: $maestro_status"
    log_message "   Android SDK: $android_status"
    log_message "   Xcode: $xcode_status"
    log_message "   Framework Files: $framework_status"
    log_message "   App Files: $app_status"
    
    echo ""
    log_message "Installation summary displayed to user"
}

# Function to show next steps
show_next_steps() {
    print_header "Next Steps"
    log_message "=== Next Steps ==="
    
    echo ""
    echo "🎉 Framework setup complete!"
    echo ""
    
    # Check if test devices were provisioned
    if [[ -f ".test_devices" ]]; then
        print_success "Test Devices Provisioned:"
        source .test_devices
        if [[ -n "$ANDROID_TEST_DEVICE" ]]; then
            echo "  • Android Device: $ANDROID_TEST_DEVICE"
        fi
        if [[ -n "$IOS_TEST_DEVICE" ]]; then
            echo "  • iOS Device: $IOS_TEST_DEVICE"
        fi
        echo ""
    fi
    
    echo "📋 To run tests:"
    echo "   1. Source your shell profile:"
    echo "      source ~/.zshrc  # or ~/.bashrc"
    echo ""
    echo "   2. Run Android test (auto-manages device & app):"
    echo "      ./utils/run_test.sh -p android"
    echo ""
    echo "   3. Run iOS test (requires manual app installation):"
    echo "      ./utils/run_test.sh -p ios"
    echo ""
    echo "   4. Run with debug output:"
    echo "      ./utils/run_test.sh --debug"
    echo ""
    
    # Device cleanup instructions
    if [[ -f ".test_devices" ]]; then
        echo "🧹 Device Cleanup:"
        echo "   • To clean up test devices after testing: ./setup.sh --cleanup"
        echo "   • This will delete all TestDevice_* devices and stop emulators"
        echo ""
    fi
    
    echo "📚 Documentation:"
    echo "   • Framework guide: cat Readme.md"
    echo "   • App installation: cat apps/README.md"
    echo "   • Test runner help: ./utils/run_test.sh --help"
    echo ""
    echo "🔧 Troubleshooting:"
    echo "   • Check prerequisites: ./setup.sh"
    echo "   • List devices: adb devices (Android) or xcrun simctl list devices (iOS)"
    echo "   • Maestro help: maestro --help"
    if [[ -f ".test_devices" ]]; then
        echo "   • For device issues, try: ./setup.sh --cleanup && ./setup.sh --provision"
    fi
    echo ""
    echo "📄 Setup Log: $LOG_FILE"
    echo ""
    echo "Happy testing! 🚀"
    
    log_message "Next steps instructions provided to user"
    log_message "Setup log file location: $LOG_FILE"
}

# Main function
main() {
    # Parse command line arguments
    local provision_devices=false
    local cleanup_devices=false
    
    while [[ $# -gt 0 ]]; do
        case $1 in
            --provision)
                provision_devices=true
                shift
                ;;
            --cleanup)
                cleanup_devices=true
                shift
                ;;
            --help)
                echo "Usage: $0 [OPTIONS]"
                echo "Options:"
                echo "  --provision    Provision test devices after setup"
                echo "  --cleanup      Clean up test devices and exit"
                echo "  --help         Show this help message"
                exit 0
                ;;
            *)
                echo "Unknown option: $1"
                echo "Use --help for usage information"
                exit 1
                ;;
        esac
    done
    
    # Initialize logging
    log_message "=== Bitfinex Mobile Automation Framework Setup Started ==="
    log_message "Setup script version: $(date)"
    log_message "Working directory: $(pwd)"
    log_message "User: $(whoami)"
    log_message "OS: $(uname -a)"
    log_message "Arguments: provision_devices=$provision_devices, cleanup_devices=$cleanup_devices"
    
    # Handle cleanup mode
    if [[ "$cleanup_devices" == "true" ]]; then
        print_header "Test Device Cleanup"
        cleanup_test_devices
        log_message "=== Cleanup completed ==="
        exit 0
    fi
    
    print_header "Bitfinex Mobile Automation Framework Setup"
    
    # Check OS
    local os=$(get_os)
    print_status "Detected OS: $os"
    log_message "Detected OS: $os"
    echo ""
    
    # Check all prerequisites
    local all_good=true
    local check_results=()
    
    log_message "Starting prerequisite checks..."
    
    check_java
    check_results+=("Java: $?")
    echo ""
    
    check_nodejs
    check_results+=("Node.js: $?")
    echo ""
    
    check_maestro
    check_results+=("Maestro: $?")
    echo ""
    
    check_android_sdk
    check_results+=("Android SDK: $?")
    echo ""
    
    check_xcode
    check_results+=("Xcode: $?")
    echo ""
    
    check_homebrew
    check_results+=("Homebrew: $?")
    echo ""
    
    check_framework_files
    check_results+=("Framework Files: $?")
    echo ""
    
    check_app_files
    check_results+=("App Files: $?")
    echo ""
    
    # Log all check results
    log_message "Prerequisite check results:"
    for result in "${check_results[@]}"; do
        log_message "  $result"
        if [[ "$result" == *": 1" ]]; then
            all_good=false
        fi
    done
    
    # Setup environment
    setup_environment
    echo ""
    
    # Create directories
    create_directories
    echo ""
    
    # Run connectivity test
    run_connectivity_test
    echo ""
    
    # Provision test devices if requested or if critical tools are available
    if [[ "$provision_devices" == "true" ]] || [[ "$all_good" == "true" && ($(command_exists avdmanager && command_exists emulator && echo "true") || $(command_exists xcrun && echo "true")) ]]; then
        provision_test_devices
        echo ""
    fi
    
    # Show installation summary
    show_installation_summary
    
    # Show next steps
    show_next_steps
    
    log_message "=== Setup script completed ==="
    log_message "Overall setup status: $(if [[ "$all_good" == "false" ]]; then echo "FAILED - Some prerequisites missing"; else echo "SUCCESS - All critical components ready"; fi)"
    
    if [[ "$all_good" == "false" ]]; then
        echo ""
        print_warning "Some prerequisites are missing. Please install them before running tests."
        log_message "Setup completed with warnings - some prerequisites missing"
        log_message "User instructed to install missing prerequisites"
        exit 1
    else
        log_message "Setup completed successfully - all critical components ready"
    fi
}

# Run main function
main "$@"
