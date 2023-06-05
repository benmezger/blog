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

```nil
System:
  Kernel: 5.16.5-arch1-1 x86_64 bits: 64 compiler: gcc v: 11.1.0 Desktop: Qtile 0.20.0
    Distro: Arch Linux
Machine:
  Type: Laptop System: Dell product: XPS 15 9510 v: N/A serial: <superuser required>
  Mobo: Dell model: 0C6CP1 v: A00 serial: <superuser required> UEFI: Dell v: 1.7.0
    date: 12/09/2021
Battery:
  ID-1: BAT0 charge: 6.4 Wh (8.1%) condition: 79.2/84.3 Wh (94.0%) volts: 11.7 min: 11.4
    model: BYD DELL M59JH1A status: Charging
CPU:
  Info: 8-core model: 11th Gen Intel Core i9-11900H bits: 64 type: MT MCP arch: Tiger Lake rev: 1
    cache: L1: 640 KiB L2: 10 MiB L3: 24 MiB
  Speed (MHz): avg: 930 high: 1240 min/max: 800/4800:4900 cores: 1: 970 2: 917 3: 801 4: 818
    5: 801 6: 1221 7: 800 8: 1086 9: 841 10: 800 11: 791 12: 801 13: 1240 14: 840 15: 1199 16: 969
    bogomips: 79888
  Flags: avx avx2 ht lm nx pae sse sse2 sse3 sse4_1 sse4_2 ssse3 vmx
Graphics:
  Device-1: Intel TigerLake-H GT1 [UHD Graphics] vendor: Dell driver: i915 v: kernel
    bus-ID: 0000:00:02.0
  Device-2: NVIDIA GA107M [GeForce RTX 3050 Ti Mobile] vendor: Dell driver: nouveau v: kernel
    bus-ID: 0000:01:00.0
  Device-3: Microdia Integrated_Webcam_HD type: USB driver: uvcvideo bus-ID: 3-11:5
  Display: x11 server: X.Org 1.21.1.3 driver: loaded: nouveau
    note: n/a (using device driver) - try sudo/root unloaded: modesetting resolution: 3840x2400~60Hz
  OpenGL: renderer: Mesa Intel UHD Graphics (TGL GT1) v: 4.6 Mesa 21.3.5 direct render: Yes
Audio:
  Device-1: Intel Tiger Lake-H HD Audio vendor: Dell driver: snd_hda_intel v: kernel
    bus-ID: 0000:00:1f.3
  Device-2: UC02 type: USB driver: hid-generic,snd-usb-audio,usbhid bus-ID: 3-4.2.1.3:9
  Sound Server-1: ALSA v: k5.16.5-arch1-1 running: yes
  Sound Server-2: JACK v: 1.9.20 running: no
  Sound Server-3: PulseAudio v: 15.0 running: no
  Sound Server-4: PipeWire v: 0.3.45 running: yes
Network:
  Device-1: Intel Tiger Lake PCH CNVi WiFi vendor: Rivet Networks driver: iwlwifi v: kernel
    bus-ID: 0000:00:14.3
  IF: wlan0 state: down mac: <filter>
  Device-2: ASIX AX88179 Gigabit Ethernet type: USB driver: ax88179_178a bus-ID: 2-4.1:3
  IF: enp0s13f0u4u1 state: up speed: 1000 Mbps duplex: full mac: <filter>
Bluetooth:
  Device-1: Intel AX201 Bluetooth type: USB driver: btusb v: 0.8 bus-ID: 3-14:7
  Report: rfkill ID: hci0 rfk-id: 1 state: up address: see --recommends
RAID:
  Hardware-1: Intel Volume Management Device NVMe RAID Controller driver: vmd v: 0.6
    bus-ID: 0000:00:0e.0
Drives:
  Local Storage: total: 968.19 GiB used: 327.43 GiB (33.8%)
  ID-1: /dev/nvme0n1 vendor: Samsung model: PM9A1 NVMe 1024GB size: 953.87 GiB temp: 43.9 C
  ID-2: /dev/sda type: USB vendor: SanDisk model: Cruzer Fit size: 14.32 GiB
Partition:
  ID-1: / size: 434.62 GiB used: 20.08 GiB (4.6%) fs: ext4 dev: /dev/dm-3 mapped: vg0-root
  ID-2: /boot size: 1006.7 MiB used: 484.5 MiB (48.1%) fs: ext2 dev: /dev/nvme0n1p2
  ID-3: /boot/efi size: 212.7 MiB used: 39.2 MiB (18.4%) fs: vfat dev: /dev/nvme0n1p1
  ID-4: /home size: 491.08 GiB used: 306.84 GiB (62.5%) fs: ext4 dev: /dev/dm-2 mapped: vg0-home
Swap:
  ID-1: swap-1 type: partition size: 10 GiB used: 0 KiB (0.0%) dev: /dev/dm-1 mapped: vg0-swap
Sensors:
  System Temperatures: cpu: 46.0 C mobo: N/A
  Fan Speeds (RPM): N/A
Info:
  Processes: 384 Uptime: 2m Memory: 62.54 GiB used: 5.37 GiB (8.6%) Init: systemd Compilers:
  gcc: 11.1.0 clang: 13.0.0 Packages: 1187 Client: Unknown Client: emacs-27.2 inxi: 3.3.12
```

