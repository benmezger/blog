+++
title = "Moving forward with suckless dwm"
author = ["Ben Mezger"]
date = 2022-08-07T21:50:00
slug = "moving_forward_with_suckless_dwm"
tags = ["linux"]
type = "notes"
draft = false
bookCollapseSection = true
+++

-   Related pages
    -   [Dell XPS 9510 and the linux experience]({{<relref "2022-02-05--23-29-55Z--dell_xps_9510_and_the_linux_experience.md#" >}})

---

I decided to give [suckless dwm](https://dwm.suckless.org/) another chance and spent my weekend configuring and applying some patches. Today (<span class="timestamp-wrapper"><span class="timestamp">&lt;2022-08-07 Sun&gt;</span></span>), I seem to have a usable configuration with which I can start working.

I've been using [qtile](http://www.qtile.org/) till now, but with multiple monitors, qtile seemed not to work well. I've tried getting a unique qtile's `GroupBox` for each screen to have 1-9 workspaces, but no luck. Maybe there is a way to fix this, but after a few tries, I gave up and took a chance at hearing my subconscious to give dwm another try.

My dwm changes is version controlled [here](https://github.com/benmezger/dwm.git).

The dwm patches I've applied were:

```text
dwm-alwayscenter-20200625-f04cac6.diff
dwm-attachbottom-20201227-61bb8b2.diff
dwm-centeredmaster-6.1.diff
dwm-cool-autostart-6.2.diff
dwm-cyclelayouts-20180524-6.2.diff
dwm-focusmaster-return-6.2.diff
dwm-fullgaps-toggle-20200830.diff
dwm-pertag-20200914-61bb8b2.diff
dwm-resetlayout-6.2.diff
dwm-sticky-6.1.diff
dwm-systray-6.3.diff
```

**alwayscenter** <br />
All floating windows are centered.

**attachbottom** <br />
New clients attach at the bottom of the stack instead of the top.

**cool-autostart** <br />
Allow dwm to execute commands from `autostart` array in your `config.h` file. And when you exit dwm all processes from `autostart` array will be killed.

**cyclelayouts** <br />
Cycles through all available layouts.

**focusmaster-return** <br />
Switch focus to the (tiled) master client from anywhere in the stack.

**fullgaps-toggle** <br />
Adds gaps between client windows.

**pertag** <br />
Keeps `layout`, `mwfact`, `barpos` and `nmaster` per tag.

**resetlayout** <br />
Resets the `layout` and `mfact` if there is only one client visible.

**sticky** <br />
Make a client 'sticky'. A sticky client is visible on all tags.

**systray** <br />
System tray implementation with multi-monitor support.
