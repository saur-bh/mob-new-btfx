#!/bin/bash

# Demo Script for Enhanced Maestro Testing with Dynamic Environment and Scope
# This script demonstrates how to use the new enhanced testing capabilities

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}🎯 Enhanced Maestro Testing Demo${NC}"
echo -e "${BLUE}================================${NC}"
echo ""

echo -e "${YELLOW}📋 Available Test Configurations:${NC}"
echo ""
echo "🌍 Environments:"
echo "   • staging - Staging environment with test data"
echo "   • prod    - Production environment with live-like data"
echo ""
echo "🎯 Test Scopes:"
echo "   • smoke - Quick smoke tests (tags: smoke)"
echo "   • full  - Complete test suite (tags: smoke, regression, end-to-end)"
echo ""

echo -e "${BLUE}🚀 Demo Test Executions:${NC}"
echo ""

# Demo 1: Smoke tests on staging
echo -e "${GREEN}Demo 1: Running smoke tests on staging environment${NC}"
echo "Command: ./utils/run_test_enhanced.sh -e staging -s smoke"
echo "This will:"
echo "  ✓ Use testdata-staging.js for test data"
echo "  ✓ Run tests tagged with 'smoke'"
echo "  ✓ Execute quick validation tests"
echo ""
read -p "Press Enter to run this demo (or Ctrl+C to skip)..."
./utils/run_test_enhanced.sh -e staging -s smoke --help
echo ""

# Demo 2: Full tests on production
echo -e "${GREEN}Demo 2: Running full test suite on production environment${NC}"
echo "Command: ./utils/run_test_enhanced.sh -e prod -s full"
echo "This will:"
echo "  ✓ Use testdata-prod.js for test data"
echo "  ✓ Run tests tagged with 'smoke', 'regression', 'end-to-end'"
echo "  ✓ Execute comprehensive test coverage"
echo ""
read -p "Press Enter to see this demo command (or Ctrl+C to skip)..."
./utils/run_test_enhanced.sh -e prod -s full --help
echo ""

# Demo 3: MCP Integration
echo -e "${GREEN}Demo 3: Running tests with MCP integration${NC}"
echo "Command: ./utils/run_mcp_test.sh -e staging -s smoke"
echo "This will:"
echo "  ✓ Enable MCP integration for enhanced context"
echo "  ✓ Use staging environment with smoke tests"
echo "  ✓ Provide rich test execution context"
echo ""
read -p "Press Enter to see MCP demo command (or Ctrl+C to skip)..."
./utils/run_mcp_test.sh --help
echo ""

# Demo 4: Custom tag filtering
echo -e "${GREEN}Demo 4: Custom tag filtering${NC}"
echo "Command: ./utils/run_test_enhanced.sh -e staging --tags login,navigation"
echo "This will:"
echo "  ✓ Use staging environment"
echo "  ✓ Run only tests tagged with 'login' and 'navigation'"
echo "  ✓ Allow precise test selection"
echo ""

echo -e "${BLUE}📚 Usage Examples:${NC}"
echo ""
echo "# Quick smoke test on staging"
echo "./utils/run_test_enhanced.sh -e staging -s smoke"
echo ""
echo "# Full regression on production"
echo "./utils/run_test_enhanced.sh -e prod -s full"
echo ""
echo "# Specific test tags"
echo "./utils/run_test_enhanced.sh -e staging --tags login,pin"
echo ""
echo "# With MCP integration"
echo "./utils/run_mcp_test.sh -e prod -s smoke"
echo ""
echo "# Exclude slow tests"
echo "./utils/run_test_enhanced.sh -e staging -s full --exclude-tags slow"
echo ""

echo -e "${GREEN}✅ Demo completed! You can now use the enhanced testing system.${NC}"
echo -e "${YELLOW}💡 Tip: Use --help with any script to see all available options.${NC}"