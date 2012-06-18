2nd Level
=========

2nd Level is a high-performance base install profile intended to be run
using the [Inception continuous integration stack][inception-about]. It
is intended to be used to build sites that will run on environments
with:

  - Varnish
  - Memcache
  - APC

This module makes use of a layout derived from that used for [packaging
Drupal.org distros][drush-make-distros], with some additional features.

Notes
-----

  - The scripts are in the process of being converted to using the rerun
    framework. Further docs are available in `tmp/docs/scripting-howto.md`.

To Do
-----

  - Convert scripts to make use of rerun framework for enhanced
    modularization.
  - Sanitize and include deploy script.
  - Sanitize and include Acquia drush alias.

<!-- Links -->
   [inception-about]:    http://github.com/myplanetdigital/inception
   [drush-make-distros]: http://drupal.org/node/1476014
