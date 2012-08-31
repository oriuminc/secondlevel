Drush Makefile Conventions
==========================

This document will attempt to codify some of the informal conventions
that teams have adopted. Everyone is encouraged to make changes and
engage in GitHub issue queue discussion on anything that isn't fully
clear.

Keep it concise
---------------

- Quotes on array values are just extra noise in the makefile, so leave
  them out.

        ; WTF
        projects[views][version] = "3.5"
        projects[views][patch][] = "http://drupal.org/files/myfix.patch"

        ; FTW
        projects[views][version] = 3.5
        projects[views][patch][] = http://drupal.org/files/myfix.patch

- Project type is not required when downloading tarballs directly from
  Drupal.org (only for Git repos from Drupal.org or other sources).

        ; WTF
        projects[views][type] = module
        projects[views][version] = 3.5

        ; FTW
        projects[views][version] = 3.5

- No need to specify the `directory_name` of a library, as it will just
  take it from the project name in the array.

        ; WTF
        libraries[jquery.imgareaselect][download][type] = file
        libraries[jquery.imgareaselect][download][url] = https://github.com/downloads/myplanetdigital/imgareaselect/jquery.imgareaselect-0.9.9.tar.gz
        libraries[jquery.imgareaselect][directory_name] = jquery.imgareaselect

        ; FTW
        libraries[jquery.imgareaselect][download][type] = file
        libraries[jquery.imgareaselect][download][url] = https://github.com/downloads/myplanetdigital/imgareaselect/jquery.imgareaselect-0.9.9.tar.gz

- Use the `defaults[projects]` array to set the `subdir` option so
  you're not listing it for each module. (It's important to note that
this requires Drush 5.6+)

        ; WTF
        projects[views][subdir] = contrib
        projects[views][version] = 3.5

        projects[rules][subdir] = contrib
        projects[rules][version] = 2.2

        ; FTW
        defaults[projects][subdir] = contrib

        projects[views][version] = 3.5

        projects[rules][version] = 2.2

Be transparent
--------------

- When applying a patch, add a quick comment about the reason for
  application, and link to the appropriate issue comment. Include the
specific comment when this particular patch was supplied, as there can
be multiple patches per issue. While it's good to include an optional
story number, the description should stand on its own.

        ; WTF
        projects[views][version] = 3.5
        ; http://drupal.org/node/1723810#comment-6337820
        projects[views][patch][] = http://drupal.org/files/views-show-langauge-neutral-1723810-2.patch

        ; WTF
        projects[views][version] = 3.5
        ; Patch for story 123.
        projects[views][patch][] = http://drupal.org/files/views-show-langauge-neutral-1723810-2.patch

        ; FTW
        projects[views][version] = 3.5
        ; 123 - Fix language field when 'und': http://drupal.org/node/1723810#comment-6337820
        projects[views][patch][] = http://drupal.org/files/views-show-langauge-neutral-1723810-2.patch

- Include extra version keys at the end of an entry to make it clear
  where otherwise unclear data might be coming from. Drush Make should
ignore *less specific* keys. For example, while a project entry might
otherwise "pin" a project, a git commit won't easily reveal that a
commit is from the 7.x-3.x branch (rather than perhaps 7.x-2.x), nor
that it's subsequent to 3.5 rather than 3.4.

        ; WTF
        projects[views][type] = module
        projects[views][download][type] = git
        projects[views][download][url] = http://git.drupal.org/project/views.git
        projects[views][download][revision] = 84890125a03a8177

        ; FTW
        projects[views][type] = module
        projects[views][download][type] = git
        projects[views][download][url] = http://git.drupal.org/project/views.git
        projects[views][download][revision] = 84890125a03a8177
        projects[views][version] = 3.5-dev

Be reproducible
---------------

- Always pin makefile entries to be unchanging, including:

  - Drupal.org projects

            ; WTF
            projects[views][version] = 3.x-dev

  - External file sources (libraries, etc.)

            ; WTF
            libraries[jquery.cycle][download][type] = file
            libraries[jquery.cycle][download][url] = http://malsup.github.com/jquery.cycle.all.js

            ; WTF
            libraries[jquery.cycle][download][type] = file
            libraries[jquery.cycle][download][url] = https://raw.github.com/malsup/cycle/master/jquery.cycle.all.js

            ; FTW
            libraries[jquery.cycle][download][type] = file
            ; v2.9999.5 (since not obvious from commit hash)
            libraries[jquery.cycle][download][url] = https://raw.github.com/malsup/cycle/b1dc72bc/jquery.cycle.all.js

  - Git repos

            ; WTF
            projects[views][type] = module
            projects[views][download][type] = git
            projects[views][download][url] = http://git.drupal.org/project/views.git
            projects[views][download][branch] = 7.x-3.x

- When referencing others' projects on GitHub, consider forking the project to
a github account in your possession, and pointing the makefile to that repo.
This is especially important for repos who's permanence is less guaranteed.

        ; WTF
        libraries[jquery.cycle][download][type] = file
        ; v2.9999.5 (since not obvious from commit hash)
        libraries[jquery.cycle][download][url] = https://raw.github.com/malsup/cycle/b1dc72bc/jquery.cycle.all.js

        ; FTW
        libraries[jquery.cycle][download][type] = file
        ; v2.9999.5 (since not obvious from commit hash)
        libraries[jquery.cycle][download][url] = https://raw.github.com/myplanetdigital/cycle/b1dc72bc/jquery.cycle.all.js

- Reproducibility is the utmost important tenet. In other words
  everything in the Makefile should be pinned so that the site built
today and the site built next year will be the same, so long as the same
commit is used.

- In close second (after reproducibility), is the idea that code used on
  any site be as conservatively divergent from contrib code as possible.
This means that we only want to diverge from contrib code with
specifically needed patches. For example, while we might be tempted to use a mid-release commit hash to make a
specific patch from the issue queues apply cleanly, we would instead
apply that patch to an actual **tagged project release**. If it does not
apply cleanly, we would reroll that patch against the tagged release,
and re-post it to the queues. [DOC THIS PROCESS]

        ; WTF
        projects[views][type] = modules
        projects[views][download][type] = git
        projects[views][download][url] = http://git.drupal.org/project/views.git
        projects[views][download][revision] = 84890125a03a8177
        projects[views][patch][] = http://drupal.org/files/views-show-langauge-neutral-1723810-2.patch

        ; FTW
        projects[views][version] = 3.5
        projects[views][patch][] = http://drupal.org/files/views-show-langauge-neutral-1723810-2.patch

        ; FTW
        projects[views][version] = 3.5
        projects[views][patch][] = http://drupal.org/files/views-show-langauge-neutral-1723810-7_reroll-3.5.patch
        
