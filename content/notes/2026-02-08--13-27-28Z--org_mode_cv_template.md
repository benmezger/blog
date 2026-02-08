+++
title = "A reproducible Org-Mode CV template"
author = ["Ben Mezger"]
date = 2026-02-08T14:27:00+01:00
slug = "org_mode_cv_template"
tags = ["org-mode", "cv", "template"]
type = "notes"
draft = false
bookCollapseSection = true
+++

{{% hint "info" %}}
_I spent the weekend improving my Org-mode/LaTeX CV template and decided it was_
_worth sharing publicly. Its modular, searchable, and designed for_
_reproducibility. I’ve made it easy to maintain and updated the structure to be_
_as ATS-friendly as possible._
{{% /hint %}}

---

For several years, I’ve been using org-mode to keep my CV up to date. I think
I’ve reached a point where the [template](https://github.com/benmezger/orgmode-cv.git) is good enough to be worth sharing
publicly. Here is a PDF with generated placeholder data:

<iframe
    src="https://drive.google.com/viewerng/viewer?embedded=true&url=https://seds.nl/files/John_Doe_cv.pdf#toolbar=0&scrollbar=0"
    frameBorder="0"
    scrolling="auto"
    height="100%"
    width="100%"
></iframe>

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
├── custom.cls         # LaTeX class
└── .dir-locals.el     # Emacs glue: export filters & headline handlers
```

Furthermore, I designed the LaTeX template to be as machine-readable as possible
so ATS can read without much hiccups. The PDF generation is fully reproducible;
if the content remains unchanged, the build process will yield an identical
file. Consequently, there is no need to commit a new PDF if no content updates
have been made.

To get started with this template, begin by editing `cv.org`. As you progress,
you will eventually need to update `setup.org` as well.


## How Files Connect {#how-files-connect}


### Setup {#setup}

Each CV variant inherits from `basecv.org` using the `#+SETUPFILE` directive:

```org
#+SETUPFILE: basecv.org
```

This pulls in the latex class declaration and macros like `{{{introduction}}}`,
`{{{position(...)}}}`, and `{{{strengths(...)}}}`.


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

This is where the magic happens. The `.dir-locals.el` file configures Emacs to
handle the custom export process.


#### Adding Custom Export Keywords {#adding-custom-export-keywords}

```elisp
(dolist (opt '((:tagline "TAGLINE" nil nil t)
               (:summary "SUMMARY" nil nil t)))
  (add-to-list 'org-export-options-alist opt))
```

This makes `#+TAGLINE:` and `#+SUMMARY:` valid file-level options that can be
used in the org files.


#### Injecting Keywords into LaTeX Preamble {#injecting-keywords-into-latex-preamble}

The `cv-latex-insert-preamble` filter converts org keywords to LaTeX commands:

```org
#+TAGLINE: Software Engineering - Clean Code
#+SUMMARY: Driving Software Engineer...
```

becomes:


#### Custom Headline Handler {#custom-headline-handler}

The `cv-org-latex-headline` function reads org properties and transforms
headlines into LaTeX commands:

| Property           | LaTeX Output                               |
|--------------------|--------------------------------------------|
| `:POSITION:`       | `\position{Role}{COMPANY}{Location}{Date}` |
| `:CV_LOCATION:`    | `\heading` + `\contactinfo{...}`           |
| `:PRIOR_POSITION:` | `\priorposition{...}`                      |
| `:HIGHLIGHT: t`    | Bold title with colon format               |


## Key Properties {#key-properties}


### Contact Header {#contact-header}

The header section in `basecv.org` uses properties to define contact information:

```org
* Header
:PROPERTIES:
:CUSTOM_ID: header
:CV_LOCATION: Berlin, Germany
:CV_PHONE: 0491701234567
:CV_PHONE_DISPLAY: +49 170 1234567
:CV_EMAIL: john.doe@example.com
:CV_USERNAME: johndoe
:CV_WEBSITE: https://johndoe.dev
:END:
```


### Job Positions {#job-positions}

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


### Prior Positions {#prior-positions}

Older positions use `:PRIOR_POSITION:` for more compact rendering:

```org
** TECHSTART
:PROPERTIES:
:PRIOR_POSITION: Software Developer
:LOCATION: Germany, Munich
:DATE: Aug 2014 - June 2015
:END:
```

In general, prior positions have no descriptions.


## Special Tags {#special-tags}

| Tag          | Purpose                                                  |
|--------------|----------------------------------------------------------|
| `:ignore:`   | Export content but hide the headline (requires ox-extra) |
| `:noexport:` | Skip entire section during export                        |

The `:ignore:` tag is particularly useful for including content without the
headline itself appearing in the output. This is enabled by `ox-extra`:

```elisp
(require 'ox-extra)
(ox-extras-activate '(ignore-headlines))
```


## The Export Flow {#the-export-flow}

1.  Open `cv.org`
2.  Emacs loads `.dir-locals.el`, activating all customizations
3.  Export with `C-c C-e l p`:
    -   `#+INCLUDE` pulls shared content from `basecv.org`
    -   Macros expand to LaTeX commands
    -   Properties transform headlines into `\position{}` etc.
    -   `custom.cls` styles everything

{{% hint "warning" %}}
_Make sure you have `pdflatex` installed, along with the LaTeX dependencies._
{{% /hint %}}

This architecture allows maintaining one source of truth for shared content
while tailoring each CV variant's introduction, strengths, and emphasis for
different positions.
