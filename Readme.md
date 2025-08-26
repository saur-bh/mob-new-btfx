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
├── 📁 testdata/                  # Environment-specific configurations
│   ├── testdata-staging.js      # Staging environment data
│   └── testdata-prod.js         # Production environment data
├── 📁 tests/                     # Main test suites
│   ├── login_test.yaml          # Complete login test
│   └── navigation_test.yaml     # Navigation validation
├── 📁 utils/                     # Testing & utility scripts
│   ├── check_mcp.sh             # MCP status checker
│   ├── run_mcp_test.sh          # MCP-enhanced testing
│   ├── run_test.sh              # Legacy test runner
│   └── run_test_enhanced.sh     # Enhanced test runner (recommended)
├── 📁 apps/                      # App files (add your APK/APP here)
│   └── README.md                # App installation guide
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
├── demo_enhanced_testing.sh      # Interactive demo script
├── Readme.md                     # This documentation
└── .gitignore                    # Version control exclusions
```

## 🛠️ **Script Execution Examples**

### **📋 setup.sh - Main Setup Script**
**Purpose:** Install prerequisites, validate environment, and prepare the framework for testing.

```bash
# Basic setup
./setup.sh

# What it does:
# ✅ Checks Java, Node.js, Maestro installation
# ✅ Verifies Android SDK and ADB
# ✅ Creates necessary directories (reports/, apps/)
# ✅ Sets up environment variables
# ✅ Provides installation guidance for missing tools
# ✅ Validates your complete development environment

# Expected output:
# [INFO] Checking prerequisites...
# [SUCCESS] Java 11+ found
# [SUCCESS] Node.js 16+ found
# [INFO] Installing Maestro...
# [SUCCESS] Maestro installed successfully
# [SUCCESS] Setup completed! Framework ready for testing.
```

### **🧪 run_test.sh - Legacy Test Runner**
**Purpose:** Basic test execution with platform and debug support (maintained for backward compatibility).

```bash
# Basic usage
./utils/run_test.sh

# Platform-specific testing
./utils/run_test.sh -p android
./utils/run_test.sh -p ios

# Custom test file
./utils/run_test.sh -t tests/login_test.yaml

# Debug mode
./utils/run_test.sh --debug

# Full parameter example
./utils/run_test.sh -p android -t tests/navigation_test.yaml --debug

# Expected output:
# [INFO] Starting test execution...
# [INFO] Platform: android
# [INFO] Test file: tests/login_test.yaml
# [INFO] Installing app on device...
# [SUCCESS] Test completed successfully
```

### **🚀 run_test_enhanced.sh - Enhanced Test Runner (Recommended)**
**Purpose:** Advanced test execution with dynamic environment, scope filtering, and comprehensive logging.

```bash
# Basic enhanced testing
./utils/run_test_enhanced.sh --env staging --scope smoke

# Full test suite
./utils/run_test_enhanced.sh --env prod --scope full

# Platform-specific enhanced testing
./utils/run_test_enhanced.sh --env staging --scope smoke --platform android
./utils/run_test_enhanced.sh --env prod --scope full --platform ios

# Custom tag filtering
./utils/run_test_enhanced.sh --env staging --tags login,navigation
./utils/run_test_enhanced.sh --env prod --tags smoke,critical

# Debug mode with enhanced logging
./utils/run_test_enhanced.sh --env staging --scope smoke --debug

# Custom device targeting
./utils/run_test_enhanced.sh --env staging --scope smoke --device emulator-5554

# Help and options
./utils/run_test_enhanced.sh --help

# Expected output:
# [INFO] Enhanced Test Runner v2.0
# [INFO] Environment: staging (testdata-staging.js)
# [INFO] Scope: smoke (tags: smoke,login,critical)
# [INFO] Platform: android
# [INFO] Updating test files with staging environment data...
# [SUCCESS] Test execution completed
# [INFO] Test files restored to original state
```

### **🎯 demo_enhanced_testing.sh - Interactive Demo Script**
**Purpose:** Interactive walkthrough of all enhanced testing features with real examples.

```bash
# Run interactive demo
./demo_enhanced_testing.sh

# What it demonstrates:
# 🎯 Environment configurations (staging vs prod)
# 🎯 Test scope options (smoke vs full)
# 🎯 Platform switching (Android vs iOS)
# 🎯 Advanced features (custom tags, debug mode)
# 🎯 Practical examples you can copy and run

