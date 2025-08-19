// Android Test Data for Maestro Tests
// This file exports Android-specific test data variables

// Android configuration
const config = {
    appId: "com.bitfinex.mobileapp.dev",
    timeout: 30000,
    maestro: {
        driverTimeout: 30000,
        elementTimeout: 10000,
        animationTimeout: 1000
    },
    reporting: {
        outputDir: "reports/android",
        screenshotsDir: "reports/android/screenshots",
        videosDir: "reports/android/videos",
        xmlReport: "reports/android/test-results.xml"
    }
};

// Bitfinex API credentials
output.bitfinex = {
    apiKey: "ea69b2a8517ac37c1499207741c2392566d28a9d880",
    secretKey: "06ecd3c6b560b32003451f244cb302c258eb5ebcd82"
};

// Android app configuration
output.app = {
    appId: config.appId,
    
    // App modes
    modes: {
        lite: "Lite",
        full: "Full"
    },
    
    // Navigation elements
    navigation: {
        continue: "Continue",
        signIn: "Sign in",
        login: "Login",
        menu: "Menu",
        profile: "Profile"
    },
    
    // PIN configuration
    pin: {
        defaultPin: "5",
        length: 4,
        confirmText: "Confirm PIN",
        successText: "PIN created successfully",
        createPinText: "Create a 4-digit PIN"
    }
};

// Android test settings
output.testSettings = {
    timeout: config.timeout,
    maestro: config.maestro,
    reporting: config.reporting
};

// Element locators
output.locators = {
    // Login page elements
    login: {
        emailField: "login_email",
        apiKeyField: "Login-Public-Key-Input",
        secretKeyField: "Login-Secret-Key-Input",
        apiKeyText: "API Key",
        keyText: "Key"
    },
    
    // PIN creation elements
    pin: {
        createPinText: "Create a 4-digit PIN",
        pinInput: "pin_input",
        confirmButton: "Confirm",
        continueButton: "Continue"
    },
    
    // Dashboard elements
    dashboard: {
        wallet: "Wallet",
        home: "Home",
        dashboard: "Dashboard"
    }
};

// Test user credentials
output.users = {
    testUser: {
        email: "test@example.com",
        password: "testpassword123"
    },
    demoUser: {
        email: "demo@example.com", 
        password: "demopassword456"
    }
};

// Environment configurations
output.environments = {
    development: {
        baseUrl: "https://dev-api.example.com",
        timeout: 10000
    },
    staging: {
        baseUrl: "https://staging-api.example.com", 
        timeout: 15000
    },
    production: {
        baseUrl: "https://api.example.com",
        timeout: 20000
    }
};
