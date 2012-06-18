#!/bin/bash

# USAGE
# Run this script as given.
#
# $ bash build-dev.sh [ /fullpath/to/project.make ] [ /fullpath/to/build/project ]
#
# (Default paths are for Vagrant VM.)

# Bail if non-zero exit code
set -e

PROJECT=2ndlevel

# Set from args
BUILD_FILE="$1"
BUILD_DEST="$2"

# Assume vagrant VM defaults if neither ENV variables nor args set
if [ -z "$BUILD_FILE" ]; then
  BUILD_FILE="/vagrant/data/make/${PROJECT}/build-${PROJECT}.local.make"
fi

if [ -z "$BUILD_DEST" ]; then
  BUILD_DEST="/mnt/www/html/${PROJECT}"
fi

# Drush make the site structure
drush make ${BUILD_FILE} ${BUILD_DEST} \
  --working-copy \
  --prepare-install \
  --yes

chmod u+w ${BUILD_DEST}/sites/default/settings.php

echo "Appending settings.php snippets..."
for f in ${BUILD_DEST}/profiles/${PROJECT}/tmp/snippets/*.settings.php
do
  # Concatenate newline and snippet, then append to settings.php
  echo "" | cat - $f | tee -a ${BUILD_DEST}/sites/default/settings.php > /dev/null
done

chmod u-w ${BUILD_DEST}/sites/default/settings.php
