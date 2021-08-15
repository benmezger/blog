+++
title = "RISC-V Instruction Format"
author = ["Ben Mezger"]
date = 2021-08-13T19:28:00-03:00
slug = "risc_v_instruction_format"
tags = ["riscv"]
type = "notes"
draft = false
bookCollapseSection = true
+++

tags
: [RISCV]({{<relref "2020-05-31--15-37-29Z--riscv.md#" >}}) [Computer Architecture]({{<relref "2020-05-31--16-01-33Z--computer_architecture.md#" >}}) [Computer Science]({{<relref "2020-05-31--15-29-21Z--computer_science.md#" >}})

    The base ISA has six instruction formats: (i) the R-format for register
    operations, (ii) I-format for immediate short and loads values, (iii) S-format
    for stores, (iv) B-format for conditional branches, (v) U-format for
    instructions with upper immediate, and (vi) J-format for
    unconditional jumps. Given that the ISA has six instruction formats, the
    simplification and decoding of instructions are much more straightforward
    compared to ARM or x86 architectures. RISC-V provides three register operands
    at the same position in all formats, simplifying the decoding process. In
    addition, the specified registers to be read or written are always in the same
    place in all instructions, enabling register access to start before the
    instruction decoding phase ([Patterson and Waterman 2017](#orgc3617d6); [Waterman et al. 2014](#orgd0427f1)).


## Bibliography {#bibliography}

<a id="orgc3617d6"></a>Patterson, David, and Andrew Waterman. 2017. _The RISC-V Reader: An Open Architecture Atlas_. 1st ed. Strawberry Canyon.

<a id="orgd0427f1"></a>Waterman, Andrew, Yunsup Lee, David A. Patterson, Krste Asanovic, Volume I User-level Isa, Andrew Waterman, Yunsup Lee, and David Patterson. 2014. “The RISC-V Instruction Set Manual.”