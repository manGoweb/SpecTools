#!/bin/bash

# Jazzy
command_name=jazzy
if ! loc="$(type -p "$command_name")" || [ -z "$loc" ]; then
    RUBY_VERSION="2.4.1"
    # Install RVM (user ruby)
    \curl -sSL https://get.rvm.io | bash -s stable --ruby=${RUBY_VERSION}
    source $HOME/.rvm/scripts/rvm
    rvm install ${RUBY_VERSION}
    rvm use ${RUBY_VERSION}
    rvm --default use ${RUBY_VERSION}

	printf "👽	Installing Jazzy\n"
	gem install jazzy
else
	printf "😎	Jazzy is installed correctly\n"
fi

printf "👾	Generating documentation\n"

jazzy --podspec ./SpecTools.podspec