# Expected output:
# ========================================
# 🚀 Enhanced Testing Framework Demo
# ========================================
# 
# This demo will show you:
# 1. Environment configurations
# 2. Test scope options
# 3. Advanced features
# 4. Practical examples
# 
# Press Enter to continue...
```

### **🤖 run_mcp_test.sh - AI-Enhanced Testing**
**Purpose:** Run tests with MCP (AI) integration for intelligent test execution and debugging.

```bash
# Basic MCP testing
./utils/run_mcp_test.sh staging smoke
./utils/run_mcp_test.sh prod full

# Platform-specific MCP testing
./utils/run_mcp_test.sh staging smoke android
./utils/run_mcp_test.sh prod full ios

# Expected output:
# [INFO] Starting MCP-enhanced test execution
# [INFO] Environment: staging, Scope: smoke, Platform: android
# [MCP] AI analyzing test execution...
# [MCP] Optimizing test flow based on previous runs
# [SUCCESS] MCP-enhanced test completed
```

### **🔍 check_mcp.sh - MCP Status Checker**
**Purpose:** Verify MCP (AI) integration status and troubleshoot connection issues.

```bash
# Check MCP status
./utils/check_mcp.sh

# Expected output (when working):
# [INFO] Checking MCP integration status...
# [SUCCESS] MCP server is running
# [SUCCESS] Trae IDE connection established
# [SUCCESS] AI-assisted testing is available
# 
# MCP Status: ✅ READY
# Server: Running on port 3000
# Connection: Active
# Features: AI test generation, debugging, optimization

# Expected output (when not working):
# [WARNING] MCP server not found
# [INFO] To enable AI-assisted testing:
# [INFO] 1. Install Trae IDE
# [INFO] 2. Run ./setup.sh
# [INFO] 3. Follow MCP setup instructions
```

### **📊 Common Usage Patterns**

```bash
# 🚀 Quick Start Workflow
./setup.sh                                    # 1. Setup environment
./demo_enhanced_testing.sh                   # 2. See what's possible
./utils/run_test_enhanced.sh --env staging --scope smoke  # 3. Run first test

# 🧪 Development Workflow
./utils/run_test_enhanced.sh --env staging --scope smoke --debug  # Test changes
./utils/run_test_enhanced.sh --env prod --scope smoke             # Validate on prod
./utils/run_test_enhanced.sh --env prod --scope full              # Full regression

# 🤖 AI-Assisted Workflow
./utils/check_mcp.sh                         # Check AI availability
./utils/run_mcp_test.sh staging smoke        # AI-enhanced testing
./utils/run_mcp_test.sh prod full            # AI-enhanced regression

# 🔧 Troubleshooting Workflow
./setup.sh                                    # Verify environment
./utils/run_test.sh --debug                  # Basic debug
./utils/run_test_enhanced.sh --env staging --scope smoke --debug  # Enhanced debug
./utils/check_mcp.sh                         # Check AI integration
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

#### **📋 Setup & Validation**
```bash
# Initial framework setup (run this first!)
./setup.sh
# ✅ Installs Maestro, validates Java/Node.js, creates directories
# ✅ Expected: "Setup completed! Framework ready for testing."

# Check AI integration status
./utils/check_mcp.sh
# ✅ Verifies MCP server connection and AI-assisted testing availability
# ✅ Expected: "MCP Status: ✅ READY" or setup instructions
```

#### **🎯 Quick Start (Recommended Path)**
```bash
# 1. See what's possible (interactive demo)
./demo_enhanced_testing.sh
# 🎮 Interactive walkthrough of all features with live examples

# 2. Run your first test (staging environment, smoke tests)
./utils/run_test_enhanced.sh --env staging --scope smoke
# 🚀 Uses testdata-staging.js, runs smoke tests only
# ✅ Expected: Test execution with environment-specific data

# 3. Get help and see all options
./utils/run_test_enhanced.sh --help
# 📖 Complete reference of all available parameters
```

