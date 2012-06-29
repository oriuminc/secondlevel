2nd Level Deep
==============

2nd Level Deep is a high-performance base install profile intended to be
run using the [Inception continuous integration stack][inception-about].
It is intended to be used to build sites that will run on environments
with:

  - Varnish
  - Memcache
  - APC

This profile uses a layout derived from that of [packaging Drupal.org
distros][drush-make-distros], with some additional features.  The
rationale behind this is that by laying out our projects according to
these guidelines, there's less to document, and we also learn how to
package package distros for drupal.org in the future.

Layout
------

    +-modules/
    | +-contrib/  (gitignored - all contrib modules should go here via makefile)
    | +-custom/   (custom modules for the site)
    | +-features/ (all feature modules)
    +-themes/
    | +-contrib/  (gitignored - any contrib themes should go here via makefile)
    | +-custom/   (custom theme for the site)
    +-libraries/  (gitignored - generated via makefile)
    +-tmp/        (for things that don't fit in standard install profile structure)
      +-docs/     (all project-related docs)
      +-scripts/  (all scripts related to project)
      +-snippets/ (settings.php snippets)
      +-tests/    (tests and test data)

*The `tmp/` directory is intended to be removed before deploying to our
cloud host.*

- If you'd like any code to be appended to `settings.php`, simply add a
  snippet as `tmp/snippets/mysnippetname.settings.php`. These snippets
  will be appended in alphabetical order during the build.

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

Known Issues
------------

  - On some systems, Drush Make fails to run on the "file" `/dev/stdin`.
    We can get around this by running `drush make php://stdin /path/to/build`.

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
   [php-drush-bug]:        https://gist.github.com/3014293
