#!/bin/bash
#
# NAME
#
#   deploy
#
# DESCRIPTION
#
#   Deploy site after building.
#

# Parse the command options
[ -r $RERUN_MODULES/2ndlevel/commands/deploy/options.sh ] && {
  source $RERUN_MODULES/2ndlevel/commands/deploy/options.sh
}

# Read module function library
[ -r $RERUN_MODULES/2ndlevel/lib/functions.sh ] && {
  source $RERUN_MODULES/2ndlevel/lib/functions.sh
}

# ------------------------------
# Your implementation goes here.
# ------------------------------

set -e

# Prepare for running Rerun
export RERUN_MODULES=`readlink -f $WORKSPACE/profile/tmp/scripts/rerun-modules`
export PATH=$PATH:`readlink -f $WORKSPACE/profile/tmp/scripts/rerun`

PROJECT=2ndlevel

# Execute site build script
cd $WORKSPACE/profile
rerun 2ndlevel:build --build-file $WORKSPACE/profile/build-${PROJECT}.make --destination $WORKSPACE/build

git clone --branch develop $REPO $WORKSPACE/acquia
cd $WORKSPACE/acquia
git rm -r --force --quiet docroot

# rsync build/ dir into acquia repo docroot/
# (excluding files according to patterns in file, accessible to developers.)
rsync --archive --exclude-from=$WORKSPACE/profile/tmp/scripts/docroot-exclude.txt $WORKSPACE/build/ $WORKSPACE/acquia/docroot/
git add --force docroot/

# Sanity check to see what was commited.
git status

# If nothing staged, `git diff --cached` exits with 0
# and so deploy script exits (no error)
if [ "$(git diff --quiet --exit-code --cached; echo $?)" -eq 0 ]; then
  echo 'DEPLOY SCRIPT: No changes staged, and so exiting gracefully...'
  exit 0
fi

# Script only gets here if something to commit.
# VVVVVV

# Get commit message from install profile repo
COMMIT_MSG=`git --git-dir=$WORKSPACE/profile/.git log --oneline --max-count=1`

git commit --message="Profile repo commit $COMMIT_MSG"

# TODO: Remove hardcoded branch?
#git push origin develop

#echo "Waiting for push to deploy..." && sleep 5
# Use drush alias in repo so accessible to developers
#alias drush='drush --yes --alias-path=$WORKSPACE/profile/tmp/scripts'
#drush @dev updatedb
#drush @dev fra
#drush @dev cc all

# Done
