+++
title = "Thoughts on Chezmoi"
author = ["Ben Mezger"]
date = 2023-05-28T19:55:00+02:00
slug = "thoughts_on_chezmoi"
tags = ["dotfiles"]
type = "notes"
draft = false
bookCollapseSection = true
+++

-   Related pages
    -   [Automating and testing dotfiles]({{< relref "2021-09-11--23-32-04Z--automating_and_testing_dotfiles.md" >}})

---

I really like to keep my dotfiles up to date, and I've been doing so for many
[years](https://github.com/benmezger/dotfiles/commit/47af536b13cca72383564f7f7edde04633c3b1cb). During the years I've progress on how I managed by dotfiles and system
dependencies. I went from manually copying the files to [Ansible](https://www.ansible.com/), then Python
[Fabric](https://www.fabfile.org/), then [GNU Stow](https://www.gnu.org/software/stow/) to manually managing with bash scripts and manual
symlinks. Some of these tools were OK, some were more complex than the others.
As my dotfiles started to grow, and as I started using multiple operating
systems in my workflow, I needed something better to handle different systems.

The problem with some configuration files is that there is no scripting or
conditions that you can make to support different systems, i.e. different binary
paths or even different binary names. Then someday on IRC someone mentioned
[Chezmoi](https://chezmoi.io).

Chezmoi had exactly what I needed, [templates](https://www.chezmoi.io/user-guide/templating/), a command line interface to manage
my files and integration with password managers. Now I just needed to update all
my configuration files to adapt Chezmoi. I was already used to process of
migration as I've done many times before. Why not another one?

As my dotfiles started to grow, the more I could take advantage of what Chezmoi
had to offer. For example, I can have multiple profiles by taking advantage of
the [template](https://github.com/benmezger/dotfiles/tree/main/.chezmoitemplates) system. In my [`chezmoi.yaml`](https://github.com/benmezger/dotfiles/blob/03bd8967f6565ce87dbd6fe92b0a3f618b4bad45/.chezmoi.yaml.tmpl#LL1C6-L1C6), I created different profiles and
based on that, I can [`chezmoiignore`](https://github.com/benmezger/dotfiles/blob/main/chezmoi/.chezmoiignore) files based on these conditions. This
allows me to install a lightweight version of my dotfiles on a remote server.

Chezmoi can also help increase performance in `zsh` or `bash` configurations,
where one can use templates to manage different operating system requirements
and include them into the main configuration depending which system it is.

<style>.org-center { margin-left: auto; margin-right: auto; text-align: center; }</style>

<div class="org-center">

<div
    class="github-card"
    data-github="benmezger/dotfiles"
    data-width="400"
    data-height="150"
    data-theme="default">
</div>
<script src="//cdn.jsdelivr.net/github-cards/latest/widget.js"></script>

</div>
