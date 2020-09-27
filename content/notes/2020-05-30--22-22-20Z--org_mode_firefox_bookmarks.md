+++
title = "Org-mode Firefox bookmarks"
author = ["Ben Mezger"]
date = 2020-05-30T19:22:00-03:00
slug = "orgmode-firefox-bookmark"
tags = ["emacs", "orgmode", "firefox"]
type = "posts"
draft = false
bookCollapseSection = true
+++

tags
: [Org-mode]({{< relref "2020-06-04--11-35-15Z--org_mode" >}}) [Emacs]({{< relref "2020-06-04--11-36-43Z--emacs" >}})

Add the following scripts to call org-capture from Firefox


## Call capture template {#call-capture-template}

The following calls capture template key `n`

```js
javascript:location.href='org-protocol://capture?template=n'+'&url='+encodeURIComponent(window.location.href)+'&title='+encodeURIComponent(document.title)+'&body='+encodeURIComponent(window.getSelection());
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