// iOS Test Data for Maestro Tests
// This file exports iOS-specific test data variables

// iOS configuration
const config = {
    appId: "com.bitfinex.bfxdev",
    timeout: 25000,
    maestro: {
        driverTimeout: 25000,
        elementTimeout: 8000,
        animationTimeout: 500
    },
    reporting: {
        outputDir: "reports/ios",
        screenshotsDir: "reports/ios/screenshots",
        videosDir: "reports/ios/videos",
        xmlReport: "reports/ios/test-results.xml"
    }
};

// Bitfinex API credentials
output.bitfinex = {
    apiKey: "ea69b2a8517ac37c1499207741c2392566d28a9d880",
    secretKey: "06ecd3c6b560b32003451f244cb302c258eb5ebcd82"
};

// iOS app configuration
output.app = {
    appId: config.appId,
    
    // App modes (can be overridden by environment variable APP_MODE)
    modes: {
        lite: {
            name: "Lite",
            selector: "Lite.*",
            timeout: 10000,
            features: ["basic_trading", "wallet_view", "simple_navigation"]
        },
        full: {
            name: "Full", 
            selector: "Full.*",
            timeout: 15000,
            features: ["advanced_trading", "full_wallet", "complete_navigation", "analytics", "advanced_orders"]
        }
    },
    
    // Get current mode (from environment variable or default to lite)
    currentMode: process.env.APP_MODE || "lite",
    
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

// iOS test settings
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