#### **🧪 Enhanced Testing (Primary Method)**
```bash
# Basic enhanced testing
./utils/run_test_enhanced.sh --env staging --scope smoke    # Quick validation
./utils/run_test_enhanced.sh --env prod --scope full        # Complete test suite

# Platform-specific testing
./utils/run_test_enhanced.sh --env staging --scope smoke --platform android
./utils/run_test_enhanced.sh --env prod --scope smoke --platform ios

# Advanced filtering and debugging
./utils/run_test_enhanced.sh --env staging --tags login,navigation  # Custom tags
./utils/run_test_enhanced.sh --env staging --scope smoke --debug     # Debug mode
./utils/run_test_enhanced.sh --env staging --exclude-tags slow       # Exclude tags

# Device-specific testing
./utils/run_test_enhanced.sh --env staging --scope smoke --device emulator-5554
```

#### **🤖 AI-Assisted Testing**
```bash
# AI-enhanced test execution
./utils/run_mcp_test.sh staging smoke        # AI-enhanced smoke tests
./utils/run_mcp_test.sh prod full            # AI-enhanced full regression

# Check AI integration
./utils/check_mcp.sh                         # Verify MCP connection status
```

#### **🔧 Legacy Testing (Backward Compatibility)**
```bash
# Basic legacy runner
./utils/run_test.sh                          # Default Android test
./utils/run_test.sh --debug                  # With debug output
./utils/run_test.sh -p ios                   # iOS platform
./utils/run_test.sh -t tests/login_test.yaml # Specific test file
```

#### **📊 Common Workflows**
```bash
# 🚀 New Developer Workflow
./setup.sh → ./demo_enhanced_testing.sh → ./utils/run_test_enhanced.sh --env staging --scope smoke

# 🧪 Development Testing Workflow
./utils/run_test_enhanced.sh --env staging --scope smoke --debug  # Test changes
./utils/run_test_enhanced.sh --env prod --scope smoke             # Validate

# 🔄 CI/CD Workflow
./utils/run_test_enhanced.sh --env staging --scope smoke          # Pre-merge
./utils/run_test_enhanced.sh --env prod --scope full              # Post-merge

# 🤖 AI-Assisted Workflow
./utils/check_mcp.sh → ./utils/run_mcp_test.sh staging smoke → ./utils/run_mcp_test.sh prod full
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

### **📋 New Team Member Checklist**

#### **✅ Setup Phase (5-10 minutes)**
- [ ] Clone repository and navigate to project directory
- [ ] Run `./setup.sh` to install prerequisites and validate environment
  ```bash
  ./setup.sh
  # Expected: "Setup completed! Framework ready for testing."
  ```
- [ ] Verify setup by checking `reports/setup_*.log` for any issues
- [ ] Add your APK/APP file to `apps/` directory (see `apps/README.md`)
- [ ] Run `./utils/check_mcp.sh` to verify AI integration status
  ```bash
  ./utils/check_mcp.sh
  # Expected: "MCP Status: ✅ READY" or setup instructions
  ```

#### **✅ Learning Phase (10-15 minutes)**
- [ ] Read this README.md completely (especially Key Features and Essential Commands)
- [ ] **Start with the interactive demo** to see all capabilities:
  ```bash
  ./demo_enhanced_testing.sh
  # 🎮 Interactive walkthrough with live examples
  ```
- [ ] **Try your first enhanced test** (recommended starting point):
  ```bash
  ./utils/run_test_enhanced.sh --env staging --scope smoke
  # 🚀 Quick smoke tests with staging environment
  ```
- [ ] **Learn about all enhanced options**:
  ```bash
  ./utils/run_test_enhanced.sh --help
  # 📖 Complete parameter reference
  ```
- [ ] Examine test files in `tests/` directory
- [ ] Review shared flows in `flows/shared/` directory
- [ ] Check testdata files: `testdata/testdata-staging.js` and `testdata/testdata-prod.js`

#### **✅ Practice Phase (15-20 minutes)**
- [ ] **Run basic legacy test** (for comparison):
  ```bash
  ./utils/run_test.sh --debug
  # 🔧 Legacy runner with debug output
  ```
- [ ] **Run enhanced smoke tests** with debug:
  ```bash
  ./utils/run_test_enhanced.sh --env staging --scope smoke --debug
  # 🧪 Enhanced runner with comprehensive logging
  ```
- [ ] **Run full test suite** on production environment:
  ```bash
  ./utils/run_test_enhanced.sh --env prod --scope full
  # 🚀 Complete regression testing
  ```
- [ ] **Try AI-assisted testing** (if MCP available):
  ```bash
  ./utils/run_mcp_test.sh staging smoke
  # 🤖 AI-enhanced test execution
  ```
- [ ] Create a simple test file following the template in Development Guide
- [ ] Run your test and check the generated reports in `reports/` directory

#### **✅ Mastery Phase (10-15 minutes)**
- [ ] **Understand environment differences**:
  ```bash
  # Staging environment (testdata-staging.js)
  ./utils/run_test_enhanced.sh --env staging --scope smoke
  
  # Production environment (testdata-prod.js)
  ./utils/run_test_enhanced.sh --env prod --scope smoke
  ```
- [ ] **Practice advanced tag filtering**:
  ```bash
  # Include specific tags
  ./utils/run_test_enhanced.sh --env staging --tags login,navigation
  
  # Exclude slow tests
  ./utils/run_test_enhanced.sh --env staging --scope full --exclude-tags slow
  ```
- [ ] **Learn platform-specific testing**:
  ```bash
  # Android testing
  ./utils/run_test_enhanced.sh --env staging --scope smoke --platform android
  
  # iOS testing
  ./utils/run_test_enhanced.sh --env staging --scope smoke --platform ios
  ```
- [ ] **Master debugging techniques** using `--debug` flag and log files
- [ ] **Explore MCP integration** features (if available)
- [ ] Review troubleshooting guide and common issues
- [ ] **Set up your development workflow**:
  ```bash
  # Recommended development cycle
  ./utils/run_test_enhanced.sh --env staging --scope smoke --debug  # Test changes
  ./utils/run_test_enhanced.sh --env prod --scope smoke             # Validate
  ./utils/run_test_enhanced.sh --env prod --scope full              # Full regression
  ```

**🎯 Total Time: ~45-60 minutes to become productive**
**🚀 Quick Start: `./setup.sh` → `./demo_enhanced_testing.sh` → `./utils/run_test_enhanced.sh --env staging --scope smoke`**

## 🚀 **Ready to Start**

### **🎯 3-Step Quick Start (5 minutes)**
```bash
# Step 1: Setup your environment
./setup.sh
# ✅ Expected: "Setup completed! Framework ready for testing."

