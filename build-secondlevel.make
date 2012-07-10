core = 7.x
api = 2

; Include the definition for how to build/patch Drupal core directly
includes[] = drupal-org-core.make

projects[secondlevel][type] = profile
projects[secondlevel][download][type] = git
projects[secondlevel][download][url] = https://github.com/myplanetdigital/2ndleveldeep.git
projects[secondlevel][download][revision] = develop
