+++
title = "Personal git workflow"
author = ["Ben Mezger"]
date = 2020-08-04T11:06:00-03:00
slug = "personal_git_workflow"
tags = ["git", "workflow"]
type = "notes"
draft = false
bookCollapseSection = true
+++

tags
: Git [Programming]({{< relref "2020-05-31--15-33-23Z--programming" >}}) Workflow

As of today, this is currently my git flow for most of my projects.

## Commit messages {#commit-messages}

From: <https://chris.beams.io/posts/git-commit/>

- `Feat`: Any code that contains **only** a new feature, whether a new model
  field, a new API flag, etc
- `Refactor`: Any general code refactoring that does not contain anything new
  nor fixes anything.
- `Chore`: Anything related to the build configuration, dependency updates
- `Docs`: Anything related to documentation. This could be a function/class doc,
  READMEs, etc.
- `Fix`: Anything that fixes a bug or any bad business logic

Don't commit unrelated code, it's easy for us to quickly change a function name
and commit together with the new feature. Don't do that. Separate your commits
nicely, it will be much easier to revert commits, view logs and understand the
development flow of a project.

### Capital vs lower case {#capital-vs-lower-case}

I like things in capital, both the type and the commit message, but that's just
my preference. Follow the project best pratices, if they use lower, stick with
that.

## Branches {#branches}

Branches are temporary, but they do appear in a merge commit, so make sure the
branch name makes sense.
Branch names are separated by what they bring to the code-base (`fix`, `feat`,
`refactor`, etc). This make it easier to read logs, you know immediately from a
merge commit that some feature that does X was merged.

Examples:

- `feat/create-read-syscall`
- `fix/remove-bad-create-user-flag`
- `refactor/move-syscalls-to-syscallsdir`
- `chore/update-external-dependencies`

## Code tests {#code-tests}

I've seen lots of repositories with test commits, where they usually bring a new
test to some specific function. These are fine if you are adding a new test to
something that existed long before, however, if you are writing a new function
together with the test, make sure you commit **both** together. This allows us to
revert a specific commit without having to revert twice in case the test is some
commit after/before the feature.

Don't:

```nil
5e2ac95 | * Fix: install dotenv on base not in dev, cause it is always used on app init
d0b041f | * Test: Add models tests
52b781d | * Feat: added version control models
```

Do:

```nil
5e2ac95 | * Fix: install dotenv on base not in dev, cause it is always used on app init
52b781d | * Feat: added version control models
```

I tend to indeed make test commit messages, however, before pushing the branch,
I run a `git rebase -i` so I can fixup commits that should be together and
reorganize the order of them.

Before a rebase:

```nil
cadf28c Test: Add question type tests [Ben Mezger]
b0a4537 Test: Add surveyadmin list test [Ben Mezger]
b0a40a7 Feat: Add institution to SurveyAdmin's list_filter [Ben Mezger]
bb0c7b0 Feat: Add question 'type' to SurveyAdmin's list_display [Ben Mezger]
842133a Feat: Enable list_filter for SurveyQuestionAdmin [Ben Mezger]
849823a Test: Add list filter tests [Ben Mezger]
cadf28c Feat: Add list_filter for user admin [Ben Mezger]
bd12b9c Fix: Migrate question type to survey response [Ben Mezger]
```

After a rebase:

```nil
b0a40a7 Feat: Add institution to SurveyAdmin's list_filter [Ben Mezger]
bb0c7b0 Feat: add question 'type' to SurveyAdmin's list_display [Ben Mezger]
849823a Feat: Enable list_filter for SurveyQuestionAdmin [Ben Mezger]
cadf28c Feat: Add list_filter for user admin [Ben Mezger]
bd12b9c Fix: Migrate question type to survey response [Ben Mezger]
```

## Merges {#merges}

Merging outside a service like Github? Then make sure you use `git merge --no-ff` instead of a `git merge`. This will prevent git from executing a
fast-forward.

## Keep it clean, stupid {#keep-it-clean-stupid}

Make sure you logs are readable. Having bad logs is the same as not having logs
at all. Make sure you keep a readable history for yourself and others. Debugging
bad commits will be **much** easier when running `git bisect` and your coworkers
will thank you.
