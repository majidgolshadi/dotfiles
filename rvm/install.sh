#!/usr/bin/env bash

set -e

source "$(dirname "$0")/../script/bootstrap.bash"

function install_keys() {
  GPG_COMMAND="gpg2"

  if is_mac; then
    brew_install gnupg2
    GPG_COMMAND="gpg"
  elif ! check_command gpg2; then
    user 'gpg2 is not in path. install gnupg2 using your distro package manager and run the installer script again.'
    exit 0
  fi

  curl -sSL https://rvm.io/mpapis.asc | gpg --import -
  curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -
}

if ! check_command rvm; then
  install_keys
  RVM="$HOME/.rvm"
  [ -d "$RVM" ] && rm -rf "$RVM"

  \curl -sSL https://get.rvm.io | bash -s -- --ignore-dotfiles
  source "$RVM/scripts/rvm"
fi

if is_mac; then
  rvm get stable --autolibs=homebrew
else
  rvm get stable
fi
rvm install ruby --latest
rvm alias create default ruby --latest

user "run rvm reload to use the newly installed ruby"
