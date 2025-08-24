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

## 🚀 **Quick Start Guide**

### **Step 1: Install Prerequisites**
```bash
# Run the setup script to check and install prerequisites
./setup.sh
```

The setup script will:
- ✅ Check Java, Node.js, Maestro installation
- ✅ Verify Android SDK and Xcode (macOS)
- ✅ Setup environment variables
- ✅ Create necessary directories
- ✅ Provide download instructions for missing components

### **Step 2: Add Your App Files**
```bash
# Place your app files in the apps/ directory
cp /path/to/your/app.apk apps/bitfinex-android.apk
cp /path/to/your/app.app apps/bitfinex-ios.app
```

### **Step 3: Run Your First Test**
```bash
# Run complete test (Android - auto-manages device & app)
./utils/run_test.sh

# Run on iOS (requires manual app installation)
./utils/run_test.sh -p ios

# Run with debug output
./utils/run_test.sh --debug
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
./utils/run_test.sh -t tests/login_and_navigation_test.yaml

# Run with debug output
./utils/run_test.sh --debug
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

### **Platform-Specific Test Data**
The framework uses separate configuration files for each platform:

- **`testdata/testdata-android.js`** - Android locators, credentials, settings
- **`testdata/testdata-ios.js`** - iOS locators, credentials, settings

### **App Configuration**
```javascript
// Example from testdata-android.js
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
  defaultTestFile: "tests/login_and_navigation_test.yaml"

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

## 🛠️ **Development Guide**

### **Adding New Test Flows**
1. Create new YAML file in `flows/shared/`
2. Add `appId: com.bitfinex.mobileapp.dev` at the top
3. Reference in main test files using `runFlow:`

### **Updating Test Data**
1. Edit platform-specific files in `testdata/`
2. Update locators, credentials, or configuration
3. Test with `./utils/run_test.sh --debug`

### **Creating New Tests**
```yaml
# tests/my_new_test.yaml
appId: com.bitfinex.mobileapp.dev
name: "My New Test"
tags: ["smoke", "feature-name"]
---
# Import test data
- runScript: '../testdata/testdata-android.js'

# Use shared flows
- runFlow: '../flows/shared/app_setup.yaml'

# Your test steps
- tapOn: "Some Element"
- inputText: "test data"
- assertVisible: "Expected Result"
```

## 🎯 **Best Practices**

### **✅ Do's**
- Use `while` loops for dynamic waiting instead of fixed counts
- Keep flows modular and reusable
- Use platform-specific test data for different UI elements
- Test on both iOS and Android regularly
- Use debug mode for troubleshooting

### **❌ Don'ts**
- Don't hardcode device-specific values
- Don't use fixed timeouts for UI elements
- Don't create monolithic test files
- Don't ignore platform differences

## 🔗 **Useful Links**

### **Maestro Documentation**
- **[Installation Guide](https://docs.maestro.dev/getting-started/installation)**
- **[Command Reference](https://docs.maestro.dev/reference/commands)**
- **[Best Practices](https://docs.maestro.dev/best-practices)**
- **[Troubleshooting](https://docs.maestro.dev/troubleshooting)**
- **[MCP Integration](https://docs.maestro.dev/getting-started/maestro-mcp)**

### **Framework Resources**
- **[App Installation Guide](apps/README.md)**
- **[Test Runner Help](./utils/run_test.sh --help)**
- **[MCP Status Check](./utils/check_mcp.sh)**

## 🚀 **Ready to Start**

Your Bitfinex automation framework is ready! 

**Quick Commands:**
```bash
./setup.sh                    # Check prerequisites
./utils/run_test.sh           # Run your first test
./utils/check_mcp.sh         # Check AI assistance status
```

**Need Help?**
- Check prerequisites: `./setup.sh`
- View test runner options: `./utils/run_test.sh --help`
- Check MCP status: `./utils/check_mcp.sh`
- Read app installation guide: `cat apps/README.md`

Happy testing! 🎯



