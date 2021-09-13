#!/bin/bash

set -e

BASEDIR=$(dirname "$0")
PROJECT_NAME="SwiftFramework"
PROJECT_PATH="$BASEDIR/A/$PROJECT_NAME.xcodeproj"
DERIVED_DATA_PATH="$BASEDIR/.derivedData/A"
ARCHIVE_PATH="$DERIVED_DATA_PATH/archives/$PROJECT_NAME.xcarchive"
PRODUCTS_PATH="$BASEDIR/product/A"

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
  xcodebuild archive \
  -project $PROJECT \
  -scheme $SCHEME \
  -derivedDataPath $DERIVED_DATA_PATH \
  -archivePath $ARCHIVE_PATH \
  -configuration $CONFIGURATION \
  -sdk $SDK \
  -arch $ARCH \
  SKIP_INSTALL=NO \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
  MACH_O_TYPE=mh_dylib | xcbeautify
}

echo_section "Cleaning"
rm -rf "$PRODUCTS_PATH"
rm -rf "$DERIVED_DATA_PATH"
mkdir -p "$PRODUCTS_PATH"
mkdir -p "$DERIVED_DATA_PATH"

echo_section "Archiving for Simulator"
archive "$PROJECT_PATH" "$PROJECT_NAME" "Release" "iphonesimulator" "x86_64"

cp -r "$ARCHIVE_PATH/Products/Library/Frameworks/$PROJECT_NAME.framework" "$PRODUCTS_PATH/$PROJECT_NAME.framework"
