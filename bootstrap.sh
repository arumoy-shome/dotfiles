#!/usr/bin/env bash

# install xcode command line developer tools
xcode-select --install

# install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# install brews
brew bundle
