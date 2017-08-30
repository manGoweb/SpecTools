#!/bin/bash

# Jazzy
command_name=jazzy
if ! loc="$(type -p "$command_name")" || [ -z "$loc" ]; then
	printf "👽	Installing Jazzy\n"
	gem install jazzy
else
	printf "😎	Jazzy is installed correctly\n"
fi

printf "👾	Generating documentation\n"

jazzy --podspec ./SpecTools.podspec --no-download-badge
