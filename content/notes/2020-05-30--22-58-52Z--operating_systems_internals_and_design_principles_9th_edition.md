+++
title = "Operating systems: Internals and design principles (9th edition)"
author = ["Ben Mezger"]
date = 2020-05-30T19:58:00-03:00
slug = "operating-systems"
tags = ["reading", "books", "cs", "operating-systems"]
type = "notes"
draft = false
bookCollapseSection = true
+++

-   Related pages
    -   [Computer Science]({{<relref "2020-05-31--15-29-21Z--computer_science.md#" >}})
    -   [Operating Systems]({{<relref "2020-05-31--15-29-38Z--operating_systems.md#" >}})

---


## READING Operating Systems: Internals and Design Principles (9th Edition) {#reading-operating-systems-internals-and-design-principles--9th-edition}

<div class="table-caption">
  <span class="table-number">Table 1</span>:
  Clock summary at <span class="timestamp-wrapper"><span class="timestamp">[2020-06-06 Sat 03:47]</span></span>
</div>

| Headline                            | Time     |
|-------------------------------------|----------|
| **Total time**                      | **3:24** |
| Operating Systems: Internals and... | 3:24     |


### Exercises {#exercises}

1.1. CPU: Takes care of processing data
   Main memory: Volatile memory for storing data and program instructions
   Secondary storage: Non-volatile for permantely storing data.
   I/O: External peripherals such as USB drive, printer and etc.

1.2. Memory address register (MAR): specifies the memory address for the next
   read or write.
   Memory buffer register (MBR): contains data to be written to memory or
   receives data read from memory.

1.3. Processor-memory: Data may be transferred from processor to memory or from
   memory to processor.
   Processor-IO: Process may transfer data to I/O module or from I/O module to
   processor
   Data processing: Processor may perform arithmetic or logical operation
   Control: The instruction may specify a different location to fetch the next
   instruction from, altering the sequence of execution.

1.4. Interrupts the current execution of the CPU. This allows external
   peripherals to process data while the CPU works on something else. When the
   data processing is over, the peripheral may trigger an interrupt requesting
   CPU attention. A CPU interrupt handler may take care of interrupt or ignore it.

1.5. There are two types of handling interrupts: sequentially or by
   priority-policy. In sequential interrupts, if an interrupt happens within the
   handler of a current interrupt, the interrupt will be ignored for the moment
   by setting a pending interrupt. After it the current interrupt has been
   dealt, it then treats the next pending interrupt. Priority-based interrupts
   allows one interrupt to be handled by priority. Whiling handling one
   interrupt, if another interrupt occurs and the priority is higher than the
   current interrupt being dealt, it stores the current context and handles the
   higher priority interrupt.

1.6. Cost, speed, size are characteristics that are important

<!--list-separator-->

-  Notes

    <!--list-separator-->

    -  Program execution

        A program consists of a set of instructions stored in memory. The processor
        fetches one instruction at a time and executes each instruction. The processing
        required for one instruction is called the **instruction cycle**. The instruction
        cycle is composed of three main stages:

        1.  Fetch stage: The process fetches an instruction from memory. Most processor
            hold some type of PC (Program counter) register which points to the next
            instruction in memory. Each time a new instruction has been fetched, the PC
            is incremented to the next instruction. The fetch stage usually consists of the
            following "substages"
            -   Address of PC is copied to the MAR (Memory address register), which either
                stores the memory address from where data will be fetched or the address to
                which data will be sent or stored.