<!-- # vi: set textwidth=100 : -->
<!-- NOTE: Markdown notation can't span mulitple lines in Jenkins. -->
<!-- NOTE: Don't include dollar symbol in file or build will fail. -->
Summary
-------

This job will be triggered on every commit to the develop branch on GitHub, rebuilding the site.

### Notes

  - N/A

Complete Build Process
----------------------

How the jenkins build currently operates:

* Jenkins polls the repo on a schedule, but also has a [special mechanism to listen for push
  notifications][jenkins-push-docs] from GitHub, which force it to immediately poll for changes.
* Jenkins clears it's workspace, clones the repo into `$WORKSPACE/profile`, and checks out the
  desired commit. By default, this is the commit at the HEAD of the "develop" branch, but not
necessarily.
* Jenkins runs the container script `tmp/scripts/jenkins-kickstart.sh` to do some intial environment
  setup and start the build script.
* Jenkins then starts rerun's 2ndlevel:build script, which runs drush make on `build-2ndlevel.make`,
  which specifies the core version and the remote destination for the same git repo, which Drush
Make goes out and fetches again in order to build. This script also rewrites the "revision" key of
the profile it's fetching, so it will build the specific commit we want, even if it doesn't happen
to be the head of "develop" branch.
* This rerun script completes the build of the full site into `$WORKSPACE/build` and then appends
  `settings.php` snippets from `tmp/snippets` and appends a few required lines to `.htaccess`.
* The job will then set this build description to the contents of `tmp/docs/build-description.md`.

<!-- Links -->
   [jenkins-push-docs]: https://wiki.jenkins-ci.org/display/JENKINS/Git+plugin#GitPlugin-Pushnotificationfromrepository
