2nd Level Deep
==============

2nd Level Deep is a high-performance base install profile intended to be
run using the [Inception continuous integration stack][inception-about].
It is intended to be used to build sites that will run on environments
with:

  - Varnish
  - Memcache
  - APC

This module makes use of a layout derived from that used for [packaging
Drupal.org distros][drush-make-distros], with some additional features.

To Build
--------

*See `tmp/docs/scripting-howto.md` for explanation of how we're using the
Rerun framework for bash scripting.*

To build the site, we'll need to run a few commands to prepare the shell
session. We're not setting anything permanent, and these will only be in
effect for the current shell session:

    $ export RERUN_MODULES=`readlink -f tmp/scripts/rerun-modules`
    $ export PATH=$PATH:`readlink -f tmp/scripts/rerun`

And now that we're prepared the shell session, we can use rerun (which
we keep as a git submodule) to build the site:

    $ git submodule init && git submodule update
    $ rerun 2ndlevel:build -f build-2ndlevel.make -d /path/to/build/docroot

Notes
-----

  - It is assumed that this install profile will be used as a base for a
    separate project install profile that uses it as a dependency.
Profile inheritance is made possible by the patches in [this d.o
issue][profile-inheritance].)
  - Drush Make fails when it comes to a symlink, so can't symlink
    "stubbs" rerun module into rerun git submodule. Posted to a related
[issue in Drush queue][drush-symlink-issue].

To Do
-----

  - Convert scripts to make use of rerun framework for enhanced
    modularization.
  - Test rerun build script.
  - Allow relative paths in rerun build script.
  - Sanitize and include deploy script.
  - Sanitize and include Acquia drush alias.

<!-- Links -->
   [inception-about]:      http://github.com/myplanetdigital/inception
   [drush-make-distros]:   http://drupal.org/node/1476014
   [profile-inheritance]:  http://drupal.org/node/1356276
   [drush-symlink-issue]:  http://drupal.org/node/1300162
