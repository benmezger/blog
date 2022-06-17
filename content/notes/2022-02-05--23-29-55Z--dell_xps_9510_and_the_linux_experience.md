+++
title = "Dell XPS 9510 and the linux experience"
author = ["Ben Mezger"]
date = 2022-02-06T00:29:00+01:00
slug = "dell_xps_9510_and_the_linux_experience"
tags = ["linux"]
type = "notes"
draft = false
bookCollapseSection = true
+++

I've recently decided to migrate back to Linux after some years of using a
MacBook. I haven't distanced myself from Linux while using the Mac, as I
had a Thinkpad x320 by my side all the time running Archlinux.

I wanted something much more powerful than the Macbook, along with a lightweight
design and something that would last for the next five years.

I've got myself a Dell XPS, with the following specification:

```shell
inxi -Fxz --color=0
```

```shell
lspci
```

It's a powerful machine, but that's not what I am here to talk about. I
want to talk about quirks and hacks I needed to do to get the hardware
fully working.

During this writing, I am running Archlinux on a `5.16.5` kernel.


## Wi-Fi {#wi-fi}

Works out of the box with Archlinux


## GPU {#gpu}


### Intel i915 {#intel-i915}

The Intel i915 with NVidia disabled worked out of the box with one issue.

-   Suddenly, Alacritty's window turns black, as if it's completely unresponsive.
    I've tried running with `vblank_mode` set but no luck either


### Modesetting {#modesetting}

The Modesetting driver works completely out of the box, with no quirks (at least
none found yet).


### NVidia GeForce RTX 3050 Ti Mobile {#nvidia-geforce-rtx-3050-ti-mobile}

Works out of the box with the `nvidia` driver from Archlinux's official
repository. I have tried \`bumblebee\` out, but no luck getting the hybrid (Intel
and NVidia) to work along.


## Bluetooth {#bluetooth}

Worked out of the box. I had to install `blueman` though, but nothing that you cannot find in the Archlinux wiki.


## Display {#display}

I've disabled the touch functionality of the screen, but it does work out of the
box with Xorg (haven't tested in Wayland).

Brightness works well with `xbacklight` when using the Intel driver or
`light` when using Modesetting.


## USB-C ports {#usb-c-ports}

All are working out of the box.


## Keyboard {#keyboard}

Working out of the box.


## Touchpad {#touchpad}

Works well with `synaptics`, but much better with `libinput`. You can get
`libinput-gestures` to set up a smooth gesture functionality.


## Fingerprint {#fingerprint}

I haven't tried to get it working yet, but I don't think it will work from what I've seen on the Internet.


## Hibernate/suspend {#hibernate-suspend}

~~I haven't managed to get it working. It seems it needs some configuration in the~~
~~BIOS, but regardless, it did not work.~~

_Update <span class="timestamp-wrapper"><span class="timestamp">&lt;2022-06-17 Fri&gt;</span></span>_
Turns out I needed to enable the `resume` hook in my `initramfs`, append a
line to my grub configuration and systemd's sleep configuration [[0084195](https://github.com/benmezger/etc/commit/0084195e500acb1e483fb5a6e7fea40e75a3ef3a)].

I will keep this updated as time goes by.
