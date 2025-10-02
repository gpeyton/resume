#!/bin/bash

# Resume PDF Export Script
# Usage: ./export_pdf.sh [--short|--long|--both]

set -e

RESUME_DIR="/Users/gpeyton/Documents/resume"
CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

print_usage() {
    echo "Usage: $0 [--short|--long|--both]"
    echo ""
    echo "Options:"
    echo "  --short    Export 1-page resume only"
    echo "  --long     Export 3-page resume only"
    echo "  --both     Export both versions (default)"
    echo ""
    echo "Example:"
    echo "  $0 --short"
    echo "  $0 --long"
    echo "  $0          # exports both versions"
}

export_short() {
    echo -e "${BLUE}Exporting 1-page resume...${NC}"
    cd "$RESUME_DIR/short_version"
    "$CHROME" --headless --disable-gpu \
        --run-all-compositor-stages-before-draw \
        --print-to-pdf="Graham_Peyton_Resume_Short.pdf" \
        --no-pdf-header-footer \
        --print-to-pdf-no-header \
        index.html
    echo -e "${GREEN}✓ Short resume exported: short_version/Graham_Peyton_Resume_Short.pdf${NC}"
}

export_long() {
    echo -e "${BLUE}Exporting 3-page resume...${NC}"
    cd "$RESUME_DIR/long_version"
    "$CHROME" --headless --disable-gpu \
        --run-all-compositor-stages-before-draw \
        --print-to-pdf="Graham_Peyton_Resume_Long.pdf" \
        --no-pdf-header-footer \
        --print-to-pdf-no-header \
        index.html
    echo -e "${GREEN}✓ Long resume exported: long_version/Graham_Peyton_Resume_Long.pdf${NC}"
}

# Parse command line arguments
case "${1:-}" in
    --short)
        export_short
        ;;
    --long)
        export_long
        ;;
    --both|"")
        export_short
        echo ""
        export_long
        ;;
    --help|-h)
        print_usage
        exit 0
        ;;
    *)
        echo -e "${RED}Error: Invalid option '$1'${NC}"
        echo ""
        print_usage
        exit 1
        ;;
esac

echo ""
echo -e "${GREEN}Done! Resume(s) exported successfully.${NC}"
