+++
title = "Go Context package"
author = ["Ben Mezger"]
date = 2020-09-03T17:08:00+02:00
slug = "go_context_package"
tags = ["go", "programming"]
type = "notes"
draft = false
bookCollapseSection = true
summary = "Cancellation and propagation in Go's context package."
+++

tags
: [Programming]({{< relref "2020-05-31--15-33-23Z--programming.md" >}}) [Go Programming]({{< relref "2020-05-31--15-31-36Z--go_programming.md" >}})


## Keywords {#keywords}

-   Cancellation: is when you are requesting some services, and you cancel this request
-   Propagation: means that if we asked someone for a service then you tell that person to cancel
