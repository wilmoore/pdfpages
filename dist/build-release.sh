#!/bin/bash
#
# Build release package for distribution
#
# Usage: ./build-release.sh
#
# Output: PDF Pages (Finder).zip in the dist/ folder
#

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
DIST_DIR="$SCRIPT_DIR"
APP_NAME="PDF Pages (Finder)"
SCHEME="SplitPDF"

echo "Building release..."

# Build the app
xcodebuild -project "$PROJECT_DIR/SplitPDF/SplitPDF.xcodeproj" \
    -scheme "$SCHEME" \
    -configuration Release \
    -derivedDataPath "$DIST_DIR/.build" \
    clean build

# Find the built app
BUILT_APP="$DIST_DIR/.build/Build/Products/Release/SplitPDF.app"

if [ ! -d "$BUILT_APP" ]; then
    echo "Error: Built app not found at $BUILT_APP"
    exit 1
fi

# Create staging directory
STAGING_DIR="$DIST_DIR/.staging"
rm -rf "$STAGING_DIR"
mkdir -p "$STAGING_DIR"

# Copy app with new name
cp -R "$BUILT_APP" "$STAGING_DIR/$APP_NAME.app"

# Copy README
cp "$DIST_DIR/README.txt" "$STAGING_DIR/"

# Create zip
ZIP_NAME="$APP_NAME.zip"
rm -f "$DIST_DIR/$ZIP_NAME"
cd "$STAGING_DIR"
zip -r "$DIST_DIR/$ZIP_NAME" .

# Cleanup
rm -rf "$STAGING_DIR"
rm -rf "$DIST_DIR/.build"

echo ""
echo "Release package created: $DIST_DIR/$ZIP_NAME"
echo ""
echo "Contents:"
unzip -l "$DIST_DIR/$ZIP_NAME"
