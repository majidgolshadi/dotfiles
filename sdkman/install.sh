#!/usr/bin/env bash

set -e

source "$(dirname "$0")/../script/bootstrap.bash"

if check_command brew; then
    brew_install curl
    brew_install zip
    brew_install unzip
else
    fail 'brew must be installed'
fi

export SDKMAN_DIR="$HOME/.sdkman"

if [ ! -d "$SDKMAN_DIR" ]; then 
    curl -s "https://get.sdkman.io" | sed 's!^sdkman_bashrc=".*"$!sdkman_bashrc=/dev/null!' | sed 's!^sdkman_zshrc=".*"$!sdkman_zshrc=/dev/null!' | bash
else
    info 'sdkman is already installed.'
fi

if ! check_command "sdkman"; then
    source "$SDKMAN_DIR/bin/sdkman-init.sh"
fi

JAVA_VERSION="8.0.232.hs-adpt"
sdk install java $JAVA_VERSION || true
sdk default java $JAVA_VERSION

SCALA_VERSION="2.13.1"
sdk install scala $SCALA_VERSION || true
sdk default scala $SCALA_VERSION

SBT_VERSION="1.3.6"
sdk install sbt $SBT_VERSION || true
sdk default sbt $SBT_VERSION

MAVEN_VERSION="3.6.3"
sdk install maven $MAVEN_VERSION || true
sdk default maven $MAVEN_VERSION

GRADLE_VERSION="6.0.1"
sdk install gradle $GRADLE_VERSION || true
sdk default gradle $GRADLE_VERSION

