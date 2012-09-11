;
; @file
; A makefile to build a new site with this installation profile when the new
; site's webroot is elsewhere.
;

core = 7.x
api = 2

; Downloads core.
includes[] = drupal-org-core.make

; Downloads this installation profile into the new site.
projects[secondlevel][type] = profile
projects[secondlevel][download][type] = git
projects[secondlevel][download][url] = https://github.com/myplanetdigital/2ndleveldeep.git
projects[secondlevel][download][revision] = develop
