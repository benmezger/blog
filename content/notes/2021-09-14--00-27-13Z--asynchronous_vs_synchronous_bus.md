+++
title = "Asynchronous vs synchronous bus"
author = ["Ben Mezger"]
date = 2021-09-13T21:27:00-03:00
slug = "asynchronous_vs_synchronous_bus"
tags = ["architecture", "cs"]
type = "notes"
draft = false
bookCollapseSection = true
+++

-   Related pages
    -   [Computer Architecture]({{<relref "2020-05-31--16-01-33Z--computer_architecture.md#" >}})

---

> In an asynchronous bus, each bus cycle is sequenced by request and
> acknowledgment signals. To perform a bus cycle, the transmitter drives the data
> onto the bus and then asserts the request signal Req. Upon seeing the request
> signal, the receiver samples the data off the bus and asserts an acknowledge
> signal Ack to indicate that the data transfer is complete. Upon receiving the
> acknowledge signal, the transmitter turns its driver off, freeing the bus for
> the next transfer ([Dally and Towles 2004](#orgbd0f10a)).


## Bibliography {#bibliography}

<a id="orgbd0f10a"></a>Dally, William James, and Brian Patrick Towles. 2004. _Principles and Practices of Interconnection Networks_. San Francisco, CA, USA: Morgan Kaufmann Publishers Inc.
