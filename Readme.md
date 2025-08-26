# 🚀 Bitfinex Mobile Automation Framework

A comprehensive mobile automation framework for testing Bitfinex iOS and Android apps using **Maestro**.

## 📚 **Documentation & Resources**

### **Essential Links**
- **[Maestro Official Docs](https://docs.maestro.dev/)** - Complete Maestro documentation
- **[Maestro Getting Started](https://docs.maestro.dev/getting-started/installation)** - Installation guide
- **[Maestro Commands Reference](https://docs.maestro.dev/reference/commands)** - All available commands
- **[Maestro Best Practices](https://docs.maestro.dev/best-practices)** - Testing best practices
- **[Maestro MCP Integration](https://docs.maestro.dev/getting-started/maestro-mcp)** - AI-assisted testing

### **Framework Overview**
This framework provides **one-command testing** for Bitfinex mobile apps with automatic device management, app installation, and comprehensive test coverage.

## 🏗️ **Framework Structure**

```
bitfixnex/
├── 📁 flows/shared/              # Reusable test components
│   ├── app_setup.yaml           # App launch & mode selection
│   ├── login_flow.yaml          # API key authentication
│   ├── pin_creation.yaml        # Ultra-simple PIN setup
│   ├── pin_enter.yaml           # PIN entry flow
│   ├── login_completion.yaml    # Post-login steps
│   ├── navigation_account.yaml  # Account navigation
│   ├── navigation_earn.yaml     # Earn section navigation
│   ├── navigation_home.yaml     # Home navigation
│   ├── navigation_pay.yaml      # Pay section navigation
│   ├── navigation_test.yaml     # Complete navigation test
│   └── navigation_wallets.yaml  # Wallets navigation
├── 📁 testdata/                  # Platform-specific configurations
│   ├── testdata-staging.js      # Staging environment data
│   └── testdata-prod.js         # Production environment data
├── 📁 tests/                     # Main test suites
│   ├── login_test.yaml          # Complete login test
│   └── navigation_test.yaml     # Navigation validation
├── 📁 utils/                     # Helper scripts
│   ├── check_mcp.sh             # MCP status checker
│   ├── run_mcp_test.sh          # MCP-enhanced testing
│   └── run_test.sh              # Test runner
├── 📁 apps/                      # App files (add your APK/APP here)
├── 📁 reports/                   # Test outputs (auto-generated)
│   ├── android/                 # Android test reports
│   ├── ios/                     # iOS test reports
│   ├── screenshots/             # Failure screenshots
│   └── recordings/              # Test recordings
├── 📁 .trae/                     # Trae IDE integration
│   └── rules/                   # MDC rule files
│       ├── documentation-framework.mdc
│       └── maestro-mcp-setup.mdc
├── config.yaml                   # Framework configuration
├── setup.sh                      # Main setup script
└── .gitignore                    # Version control exclusions
```

## 🚀 **New Team Member Onboarding Guide**

### **🛠️ Prerequisites & Tools**

#### **Required Tools:**
- **Java 11+** - For Android development and Maestro
- **Node.js 16+** - For JavaScript test data and utilities
- **Maestro** - Mobile UI testing framework (auto-installed by setup)
- **Android SDK** - For Android testing (with ADB)
- **Xcode** (macOS only) - For iOS testing
- **Git** - Version control

#### **Optional Tools:**
- **Trae IDE** - Enhanced development experience with MCP integration
- **Android Studio** - For advanced Android debugging
- **Xcode Simulator** - For iOS testing without physical device

### **📱 Step 1: Install Prerequisites**
```bash
# Run the automated setup script
./setup.sh
```

**What the setup script does:**
- ✅ Checks and installs Java, Node.js, Maestro
- ✅ Verifies Android SDK and ADB installation
- ✅ Sets up environment variables
- ✅ Creates necessary directories
- ✅ Provides download links for missing components
- ✅ Validates your development environment

### **📂 Step 2: Add Your App Files**

**Where to place app files:**
```bash
# Android APK files go here:
apps/bitfinex-android.apk

# iOS APP files go here:
apps/bitfinex-ios.app
# or
apps/BitfinexRedesign.app
```

**How to add files:**
```bash
# Copy your APK file
cp /path/to/your/bitfinex.apk apps/bitfinex-android.apk

# Copy your iOS app bundle
cp -r /path/to/your/Bitfinex.app apps/bitfinex-ios.app

# Verify files are in place
ls -la apps/
```

### **🎯 Step 3: Run Your First Test**

#### **Basic Testing:**
```bash
# Run default test (Android, staging environment, smoke tests)
./utils/run_test.sh

# Run on iOS
./utils/run_test.sh -p ios

# Run with debug output for troubleshooting
./utils/run_test.sh --debug
```

#### **Enhanced Testing (Recommended):**
```bash
# Run smoke tests on staging environment
./utils/run_test_enhanced.sh --env staging --scope smoke

# Run full test suite on production environment
./utils/run_test_enhanced.sh --env prod --scope full

# Run with specific platform
./utils/run_test_enhanced.sh --env staging --scope smoke --platform android
```

#### **AI-Assisted Testing:**
```bash
# Run tests with MCP (AI) integration
./utils/run_mcp_test.sh staging smoke
./utils/run_mcp_test.sh prod full

# Check MCP status
./utils/check_mcp.sh
```

## 🎯 **Key Features**

### **✅ One-Command Testing**
- **Automatic Device Management** - Checks for devices, starts emulator if needed
- **Automatic App Installation** - Installs APK file automatically
- **Platform Switching** - Easy switching between iOS and Android
- **Debug Support** - Built-in debugging and troubleshooting

### **✅ Ultra-Simple PIN Creation**
```yaml
# Keep pressing the same number until "Create a 4-digit PIN" appears
- repeat:
    while:
      visible: "Create a 4-digit PIN"
    commands:
      - tapOn: "5"

# Keep pressing the same number until "Confirm 4-digit PIN" appears
- repeat:
    while:
      visible: "Confirm 4-digit PIN"
    commands:
      - tapOn: "5"
```

### **✅ Complete Navigation Testing**
- **Account Section** - Profile, settings, logout
- **Wallets Section** - Balance display, wallet management
- **Pay Section** - Fast Pay, payment options
- **Earn Section** - Rewards, staking options
- **Home Section** - Portfolio overview

## 📋 **Test Runner Commands**

### **Basic Usage**
```bash
# Run with default settings (Android)
./utils/run_test.sh

# Run on specific platform
./utils/run_test.sh -p android
./utils/run_test.sh -p ios

# Run specific test file
./utils/run_test.sh -t tests/login_test.yaml

# Run with debug output
./utils/run_test.sh --debug
```

### **Enhanced Testing (Dynamic Environment & Scope)**

#### **🚀 Enhanced Test Runner (`run_test_enhanced.sh`)**
The enhanced test runner provides dynamic environment and scope support with comprehensive logging and automatic test data management.

**Key Features:**
- ✅ **Dynamic Environment Selection** - Automatically uses correct testdata files
- ✅ **Scope-Based Tag Filtering** - Runs appropriate test sets based on scope
- ✅ **Comprehensive Logging** - Detailed execution logs with timestamps
- ✅ **Automatic File Management** - Updates and restores test files automatically
- ✅ **Parameter Validation** - Validates all input parameters
- ✅ **Backup & Restore** - Safely modifies test files with automatic restoration

**Basic Usage:**
```bash
# Run smoke tests on staging environment
./utils/run_test_enhanced.sh --env staging --scope smoke

# Run full tests on production environment
./utils/run_test_enhanced.sh --env prod --scope full

# Run with specific platform
./utils/run_test_enhanced.sh --env staging --scope smoke --platform android

# Run with debug output
./utils/run_test_enhanced.sh --env staging --scope smoke --debug
```

**Advanced Usage:**
```bash
# Custom tag filtering
./utils/run_test_enhanced.sh --env staging --tags login,navigation

# Exclude specific tags
./utils/run_test_enhanced.sh --env staging --scope full --exclude-tags slow

# Specific device targeting
./utils/run_test_enhanced.sh --env staging --scope smoke --device emulator-5554

# Custom app path
./utils/run_test_enhanced.sh --env staging --scope smoke --app-path apps/custom-app.apk
```

**All Available Options:**
```bash
./utils/run_test_enhanced.sh [OPTIONS]

Options:
  -t, --test-file FILE     Test file to run (default: tests)
  -p, --platform PLATFORM  Platform: ios or android (default: android)
  -m, --mode MODE          App mode: lite or full (default: lite)
  -i, --pin-iterations N   Number of PIN iterations (default: 9)
  -d, --device DEVICE      Device ID to run on
  -e, --env ENV            Environment: staging, prod (default: staging)
  -s, --scope SCOPE        Test scope: smoke, full (default: smoke)
  -a, --app-path PATH      Path to app file
  --tags TAGS              Comma-separated tags to include
  --exclude-tags TAGS      Comma-separated tags to exclude
  --debug                  Enable debug output
  --help                   Show help message
```

#### **🎯 Demo Script (`demo_enhanced_testing.sh`)**
Interactive demonstration script that showcases all enhanced testing capabilities with step-by-step examples.

```bash
# Run the interactive demo
./demo_enhanced_testing.sh
```

**Demo Features:**
- 🎮 **Interactive Walkthrough** - Step-by-step demonstration with user prompts
- 🌍 **Environment Overview** - Shows staging vs production configurations
- 🎯 **Scope Explanation** - Demonstrates smoke vs full test scopes
- 📋 **Live Examples** - Real command examples you can copy and use
- 🚀 **Feature Showcase** - Demonstrates all enhanced runner capabilities

**What the demo covers:**
1. **Environment Configurations:**
   - `staging` - Uses `testdata-staging.js` for test data
   - `prod` - Uses `testdata-prod.js` for production-like data

2. **Test Scope Options:**
   - `smoke` - Quick validation tests (tags: smoke)
   - `full` - Complete test suite (tags: smoke, regression, end-to-end)

3. **Advanced Features:**
   - Custom tag filtering (`--tags login,navigation`)
   - Tag exclusion (`--exclude-tags slow`)
   - MCP integration examples
   - Debug mode demonstrations

4. **Practical Examples:**
   ```bash
   # Examples shown in demo
   ./utils/run_test_enhanced.sh -e staging -s smoke
   ./utils/run_test_enhanced.sh -e prod -s full
   ./utils/run_test_enhanced.sh -e staging --tags login,pin
   ./utils/run_mcp_test.sh staging smoke
   ```

**Demo Output:**
- 📊 **Configuration Tables** - Clear overview of available options
- 💡 **Usage Tips** - Best practices and recommendations
- 🔗 **Command Examples** - Ready-to-use commands for different scenarios
- ✅ **Success Indicators** - Shows what each command accomplishes

#### **🤖 AI-Assisted Testing**
```bash
# Run with MCP integration
./utils/run_mcp_test.sh staging smoke
./utils/run_mcp_test.sh prod full

# Check MCP status
./utils/check_mcp.sh
```

### **Advanced Options**
```bash
# Full command reference
./utils/run_test.sh --help

# Examples
./utils/run_test.sh -p android -m full -i 5          # Android, Full mode, 5 PIN iterations
./utils/run_test.sh -p ios -d "iPhone 15 Pro"        # iOS on specific device
./utils/run_test.sh --tags smoke,login               # Run specific test tags
./utils/run_test.sh -a /path/to/custom/app.apk       # Use custom app file
```

### **Framework Shortcuts** (after running setup-mcp.sh)
```bash
run-test          # Run default test
run-android       # Run Android test
run-ios           # Run iOS test
run-debug         # Run with debug output
check-setup       # Check prerequisites
```

## 🔧 **Configuration**

### **Environment-Specific Test Data**
The framework uses separate configuration files for different environments:

- **`testdata/testdata-staging.js`** - Staging environment (Android-specific)
- **`testdata/testdata-prod.js`** - Production environment (iOS-specific)

### **Dynamic Environment Selection**
The enhanced test runner automatically selects the appropriate test data file based on the environment parameter:

```bash
# Uses testdata-staging.js
./utils/run_test_enhanced.sh --env staging

# Uses testdata-prod.js
./utils/run_test_enhanced.sh --env prod
```

### **App Configuration**
```javascript
// Example from testdata-staging.js
output.app = {
  appId: "com.bitfinex.mobileapp.dev",
  mode: "lite",
  pin: {
    createPinText: "Create a 4-digit PIN",
    defaultPin: "5"
  }
}
```

### **Framework Configuration**
```yaml
# config.yaml
framework:
  defaultPlatform: "android"
  defaultMode: "lite"
  defaultPinIterations: 9
  defaultTestFile: "tests/login_test.yaml"
  defaultEnvironment: "staging"
  defaultTestScope: "smoke"

testScopes:
  smoke:
    description: "Quick smoke tests for basic functionality"
    tags: ["smoke", "login", "critical"]
    timeout: 300
  full:
    description: "Comprehensive test suite with all features"
    tags: ["smoke", "login", "navigation", "end-to-end", "regression"]
    timeout: 1800

environments:
  staging:
    testDataPath: "testdata/testdata-staging.js"
    description: "Staging environment for development testing"
    timeout: 30000
  prod:
    testDataPath: "testdata/testdata-prod.js"
    description: "Production environment for release testing"
    timeout: 45000

apps:
  android:
    appId: "com.bitfinex.mobileapp.dev"
    apkPath: "apps/bitfinex-android.apk"
  ios:
    appId: "com.bitfinex.mobileapp.dev"
    appPath: "apps/bitfinex-ios.app"
```

## 🧪 **Test Flows**

### **Complete Test Workflow**
1. **App Setup** - Launch app and select mode
2. **Login** - API key authentication
3. **PIN Creation** - Ultra-simple PIN setup
4. **Login Completion** - Handle popups and verify login
5. **Navigation Testing** - Test all app sections

### **Individual Flow Components**
```yaml
# Use individual flows for specific testing
- runFlow: '../flows/shared/app_setup.yaml'      # App launch
- runFlow: '../flows/shared/login_flow.yaml'     # Authentication
- runFlow: '../flows/shared/pin_creation.yaml'   # PIN setup
- runFlow: '../flows/shared/navigation_test.yaml' # Navigation testing
```

## 🤖 **AI-Assisted Testing (MCP Integration)**

### **Setup MCP Integration**
```bash
# Setup AI-assisted testing in Trae
./setup.sh
```

### **MCP Commands**
```bash
# Check MCP status
./utils/check_mcp.sh

# Run tests with MCP integration
./utils/run_mcp_test.sh
```

### **AI Interactions in Trae**
- **"Create a test flow for Bitfinex login"**
- **"Debug my failing tapOn command"**
- **"Optimize my test for better performance"**
- **"Show me the current framework structure"**
- **"Help me fix the PIN creation flow"**

## 📊 **Reports & Debugging**

### **Test Outputs**
- **Screenshots** - `reports/screenshots/` - Failure screenshots
- **Recordings** - `reports/recordings/` - Test execution videos
- **Log Files** - `reports/` - Comprehensive execution logs with timestamps

### **Logging System**
The framework includes comprehensive logging for both setup and test execution:

#### **Setup Logs**
- **File Pattern**: `reports/setup_YYYYMMDD_HHMMSS.log`
- **Content**: Detailed setup process, prerequisite checks, installation status
- **Example**: `reports/setup_20250817_114202.log`

#### **Test Run Logs**
- **File Pattern**: `reports/test_run_YYYYMMDD_HHMMSS.log`
- **Content**: Test execution details, device management, command execution
- **Example**: `reports/test_run_20250817_114500.log`

#### **Log Features**
- ✅ **Timestamps** - Every log entry includes date and time
- ✅ **Log Levels** - INFO, WARNING, ERROR, SUCCESS, HEADER
- ✅ **Detailed Context** - What happened, where it failed, why it failed
- ✅ **Command Tracking** - All executed commands and their results
- ✅ **Device Management** - Android device detection, startup, app installation
- ✅ **Parameter Validation** - All input parameters and validation results
- ✅ **Exit Codes** - Test execution results and failure reasons

### **Troubleshooting**
```bash
# Check prerequisites
./setup.sh

# Check MCP integration
./utils/check_mcp.sh

# List devices
adb devices                    # Android
xcrun simctl list devices     # iOS

# Check Maestro
maestro --version
maestro --help

# View recent logs
ls -la reports/               # List all log files
tail -f reports/setup_*.log   # Monitor setup logs
tail -f reports/test_run_*.log # Monitor test run logs
```

## 🛠️ **Development Guide for New Team Members**

### **📝 Creating New Tests**

#### **Step 1: Create Test File**
```bash
# Create new test file in tests/ directory
touch tests/my_feature_test.yaml
```

#### **Step 2: Test File Template**
```yaml
# tests/my_feature_test.yaml
# Description of what this test does
# Supports dynamic testdata selection based on environment (staging/prod)

appId: com.bitfinex.bfxdev
name: "My Feature Test"
description: "Test description explaining what this validates"
tags: ["smoke", "feature-name", "regression"]  # Choose appropriate tags
env: ["staging", "prod"]                        # Supported environments
scope: ["smoke", "full"]                        # Test scopes
---
# Import test data (automatically updated by enhanced runner)
- runScript: '../../testdata/testdata-staging.js'

# Use shared flows for common actions
- runFlow: '../flows/shared/app_setup.yaml'
- runFlow: '../flows/shared/login_flow.yaml'

# Your specific test steps
- tapOn: "Feature Button"
- inputText: "test input"
- assertVisible: "Expected Result"
- assertNotVisible: "Error Message"
```

#### **Step 3: Available Tags**
Choose appropriate tags for your test:
- **`smoke`** - Critical functionality, runs in smoke tests
- **`login`** - Authentication related tests
- **`navigation`** - UI navigation tests
- **`regression`** - Regression testing
- **`end-to-end`** - Complete user workflows
- **`critical`** - Must-pass tests
- **`ui`** - User interface specific tests

### **🔧 Adding New Test Flows**

#### **Step 1: Create Shared Flow**
```bash
# Create reusable flow in flows/shared/
touch flows/shared/my_feature_flow.yaml
```

#### **Step 2: Flow Template**
```yaml
# flows/shared/my_feature_flow.yaml
appId: com.bitfinex.bfxdev
---
# Reusable flow for feature testing
- tapOn: "Feature Menu"
- waitForAnimationToEnd
- assertVisible: "Feature Screen"
- tapOn: "Feature Action"
```

#### **Step 3: Use in Tests**
```yaml
# Reference in your test files
- runFlow: '../flows/shared/my_feature_flow.yaml'
```

### **📊 Updating Test Data**

#### **Environment Files:**
- **`testdata/testdata-staging.js`** - Staging environment data (Android-focused)
- **`testdata/testdata-prod.js`** - Production environment data (iOS-focused)

#### **How to Update:**
```javascript
// Example: Adding new test data
output.newFeature = {
  buttonText: "New Feature",
  expectedResult: "Feature Activated",
  testCredentials: {
    username: "test@example.com",
    password: "testpass123"
  }
}
```

#### **Test Your Changes:**
```bash
# Test with staging data
./utils/run_test_enhanced.sh --env staging --scope smoke --debug

# Test with production data
./utils/run_test_enhanced.sh --env prod --scope smoke --debug
```

## 🚀 **Enhanced Testing Features**

### **Dynamic Environment & Scope Selection**
The framework now supports dynamic selection of test environments and scopes:

#### **Environment Options**
- **`staging`** - Uses `testdata-staging.js` (Android-focused)
- **`prod`** - Uses `testdata-prod.js` (iOS-focused)

#### **Test Scope Options**
- **`smoke`** - Quick tests for basic functionality (tags: smoke, login, critical)
- **`full`** - Comprehensive test suite (tags: smoke, login, navigation, end-to-end, regression)

### **Enhanced Test Runner Usage**
```bash
# Basic enhanced testing
./utils/run_test_enhanced.sh --env staging --scope smoke
./utils/run_test_enhanced.sh --env prod --scope full

# With additional parameters
./utils/run_test_enhanced.sh --env staging --scope smoke --platform android --debug
./utils/run_test_enhanced.sh --env prod --scope full --platform ios

# MCP integration with enhanced parameters
./utils/run_mcp_test.sh staging smoke
./utils/run_mcp_test.sh prod full

# Demo script showcasing all features
./demo_enhanced_testing.sh
```

### **Automatic Test Data Selection**
The enhanced runner automatically:
- ✅ Selects appropriate test data file based on environment
- ✅ Applies scope-specific tag filtering
- ✅ Sets environment-specific timeouts
- ✅ Updates test files with correct data paths
- ✅ Provides comprehensive logging

### **Enhanced Script Features**
- **Parameter Validation** - Validates environment and scope parameters
- **Dynamic File Updates** - Updates test files with correct testdata paths
- **Tag-based Filtering** - Runs tests based on scope-defined tags
- **Comprehensive Logging** - Detailed execution logs with timestamps
- **Backward Compatibility** - Works alongside existing test runner

## 🎯 **Best Practices for New Team Members**

### **✅ Do's**
- **Use Enhanced Test Runner** - Always prefer `run_test_enhanced.sh` for new tests
- **Tag Appropriately** - Use correct tags (`smoke`, `regression`, etc.) for proper filtering
- **Environment Testing** - Test on both staging and production environments
- **Modular Flows** - Create reusable flows in `flows/shared/` directory
- **Dynamic Waiting** - Use `while` loops instead of fixed timeouts
- **Debug Mode** - Use `--debug` flag when troubleshooting
- **Version Control** - Commit test files with descriptive messages
- **Documentation** - Add clear descriptions to your test files

### **❌ Don'ts**
- **No Hardcoding** - Don't hardcode device-specific values or timeouts
- **No Monolithic Tests** - Don't create single large test files
- **No Platform Assumptions** - Don't ignore iOS/Android differences
- **No Direct Testdata Edits** - Don't manually change testdata imports in test files
- **No Skipping Validation** - Don't skip running tests after changes

## 🚨 **Troubleshooting Guide**

### **Common Issues & Solutions**

#### **🔧 Setup Issues**
```bash
# Problem: Maestro not found
# Solution: Run setup script
./setup.sh

# Problem: ADB not found
# Solution: Install Android SDK or add to PATH
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Problem: Java version issues
# Solution: Install Java 11+
brew install openjdk@11
```

#### **📱 Device Issues**
```bash
# Problem: No Android devices found
# Solution: Start emulator or connect device
adb devices

# Problem: App installation fails
# Solution: Check APK file exists and is valid
ls -la apps/
file apps/bitfinex-android.apk
```

#### **🧪 Test Execution Issues**
```bash
# Problem: Test fails to find elements
# Solution: Run with debug mode
./utils/run_test_enhanced.sh --env staging --scope smoke --debug

# Problem: Wrong testdata being used
# Solution: Check environment parameter
./utils/run_test_enhanced.sh --env prod --scope smoke  # Uses testdata-prod.js
./utils/run_test_enhanced.sh --env staging --scope smoke  # Uses testdata-staging.js
```

#### **📊 Test Development Issues**
```bash
# Problem: Test not running in scope
# Solution: Check tags in test file match scope configuration
# Smoke scope runs: ["smoke", "login", "critical"]
# Full scope runs: ["smoke", "login", "navigation", "end-to-end", "regression", "critical", "ui"]

# Problem: Flow not found
# Solution: Check file path and ensure flow exists
ls -la flows/shared/
```

### **🔍 Debug Commands**
```bash
# Check framework status
./setup.sh

# Check MCP integration
./utils/check_mcp.sh

# List available devices
adb devices                    # Android
xcrun simctl list devices     # iOS

# Check Maestro installation
maestro --version
maestro --help

# View recent logs
ls -la reports/
tail -f reports/test_run_*.log
```

### **📞 Getting Help**
- **Check Logs** - Always check `reports/` directory for detailed logs
- **Use Debug Mode** - Add `--debug` flag to any test command
- **Maestro Docs** - Refer to [official Maestro documentation](https://docs.maestro.dev/)
- **Framework Demo** - Run `./demo_enhanced_testing.sh` to see examples

## 🔗 **Useful Links**

### **Maestro Documentation**
- **[Installation Guide](https://docs.maestro.dev/getting-started/installation)**
- **[Command Reference](https://docs.maestro.dev/reference/commands)**
- **[Best Practices](https://docs.maestro.dev/best-practices)**
- **[Troubleshooting](https://docs.maestro.dev/troubleshooting)**
- **[MCP Integration](https://docs.maestro.dev/getting-started/maestro-mcp)**

### **Framework Resources**
- **[App Installation Guide](apps/README.md)**
- **[Basic Test Runner Help](./utils/run_test.sh --help)**
- **[Enhanced Test Runner Help](./utils/run_test_enhanced.sh --help)**
- **[Interactive Demo](./demo_enhanced_testing.sh)**
- **[MCP Status Check](./utils/check_mcp.sh)**

## 📋 **Quick Reference for New Team Members**

### **🚀 Essential Commands**
```bash
# Setup and validation
./setup.sh                                    # Install prerequisites and validate setup
./utils/check_mcp.sh                         # Check AI integration status

# Basic testing (legacy)
./utils/run_test.sh                          # Run default test
./utils/run_test.sh --debug                  # Run with debug output

# Enhanced testing (recommended) - run_test_enhanced.sh
./utils/run_test_enhanced.sh --env staging --scope smoke    # Quick smoke tests
./utils/run_test_enhanced.sh --env prod --scope full        # Full test suite
./utils/run_test_enhanced.sh --env staging --scope smoke --platform android --debug
./utils/run_test_enhanced.sh --tags login,navigation        # Custom tag filtering
./utils/run_test_enhanced.sh --help                         # See all options

# AI-assisted testing
./utils/run_mcp_test.sh staging smoke        # AI-enhanced smoke tests
./utils/run_mcp_test.sh prod full            # AI-enhanced full tests

# Demo and examples
./demo_enhanced_testing.sh                   # Interactive demo of all features
```

### **📁 File Locations**
```bash
# App files
apps/bitfinex-android.apk                    # Android APK file
apps/bitfinex-ios.app                        # iOS app bundle

# Test files
tests/login_test.yaml                        # Login and navigation test
tests/navigation_test.yaml                   # Navigation-only test
tests/my_new_test.yaml                       # Your new test files

# Test data
testdata/testdata-staging.js                 # Staging environment data
testdata/testdata-prod.js                    # Production environment data

# Shared flows
flows/shared/app_setup.yaml                  # App launch flow
flows/shared/login_flow.yaml                 # Login flow
flows/shared/navigation_test.yaml            # Navigation testing

# Reports and logs
reports/test_run_*.log                       # Test execution logs
reports/screenshots/                         # Failure screenshots
reports/recordings/                          # Test recordings
```

### **🎯 New Team Member Checklist**
- [ ] Run `./setup.sh` and ensure all prerequisites are installed
- [ ] Add your APK/APP files to the `apps/` directory
- [ ] Run your first test: `./utils/run_test_enhanced.sh --env staging --scope smoke`
- [ ] Create a simple test following the template in the Development Guide
- [ ] Test on both environments: staging and production
- [ ] Try AI-assisted testing: `./utils/run_mcp_test.sh staging smoke`
- [ ] Review the troubleshooting guide for common issues
- [ ] Explore the enhanced testing demo: `./demo_enhanced_testing.sh`
- [ ] Try enhanced test runner: `./utils/run_test_enhanced.sh --env staging --scope smoke`
- [ ] Learn about all enhanced options: `./utils/run_test_enhanced.sh --help`

## 🚀 **Ready to Start**

Your Bitfinex automation framework is ready for new team members! 

**First Steps:**
```bash
./setup.sh                                   # Validate your environment
./demo_enhanced_testing.sh                   # See interactive demo of all features
./utils/run_test_enhanced.sh --env staging --scope smoke --debug  # Run first enhanced test
./utils/run_test_enhanced.sh --help          # Learn all available options
```

**Need Help?**
- **Setup Issues**: Run `./setup.sh` and follow the instructions
- **Test Issues**: Use `--debug` flag and check `reports/` directory
- **Framework Questions**: Read the troubleshooting guide above
- **Maestro Help**: Visit [Maestro Documentation](https://docs.maestro.dev/)
- **AI Integration**: Run `./utils/check_mcp.sh` for MCP status

**Welcome to the team! Happy testing! 🎯**



