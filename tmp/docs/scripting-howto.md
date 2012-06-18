Scripting
=========

To help with modularization, we are using the [Rerun][rerun-readme].

> Rerun is a lightweight tool building framework useful to those
> implementing management procedure with shell scripts.

Rerun helps with creating options, commands,modules (groups of
related commands), and also docs, and keeps all the elements separated
into distinct files, while makes them simple to remix between projects.

In a meta sort of way, Rerun comes with a sample module called "stubbs"
that is responsible for creating stubbs for any new
modules/commands/options.

To see how Rerun works, navigate into the `tmp/scripts/rerun` directory
and run:

    $ ./rerun -h

This will start you down the road to using Rerun.

We keep our custom rerum modules in
[`tmp/scripts/rerun-modules`][rerun-layout]. You
can most easily explore them via the CLI by navigating to `tmp/scripts`
and running

    $ RERUN_MODULES=rerun-modules ./rerun/rerun

As an explanation of how jenkins uses rerun, it performs the setup for
each job's shell session in `tmp/scripts/jenkins-setup.sh`, such as
adding the rerun directory to the path, and then setting the
RERUN_MODULES environment variable to the current directory, after which
it can run Rerun with just the `rerun` command at any time during that
shell session.

<!-- Links -->
   [rerun-readme]: https://github.com/dtolabs/rerun#readme
   [rerun-layout]: https://github.com/dtolabs/rerun/blob/master/README.md#layout
