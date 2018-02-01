#!/bin/sh

# Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Inatall Hombrew Cask
brew tap caskroom/cask

# Install development tools
brew install bash git wget tree jq

# Install development apps
brew cask install visual-studio-code docker virtualbox vagrant

# Install Caskroom-fonts
brew tap caskroom/fonts

# Install development fonts
brew cask install font-ricty-diminished
