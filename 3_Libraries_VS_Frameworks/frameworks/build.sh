#!/bin/bash

set -e

BASEDIR=$(dirname "$0")
PROJECT_NAME="SwiftFramework"
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
  MACH_O=$7
  xcodebuild archive \
  -project $PROJECT \
  -scheme $SCHEME \
  -derivedDataPath $DERIVED_DATA_PATH \
  -archivePath $ARCHIVE \
  -configuration $CONFIGURATION \
  -sdk $SDK \
  -arch $ARCH \
  MACH_O_TYPE=$MACH_O \
  SKIP_INSTALL=NO | xcbeautify
}

echo_section "Cleaning: Swift"

rm -rf "$PRODUCTS_PATH"
rm -rf "$DERIVED_DATA_PATH"

mkdir -p "$PRODUCTS_PATH/dynamic"
mkdir -p "$PRODUCTS_PATH/static"
mkdir -p "$DERIVED_DATA_PATH"

echo_section "Archiving: Swift"

archive $PROJECT_PATH $PROJECT_NAME "Release" "iphonesimulator" "x86_64" "$ARCHIVE_PATH/dynamic" mh_dylib
archive $PROJECT_PATH $PROJECT_NAME "Release" "iphonesimulator" "x86_64" "$ARCHIVE_PATH/static" staticlib

echo_section "Copying files: Swift"

cp -r "$ARCHIVE_PATH/dynamic.xcarchive/Products/Library/Frameworks/$PROJECT_NAME.framework" "$PRODUCTS_PATH/dynamic/$PROJECT_NAME.framework"
cp -r "$ARCHIVE_PATH/static.xcarchive/Products/Library/Frameworks/$PROJECT_NAME.framework" "$PRODUCTS_PATH/static/$PROJECT_NAME.framework"

echo_section "Done: Swift"