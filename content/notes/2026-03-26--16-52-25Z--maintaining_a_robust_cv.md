+++
title = "Maintaining a robust CV"
author = ["Ben Mezger"]
date = 2026-03-26T17:52:00+01:00
slug = "maintaining_a_robust_cv"
tags = ["cv", "ai", "orgmode"]
type = "notes"
draft = false
bookCollapseSection = true
+++

-   Related pages
    -   [A reproducible Org-Mode CV template]({{<relref "2026-02-08--13-27-28Z--org_mode_cv_template.md#" >}})

---

I've been investing in having a well structured CV for some time now.
Maintaining a CV is hard, and you have to do it well, since this is your entry
ticket for your first interview.

It doesn't matter who you are, if your CV is badly written and unstructured, you
are unlikely to receive that first call with the recruiter. It's even harder
nowadays due to AI. A lot of recruiters are using AI to triage many CVs they
receive, so you have to make sure you pass through this automated triage, that
means having a parsable and well linked content is important.

Although my CV structure has diverged a little from what I provided [here]({{<relref "2026-02-08--13-27-28Z--org_mode_cv_template.md#" >}}), I've
noticed that I did not have any tests to make sure I haven't missed any detail
when updating the CV. I wanted to ensure:

1.  That if I claim X years of experience, it doesn't contradict my actual job
    history.
2.  That my PDF is machine-readable and parsable by ATS and AI systems.
3.  That there are no spelling mistakes.
4.  That what I write in my _highlight_ section is backed by a corresponding
    position in my experience section.
5.  That all work experience uses a consistent tense, except for my current
    position.
6.  Etc.

Although some of these seem trivial and can be done with a better latex class,
verifying and cross-checking context is hard. It gets even harder when you
start maintaining multiple versions of your CV. I had other questions that I
wished I could test. So I decided to use AI for that.

