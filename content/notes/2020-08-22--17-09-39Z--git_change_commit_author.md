+++
title = "Git change commit author"
author = ["Ben Mezger"]
date = 2020-08-22T14:09:00-03:00
slug = "git_change_commit_author"
tags = ["git"]
type = "notes"
draft = false
bookCollapseSection = true
+++

tags
: [Programming]({{<relref "2020-05-31--15-33-23Z--programming.md#" >}}) [Software Engineering]({{<relref "2020-06-23--12-50-55Z--software_engineering.md#" >}})

The following scripts changes all repository commits from an specific author to
a new author. This is specially handy if you mess up your git config at
somepoint without knowing and start commiting with a random author or you change
your email/name.

```sh
#!/bin/sh

git filter-branch --env-filter '

OLD_EMAIL="your-old-email@example.com"
CORRECT_NAME="Your Correct Name"
CORRECT_EMAIL="your-correct-email@example.com"

if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ]
then
export GIT_COMMITTER_NAME="$CORRECT_NAME"
export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
fi
if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]
then
export GIT_AUTHOR_NAME="$CORRECT_NAME"
export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
fi
' --tag-name-filter cat -- --branches --tags
```