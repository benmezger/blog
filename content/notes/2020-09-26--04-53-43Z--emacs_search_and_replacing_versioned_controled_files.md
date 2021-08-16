+++
title = "Emacs - Search and replacing versioned controled files"
author = ["Ben Mezger"]
date = 2020-09-26T01:53:00-03:00
slug = "emacs_search_and_replacing_versioned_controled_files"
tags = ["emacs"]
type = "notes"
draft = false
bookCollapseSection = true
+++

-   Related pages
    -   [Emacs]({{<relref "2020-06-04--11-36-43Z--emacs.md#" >}})
    -   [Programming]({{<relref "2020-05-31--15-33-23Z--programming.md#" >}})
    -   [Using macros in Emacs]({{<relref "2020-07-29--11-51-34Z--using_macros_in_emacs.md#" >}})

---

I had to search and replace many files in a git repository, for some reason
`dired-do-find-regexp-and-replace`, but I found using `counsel-git-grep` with
`wgre` much easier. Here is on you do it:

1.  `M-x counsel-git-grep`
    Search for the string
2.  Press `ivy-occur` key on `ivy`'s search prompt result, which is set to `C-c
       C-o` by default. This will open the search results in a new buffer
3.  On your new buffer, run `wgrep-change-to-wgrep-mode` (`C-c C-p`) and do your
    editing.
4.  `C-c C-c` to apply your changes

I still have to figure out why isn't `dired-do-find-regexp-and-replace` working
properly on strings without any regular expression, for example
`name_to_change`. It might be a bug on my end or upstream, but [this](https://www.reddit.com/r/emacs/comments/5y1c11/direddofindregexpandreplace%5Fvs%5Fqueryreplaceregexp/?utm%5Fsource=share&utm%5Fmedium=web2x&context=3) might seem a
bit related.