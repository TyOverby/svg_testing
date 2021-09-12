# Bonsai Example App ![Bonsai Build](https://github.com/tyoverby/bonsai_example/actions/workflows/docker_test.yml/badge.svg)


This repo contains an demo application for Bonsai.

More importantly than that, it also includes reproducable steps for how to build
the dependencies.  The [`./devcontainer`](./.devcontainer) folder contains a
dockerfile which will fully prepare this repo for use, however, you may choose
to just read the file and follow the steps instead of using docker.  That said,
I do recommend using docker alongside the 
["devcontainer" workflow in VS Code](https://code.visualstudio.com/docs/remote/containers).

This example has three parts, divided up into three subdirectories:

```
├── scripts # Handy scripts for building the project
├── common  # A shared library which both the client and server link against
├── client  # The web UI, built using Bonsai and Js_of_ocaml
└── server  # The web-server and RPC server
    ├── bin # The command-line executable for the server
    └── src # A library containing all the server logic
```