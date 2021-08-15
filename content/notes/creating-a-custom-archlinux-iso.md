+++
title = "Creating a custom Archlinux ISO"
author = ["Ben Mezger"]
date = 2020-04-23T00:00:00-03:00
publishDate = 2020-08-28
tags = ["dotfiles", "config", "archlinux"]
draft = true
+++

Here I am again, trying to make my life easier for the future with my [dotfiles](https://github.com/benmezger/dotfiles.git)
and system environment. Yesterday I reinstalled my Archlinux, ran my Ansible
against my user and all worked perfectly fine, but I still had to do some basic
Linux installation beforehand, like setting my `hostname`, creating my user,
etc.

I&rsquo;ve been looking into [archiso](https://wiki.archlinux.org/index.php/archiso) for some time now, and after reinstalling
Archlinux, I started digging into it.
`archiso` has two main profiles you can choose from, _releng_ for the official
monthly ISO install or _baseline_ for a minimalistic configuration, which
includes the bare minimum packages required to boot the live environment. I
choose the _releng_ profile as a starting point.

You will work on the `airootfs/etc` directory, where `airootfs/` basically holds
you future `/` (root) directory.

I began updating `packages.x86_64` with the packages I needed to boot and use my
system, manually created my user by modifying `/etc/passwd`, `/etc/group`,
`/etc/gshadow` and `/etc/shadow`. Ideally you would want to take a look at your
current system configuration files and basically copy these to `airootfs/etc`
accordingly.

`archiso` contains a customization bash script which gets ran after the initial
creation for the `ISO`, this is located at
`airootfs/root/customize_airootfs.sh`. I created a `/airootfs/home/seds`
directory for my user home directory, so when `customize_airootfs.sh` gets run,
it `cd's` to my home directory and initializes my dotfiles with [Chezmoi](https://chezmoi.io).

_For some reason, `customize_airootfs.sh` will be deprecated, so I am not sure
what the alternative will be._

Now, creating the `ISO` image out of our base directory is easy, run:

```shell
sudo mkarchiso -v -w archiso-out -o out <base-directory>
```

This will download and install the packages specified in `airootfs`, create the
kernel and the init images and apply any customizations, it will then create the
`ISO` in the `out/` directory and keep any cached files in `archiso-out`.

Finally, you can test out the image with Qemu.

```shell
run_archiso -i ./out/archlinux-yyyy.mm.dd-x86_64.iso
```

If everything looks good, burn the `ISO` to your USB stick and boot it up. Don&rsquo;t
forget you still have to handle your partitions, and make any install
modifications required by Archlinux (those you cannot really automate, or can you!?).

That&rsquo;s all for today, folks.

<style>.org-center { margin-left: auto; margin-right: auto; text-align: center; }</style>

<div class="org-center">
  <div></div>

<div
    class="github-card"
    data-github="benmezger/archiso"
    data-width="400"
    data-height="150"
    data-theme="default">
</div>
<script src="//cdn.jsdelivr.net/github-cards/latest/widget.js"></script>

</div>


## References {#references}

-   [Archiso - Archlinux Wiki](https://wiki.archlinux.org/index.php/archiso)
-   [Archiso - Gitlab](https://gitlab.archlinux.org/archlinux/archiso/-/blob/master/docs/README.build)
