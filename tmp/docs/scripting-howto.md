Scripting
=========

To help with modularization, we are using the [Rerun][rerun-readme].

> Rerun is a lightweight tool building framework useful to those
> implementing management procedure with shell scripts.

Rerun helps with creating properly documented options, commands, modules
(groups of related commands), and keeps all the elements separated into
distinct files, while makes them simple to remix between projects.

In a meta sort of way, Rerun comes with a sample module called "stubbs"
that is responsible for creating skeletons for any new
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

<!-- Links -->
   [rerun-readme]: https://github.com/dtolabs/rerun#readme
   [rerun-layout]: https://github.com/dtolabs/rerun/blob/master/README.md#layout
