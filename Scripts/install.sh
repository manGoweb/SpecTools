#!/bin/bash

echo "Install cocoapods"

sudo gem install cocoapods
pod setup
cd ./Example/ && pod install