#!/bin/bash

set -e

BASEDIR=$(dirname "$0")
PROJECT_NAME="SwiftStaticLibrary"
PROJECT_PATH="$BASEDIR/$PROJECT_NAME/$PROJECT_NAME.xcodeproj"
DERIVED_DATA_PATH="$BASEDIR/.derivedData/$PROJECT_NAME"
ARCHIVE_PATH="$DERIVED_DATA_PATH/archives/$PROJECT_NAME/$PROJECT_NAME.xcarchive"
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
  xcodebuild archive \
  -project $PROJECT \
  -scheme $SCHEME \
  -derivedDataPath $DERIVED_DATA_PATH \
  -archivePath $ARCHIVE_PATH \
  -configuration $CONFIGURATION \
  -sdk $SDK \
  -arch $ARCH \
  BUILD_LIBRARY_FOR_DISTRIBUTION=NO \
  SKIP_INSTALL=NO | xcbeautify
}

echo_section "Cleaning: Swift"

rm -rf "$PRODUCTS_PATH/$PROJECT_NAME"
rm -rf "$DERIVED_DATA_PATH/$PROJECT_NAME"

mkdir -p "$PRODUCTS_PATH/$PROJECT_NAME"
mkdir -p "$DERIVED_DATA_PATH/$PROJECT_NAME"

echo_section "Archiving: Swift"

archive $PROJECT_PATH $PROJECT_NAME "Release" "iphonesimulator" "x86_64"

echo_section "Copying files: Swift"

cp "$ARCHIVE_PATH/Products/usr/local/lib/lib$PROJECT_NAME.a" "$PRODUCTS_PATH/$PROJECT_NAME/lib$PROJECT_NAME.a"
cp -r "$DERIVED_DATA_PATH/Build/Intermediates.noindex/ArchiveIntermediates/$PROJECT_NAME/BuildProductsPath/Release-iphonesimulator/$PROJECT_NAME.swiftmodule" "$PRODUCTS_PATH/$PROJECT_NAME"

echo_section "Done: Swift"