+++
title = "A reproducible Org-Mode CV template"
author = ["Ben Mezger"]
date = 2026-02-08T14:27:00+01:00
slug = "reproducible_orgmode_cv_template"
tags = ["org-mode", "cv", "template"]
type = "notes"
draft = false
bookCollapseSection = true
+++

{{% hint "info" %}}
_I spent the weekend improving my Org-mode/LaTeX CV template and decided it was_
_worth sharing publicly. Its modular, searchable, and designed for_
_reproducibility. I've made it easy to maintain and updated the structure to be_
_as ATS-friendly as possible._
{{% /hint %}}

{{% hint "caution" %}}
_I used AI to help document this. I tend to spend more time building than
writing about what I built, so it was useful to have something that could map
the full picture._
{{% /hint %}}

---

For several years, I've been using org-mode to keep my CV up to date. I think
I've reached a point where the [template](https://github.com/benmezger/orgmode-cv.git) is good enough to be worth sharing
publicly. Here is a PDF with generated placeholder data:

{{% pdf src="/files/John_Doe_cv.pdf" %}}

Back in time, I hired a service to help me design and prepare my CV to make it
look better and more professional. Engineers are bad at writing CVs that are
friendly to both a recruiter and technical enough for an engineering manager.
It's hard to find that balance.

They delivered the CV in a `docx` format, which I obviously had to convert to
LaTeX. I wanted to write a custom LaTeX class based on their template and use
org-mode to keep track of the content. This required lots of back and forth to
make sure I had duplicated the template correctly and more back and forths with
org-mode to properly organize my data in an `org` file.

I wanted to have a good organization, as I wanted to keep track of two (or more)
versions of my CV, depending on the position I would apply to.

