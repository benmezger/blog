+++
title = "Adopting conventional commits in a codebase"
author = ["Ben Mezger"]
date = 2021-04-16T19:30:00-03:00
publishDate = 2021-04-16T00:00:00-03:00
tags = ["git"]
draft = false
summary = """
Recently, it came to my attention that conventional commits don't fit all
codebases; in fact, they can annoy more than they can help in some situations.
"""
+++

If you are not familiar with Git&rsquo;s conventional commit approach, jump over [here](https://www.conventionalcommits.org/)
before you continue reading.

I&rsquo;ve been using Git&rsquo;s conventional commit approach for at least four years.
Recently, it came to my attention that conventional commits don&rsquo;t fit all
codebases; in fact, they can annoy more than they can help in some situations.

The main _benefit_ of using conventional commits that I see is that you can:

1.  Generate `CHANGELOGS` based on the semantics of the commit
2.  Easily allow another developer to understand the impact of a specific commit
    by reading the commit message
3.  Implement tools that can act upon a particular commit message

## Generating `CHANGELOGS` {#generating-changelogs}

The idea of a changelog is to let anyone understand what has been
implemented/fixed/removed from a given version. A changelog is interesting
because it provides users with transparency of what is going on within the
development team and what they can expect from a specific software version.

The main problem of a changelog is the developer. Developers tend to write
software for others to use, but they don&rsquo;t necessarily care about informing them
what has changed and why. That&rsquo;s when conventional commits came into play. The
idea of conventional commits is to use semantic words within the commit message
to generate the changelog automatically. So say you have the following commits:

```nil
c540106 * Refactor: Move riscv related mmu code to riscv.rs
24694f0 * Docs: Add MMU documentation
946c058 * Fix: Take entries reference instead of an owned value
065dabd * Feat: Display heap size when running main
cd02e93 * Feat: Add MMU Page table support
8eec4b4 * Feat: Add initial MMU page entry bits and entries
```

You could parse these messages and generate a changelog like so:

{{< details Changelog>}}

```text
# Change Log

## [2.1.0]

### Features

* Display heap size when running main
* Add MMU Page table support
* Add initial MMU page entry bits and entries

### Fixes

* Take entries reference instead of an owned value

### Refactor

* Move riscv related mmu code to riscv.rs

### Documentation

* Add MMU documentation
```

{{< /details >}}

The problem with this approach is that commits are generally too technical and
software-development-focussed. Take the `fix` commit: &ldquo;_take entries&#x2026;_&rdquo; as an
example. What does this tell you as a user of my software? Because from the
user&rsquo;s perspective, this means nothing.

Changelogs should be written by a human and not by software. Take a look at this
alternative changelog:

{{< details Changelog>}}

```text
# Change Log

## [2.1.0]

### Features

* Display heap information upon kernel boot
* Add RISC-V paging support

### Fixes

* Fixes then crashing when an user allocates memory in user-mode

### Refactor

* Move any RISC-V MMU related code to the RISC-V module

### Documentation

* Add documentation related to the new MMU component
```

{{</ details >}}

The previous example is more user-friendly. As a user, I am now aware that there
were two main features: the kernel now displays heap information on boot, and
RISC-V paging is currently supported. I also know that the documentation related
to the new MMU component is now available. Cool, much cleaner, less technical,
and separated two main domains: the software developer and the user.

A fix may not necessarily mean anything to a user, but it might mean to a
developer. A feature may not necessarily add anything to the end-user. The MMU
might mean something to the developer, for which paging is dependent, but not
necessarily to the end-user.

## Allow developers to understand code impact {#allow-developers-to-understand-code-impact}

Another problem semantic commits try to solve is by warning the developer of the
impact a commit might have. Specific words, such as `feat`, `fix` is written at
the beginning of a commit message, for example:

```text
c540107 * Fix: Bad memory reference on memor allocation
24694f8 * Feat: Add new MMU component
```

Commits generally have 50-72 characters (first line) length and 80 for the
commit body. The size is limited (with reason), which means we should take every
word seriously.

In semantic commits, you can either use `feat`, `feature`, etc., or even by
scope, with `feat(lang)`. This takes too much precious character space, limiting
the actual commit argument regarding the change. Countless times, I&rsquo;ve lost
commit space due to `feat(lang)`. Sure, it&rsquo;s ten characters, giving our length
of 50 characters, we have 40 characters left, including space.

The size limit with semantic commits can be a problem because not all commit
messages can be 40 or 62 characters.

I do, however, find the scope semantic desirable, even if we have to give
up on a few characters.

## The scope approach of conventional commits {#the-scope-approach-of-conventional-commits}

As I mentioned previously, I do find the scope approach appealing. It guides the
developer on where the change is located by simply reading the commit message.
For example:

```text
c540107 * feat(kernel/mem): Check if memory is deallocated before trashing
24694f8 * feat(docs/menu): Add syscall to documentation menu
```

This is interesting, as I now know which component was modified; however, I have
a few questions regarding the first commit. It does mention it was a `feature`,
but by reading the message, it does seem like a fix to me or a forgotten logic
that just got added. It seems to me that `feat` and `before` words conflict.
Lets look at the following approach:

```text
c540107 * kernel/mem: Check if memory is reallocated before deleting
24694f8 * docs/menu: Add syscall to documentation menu
```

I find this much more intuitive, as it still lets me know which component got
added, without the conflict of `before` and `feat`.
The scope approach is interesting in large codebases, where two or more
components exist within the system. I can easily give up a few characters for
such benefit.

## Does conventional commits really make sense? {#does-conventional-commits-really-make-sense}

It depends. A scope-based approach may make sense if you maintain a large
codebase. I won&rsquo;t go on the merit of what exactly is a large project - the
project may be complex, but that does not make it necessarily large. How many
engineers are working on the code? Answering all these questions may lead to an
answer whether conventional commits, either scope-based or specific keywords,
or&#x2026;

You can write a message without scopes or specific words. Take a look at the
following commits:

```text
c540107 * Check if memory is reallocated before deleting.
24694f8 * Add syscall to page documentation menu
```

Straightforward and readable.

## Conclusions {#conclusions}

Generating changelogs from conventional commits is not user-friendly or
developer-friendly (because why would you create a changelog from your commits
if the developer can look at the commit logs?). Instead, humanize the process of
writing changelogs. If you cannot write humanized reports, you are not following
what is going on within the system.

Conventional commits (specially scope-oriented) take too much message space, and
they generally conflict depending on the message. Either you stick with
conventional commits by carefully writing your commit messages, or you don&rsquo;t use
them at all.

Scope-oriented (i.e., component-related) is interesting, as a developer can
quickly read the logs and understand what exactly is modified.

Finally, think through if conventional commits make sense for your project. What
are you trying to archive with conventional commits? Commit organization? Trend?
Changelog?
