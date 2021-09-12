#!/bin/bash

set -e

BASEDIR=$(dirname "$0")
sh "$BASEDIR/buildA.sh"
sh "$BASEDIR/buildB.sh"