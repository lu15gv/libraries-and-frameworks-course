#!/bin/bash

set -e

BASEDIR=$(dirname "$0")
rm -rf "$BASEDIR/.derivedData"
sh "$BASEDIR/buildC.sh"
sh "$BASEDIR/buildObjC.sh"
sh "$BASEDIR/buildSwift.sh"