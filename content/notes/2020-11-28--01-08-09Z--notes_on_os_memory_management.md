+++
title = "Notes on OS memory management"
author = ["Ben Mezger"]
date = 2020-11-27T22:08:00-03:00
slug = "notes_on_os_memory_management"
tags = ["os", "mmu"]
type = "notes"
draft = false
bookCollapseSection = true
+++

tags
: [Operating Systems]({{< relref "2020-05-31--15-29-38Z--operating_systems" >}})

## Memory management requirements {#memory-management-requirements}

Some the requirements that memory management is intended to satisfy are:

1.  Relocation
2.  Protection
3.  Sharing
4.  Logical organization
5.  Physical organization
