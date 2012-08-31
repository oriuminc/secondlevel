Drush Makefile Conventions
==========================

This document will attempt to codify some of the informal conventions
that teams have adopted. Everyone is encouraged to make changes and
engage in GitHub issue queue discussion on anything that isn't fully
clear.

Keep it concise
---------------

- Project type is not required when downloading tarballs directly from
  Drupal.org.

        ; WTF
        projects[views][type] = module
        projects[views][version] = 3.5

        ; FTW
        projects[views][version] = 3.5

- Quotes on values are just extra noise in the makefile, so leave them
  out.

        ; WTF
        projects[views][version] = "3.5"
        projects[views][patch][] = "http://drupal.org/files/myfix.patch"

        ; FTW
        projects[views][version] = 3.5
        projects[views][patch][] = http://drupal.org/files/myfix.patch
