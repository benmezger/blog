+++
title = "Notes on RISC-V CPU HARD IP Cores enter SoC FPGAs"
author = ["Ben Mezger"]
date = 2020-11-16T22:49:00
slug = "notes_on_risc_v_cpu_hard_ip_cores_enter_soc_fpgas"
tags = ["riscv", "computer", "architecture"]
type = "notes"
draft = false
bookCollapseSection = true
+++

-   Related pages
    -   [RISCV]({{<relref "2020-05-31--15-37-29Z--riscv.md#" >}})
    -   [Computer Architecture]({{<relref "2020-05-31--16-01-33Z--computer_architecture.md#" >}})
    -   [RISC-V Instruction Format]({{<relref "2021-08-13--22-28-40Z--risc_v_instruction_format.md#" >}})

---

Notes on [RISC-V CPU HARD IP Cores enter SoC FPGAs](https://ieeechicago.org/event/ieee-chicago-rockford-consultants-network-risc-v-cpu-hard-ip-cores-enter-soc-fpgas-virtual-meeting/) presentation

-   Frozen base ISA
-   Consolidation in the semiconductor industry
-   RISC-V is not owned by anyone
-   Custom instruction extension to extend the virtuous cycle of semiconductor
    innovation


## PolarFire SoC - RISC-V enabled innocation platform {#polarfire-soc-risc-v-enabled-innocation-platform}

-   Mixed critically RTOS + Linux support
-   Defence grade security
-   Exceptional reliability
-   Designed for low-power
-   L2 memory subsystem
    -   Can be made to be deterministic
    -   Not all L2 are deterministic

{{< figure src="/imgs/polarfire-soc.png" >}}
