#!/usr/bin/env bash

set -e

source "$(dirname "$0")/../script/bootstrap.bash"

if ! is_mac; then
  info "This machine is not running macOS. Skipping..."
  exit 0
fi

# install google sdk
brew_tap caskroom/cask
brew_install google-cloud-sdk
