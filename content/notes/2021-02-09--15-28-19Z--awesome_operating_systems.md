+++
title = "Awesome Operating Systems"
author = ["Ben Mezger"]
date = 2021-02-09T12:28:00
slug = "awesome_operating_systems"
tags = ["os"]
type = "notes"
draft = false
bookCollapseSection = true
+++

-   Related pages
    -   [Operating Systems]({{<relref "2020-05-31--15-29-38Z--operating_systems.md#" >}})
    -   [Computer Architecture]({{<relref "2020-05-31--16-01-33Z--computer_architecture.md#" >}})

---

Another awesome list of available Operating System. This is an ongoing list and
gets updated from time to time.


## Unix-like {#unix-like}


### Microkernel {#microkernel}

-   [Minix 3](https://www.minix3.org/): MINIX 3 is a free, open-source, operating system designed to be
    highly reliable, flexible, and secure. It is based on a tiny microkernel
    running in kernel mode with the rest of the operating system running as a
    number of isolated, protected, processes in user mode. It runs on x86 and ARM
    CPUs, is compatible with NetBSD, and runs thousands of NetBSD packages.
-   [Redox OS](https://www.redox-os.org/): Redox is a Unix-like Operating System written in Rust, aiming to
    bring the innovations of Rust to a modern microkernel and full set of
    applications.


### Monolithic {#monolithic}

-   [Linux Kernel](https://kernel.org): The Linux kernel is a free and open-source, monolithic, modular,
    multitasking, Unix-like operating system kernel. It was conceived and created
    in 1991 by Linus Torvalds for his i386-based PC, and it was soon adopted as
    the kernel for the GNU operating system.
-   [illumos](https://illumos.org/): illumos is a Unix operating system which provides next-generation
    features for downstream distributions, including advanced system debugging,
    next generation filesystem, networking, and virtualization options.
-   [SmartOS](https://docs.smartos.org/): SmartOS is a specialized Type 1 Hypervisor platform based on [illumos](https://illumos.org/).
-   [Xv6](https://pdos.csail.mit.edu/6.828/2020/xv6.html): Xv6 is a teaching operating system developed in the summer of 2006, which
    was ported to RISC-V for a new undergraduate class 6.S081.
-   [SerenityOS](https://www.serenityos.org/): The goal is a marriage between the aesthetic of late-1990s
    productivity software and the power-user accessibility of late-2000s \*nix.
-   [XFree86](https://www.xfree86.org/): Provides a client/server interface between the display hardware (those
    physical things like the mouse, keyboard, and video displays) and the desktop
    environment, (this is typically called a window manager as it deals with how X
    is displayed i.e. the overall appearance). Yet X it goes beyond that and also
    gives the infrastructure and a standardized application interface (API).


## Embedded OS {#embedded-os}


### Microkernel {#microkernel}

-   [Contiki-NG](https://github.com/contiki-ng/contiki-ng): Contiki-NG is an open-source, cross-platform operating system for
    Next-Generation IoT devices. It focuses on dependable (secure and reliable)
    low-power communication and standard protocols, such as IPv6/6LoWPAN, 6TiSCH,
    RPL, and CoAP. Contiki-NG comes with extensive documentation, tutorials, a
    roadmap, release cycle, and well-defined development flow for smooth
    integration of community contributions.
-   [FreeRTOS](https://www.freertos.org/): FreeRTOS is a real-time operating system kernel for embedded devices
    that has been ported to 35 microcontroller platforms.
-   [Riot OS](https://www.riot-os.org/): RIOT is a small operating system for networked, memory-constrained
    systems with a focus on low-power wireless Internet of Things devices.
-   [Mbed](https://os.mbed.com/): Mbed is a platform and operating system for internet-connected devices
    based on 32-bit ARM Cortex-M microcontrollers.
-   [μT-Kernel 3.0](https://github.com/tron-forum/mtkernel%5F3): Real-time OS for Small-scale Embedded Systems and IoT Edge
    nodes. It is compliant with IEEE Standard 2050-2018 and has high compatibility
    with [μT-Kernel 2.0](https://www.tron.org/download/index.php?route=product/category&path=50).
-   [Hubris](https://github.com/oxidecomputer/hubris): Hubris is a microcontroller operating environment designed for
    deeply-embedded systems with reliability requirements. Its design was
    initially proposed in RFD41, but has evolved considerably since then. Hubris
    provides preemptive multitasking, memory isolation between separately-compiled
    components, the ability to isolate crashing drivers and restart them without
    affecting the rest of the system, and flexible inter-component messaging that
    eliminates the need for most syscalls — in about 2000 lines of Rust. The
    Hubris debugger, Humility, allows us to walk up to a running system and
    inspect the interaction of all tasks, or capture a dump for offline debugging.


### Monolithic {#monolithic}

-   [Zephyr](https://zephyrproject.org/): Zephyr is a small real-time operating system[3] for connected,
    resource-constrained and embedded devices (with an emphasis on
    microcontrollers) supporting multiple architectures


### Megalithic Kernel {#megalithic-kernel}

[TinyOS](https://github.com/tinyos/tinyos-main): TinyOS is an open source, BSD-licensed operating system designed for
low-power wireless devices, such as those used in sensor networks, ubiquitous
computing, personal area networks, smart buildings, and smart meters.


## Others {#others}

-   [SmartOS](https://www.joyent.com/smartos): SmartOS is a specialized Type 1 Hypervisor platform based on illumos.
    It supports two types of virtualization: OS Virtual Machines (Zones) and
    Hardware Virtual Machines (KVM, Bhyve)
-   [CertiKOS](https://flint.cs.yale.edu/certikos/index.html): Clean-slate design with end-to-end guarantees on extensibility,
    security, and resilience. Without Zero-Day Kernel vulnerabilities.
-   [OSBlog](https://osblog.stephenmarz.com/): This tutorial will progressively build an operating system from start
    to something that you can show your friends or parents.


### Microkernel {#microkernel}

-   [Sel4](https://sel4.systems/): eL4 is a high-assurance, high-performance operating system microkernel.
    It is unique because of its comprehensive formal verification, without
    compromising performance. It is meant to be used as a trustworthy foundation
    for building safety- and security-critical systems.


### Hybrid kernel {#hybrid-kernel}

-   [ChaiOS](https://github.com/ChaiSoft/ChaiOS): Modular multi-platform hobby OS. Hybrid kernel, largely monolithic.
    Kernel C library is dynamically linked. Chai from Hebrew for "living " - "חי"


### Monolithic kernel {#monolithic-kernel}

-   [bootOS](https://github.com/nanochess/bootOS):  bootOS is a monolithic operating system that fits in one boot sector.
    It's able to load, execute, and save programs. Also keeps a filesystem. It can
    work with any floppy disk size starting at 180K. It's compatible with 8088
    (the original IBM PC).


### Network OS {#network-os}

-   [Junos OS](https://www.juniper.net/us/en/products/network-operating-system/junos-os.html): Junos® OS automates network operations with streamlined precision,
    furthers operational efficiency, and frees up valuable time and resources for
    top-line growth opportunities. Built for reliability, security, and
    flexibility, Junos OS runs many of the world’s most sophisticated network
    deployments, giving operators an advantage over those who run competing
    network operating systems.


## References {#references}

-   [OSdev project list](https://wiki.osdev.org/Projects)
