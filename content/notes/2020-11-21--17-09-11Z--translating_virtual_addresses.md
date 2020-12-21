+++
title = "Translating Virtual addresses"
author = ["Ben Mezger"]
date = 2020-11-21T14:09:00-03:00
slug = "translating_virtual_addresses"
tags = ["os", "architecture"]
type = "posts"
draft = false
bookCollapseSection = true
bookCollapseSection = true
+++

tags
: [Computer Architecture]({{< relref "2020-05-31--16-01-33Z--computer_architecture" >}}) [Operating Systems]({{< relref "2020-05-31--15-29-38Z--operating_systems" >}})

Translating virtual address space in [RISCV]({{< relref "2020-05-31--15-37-29Z--riscv" >}}) in Sv39

Virtual address: `0x7d_beef_cafe`
Virtual address in binary: `0b0111_1101_1011_1110_1110_1111_1100_1010_1111_1110`

| VPN[2]        | VPN[1]        | VPN[0]        | 12-bit offset    |
| ------------- | ------------- | ------------- | ---------------- |
| `1_1111_0110` | `1_1111_0111` | `0_1111_1100` | `1010_1111_1110` |
| 502           | 503           | 252           |                  |
