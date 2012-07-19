core = 7.x
api = 2

projects[drupal][version] = 7.14
; Allows inheritable install profiles: http://drupal.org/node/1356276#comment-6240570
projects[drupal][patch][] = http://drupal.org/files/1356276-base-profile-do-not-test.patch
