+++
title = "Taking notes digitally"
author = ["Ben Mezger"]
date = 2020-04-23T00:00:00-03:00
publishDate = 2020-12-24
draft = true
+++

## Introduction {#introduction}

Organizing notes on a computer can difficult at times, not only good note-taking
may require application of common methodologies, but also requires a well
defined directory structure, a good text search software, a file search software
and note-taking system to manage all your notes.


### The problem with note-taking applications {#the-problem-with-note-taking-applications}

Some commonly known note-taking applications provide their user with a custom
editor (Markdown, Latex, etc.), or allows importing existing notes to their
system and synchronizes these files to their cloud (or if they allow, your
personal cloud). Some provide free or limited access and requires a subscription
for pro-features.

File exports are rather limited, as some application only support the most
_common_ filetypes (`.md`, `.txt` `.pdf`) or require a subscription for more.


### The complications with note exports and imports {#the-complications-with-note-exports-and-imports}

The limited freedom you get when using these applications can also become future
complications. What happens if you need to switch note-taking application to
another?

Will the application support exporting files (in bulk) to the file type required
by the other software? Will tags get exported with the files and the new
application support it? How about dates and reminder? Will they work? Migrating
notes isn&rsquo;t an easy task, specially when your application uses their own
metadata, or in-file features.

Exporting sections of your notes is important, what happens when your
colleague asks you for the notes you took in the last meeting in a PDF format?
What happens if you have notes in that file you don&rsquo;t want to share, will you
make a copy of your file to another and delete that section before exporting, or
does your application support any type of in-file _comment section out_
settings?

TODO: Talk about proprietary and end of life (EOL)


### Context switching between applications {#context-switching-between-applications}

Context switching plays an important role in note-taking. As a software
engineer, having a terminal, text-editor, browser, music player all opened,
_CTRL + tab_ isn&rsquo;t that productive, not even using a WM, specially if you take
a quick note during coding.


### Code support {#code-support}

How does the application handle code snippets? Does it support
syntax-highlight? Does it support in-line code evaluation, or do you have to run
the snippet and copy-paste the output? Some support for literate programming?


## Note-taking requirements {#note-taking-requirements}

Before choosing between a note-taking application, my note-taking requirements
are:

1.  Export to a variety of file types: `docx`, `markdown`, `latex`, `ascii`,
    `pdf`, `html`, `ODT`
2.  Git support or any other file synchronization software
3.  In-buffer settings, allowing me to customize the file before exporting to a
    specific file type
4.  Markdown or similar syntax
5.  In-buffer code evaluation
6.  Shared (global) file with in-buffer settings for all my other files
7.  Tags, date support, comments (excluded from any export)
8.  Keyboard-driven
9.  Back-links to notes (graph-like)
10. Easily search through all tags, text, filenames, date, etc
11. Custom template support
12. And literate programming, with code evaluation and result in-file
    dynamically

After years tinkering with multiple note-taking application, I found something
that fulfilled these requirements well: `orgmode`.


## Orgmode {#orgmode}

Orgmode is an Emacs major mode for plain text markup. It allows literate
programming, file/text search, multiple custom or third-party exports, in-buffer
settings, tangle sections to different files and much more.

Orgmode&rsquo;s syntax is intuitive, and allows custom LaTex, HTML and other file types to be
customized in-buffer.

This is how the source of this post looks like:

```org
#+TITLE: Posts
#+SUBTITLE: Blog notes
#+AUTHOR: Ben Mezger
#+DATE: <2020-12-24 Thu>
#+EMAIL: me@benmezger.nl
#+FILETAGS: :@blog:

#+OPTIONS: ':t *:t -:t ::t <:t H:3 \n:nil ^:nil arch:headline author:t c:nil html5-fancy
#+STARTUP: overview
#+OPTIONS: html-style:t
#+SETUPFILE:

#+HTML_DOCTYPE: xhtml5
#+HTML_HTML5_FANCY:

# Hugo config
#+DRAFT: false
#+HUGO_AUTO_SET_LASTMOD: t
#+HUGO_BASE_DIR: ~/workspace/blog
#+HUGO_AUTO_SET_LASTMOD: t

* TODO Note-taking system :post:org:
  ....
```


## Directory structure {#directory-structure}

{{< details Structure >}}

```nil
├── README.org
├── archives
│   ├── cv.org_archive
│   └── notes.org_archive
├── bibliography.bib
├── bibnotes.org
├── blog
│   ├── about.org
│   ├── menu.org
│   └── posts.org
├── code.org
├── cv.org
├── drafts.org
├── hugo.setup
├── journal
│   ├── 20200731
│   ├── 20200801
│   ├── ...
├── notes.org
├── org-notes-style.setup
├── roam
│   ├── 2020-05-30--19-14-46Z--information_theory.org
│   ├── 2020-05-30--21-56-36Z--list_of_spority_artists.org
|   ├── ...
│   ├── bibliography.org
│   ├── daily
│   ├── index.org
│   ├── org-roam.db
│   ├── private
│   │   ├── 2020-11-03--20-16-48Z--postgraduate.org
│   └── the_go_programming_language_specification_the_go_programming_language.org
├── templates
│   ├── book-note.capture
│   ├── code-snippet.capture
│   ├── decision.capture
│   ├── new-book.capture
│   └── weekly-journal.capture
└── urls.org
```

{{< /details >}}


## Roam {#roam}


## Bibliography support {#bibliography-support}
