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

exit $?

# Done
