+++
title = "Automating and testing dotfiles"
author = ["Ben Mezger"]
date = 2020-08-09T13:06:00-03:00
aliases = ["/posts/automating-and-testing-dotfiles/"]
slug = "automating-and-testing-dotfiles"
tags = ["dotfiles", "chezmoi", "testing"]
type = "notes"
draft = false
bookCollapseSection = true
summary = """
I run multiple Archlinux machines at home and an OSX machine for work, so I need
to keep my system configuration in sync. This is how I do it. 
"""
+++

-   Related pages
    -   [Chezmoi and Emacs]({{<relref "2021-09-11--22-48-50Z--chezmoi_and_emacs.md#" >}})

---

I run multiple Archlinux machines at home and an OSX machine for work, so I need
to keep my system configuration in sync. I have a lot of applications tinkered
for my workflow — I don't want to switch computers and have to reconfigure
something every time I change in another machine. `stow` or a `bash` script
could allow us to manage files, but they are limited when a specific
non-scripting configuration requires different settings for a specific machine.
For example, my [Alacritty](https://github.com/alacritty/alacritty) requires different settings for OSX and Linux.

I ~~solved~~ this issue by keeping multiple branches for multiple machines, but
that sucked when I updated a configuration and I needed to sync with my main
branch (Linux). Handling merge conflicts or cherry-picking commits was tiring.
Eventually, after trying out `stow` for years and bash scripts, I came up with a
neat workflow


## Chezmoi to the rescue {#chezmoi-to-the-rescue}

[`Chezmoi`](https://www.chezmoi.io/) solved the branching issue as it allows me to handle multiple
configurations for different machines, by using [templates](https://www.chezmoi.io/docs/how-to/#use-templates-to-manage-files-that-vary-from-machine-to-machine) of non-scripting
configurations for inserting context before copying the file. This solves the
headaches with merge conflicts and having to maintain multiple branches. I now
need one branch for keeping my files and let Chezmoi handle the configuration
context and changes when required.


## Handling installation with Ansible {#handling-installation-with-ansible}

Yet, I still have the dependency problem when reinstalling my operating system,
I almost always remember the applications I use, but not always all their
non-required dependencies, also, as I keep multiple OSes, some program differ.
Keeping a bash script in my dotfiles could solve this, but that would require
some time to maintain an installation script for each OS.

I choose [Ansible](https://www.ansible.com/) to handle my dependency installation. I keep 4 Ansible roles,
`osx` for anything related to `osx` installation, `archlinux` for arch related
stuff, `linux` for common Linux commands and `common`, shared between `osx` and
`archlinux` (it takes care of cloning external repositories, applying Chezmoi,
etc).

This allows me to easily install my configuration in a new machine and update
any new dependency I added to my toolkit.


## Continuous Integration {#continuous-integration}

I mentioned before that I am working more from OSX due to my job, so I tend to
miss Archlinux package updates/removals, and I always end up having to tinker my
Archlinux Ansible roles with the new packages or configuration when they change,
again, tiring. I decided to install my dotfiles on a CI, using [Github Workflow](https://github.com/benmezger/dotfiles/actions).
My current Github workflow runs 2 jobs, one for Archlinux (running on Ubuntu
with Docker) and another with MacOS. Both runs Ansible, installs all
dependencies, does some system checks, and finally caches the result.

This allows me to keep up with Archlinux/OSX updates a bit faster and making
sure my Ansible is fully functional — if one of the CI fail, something happened
with the dependencies or my configuration.


## Going down the hole {#going-down-the-hole}

With this dotfile structure, I can easily write test scripts for asserting if
files were correctly copied, packages installed, etc. For example, I could write
a Python script which asserts if files are correctly in place, I could then set
this script to run after Ansible did it's job.

```python
import pathlib
import os
import platform

HOME = pathlib.Path(os.getenv("HOME", ".")).absolute()

def osx_verify_copied_files(home: str = HOME,
                            required=(".zshrc", ".zshenv")):
    for f in required:
        print(f"Checking if {HOME.joinpath(f)} exists")
        assert HOME.joinpath(f).exists() == True, "{f} does not exist"

def osx_verify_hostname(hostname):
    print(f"Verifying if hostname '{hostname}' is set")
    assert platform.node() == hostname, "Hostname does not match"

osx_verify_copied_files()
osx_verify_hostname("benmezger-ckl.local")
```


## Emacs org mode {#emacs-org-mode}

I live in Emacs, this blog is written in [Org mode](https://orgmode.org/) and [Hugo](https://gohugo.io/), my snippets are
stored in an org file and my code is written in Emacs. To ease my life, I
decided to keep a [COMMAND.org](https://github.com/benmezger/dotfiles/blob/main/COMMANDS.org) file with general commands I might need when
tinkering with my dotfiles. Org mode supports literate programming, so keeping a
`COMMAND.org` file allows me to execute the commands in-buffer. I simply `C-c
C-c` in the snippet and let org mode make it happen. This is nice when I am
tinkering my dotfiles and I need to apply changes with Chezmoi, for example.


## Conclusion {#conclusion}

System configuration is important for a stable workflow, as we don't want to
change much when switching machines, Ansible allows us to keep multiple
installations up to date and Chezmoi allows handling these configurations file
properly. Keeping your dotfiles in a CI sounds overwhelming, however, it does
guarantee your installation scripts are fully functional against multiple OSes
and you will know when something bad happened.

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