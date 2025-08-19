#!/bin/bash

# MCP Test Runner for Bitfinex Framework
# This script runs tests with MCP integration enabled

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}🚀 Running Bitfinex Framework Test with MCP Integration${NC}"

# Set MCP environment variables
export MAESTRO_MCP_ENABLED=true
export MAESTRO_WORKSPACE_PATH="$(pwd)"
export MAESTRO_DEVICE_TYPE="Android"
export MAESTRO_APP_ID="com.bitfinex.mobileapp.dev"

# Run the test with MCP context
./utils/run_test.sh "$@"

echo -e "${GREEN}✅ Test completed with MCP integration${NC}"
