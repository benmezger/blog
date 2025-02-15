+++
title = "My journey in managing online services"
author = ["Ben Mezger"]
date = 2025-02-02T20:22:00+01:00
slug = "my_journey_in_managing_online_services"
tags = ["automation", "software", "terraform", "tools", "services"]
type = "notes"
draft = false
bookCollapseSection = true
+++

-   Related pages
    -   [My journey in managing dotfiles]({{<relref "2025-02-02--16-22-22Z--my_journey_in_managing_dotfiles.md#" >}})

---

As part of my journey to centralize and automate my computing life, one of my
annoyances is having to configure services such as DNS or GitHub repositories
every time I need to create or modify one.

I use Cloudflare to manage my domains and handle DNS configurations. Every time
I got a new domain and/or DNS configuration, I had to go to Cloudflare and
update the entries. Maybe a week later, I would realize I had made a mistake and
had to track down what I had before to roll it back. Further, I use UptimeRobot
to monitor some of my personal domains and get notified in case they become
unavailable.

Over the years, GitHub and GitLab have become a little more complex. We now have
CI/CD pipelines, deployment keys, secrets, branch rules, etc. With that,
whenever I created a new repository, I had to configure all of that. Many of my
repositories use similar configurations, so I had to replicate them across all
of them.

Managing all of that was tedious. It was difficult to remember why I had created
a dummy DNS entry in one of my Cloudflare zones, and it was tedious to configure
a GitHub/GitLab repo.

For a couple of years now, I’ve been managing all of that with [Terraform](https://www.terraform.io/). It has
reduced the risk of incorrect configurations, and I can look into the history to
remember why I made a particular change and easily revert it.

I modularized my default GitHub/GitLab settings so that once I create a
repository, it uses many of my default values unless specified otherwise. I can
now copy and paste UptimeRobot configurations and change the domain to
immediately start monitoring—no need to go to the dashboard, no need for mouse
clicks 🤓.

Finally, I use [Terraform Cloud](https://app.terraform.io/) to plan, apply, and store state, which makes it
particularly simple and cost-effective. Terraform Cloud is connected to my
GitHub repository, so on every push to `main`, it will plan and apply any
changes.