`Claude` allows you to write [custom commands](https://code.claude.com/docs/en/skills), which you can easily call with
\`/custom-command\` from your `claude-cli`. So I've asked Claude to help me write
a custom command to test some of these (and more) questions I had, including
checking particular Org Mode configuration I had.

With this approach, using Org Mode/LaTeX gives me the confidence that my CV
follows a well defined structure, while using AI to check based on the context
(content) whether things are matching and not contradicting itself (_i.e. 10y of
experience, while your_ _experience list shows 15y_).

My flow now is essentially:

1.  Make changes to my CV.
2.  Export the PDFs.
3.  Run `claude` and run my slash `/test` command.
4.  Fix what Claude found and repeat.

Here is how my Claude test looks like:

{{% details "Claude CV test" %}}

```text
Read `cv.org`, `basecv.org`, and `cv-export-init.el` in full. Then run
every check below using the Read, Grep, and Bash tools.

After running all checks, output a results table in this format:

| #   | Check                            | Status      | Details                            |
|-----|----------------------------------|-------------|------------------------------------|
| 1   | Spelling and grammar             | PASS / FAIL | Brief note or file:line on failure |
| 2   | Position consistency between CVs | PASS / FAIL | ...                                |
| ... |                                  |             |                                    |

Use ✅ for PASS and ❌ for FAIL in the Status column. List every check as a row,
even if it passes. After the table, list full details for any failures.

---

The CV consists of the following files:

- `cv.org`: Main CV file containing two export variants: **General CV** and
  **Python CV**. Each variant ends with a `** Tail :ignore:` heading that
  includes `basecv.org::*CV Tail`.
- `basecv.org`: Shared content included into `cv.org`. Contains top-level
  sections for Header and Highlights, plus a `* CV Tail :ignore:` group that
  bundles Education, Technical Acumen, Contract Work, Prior Engagement, and
  Language Proficiencies.
- `cv-export-init.el`: Export logic, custom headline handlers, and table
  renderers.
- `Benjamin_Mezger_cv.pdf` / `Benjamin_Mezger_python_cv.pdf`: Generated PDF
  files.

---

## `cv.org` and `basecv.org`

### Spelling and grammar

1. Read all prose in `basecv.org` (Highlights section) and both CV introductions
   in `cv.org` for typos and grammatical errors.
2. Read all bullet points under each job position in both CV variants for typos
   and grammatical errors.
3. Check for consistent tense: all bullet points should use past tense, except
   for the current position (`:DATE:` ending in `Current`) which should use
   present or past consistently across both CVs.

### Position consistency between CVs

Both the **General CV** and the **Python CV** contain duplicated job entries for
the same companies. To check consistency:

1. Read both CV variants in `cv.org` and collect every job headline that has a
   `:POSITION:` property, along with its `:DATE:` and `:LOCATION:` values.
2. The set of companies must be identical between the two variants — flag any
   company present in one but missing from the other.
3. For each company that appears in both variants, verify these properties match
   exactly:
   - `:POSITION:` — job title
   - `:DATE:` — date range
   - `:LOCATION:` — location string

If any field differs between the two variants for the same company, flag it as
an inconsistency.

### Content contradictions

Check that metrics, claims, and accomplishments are consistent across sections.
Do not rely on hardcoded values — derive everything from the files at check
time:

1. For each highlight in `basecv.org` (under `* Highlights`), note the company
   it references (`:COMPANY:` property) and any specific metrics or claims in
   its prose. Then find the matching job entry for that company in both CV
   variants and verify those same metrics and claims appear in the bullet
   points. Flag any highlight claim that is absent from or contradicted by the
   corresponding job bullets.
2. For each CV introduction (the `:OPENER:` heading in each variant), note any
   domain claims (e.g. "AI", "fintech") and years-of-experience claims. Verify
   each domain is traceable to at least one job entry in that CV variant. Verify
   any years-of-experience figure is consistent with the earliest job `:DATE:`
   in that CV and today's date.
3. Check that no metric (percentage, count, time saving, etc.) appears in a
   highlight with a different value than it does in the corresponding job
   bullets across either CV variant.

### Org-mode structure

1. Verify both CV variants use `#+INCLUDE` for all shared sections:
   - `basecv.org::*Header` — included directly in each CV variant in `cv.org`
   - The five closing sections are bundled under `* CV Tail :ignore:` in
     `basecv.org` and pulled in via `#+INCLUDE: "./basecv.org::*CV Tail"
     :minlevel 1` under a `** Tail :ignore:` heading at the end of each CV
     variant. Verify `* CV Tail` in `basecv.org` contains all five as
     sub-headings:
     - `** Contract Work`
     - `** Prior Engagement`
     - `** Education`
     - `** Technical Acumen`
     - `** Language Proficiencies`
2. For each CV variant, collect the highlights included via `#+INCLUDE` under
   the `Career Highlights` heading. Verify that each included highlight exists
   as a heading in `basecv.org` under `* Highlights`. Each CV variant may
   include a different subset — that is fine — but no variant should reference a
   highlight that does not exist in `basecv.org`.
3. Verify every job headline in both CVs has all required properties:
   `:POSITION:`, `:LOCATION:`, `:DATE:`.
4. Verify every `:LOCATION:` value in both `cv.org` (`:POSITION:` entries) and
   `basecv.org` (`:POSITION:`, `:PRIOR_POSITION:` entries) conforms to the
   three-part format: `Country, City/State, Mode` where `Mode` is exactly one of
   `Remote`, `Hybrid`, or `On-Site`. Flag any `:LOCATION:` that is missing the
   work-mode suffix, uses an unrecognised mode, or has the wrong number of
   comma-separated parts.
5. Verify that the export properties on each CV subtree are set:
   `:EXPORT_FILE_NAME:`, `:EXPORT_TITLE:`, `:EXPORT_DESCRIPTION:`,
   `:EXPORT_KEYWORDS:`, `:EXPORT_TAGLINE:`. Also verify that `#+AUTHOR: Benjamin
   Mezger` appears as a file-level keyword at the top of `cv.org` (author is no
   longer a per-subtree property).

### Date ordering and continuity

1. Collect all job entries (`:POSITION:` headlines) in each CV variant and
   verify they appear in reverse chronological order by start date (most recent
   first). Flag any entry that is out of sequence.
2. For consecutive job entries, compare the end date of one with the start date
   of the next. Flag any gap longer than three months as something to review —
   it may be intentional but should be verified.
3. Verify all `:DATE:` values in both `cv.org` and `basecv.org` use a consistent
   format: `Month YYYY - Month YYYY` or `Month YYYY - Current`, where month is
   the full name (e.g. `August`, not `Aug`). Flag any abbreviated month or
   year-only date.

### Export properties coherence

1. For each CV variant, verify that `:EXPORT_DESCRIPTION:` matches the title of
   the heading with the `:OPENER:` property. These should stay in sync as the
   seniority title evolves.
2. For each CV variant, verify that every technology listed in
   `:EXPORT_KEYWORDS:` appears somewhere in the CV body (job bullets,
   `cvdescription` blocks, or Technical Acumen). Flag any keyword with no
   supporting mention.

### Strengths Snapshots grid

The `bullet-grid` renderer lays out items in rows of 3. For each CV variant,
count the items in the Strengths Snapshots table and verify the count is a
multiple of 3. An item count that is not divisible by 3 will produce an
incomplete final row in the rendered PDF.

### Duplicate bullet points

Within each CV variant, verify that no bullet point is duplicated verbatim
across different job entries. Each accomplishment should appear under exactly
one employer.

### `#+BEGIN_COMMENT` block isolation

Both CV variants contain `#+BEGIN_COMMENT` blocks with alternate or retired
bullet versions. Verify that no sentence or claim from inside a comment block
appears verbatim in the active (uncommented) bullet list. The commented content
should be fully inert.

### Unclosed Org blocks

Scan both `cv.org` and `basecv.org` for every `#+BEGIN_X` directive and verify a
matching `#+END_X` follows in the same file. A missing `#+END_cvdescription` or
similar will silently corrupt the LaTeX output. Flag any unpaired block.

### No TODO or placeholder in active content

Verify that no active (non-`:noexport:`) section in either CV variant contains
the literal string `TODO` or any other placeholder text. Check both the headline
titles and body content. This catches draft entries accidentally left in the
exported document.

### Metric consistency across CV variants for shared jobs

For each company that appears in both CV variants (NOOK, CHEESECAKE LABS, and
any others with identical bullets), extract every quantified metric from the
bullets — percentages, multipliers, counts, time values (e.g. `50%`, `10x`, `5
million`, `80%`). Verify that each metric has the same value in both variants
for the same company. A drift introduced during editing (e.g. `50%` in one CV
and `60%` in the other for the same job) is a credibility risk.

### Highlight company traceability

For each highlight in `basecv.org` (under `* Highlights`), read its `:COMPANY:`
property and verify that a job headline for that company exists as an active
(non-`:noexport:`) entry in both CV variants. Flag any highlight whose company
has no corresponding active job entry — it means a company was removed from a CV
while its highlight remained.

### Years-of-experience claim validation

For each CV variant, scan the `:OPENER:` heading body for any pattern of the
form `N year(s)` (e.g. "10 years of Python expertise"). For each such claim,
verify it is consistent with `today's date − earliest job start date` across the
full career history — including active `:POSITION:` entries in `cv.org` and all
`:PRIOR_POSITION:` entries in `basecv.org` (both Contract Work and Prior
Engagement). These entries count toward tenure because they represent real work,
just presented in compact form. Flag any claim that overstates or significantly
understates the tenure implied by the combined job history.

### Bullet count per active job

For each active (non-`:noexport:`) job entry in both CV variants, count the
bullet points. Flag any entry with fewer than 3 or more than 5 bullets. Fewer
than 3 is thin; more than 5 tends to dominate the layout and may overflow the
two-page limit.

### Bullets start with a past-tense action verb

For each bullet point in both CV variants, verify it begins with a capitalised
word ending in `-ed` (past tense). Flag any bullet that starts with "I", an
article ("A", "An", "The"), a lowercase letter, or a non-action word. Exception:
bullets under a job whose `:DATE:` ends in `Current` may use present tense, but
must still be consistent within that job entry.

### At least one quantified metric per active job

For each active job entry in both CV variants, verify that at least one bullet
contains a quantified metric — a percentage, a multiplier (e.g. `2x`, `10x`), a
count, or an explicit time saving. A job entry with no metrics is comparatively
weak and may have had its numbers accidentally removed.

### Company names in ALL CAPS

For every headline that has a `:POSITION:` or `:PRIOR_POSITION:` property in
both `cv.org` and `basecv.org`, verify that the headline title (the company
name) is entirely uppercase. Flag any company name that contains a lowercase
letter. This applies to active and `:noexport:` entries alike, and to both
Contract Work and Prior Engagement sections in `basecv.org`.

---

## `Benjamin_Mezger_*.pdf`

Before checking the PDF content, verify file freshness: the `.pdf` files must be
newer than both `cv.org` and `basecv.org`. Use `stat` to compare modification
times. If either source file is newer than the `.pdf` files, the export is stale
and PDF checks cannot be trusted.

Use `pdftotext` to extract text from each PDF for content checks.

1. Verify the PDF is machine-readable: confirm text can be extracted with
   `pdftotext` (not a scanned image).
2. Confirm it's ATS friendly (text is selectable, not just an image).
3. Verify PDF metadata using `pdfinfo`:
   - Author: `Benjamin Mezger`
   - Title: `Benjamin Mezger`
   - Subject/Description matches `:EXPORT_DESCRIPTION:` for the respective CV
   - Keywords match `:EXPORT_KEYWORDS:` for the respective CV
4. Verify the PDF is exactly **two pages**.
5. Verify margins are consistent: content should not overflow page edges and
   spacing between sections should be uniform.
6. Verify the contact information block (location, phone, email, username,
   website) appears at the top of page 1.
7. Verify section order matches the source: Introduction → Career Highlights →
   Strengths Snapshots → Experience → Prior Positions → Education → Technical
   Acumen → Language Proficiencies.
8. Verify the extracted text contains no LaTeX artifacts: grep for backslashes,
   `\textbf`, `\emph`, `\begin`, `\end`, or any other LaTeX command. Their
   presence indicates a command was not processed and leaked into the visible
   output.
9. Verify the PDF contains no literal `TODO` or placeholder text.
10. Verify contact field round-trip: extract the phone number, email address,
    and website from the PDF text and confirm they match the
    `:CV_PHONE_DISPLAY:`, `:CV_EMAIL:`, and `:CV_WEBSITE:` properties in
    `basecv.org`'s Header section.
```

{{% /details %}}