# Step 2: See what's possible (interactive demo)
./demo_enhanced_testing.sh
# 🎮 Interactive walkthrough showing all features and examples

# Step 3: Run your first test
./utils/run_test_enhanced.sh --env staging --scope smoke
# 🚀 Quick smoke tests using staging environment data
```

### **📚 Next Steps (Explore & Learn)**
```bash
# Get complete help and options reference
./utils/run_test_enhanced.sh --help
# 📖 See all available parameters and usage examples

# Try different environments and test scopes
./utils/run_test_enhanced.sh --env prod --scope full
# 🧪 Full regression testing with production environment

# Check AI integration (if available)
./utils/check_mcp.sh
# 🤖 Verify AI-assisted testing capabilities

# Try AI-enhanced testing
./utils/run_mcp_test.sh staging smoke
# 🚀 AI-powered test execution and optimization
```

### **🔄 Development Workflow**
```bash
# Daily development cycle
./utils/run_test_enhanced.sh --env staging --scope smoke --debug  # 1. Test changes
./utils/run_test_enhanced.sh --env prod --scope smoke             # 2. Validate
./utils/run_test_enhanced.sh --env prod --scope full              # 3. Full regression
```

**🎯 You're now ready to test like a pro! 🚀**

**💡 Pro Tips:**
- Start with `./demo_enhanced_testing.sh` to understand all capabilities
- Use `--env staging --scope smoke` for quick validation during development
- Use `--env prod --scope full` for comprehensive testing before releases
- Enable `--debug` flag when troubleshooting issues
- Check `reports/` directory for detailed logs and test results

**Need Help?**
- **Setup Issues**: Run `./setup.sh` and follow the instructions
- **Test Issues**: Use `--debug` flag and check `reports/` directory
- **Framework Questions**: Read the troubleshooting guide above
- **Maestro Help**: Visit [Maestro Documentation](https://docs.maestro.dev/)
- **AI Integration**: Run `./utils/check_mcp.sh` for MCP status

**Welcome to the team! Happy testing! 🎯**



