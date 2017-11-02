#!/bin/bash

echo "Build SpecTools"
cd ./Example/ && set -o pipefail && xcodebuild test -workspace SpecTools.xcworkspace -scheme SpecTools-Example -destination 'platform=iOS Simulator,name=iPhone X'

