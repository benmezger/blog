+++
title = "My journey in managing dotfiles"
author = ["Ben Mezger"]
date = 2025-02-02T17:22:00+01:00
slug = "my-journey-in-managing-dotfiles"
tags = ["automation", "software", "tools"]
type = "notes"
draft = false
bookCollapseSection = true
+++

-   Related pages
    -   [Automating and testing dotfiles]({{<relref "2021-09-11--23-32-04Z--automating_and_testing_dotfiles.md#" >}})
    -   [NixOS important commands]({{<relref "2025-02-02--12-08-34Z--nixos_important_commands.md#" >}})
    -   [Chezmoi and Emacs]({{<relref "2021-09-11--22-48-50Z--chezmoi_and_emacs.md#" >}})

---

One of my biggest complaints when managing my dotfiles was having to deal with
my scripts and secrets (tokens, passwords, etc.) to set up my machine. My ideal
scenario was that when I made a fresh install of my system and ran my script, I
could start working. But the reality was different. I always had to update a
script or rework something to make it compatible with the new system because
the system state was different than before.

To mitigate that, throughout the years, I looked for and tried different
approaches to solve my annoyance


## Approaches I Tried {#approaches-i-tried}

I tried multiple approaches, some successfully, some not so much.


### Bash scripts {#bash-scripts}

In the beginning, I had a Bash script that would create a symlink to my dotfiles
and install and configure packages. This was okay in the beginning, but as my
configuration and requirements grew, it became more difficult to maintain
everything.

This made it harder to manage configuration file secrets. At this point, I didn't
know how to deal with it properly, so I was manually going through the files and
adding any needed secret.


### Ansible {#ansible}

Then I migrated to [Ansible](https://github.com/ansible/ansible). I liked that approach, and I managed to replace
all (or almost all) of my Bash scripts. Although it was a little harder to
maintain, I always felt it was overkill for such a requirement.

Given this happened years ago, I don't remember all the details, but I remember I had
issues dealing with configuration secrets and different systems (i.e., Linux and
macOS).


### GNU Stow {#gnu-stow}

I switched from Ansible to [GNU Stow](https://www.gnu.org/software/stow/). Stow is a lot simpler, and it only managed
symlinks to my dotfiles. This made me bring back my Bash scripts, which I
previously replaced with Ansible.

Stow was simple, and it dealt with symlinks much better than my previous
Bash script. Still, I had issues managing configuration secrets and now the same
issues I had when maintaining my Bash scripts.


### GNU Make {#gnu-make}

Then I replaced Stow with [GNU Make](https://www.gnu.org/software/make/). I had a long Makefile that would install
dependencies, deal with package configuration, and handle my symlinks. Although
compact, I didn't like this approach after using it a few times, and it still
required constant maintenance.


### Each machine has a Git branch {#each-machine-has-a-git-branch}

With all the approaches I experienced, I almost always had to maintain a
different branch for a host to maintain non-scriptable configuration. For
example, with Alacritty, I use different configurations if it's macOS or Linux,
and since it's not scriptable, I had to duplicate the configuration to make it
work.

At some point, this was becoming a mess. I had to maintain two copies of the
same configuration and make sure they were synced once I updated the theme.


### Challenges {#challenges}

Each of these approaches had its own strengths, but they also introduced
different challenges:

-   If I switched from Arch Linux to Debian, I had to update all my scripts or my

Ansible configuration to make it work.

-   Needed to install some dependencies before I could configure my system.
-   While still on the old system, I would sometimes install a package, configure
    it, and forget to update my install scripts.
-   Maintaining my repository (or ies) became a burden at times.
-   Managing secrets was always difficult. For example, I use software to manage
    my email and had to manually update API tokens and passwords in my
    configuration.
-   Maintaining duplicate files with slight differences.

{{% hint "info" %}}
_At some point, I stopped distro-hopping and settled on Arch Linux and macOS_,
_so the burden of updating my Bash scripts to different systems reduced._
{{% /hint %}}


## Chezmoi entered the room {#chezmoi-entered-the-room}

Then I discovered [Chezmoi](https://www.chezmoi.io/). Chezmoi solved many of these issues. Chezmoi can
extract passwords from my password manager and automatically apply them to my
configuration, and I can maintain a single configuration file for multiple
hosts (e.g., Linux and macOS). Chezmoi does not use symlinks; instead, it
puts a copy of the file into the location, which was particularly important
to me because some software does not work well with symlinks.

However, I still had to maintain multiple Bash scripts for different hosts, but
I was trying to make peace with that.

At one point, I tried maintaining a custom Arch Linux ISO, where I would
configure any root-level settings and have Chezmoi automatically install my
dotfiles. Unfortunately, this meant maintaining both my Bash scripts and a
second repository. Additionally, testing and ensuring everything worked out of
the box was time-consuming

{{% hint "warning" %}}
The issues I experienced with Arch Linux were not inherent to Arch itself but
rather stemmed from the nature of a non-reproducible system. I would have faced
these issues in any non-reproducible Linux distribution.
{{% /hint %}}


## Discovering NixOS {#discovering-nixos}

Then I read about NixOS 🧐.
Then I switched from Archlinux to NixOS 🫨.
Then I got happier 🙂.

Now, instead of relying on Bash scripts, I can declaratively build my system. I
can manage both my home and system configurations, separate root and user
applications, and easily recover from mistakes. I am sure once I have to do a
reinstall, things will work exactly how it worked on my previous system.

{{% hint "info" %}}
I had easy access to recovery on Arch Linux using `btrfs` and snapshots, but
that still required maintaining my Bash scripts to configure everything.
{{% /hint %}}

NixOS also made me realize I could configure parts of my system that I had never
considered before, such as [unlocking LUKS via SSH](https://mynixos.com/nixpkgs/options/boot.initrd.network.ssh). I started using
`home-manager` to manage my home directory alongside Chezmoi. Nix made testing
easier—I can now spin up a VM with my configuration to ensure everything works
before reinstalling.

```bash
$ nixos-rebuild build-vm-with-bootloader --flake .#default
```

I can now keep my NixOS configuration inside my `dotfiles` repository and manage
everything from a single repository.

I did consider replacing Chezmoi with Nix let Nix manage my dotfiles, but I
still prefer to use Chezmoi to make my application configuration separate from
Nix. This makes it easier to migrate to another system or have my dotfiles in
non-Nix systems.


## Nix on MacOS {#nix-on-macos}

I can't talk much about it here. I tried configuring Nix on macOS and having my
configuration installed. It partially worked, but I was having too many issues
with it. So for now, I rely solely on getting Homebrew manually installed,
applying my configuration with Chezmoi, and installing dependencies through my
`Brewfile`.

This is yet another reason to not replace Chezmoi with Nix.


## Last words {#last-words}

Chezmoi is now an inseparable part of my system journey, and although Nix is
still yet to become an inseparable part of this journey, I think its getting
closer.

<style>.org-center { margin-left: auto; margin-right: auto; text-align: center; }</style>

<div class="org-center">
  <div></div>

<div
    class="github-card"
    data-github="benmezger/dotfiles"
    data-width="400"
    data-height="150"
    data-theme="default">
</div>
<script src="//cdn.jsdelivr.net/github-cards/latest/widget.js"></script>

</div>
