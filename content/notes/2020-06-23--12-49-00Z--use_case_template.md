+++
title = "Use case template"
author = ["Ben Mezger"]
date = 2020-06-23T09:49:00-03:00
slug = "use_case_template"
tags = ["programming", "methodology", "cs"]
type = "notes"
draft = false
bookCollapseSection = true
+++

tags
: [Computer Science]({{< relref "2020-05-31--15-29-21Z--computer_science" >}}) [Programming]({{< relref "2020-05-31--15-33-23Z--programming" >}}) [Methodologies]({{< relref "2020-06-23--12-50-09Z--methodologies" >}}) [Software Engineering]({{< relref "2020-06-23--12-50-55Z--software_engineering" >}})

The following is a requirements template developed by [Alistair Cockburn](https://heartofagile.com/alistair-cockburn/).
This template may or may not have all or more fields related to the requirements
itself.

Recommended reading:

- [Basic Use Case Template](</ox-hugo/Use-Case-Template (Cockburn).pdf>)

---

| USE CASE **#N**       | _<The name of the goal as a short active verb phrase>_                     |
| --------------------- | -------------------------------------------------------------------------- |
| Goal in context       | _<A longer statement of the goal in context if needed>_                    |
| Scope                 | _<What system is being considered back box under design>_                  |
| Level                 | _<one of: Summary, Primary task, Subfunction>_                             |
| Preconditions         | _<what we expect is already the state of the world>_                       |
| Success end condition | _<the state of the world upon successful completion>_                      |
| Failed end condition  | _<the state of the world if goal abandoned>_                               |
| Primary actor         | _<a role name for the primary actor, or description>_                      |
| Trigger               | _<the action upon the system that starts the use case, may be time event>_ |
| Priority              | _<how critical to your system/organization>_                               |
| Frequency             | _<how often it is expected to happen>_                                     |

Usage example:

## User profile {#user-profile}

| USE CASE **#1**       | Create user account                                                 |
| --------------------- | ------------------------------------------------------------------- |
| Goal in context       | Client expects to create and account                                |
| Scope                 | User account system                                                 |
| Level                 | Primary task                                                        |
| Preconditions         | User model exists and ready to save new users                       |
| Success end condition | User gets account created and receives a notification upon creation |
| Failed end condition  | Unable to create user                                               |
| Primary actor         | User                                                                |
| Trigger               | Invocation of user creation                                         |
| Priority              | Top priority                                                        |
| Frequency             | Common, users create new account from time to time                  |