With that, I came up with [this](https://github.com/benmezger/orgmode-cv) template. I keep a `basecv.org` file to store
`LaTeX` and file configuration, along with reusable (across different CVs)
content, while `cv.org` holds the content specific to that CV.

```text
cv/
├── basecv.org         # Base template: macros, shared content
├── cv.org             # CV variant
├── cv-export-init.el  # Export logic: LaTeX class, filters, headline handler
├── custom.cls         # LaTeX class
└── .dir-locals.el     # Emacs glue: loads cv-export-init.el, auto-export hooks
```

Furthermore, I designed the LaTeX template to be as machine-readable as possible
so ATS can read without much hiccups. The PDF generation is fully reproducible,
if the content remains unchanged, the build process will yield an identical
file. Consequently, there is no need to commit a new PDF if no content updates
have been made.

To get started with this template, begin by editing `cv.org`. As you progress,
you will eventually need to update `basecv.org` as well.


## How Files Connect {#how-files-connect}


### Setup {#setup}

Each CV variant inherits from `basecv.org` using the `#+SETUPFILE` directive:

```org
#+SETUPFILE: basecv.org
```

This pulls in the LaTeX class declaration, the `#+SUMMARY:` keyword, and the
`{{{new-page}}}` macro. Properties, not macros, drive all structural LaTeX
output (see [Key Properties](#key-properties)).


### Shared sections {#shared-sections}

Shared sections are pulled from `basecv.org` into variants using `#+INCLUDE`:

```org
#+INCLUDE: "./basecv.org::*Header"
#+INCLUDE: "./basecv.org::*System observability"
#+INCLUDE: "./basecv.org::*Education" :minlevel 1
```

This allows writing highlights, education, and technical skills once and reusing
them across multiple CV variants.


### The `.dir-locals.el` {#the-dot-dir-locals-dot-el}

The `.dir-locals.el` is intentionally thin. Its sole job is to load
`cv-export-init.el` (for both interactive and async export), register the
`benmezger/cv-export-pdfs` interactive command, and set up auto-export hooks.

Saving `cv.org` or `basecv.org` triggers an automatic async PDF export. Saving
`custom.cls` does the same via a `latex-mode` hook.


### The `cv-export-init.el` {#the-cv-export-init-dot-el}

This file contains all export logic and is loaded by both the interactive Emacs
session (via `.dir-locals.el`) and the async export subprocess. It registers the
`custom` LaTeX class, defines the `#+TAGLINE:` and `#+SUMMARY:` file-level
keywords, and installs the preamble filter and headline advice.


#### Injecting keywords into the LaTeX preamble {#injecting-keywords-into-the-latex-preamble}

The `cv-latex-insert-preamble` filter converts org keywords to LaTeX commands
inserted just before `\begin{document}`:

```org
#+TAGLINE: Software Engineering - Clean Code
#+SUMMARY: Driving Software Engineer...
```

becomes:

`\cvtagline` and `\cvsummary` store their values and `\introduction` (triggered by
`:OPENER: t`) renders them both in the body (see below).


#### Custom headline handler {#custom-headline-handler}

The headline handler reads properties and emits the appropriate LaTeX,
short-circuiting the default `\section{}` rendering where needed:

| Property           | LaTeX output                               |
|--------------------|--------------------------------------------|
| `:CV_LOCATION:`    | `\heading` + `\contactinfo{...}`           |
| `:POSITION:`       | `\position{Role}{Company}{Location}{Date}` |
| `:PRIOR_HEADING:`  | `\priorheading`                            |
| `:HIGHLIGHT: t`    | Bold title with colon, inline format       |
| `:PRIOR_POSITION:` | `\priorposition{...}`                      |
| `:OPENER: t`       | Prepends `\introduction` to section body   |

Headlines matching none of the above fall through to the standard org-latex
transcoder.


## Key Properties {#key-properties}


### Contact header {#contact-header}

The header section in `basecv.org` uses properties to define contact
information, which `\contactinfo` renders as a two-column block:

```org
* Header
:PROPERTIES:
:CUSTOM_ID: header
:CV_LOCATION: Amsterdam, Netherlands
:CV_PHONE: 31612345678
:CV_PHONE_DISPLAY: +31 6 12 345 678
:CV_EMAIL: john.doe@example.com
:CV_USERNAME: johndoe
:CV_WEBSITE: https://johndoe.dev
:END:
```


### Introduction opener {#introduction-opener}

Set `:OPENER: t` on the introduction headline to automatically render the
`\introduction` block (tagline + summary sentence) before the body text. No
macro call needed:

```org
* Senior Software Engineer
:PROPERTIES:
:CUSTOM_ID: introduction
:OPENER: t
:END:

*Software engineer* with over ten years of experience...
```

`\introduction` reads the `\cvtagline` and `\cvsummary` values stored by the
preamble filter and renders them centered above the body paragraph.


### Job positions {#job-positions}

Each job entry uses properties to structure the position details:

```org
** Company Name
:PROPERTIES:
:POSITION: Senior Software Engineer
:LOCATION: Germany, Berlin, Hybrid
:DATE: September 2025 - Current
:END:
```

Job descriptions use a custom block that renders in a shaded box:

```org
#+BEGIN_cvdescription
Role summary text here...
#+END_cvdescription
```

This is defined in `custom.cls` as the `cvdescription` environment using
`tcolorbox`.


### Prior positions {#prior-positions}

Older positions use `:PRIOR_POSITION:` for compact rendering with no
description block. The enclosing heading uses `:PRIOR_HEADING: t` to emit the
"Prior Engagement:" label:

```org
* Prior Engagement
:PROPERTIES:
:PRIOR_HEADING: t
:END:

** Coolblue
:PROPERTIES:
:PRIOR_POSITION: Junior Software Developer
:LOCATION: Netherlands, Rotterdam
:DATE: June 2012 - August 2013
:END:
```


## Special Tags {#special-tags}

| Tag          | Purpose                                                  |
|--------------|----------------------------------------------------------|
| `:ignore:`   | Export content but hide the headline (requires ox-extra) |
| `:noexport:` | Skip entire section during export                        |

The `:ignore:` tag is particularly useful for including shared sections without
their headlines appearing in the output. It is enabled via `ox-extra` in
`cv-export-init.el`.


## The `custom.cls` {#the-custom-dot-cls}


### Reproducible builds {#reproducible-builds}

The class suppresses all date and toolchain metadata from the PDF (creation
date, modification date, PTEX info, trailer ID, and compression) so that
identical content always produces a bit-for-bit identical file. `hyperref` date
fields are also cleared. This means the PDF can be committed to git and a diff
will only show real content changes.


### ATS readability {#ats-readability}

The class enables glyph-to-unicode mapping so text copied from the PDF (by a
human or an ATS parser) maps to proper Unicode characters.


### Custom commands {#custom-commands}

| Command                                        | Purpose                                       |
|------------------------------------------------|-----------------------------------------------|
| `\heading`                                     | Renders the large centered author name        |
| `\contactinfo{loc}{ph}{phd}{email}{user}{web}` | Two-column contact block                      |
| `\introduction`                                | Renders tagline + summary sentence            |
| `\position{role}{co}{loc}{date}`               | Job position header row                       |
| `\priorheading`                                | "Prior Engagement:" label row                 |
| `\priorposition{role}{co}{loc}{date}`          | Compact prior position row                    |
| `\lastupdate`                                  | "Last Updated on \today" (auto at end of doc) |

`#+TITLE` is intentionally suppressed; it is only used for PDF metadata via
`#+AUTHOR` and `hyperref`.


### Environments {#environments}

`cvdescription`
: A full-width `tcolorbox` with a light gray background used
    for role summary paragraphs.

`strengthstable`
: A `tabularx` wrapper pre-configured with three equal
    columns for the strengths/skills snapshot table.


## The Export Flow {#the-export-flow}

1.  Open `cv.org`
2.  Emacs loads `.dir-locals.el`, which loads `cv-export-init.el`, registering
    the LaTeX class, export keywords, preamble filter, and headline advice
3.  Export with `C-c C-e l p` (or save the file for auto-export):
    -   `#+INCLUDE` pulls shared content from `basecv.org`
    -   `#+TAGLINE:` / `#+SUMMARY:` are injected as `\cvtagline{}` / `\cvsummary{}`
        before `\begin{document}`
    -   Headlines with `:OPENER: t` have `\introduction` prepended to their body
    -   Headlines with `:POSITION:`, `:PRIOR_POSITION:` etc. are rendered as the
        corresponding LaTeX commands
    -   `custom.cls` styles everything and appends `\lastupdate` automatically

{{% hint "warning" %}}
_Make sure you have `pdflatex` installed, along with the LaTeX dependencies._
{{% /hint %}}

This architecture allows maintaining one source of truth for shared content
while tailoring each CV variant's introduction, strengths, and emphasis for
different positions.
