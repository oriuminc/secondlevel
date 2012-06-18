#!/bin/sh

set -e

# Config how automated commits from Jenkins will show up in git log.
git config --global user.email "jenkins@example.com"
git config --global user.name "Jenkins"

# Turn on colored output (helpful for console log)
git config --global color.ui auto

mkdir -p ~/.ssh
echo -e "Host *\n  StrictHostKeyChecking no" > ~/.ssh/config

# Add rerun directory to PATH
export PATH="$PATH:$WORKSPACE/profile/tmp/scripts/rerun"
export RERUN_MODULES="$WORKSPACE/profile/tmp/scripts/rerun-modules"
