+++
title = "Understanding key concepts before writing a Kernel"
author = ["Ben Mezger"]
date = 2020-05-03T12:42:00-03:00
publishDate = 2020-05-03
tags = ["c", "riscv"]
categories = ["kernel"]
draft = false
+++

In this series of posts, I intend to document my re-go on writing a small,
portable kernel for the RISC-V architecture. I developed a micro-kernel for the
RISC-V ISA in my bachelor thesis, however, due to the time it takes on
developing a kernel, and the time I had on writing a bachelor&rsquo;s thesis, I choose
on writing the kernel for the [Sifive&rsquo;s HiFive1 Rev B](https://www.sifive.com/boards/hifive1-rev-b) development board due to
their well written bare metal compatibility [Library](https://github.com/sifive/freedom-metal) for the board, low cost and
most importantly, RISC-V.

By using Sifive&rsquo;s API, it took out the overhead of having to deal with the
configurations of the clock, interrupt, CPU, and generally required hardware for
the kernel to run. Long story short, I submitted my thesis, got approved, and
now I am willing to rewrite the code all over. During the development of my
thesis, there were components I needed to write and have a better understanding,
so I was not able to pay as much attention as I wanted to the project design,
structural decisions, and general kernel/architectural decisions.
One of the decisions I made during the development phase was not to document my
ideas, questions, and answers I had. This post attempts to fix this problem, by
documenting on how to write a Kernel for the RISC-V architecture.

Before we start, let&rsquo;s remember some basic computer concepts and try to
assemble them together so we can better understand how each component fits
within a kernel.


## A modern computer {#a-modern-computer}

A modern computer consists of at least one central processing unit, main memory,
some data storage, and another type of input and output devices.
Computer architecture is the specification on which describes how software and
hardware may interact with each other.
Computer processors provide an abstract model interface known as the instruction
set, which serves as an interface between the hardware and software.


## The need for a kernel {#the-need-for-a-kernel}

Application developers need to communicate with these types of hardware, and by
having to learn each computer specification is difficult and time-consuming. The
kernel is the middle section of the abstraction between hardware and user
software (Figure [1](#org581f825)). It manages computer resources to
allow application programmers to communicate with them.

By having a simpler model of the computer, application programmers can write
less error-prone software by leaving the hardware complexity to the kernel.

<a id="org581f825"></a>

{{< figure src="/imgs/os-hw-flow.png" >}}

Kernels may provide little to no abstraction at all. Kernels may be necessary
for specific purposes instead of offering any resource to an upper layer. We can
take the traffic light system as an example. The system may need to change
states every 60 seconds, and that is all. For that, instead of having a Kernel,
we could do some simple bare-metal programming, enable a timer interrupt and
have a timer interrupt handler handle state changes[^fn:1].


## The computer organization and architecture {#the-computer-organization-and-architecture}

Although there are different distinctions made between computer architecture and
organization, the first refers to what systems and application programmers see,
which are the attributes that have a direct impact on the execution of a
program, for example, whether a computer will have a multiply instruction, where
the latter refers to the operational unit and its interconnections that make the
architectural specifications, such as whether the multiply instruction will be
implemented by a multiply unit or by a mechanism of repeated add unit. The ISA,
the numbers of bits used to represent data types, the IO structure, and
approaches for memory addressing are all organizational issues that need to be
structured [@Stallings:2011:OSI:2012029].

The computer organization creates a hierarchy of hardware attributes details
that are transparent to the programmer, such the interface between the computer
and peripherals, the memory technology used, the type of processor and control
signals [@Stallings:2011:OSI:2012029].
Computer architecture should offer a clean abstract set to simplify design,
modeling, and allow running software to communicate with the hardware available
[@patterson2017computer].

The processor needs extra hardware in order to do its job, RAM to store program
and data, support for logic and at least one I/O device to transfer data between
the computer and the outside world [@Catsoulis:2005:DEH:1204014]

Processors should be designed to _process_, _store_ and _retrieve_ data, but for
that to happen, the processor has to go through several stages, where (i) fetch
the instruction from memory, which could be the register, cache or main memory,
(ii) decode the instruction to figure out what action is required to run, (iii)
fetch data from memory or a IO module if required, (iv) perform arithmetic or
logical operation on the fetched data if required and (v) the results of an
execution may require to be written back to memory or the IO module
[@Stallings:2011:OSI:2012029].


## Final conclusions {#final-conclusions}

We understood a modern computer is a complex set of hardware with different
factors and use-cases. We saw how a kernel should interact with the hardware and
how it should abstract the underlying hardware resources and provide some sort
of API for programmers and users to interact. Not all problems are solvable with
a kernel, some times pure bare-metal programming is what it takes to solve the
problem, however, when we are willing to multitask, exchange communication
between different resources, a Kernel might come in handy dealing with those
problems.

Computer organization is hierarchy of hardware attribute details that are
transparent to the programmer, like IO functions, inter-process communication,
memory management and etc.

I hope with this post you were able to understand or remember key concepts of
fundamental &ldquo;modern&rdquo; computing. Part 2 we will start implementing the initial
boot of our kernel, starting by initializing the CPU and booting into QEMU&rsquo;s
RISC-V emulator and as we go along, I will introduce more concepts like those
introduced in this post.

[^fn:1]: I don&rsquo;t know how an actual traffic light system works, but I am assuming it&rsquo;s some state-machine that handles interrupts of some kind.
