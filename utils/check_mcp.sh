#!/bin/bash

# MCP Status Checker for Bitfinex Framework

set -e

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}🔍 Checking MCP Integration Status${NC}"
echo "========================================"

# Check MCP configuration
if [[ -f ".trae/mcp.json" ]]; then
    echo -e "${GREEN}✅ MCP configuration found${NC}"
else
    echo -e "${RED}❌ MCP configuration missing${NC}"
fi

# Check framework config
if [[ -f "config.yaml" ]]; then
    echo -e "${GREEN}✅ Framework configuration found${NC}"
else
    echo -e "${RED}❌ Framework configuration missing${NC}"
fi

# Check environment variables
if [[ -n "$MAESTRO_MCP_ENABLED" ]]; then
    echo -e "${GREEN}✅ MCP environment variables set${NC}"
else
    echo -e "${YELLOW}⚠️  MCP environment variables not set${NC}"
fi

# Check Maestro MCP command
if maestro mcp --help &> /dev/null; then
    echo -e "${GREEN}✅ Maestro MCP command available${NC}"
else
    echo -e "${RED}❌ Maestro MCP command not available${NC}"
fi

echo ""
echo -e "${BLUE}MCP Integration Status:${NC}"
echo "• Framework Root: $BITFINEX_FRAMEWORK_ROOT"
echo "• MCP Enabled: $MAESTRO_MCP_ENABLED"
echo "• Workspace Path: $MAESTRO_WORKSPACE_PATH"
echo "• Device Type: $MAESTRO_DEVICE_TYPE"
echo "• App ID: $MAESTRO_APP_ID"
