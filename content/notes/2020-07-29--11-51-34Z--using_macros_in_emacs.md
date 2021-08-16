+++
title = "Using macros in Emacs"
author = ["Ben Mezger"]
date = 2020-07-29T08:51:00-03:00
slug = "using_macros_in_emacs"
tags = ["emacs"]
type = "notes"
draft = false
bookCollapseSection = true
+++

-   Related pages
    -   [Emacs]({{<relref "2020-06-04--11-36-43Z--emacs.md#" >}})

---

Emacs macros allows us to record sequence of keyboard keystrokes, mouse actions,
menu actions that is bound to an Emacs command. It allows us to record these
actions and repeat them when needed.


## Creating a new macro {#creating-a-new-macro}

-   `C-x (` starts recording a macro
-   `C-x )` stops recording a macro
-   `C-x e` executes the macro
-   `C-u 37 C-x e` executes the macro 37 times
-   `C-u 0 C-x e` executes the macro an infinite number of times until EOF.


## Testing {#testing}

Create a macro to remove the `-` from the following fruit list and replace it
with an `+` (org-mode has still already setup, but for learning purpose, let's
do it with a macro).

Place the cursor the `banana` section and start recording a macro. Remove the
first `-` from Banana and replace it with `+`, move to the next line (`apple`)
and stop recording the macro. Run `C-u 0 C-x e` to run the macro until EOF.

-   Banana
-   Apple
-   Melon
-   Grape
-   Orange
-   Watermelon
-   Kiwi

It is important to stop defining a macro at a similar position to where you
started it. Executing `apply-macro-to-region-lines` applies the last-defined
keyboard macro to each of the lines of a region


## Resources {#resources}

-   [EmacsWiki - Keyboard macros](https://www.emacswiki.org/emacs/KeyboardMacros)
-   [elmacro - Shows keyboard macros or latest interactive commands as emacs lisp](https://github.com/Silex/elmacro)
-   [GNU Emacs - Keyboard Macros](https://www.gnu.org/software/emacs/manual/html%5Fnode/emacs/Keyboard-Macros.html)
-   [Emacs keyboard macros (info)](<(info "(emacs) Keyboard macros")>)