#!/bin/bash

# Enhanced MCP Test Runner for Bitfinex Framework
# This script runs tests with MCP integration and dynamic environment/scope support

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Function to print usage
print_usage() {
    echo -e "${BLUE}Enhanced MCP Test Runner for Bitfinex Framework${NC}"
    echo ""
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "This script supports all options from run_test_enhanced.sh:"
    echo "  -e, --env ENV            Environment: staging, prod (default: staging)"
    echo "  -s, --scope SCOPE        Test scope: smoke, full (default: smoke)"
    echo "  -t, --test-file FILE     Test file to run"
    echo "  -p, --platform PLATFORM  Platform: ios or android"
    echo "  -m, --mode MODE          App mode: lite or full"
    echo "  --tags TAGS              Comma-separated tags to include"
    echo "  --exclude-tags TAGS      Comma-separated tags to exclude"
    echo "  --help                   Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 -e prod -s full       # Run full test suite on production with MCP"
    echo "  $0 -e staging -s smoke   # Run smoke tests on staging with MCP"
    echo ""
}

# Check for help flag
if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    print_usage
    exit 0
fi

echo -e "${BLUE}🚀 Running Enhanced Bitfinex Framework Test with MCP Integration${NC}"

# Parse environment and scope from arguments for display
ENVIRONMENT="staging"
TEST_SCOPE="smoke"

for arg in "$@"; do
    case $arg in
        -e|--env)
            shift
            ENVIRONMENT="$1"
            shift
            ;;
        -s|--scope)
            shift
            TEST_SCOPE="$1"
            shift
            ;;
        *)
            shift
            ;;
    esac
done

echo -e "${YELLOW}📋 Configuration:${NC}"
echo -e "   Environment: ${ENVIRONMENT}"
echo -e "   Test Scope: ${TEST_SCOPE}"
echo -e "   MCP Integration: Enabled"
echo ""

# Set MCP environment variables
export MAESTRO_MCP_ENABLED=true
export MAESTRO_WORKSPACE_PATH="$(pwd)"
export MAESTRO_DEVICE_TYPE="Android"
export MAESTRO_APP_ID="com.bitfinex.mobileapp.dev"
export MAESTRO_ENVIRONMENT="$ENVIRONMENT"
export MAESTRO_TEST_SCOPE="$TEST_SCOPE"

# Run the enhanced test with MCP context
./utils/run_test_enhanced.sh "$@"

echo -e "${GREEN}✅ Enhanced test completed with MCP integration${NC}"
