+++
title = "NixOS important commands"
author = ["Ben Mezger"]
date = 2025-02-02T13:08:00+01:00
slug = "nixos_important_commands"
tags = ["nixos", "tools", "software"]
type = "notes"
draft = false
bookCollapseSection = true
+++

After I distro hopped from Archlinux to NixOS, I've been having to learn the Nix ecosystem and package management commands. I've found the migration from Archlinux to NixOS OK, but I am still struggling remembering some important Nix commands.


## Updating packages {#updating-packages}

`sudo nix-channel --update -vv` to update to the latest nix channel. This will essentially pull `nixos-unstable` and `nixpkgs-unstable`.

`nix flake update` Will update my `flake.lock` file with the latest version.


## Rebuilding machine {#rebuilding-machine}

`sudo nixos-rebuild switch --flake /home/seds/workspace/dotfiles/.#default` rebuilds and applies latest changes/updates.


## Diffing builds {#diffing-builds}

`nvd diff /run/current-system result` will diff the curren system with the recent build result. Handy to keep track what changed between rebuilds.


## List generations {#list-generations}

`nix-env --list-generations` will list all existing builds.


## Garbage collect generations {#garbage-collect-generations}

`nix-collect-garbage -d` will garbage collect old generations.


## Start a shell with a specific package {#start-a-shell-with-a-specific-package}

`nix-shell -p <package>` will start a shell with `<package>` installed.


## Run a custom `nix-shell` {#run-a-custom-nix-shell}

`nix-shell python-poetry.nix --command zsh` will execute python-poetry.nix shell and drop you into a `zsh` shell.
