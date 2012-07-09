#!/bin/bash
#
# NAME
#
#   build
#
# DESCRIPTION
#
#   Build the site from install profile.
#

# Parse the command options
[ -r $RERUN_MODULES/2ndlevel/commands/build/options.sh ] && {
  source $RERUN_MODULES/2ndlevel/commands/build/options.sh
}

# Read module function library
[ -r $RERUN_MODULES/2ndlevel/lib/functions.sh ] && {
  source $RERUN_MODULES/2ndlevel/lib/functions.sh
}

# ------------------------------
# Your implementation goes here.
# ------------------------------

set -e

# Install composer before running make, if not already installed
# (Will only work on PHP 5.3+)
drush dl composer --no

# Drush make the site structure
echo "Running Drush Make..."
cd $(dirname `readlink -f $BUILD_FILE`)
cat ${BUILD_FILE} | sed "s/^\(projects\[${PROJECT}\].*\)develop$/\1${REVISION}/" | drush make php://stdin ${BUILD_DEST} \
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

# Add snippet that allows basic auth through settings.php
tee -a ${BUILD_DEST}/.htaccess << EOH

# Required for user/password authentication on development environments.
RewriteEngine on
RewriteRule .* - [E=REMOTE_USER:%{HTTP:Authorization},L]
EOH

# Done
