+++
title = "Technical challenge checklist"
author = ["Ben Mezger"]
date = 2020-10-16T07:43:00-03:00
slug = "technical_challenge_checklist"
tags = ["programming", "checklist"]
type = "notes"
draft = false
bookCollapseSection = true
+++

tags
: [Programming]({{< relref "2020-05-31--15-33-23Z--programming" >}}) [Software Engineering]({{< relref "2020-06-23--12-50-55Z--software_engineering" >}})

Having done quiet a lot of technical challenges, and having forgotten some
details when submitting, I came up with a good checklist of things to check
before submitting the technical test.

## Must do checklist {#must-do-checklist}

- [ ] Keep commit readable, check if the company has any commit format of their
      own in their public GitHub organization or their wiki page (if any),
      otherwise, use [conventional commits](https://www.conventionalcommits.org/en/v1.0.0/)
- [ ] Structure your commits so we can revert in case of any bug. Make your
      `git` history ready for production, see [Personal git workflow]({{< relref "2020-08-04--14-06-04Z--personal_git_workflow" >}})
- [ ] Use well stable, known libraries
- [ ] Document your decisions of _why_, _where_ and _how_
- [ ] Write tests for **everything your write**
- [ ] Run static code analysers and make sure there aren't any undefined
      variables
- [ ] Benchmark what you wrote for validating algorithms/project
- [ ] Configure and use a linter

## Technical project {#technical-project}

- [ ] Use environment variables for secrets, api urls, debugging and general
      configuration
- [ ] Enable application logging where needed
- [ ] Document reusable API functions
- [ ] Lock dependency versions
- [ ] Take some time to think of the project structure, create diagrams, check
      out related project's structure
- [ ] Read and re-read the requirements, if you have any doubts, `do` ask the
      developers/human resources
- [ ] HTTP API? Run a stress test against your API
- [ ] Containerize your application
- [ ] Last but not least, have fun learning

## Algorithms {#algorithms}

- [ ] Document algorithm decisions and steps
- [ ] Make algorithm comparison if possible
- [ ] Don't over complicate. It's not because it's an algorithm that it requires
      to be unreadable
- [ ] Make sure the algorithm you are applying is well suited for the task
- [ ] Don't panic, you are not supposed to know all algorithms out there, but
      you are supposed to know where to search and implement your findings

## Bonus {#bonus}

- [ ] Add CI integration (CircleCI, Travis, GitHub Workflow, etc)
