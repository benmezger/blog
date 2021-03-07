+++
title = "Org-roam Firefox bookmark"
author = ["Ben Mezger"]
date = 2020-05-30T19:30:00-03:00
slug = "org-roam-firefox-bookmark"
tags = ["emacs", "orgmode", "roam", "firefox"]
type = "notes"
draft = false
bookCollapseSection = true
+++

tags
: [Org-mode]({{< relref "2020-06-04--11-35-15Z--org_mode" >}}) [Emacs]({{< relref "2020-06-04--11-36-43Z--emacs" >}}) [Org-roam]({{< relref "2020-06-04--11-51-18Z--org_roam" >}})

[Org-roam](https://org-roam.readthedocs.io/en/master/roam%5Fprotocol/) has roam-protocol, which we can call throughout the system just like
[Org-mode Firefox bookmarks]({{< relref "2020-05-30--22-22-20Z--org_mode_firefox_bookmarks" >}}).

`Org-roam` protocol supports specifying the roam template to use.
Template is the `template` key for a template in org-roam-capture-ref-templates.
More documentation on the templating system can be found here.

These templates should contain a `#+ROAM_KEY: ${ref}` in it.

## `Roam-ref` protocol {#roam-ref-protocol}

Find and creates from with a specific ROAM_KEY

```js
javascript: location.href =
  "org-protocol://roam-ref?template=r&ref=" +
  encodeURIComponent(location.href) +
  "&title=" +
  encodeURIComponent(document.title);
```

Related link: <https://org-roam.readthedocs.io/en/master/roam%5Fprotocol/>