```shell
lspci
```

```nil
0000:00:00.0 Host bridge: Intel Corporation 11th Gen Core Processor Host Bridge/DRAM Registers (rev 05)
0000:00:01.0 PCI bridge: Intel Corporation 11th Gen Core Processor PCIe Controller #1 (rev 05)
0000:00:02.0 VGA compatible controller: Intel Corporation TigerLake-H GT1 [UHD Graphics] (rev 01)
0000:00:04.0 Signal processing controller: Intel Corporation TigerLake-LP Dynamic Tuning Processor Participant (rev 05)
0000:00:07.0 PCI bridge: Intel Corporation Tiger Lake-H Thunderbolt 4 PCI Express Root Port #2 (rev 05)
0000:00:07.3 PCI bridge: Intel Corporation Tiger Lake-H Thunderbolt 4 PCI Express Root Port #3 (rev 05)
0000:00:0a.0 Signal processing controller: Intel Corporation Tigerlake Telemetry Aggregator Driver (rev 01)
0000:00:0d.0 USB controller: Intel Corporation Tiger Lake-H Thunderbolt 4 USB Controller (rev 05)
0000:00:0d.3 USB controller: Intel Corporation Tiger Lake-H Thunderbolt 4 NHI #1 (rev 05)
0000:00:0e.0 RAID bus controller: Intel Corporation Volume Management Device NVMe RAID Controller
0000:00:12.0 Serial controller: Intel Corporation Device 43fc (rev 11)
0000:00:14.0 USB controller: Intel Corporation Tiger Lake-H USB 3.2 Gen 2x1 xHCI Host Controller (rev 11)
0000:00:14.2 RAM memory: Intel Corporation Tiger Lake-H Shared SRAM (rev 11)
0000:00:14.3 Network controller: Intel Corporation Tiger Lake PCH CNVi WiFi (rev 11)
0000:00:15.0 Serial bus controller: Intel Corporation Tiger Lake-H Serial IO I2C Controller #0 (rev 11)
0000:00:15.1 Serial bus controller: Intel Corporation Device 43e9 (rev 11)
0000:00:16.0 Communication controller: Intel Corporation Tiger Lake-H Management Engine Interface (rev 11)
0000:00:1c.0 PCI bridge: Intel Corporation Device 43be (rev 11)
0000:00:1f.0 ISA bridge: Intel Corporation Device 4389 (rev 11)
0000:00:1f.3 Audio device: Intel Corporation Tiger Lake-H HD Audio Controller (rev 11)
0000:00:1f.4 SMBus: Intel Corporation Tiger Lake-H SMBus Controller (rev 11)
0000:00:1f.5 Serial bus controller: Intel Corporation Tiger Lake-H SPI Controller (rev 11)
0000:01:00.0 3D controller: NVIDIA Corporation GA107M [GeForce RTX 3050 Ti Mobile] (rev a1)
0000:74:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS5260 PCI Express Card Reader (rev 01)
10000:e0:01.0 System peripheral: Intel Corporation Device 09ab
10000:e0:01.2 PCI bridge: Intel Corporation Device 9a07 (rev 05)
10000:e1:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller PM9A1/PM9A3/980PRO
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

**Update <span class="timestamp-wrapper"><span class="timestamp">&lt;2023-06-05 Mon&gt;</span></span>**:
Turns out that from time-to-time the touchpad started lagging. This is a known
[issue](https://wiki.archlinux.org/title/Dell%5FXPS%5F15%5F(9510)#Touchpad%5Flag) and I've fixed it by following [this](https://gitlab.freedesktop.org/libinput/libinput/-/issues/618#note%5F1379374) guide to downgrade the touchpad
firmware to `0x000c`.

I am keeping the firmware here as a back up.

[Touchpad firmware 0c for XPS 9510](/files/FWUpdate_v1.0.3.0_DellMUP_Fv0C_Trial_04_ZPE.zip) <br />
_sha256: 11704b552a1e4cf45ab8d48db6da00e50df418d8cdffd261fdd710709ca13e91_


## Fingerprint {#fingerprint}

I haven't tried to get it working yet, but I don't think it will work from what I've seen on the Internet.


## Hibernate/suspend {#hibernate-suspend}

~~I haven't managed to get it working. It seems it needs some configuration in the~~
~~BIOS, but regardless, it did not work.~~

**Update <span class="timestamp-wrapper"><span class="timestamp">&lt;2022-06-17 Fri&gt;</span></span>**:
Turns out I needed to enable the `resume` hook in my `initramfs`, append a
line to my grub configuration and systemd's sleep configuration [[gist](https://gist.github.com/benmezger/fd5a424bb4a2a8649107989dd62dbea0)].

I will keep this updated as time goes by.