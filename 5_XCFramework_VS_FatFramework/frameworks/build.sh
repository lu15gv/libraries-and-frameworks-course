#!/bin/bash

set -e

BASEDIR=$(dirname "$0")
PROJECT_NAME="SwiftStaticFramework"
PROJECT_PATH="$BASEDIR/$PROJECT_NAME/$PROJECT_NAME.xcodeproj"
DERIVED_DATA_PATH="$BASEDIR/.derivedData"
ARCHIVE_PATH="$DERIVED_DATA_PATH/archives"
PRODUCTS_PATH="$BASEDIR/product"

echo_section() {
  SECTION=$1
  echo "\033[1;34m ********************************* $SECTION ********************************** \033[0m" 
}

archive() {
  PROJECT=$1
  SCHEME=$2
  CONFIGURATION=$3
  SDK=$4
  ARCH=$5
  ARCHIVE=$6
  xcodebuild archive \
  -project $PROJECT \
  -scheme $SCHEME \
  -derivedDataPath $DERIVED_DATA_PATH \
  -archivePath $ARCHIVE \
  -configuration $CONFIGURATION \
  -sdk $SDK \
  -arch $ARCH \
  SKIP_INSTALL=NO \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
  MACH_O_TYPE=staticlib | xcbeautify
}

echo_section "Cleaning"
rm -rf "$PRODUCTS_PATH"
rm -rf "$DERIVED_DATA_PATH"
mkdir -p "$PRODUCTS_PATH/XCFramework"
mkdir -p "$PRODUCTS_PATH/FatFramework"
mkdir -p "$DERIVED_DATA_PATH"

echo_section "Archiving for Simulator (x86_64)"
archive "$PROJECT_PATH" "$PROJECT_NAME" "Release" "iphonesimulator" "x86_64" "$ARCHIVE_PATH/iphonesimulator"

echo_section "Archiving for iPhone (arm64)"
archive "$PROJECT_PATH" "$PROJECT_NAME" "Release" "iphoneos" "arm64" "$ARCHIVE_PATH/iphoneos"

echo_section "Creating FatFramework"
# Copy base framework and mixing swiftmodule folders
cp -R "$ARCHIVE_PATH/iphoneos.xcarchive/Products/Library/Frameworks/$PROJECT_NAME.framework" "$PRODUCTS_PATH/FatFramework/"
cp -a "$ARCHIVE_PATH/iphonesimulator.xcarchive/Products/Library/Frameworks/$PROJECT_NAME.framework/Modules/$PROJECT_NAME.swiftmodule" "$PRODUCTS_PATH/FatFramework/$PROJECT_NAME.framework/Modules"
# Creating fat-framework
lipo -create \
"$ARCHIVE_PATH/iphonesimulator.xcarchive/Products/Library/Frameworks/$PROJECT_NAME.framework/$PROJECT_NAME" \
"$ARCHIVE_PATH/iphoneos.xcarchive/Products/Library/Frameworks/$PROJECT_NAME.framework/$PROJECT_NAME" \
-output "$PRODUCTS_PATH/FatFramework/$PROJECT_NAME.framework/$PROJECT_NAME"

echo_section "Creating XCFramework"
xcodebuild -create-xcframework \
-framework "$ARCHIVE_PATH/iphonesimulator.xcarchive/Products/Library/Frameworks/$PROJECT_NAME.framework" \
-framework "$ARCHIVE_PATH/iphoneos.xcarchive/Products/Library/Frameworks/$PROJECT_NAME.framework" \
-output "$PRODUCTS_PATH/XCFramework/$PROJECT_NAME.xcframework"
