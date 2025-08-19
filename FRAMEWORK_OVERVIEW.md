# 🎯 Bitfinex Framework - Quick Reference

## 🚀 **One-Command Testing**
```bash
./utils/run_test.sh           # Run complete test (Android)
./utils/run_test.sh -p ios    # Run on iOS
./utils/run_test.sh --debug   # Run with debug output
```

## 📁 **Framework Structure**
```
bitfixnex/
├── flows/shared/     # Reusable test components
├── testdata/         # Platform-specific configs
├── tests/            # Main test scenarios
├── utils/            # Framework utilities
├── apps/             # App files (add APK/APP here)
├── reports/          # Test outputs
└── .trae/            # Trae IDE integration
```

## 🔧 **Essential Commands**
```bash
./setup.sh                    # Check prerequisites
./setup-mcp.sh               # Setup AI assistance
./utils/run_test.sh --help   # View all options
./utils/check_mcp.sh         # Check MCP status
```

## 📚 **Documentation Links**
- **[Maestro Docs](https://docs.maestro.dev/)** - Complete documentation
- **[Getting Started](https://docs.maestro.dev/getting-started/installation)** - Installation guide
- **[Commands Reference](https://docs.maestro.dev/reference/commands)** - All commands
- **[Best Practices](https://docs.maestro.dev/best-practices)** - Testing guidelines

## 🎯 **Key Features**
- ✅ **One-Command Testing** - Auto-manages devices & apps
- ✅ **Ultra-Simple PIN Creation** - Dynamic PIN setup
- ✅ **Complete Navigation Testing** - All app sections
- ✅ **AI-Assisted Testing** - MCP integration with Trae
- ✅ **Platform Switching** - Easy iOS/Android switching
- ✅ **Comprehensive Logging** - Detailed logs with timestamps

## 🚀 **Quick Start**
1. `./setup.sh` - Check prerequisites
2. Add app files to `apps/` directory
3. `./utils/run_test.sh` - Run your first test
4. `./setup-mcp.sh` - Setup AI assistance (optional)

**Need Help?** Check the main [README.md](Readme.md) for detailed documentation.
