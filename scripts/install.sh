#!/bin/bash

# DailyAI Plugin Installation Script
# Sets up vault structure, copies templates, and installs dependencies

set -e

echo "🚀 DailyAI Plugin Setup"
echo "======================="
echo ""

# Check VAULT_PATH
if [ -z "$VAULT_PATH" ]; then
    echo "❌ ERROR: VAULT_PATH environment variable not set"
    echo ""
    echo "Please set VAULT_PATH to your Obsidian vault location."
    echo ""
    echo "Add this to ~/.bashrc or ~/.zshrc:"
    echo ""
    echo '  export VAULT_PATH="/path/to/your/obsidian/vault"'
    echo ""
    echo "Then reload:"
    echo "  source ~/.bashrc  # or ~/.zshrc"
    echo ""
    exit 1
fi

echo "✅ VAULT_PATH: $VAULT_PATH"
echo ""

# Validate vault directory exists
if [ ! -d "$VAULT_PATH" ]; then
    echo "❌ ERROR: Vault directory does not exist"
    echo "   Path: $VAULT_PATH"
    exit 1
fi

# Create required directories
echo "📁 Creating vault structure..."
mkdir -p "$VAULT_PATH/System"
mkdir -p "$VAULT_PATH/Projects/ThingsToDo"
mkdir -p "$VAULT_PATH/Projects/ThingsToLearn"
mkdir -p "$VAULT_PATH/Daily/$(date +%Y)"

echo "  ✅ System/"
echo "  ✅ Projects/ThingsToDo/"
echo "  ✅ Projects/ThingsToLearn/"
echo "  ✅ Daily/$(date +%Y)/"
echo ""

# Get plugin directory
PLUGIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Copy templates
echo "📋 Copying templates..."

if [ ! -f "$VAULT_PATH/System/AGENT.md" ]; then
    if [ -f "$PLUGIN_DIR/templates/AGENT_TEMPLATE.md" ]; then
        cp "$PLUGIN_DIR/templates/AGENT_TEMPLATE.md" "$VAULT_PATH/System/AGENT.md"
        echo "  ✅ System/AGENT.md"
    else
        echo "  ⚠️  System/AGENT.md (template not found - you can create manually)"
    fi
else
    echo "  ⏭️  System/AGENT.md (already exists)"
fi

if [ ! -f "$VAULT_PATH/System/catalog-project.md" ]; then
    if [ -f "$PLUGIN_DIR/templates/PROJECT_CATALOG.md" ]; then
        cp "$PLUGIN_DIR/templates/PROJECT_CATALOG.md" "$VAULT_PATH/System/catalog-project.md"
        echo "  ✅ System/catalog-project.md"
    else
        echo "  ⚠️  System/catalog-project.md (template not found)"
    fi
else
    echo "  ⏭️  System/catalog-project.md (already exists)"
fi

if [ ! -d "$VAULT_PATH/templates" ]; then
    mkdir -p "$VAULT_PATH/templates"
    if [ -f "$PLUGIN_DIR/templates/DAILY_NOTE_TEMPLATE.md" ]; then
        cp "$PLUGIN_DIR/templates/DAILY_NOTE_TEMPLATE.md" "$VAULT_PATH/templates/"
        echo "  ✅ templates/DAILY_NOTE_TEMPLATE.md"
    fi
fi

echo ""

# Install Python dependencies (optional)
echo "🐍 Checking Python dependencies..."

if command -v python3 &> /dev/null; then
    PYTHON_VERSION=$(python3 --version 2>&1 | awk '{print $2}')
    echo "  ✅ Python3 found: $PYTHON_VERSION"
    echo ""

    if [ -f "$PLUGIN_DIR/calendar/requirements.txt" ]; then
        echo "📦 Installing calendar dependencies..."
        echo "   (This may take a minute...)"
        echo ""

        if python3 -m pip install -q -r "$PLUGIN_DIR/calendar/requirements.txt" 2>/dev/null; then
            echo "  ✅ Calendar dependencies installed successfully"
            echo ""
        else
            echo "  ⚠️  Some dependencies may have failed to install"
            echo "   You can install manually with:"
            echo "   pip install -r $PLUGIN_DIR/calendar/requirements.txt"
            echo ""
        fi
    fi
else
    echo "  ⚠️  Python3 not found"
    echo "   Calendar integration will not be available"
    echo "   To enable calendar support, install Python 3.8+"
    echo ""
fi

# Summary
echo "✅ Installation Complete!"
echo ""
echo "📋 Next steps:"
echo ""
echo "  1️⃣  For Google Calendar (optional):"
echo "      See: calendar/README.md"
echo ""
echo "  2️⃣  For iCal/CalDAV (optional):"
echo "      See: calendar/README.md"
echo ""
echo "  3️⃣  Try your first command:"
echo "      /start-day"
echo ""
echo "  4️⃣  Questions?"
echo "      See: docs/troubleshooting.md"
echo ""
echo "📍 Vault location: $VAULT_PATH"
echo "📍 Plugin location: $PLUGIN_DIR"
echo ""
