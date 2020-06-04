+++
title = "Org-mode Firefox bookmarks"
author = ["Ben Mezger"]
date = 2020-05-30T19:22:00-03:00
lastmod = 2020-06-04T00:44:46-03:00
slug = "orgmode-firefox-bookmark"
type = "posts"
draft = false
bookCollapseSection = true
+++

### Backlinks {#backlinks}

- [Org-roam firefox bookmark]({{< relref "2020-05-30--22-30-53Z--org_roam_firefox_bookmark" >}})

Add the following scripts to call org-capture from Firefox

## Call capture template {#call-capture-template}

The following calls capture template key `n`

```js
javascript: location.href =
  "org-protocol://capture?template=n" +
  "&url=" +
  encodeURIComponent(window.location.href) +
  "&title=" +
  encodeURIComponent(document.title) +
  "&body=" +
  encodeURIComponent(window.getSelection());
```

## Without a capture template {#without-a-capture-template}

If unspecified, the template key is set in the variable
org-protocol-default-template-key. The following template placeholders are
available:

```org
%:link          The URL
%:description   The webpage title
%:annotation    Equivalent to [[%:link][%:description]]
%i              The selected text
```

See: <https:orgmode.org/manual/The-capture-protocol.html#The-capture-protocol>
