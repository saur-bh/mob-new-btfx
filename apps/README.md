# 📱 App Installation Guide

This directory contains the mobile app files for testing.

## 📁 **Required Files**

### **Android App**
- **File**: `bitfinex-android.apk`
- **Package**: `com.bitfinex.mobileapp.dev`
- **Source**: Download from your development team or build from source

### **iOS App**
- **File**: `bitfinex-ios.app` (or `.ipa`)
- **Bundle ID**: `com.bitfinex.mobileapp.dev`
- **Source**: Download from your development team or build from source

## 🚀 **Automatic Installation**

The test runner (`utils/run_test.sh`) automatically handles app installation:

### **Android**
```bash
# Automatic device management and app installation
./utils/run_test.sh -p android

# Specify custom app path
./utils/run_test.sh -p android -a /path/to/your/app.apk
```

### **iOS**
```bash
# Manual installation required for iOS
# Install app on simulator first, then run tests
./utils/run_test.sh -p ios
```

## 📋 **Installation Process**

### **Android Automatic Process**
1. ✅ **Check for running devices** - Looks for connected devices or emulators
2. ✅ **Start emulator if needed** - Automatically starts AVD if no device found
3. ✅ **Wait for device ready** - Ensures device is fully booted
4. ✅ **Install app** - Installs APK file automatically
5. ✅ **Run tests** - Executes test scenarios

### **Manual Installation (if needed)**
```bash
# Android
adb install apps/bitfinex-android.apk

# iOS (requires Xcode)
xcrun simctl install booted apps/bitfinex-ios.app
```

## 🔧 **Troubleshooting**

### **No AVD Found**
```bash
# Create AVD using Android Studio
# Or use command line:
avdmanager create avd -n "test_device" -k "system-images;android-30;google_apis;x86_64"
```

### **App Installation Failed**
- Check if app file exists in `apps/` directory
- Verify app package name matches test configuration
- Ensure device has enough storage space
- Check app permissions and signing

### **Device Not Detected**
```bash
# Check ADB connection
adb devices

# Restart ADB server
adb kill-server
adb start-server
```

## 📝 **Notes**

- The test runner automatically manages Android devices and app installation
- For iOS, manual app installation is required before running tests
- App files should be placed in the `apps/` directory
- Default app path is `apps/bitfinex-android.apk` for Android
- Custom app paths can be specified with `-a` parameter
