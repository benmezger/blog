+++
title = "Attaching Jira issues to commit"
author = ["Ben Mezger"]
date = 2020-05-24T02:39:00
aliases = ["/posts/attaching-jira-issues-to-commits/"]
slug = "attaching-jira-issues-to-commits"
tags = ["git", "projects", "software"]
type = "notes"
draft = false
bookCollapseSection = true
+++

-   Related pages
    -   [Git change commit author]({{<relref "2020-08-22--17-09-39Z--git_change_commit_author.md#" >}})
    -   [Programming]({{<relref "2020-05-31--15-33-23Z--programming.md#" >}})

---

{{< expand TLDR >}}
Dynamically attach Jira attributes to commit body using git-hook.
Check the project's [README](https://github.com/benmezger/gjira/).
{{< /expand >}}

The place I work at requires Jira story ID and task ID attached to the commit
body. Initially, I was attaching the ID to the commit body manually, by checking
either my previous commit or opening up the Jira board, however, after working
some hours I was easily forgetting to attach the IDs to the commit and getting
annoying having to either reword them and perhaps having to lookup Jira again.

This was tedious and frustrating, so I wrote a Git hook using [pre-commit](https://pre-commit.com) to
handle and install the hook. Our workflow requires the task ID to be attached to
the branch same, like so: `SKYR-123_branch-description`, so Jira is capable of
logging commits related to task branches[^fn:1].
This makes it easy for the hook to know which task are you working on before
writing to the commit body. As it checks whether you are in a task branch or any
other branch. The Jira ID branch is configurable by specifying a regex for the
Jira ID, like so: `SKYR-\d+`.

Git provides a `pre-commit-msg` hook, which prepares the default commit message
before prompting the user for the commit description/body. To allow
extensibility, the hook handles custom Git template with [Jinja](https://jinja.palletsprojects.com/en/2.11.x/templates/), so each project
may have a custom commit template.

For example, the following template will write the task ID, story ID (if any)
and task description.

```text
Task description: {{ summary }}
Jira task ID: {{ key }}
{% if parent__key %}Jira story ID: {{ parent__key }}{% endif %}
```

The fields are related to Jira's REST fields. Inner fields such as `parent.key`
should replace the dot (`.`) with a double underscore (`__`).

I named the project [GJira](https://github.com/benmezger/gjira/) , as of Git-Jira.

[^fn:1]: <https://www.atlassian.com/blog/bitbucket/integration-tips-jira-software-bitbucket-server>
