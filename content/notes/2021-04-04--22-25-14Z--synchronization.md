+++
title = "Synchronization"
author = ["Ben Mezger"]
date = 2021-04-04T19:25:00-03:00
slug = "synchronization"
tags = ["os", "osdev", "programming", "synchronization"]
type = "notes"
draft = false
bookCollapseSection = true
+++

tags
: [Operating Systems]({{< relref "2020-05-31--15-29-38Z--operating_systems" >}}) [Programming]({{< relref "2020-05-31--15-33-23Z--programming" >}}) [Computer Science]({{< relref "2020-05-31--15-29-21Z--computer_science" >}})

notes from the Little book of Semaphores ([Downey 2008](#orgf909852)).


## Shared variables {#shared-variables}


## Quizzes and exercises {#quizzes-and-exercises}

1.  Imagine that you and your friend Bob live in different cities, and one day,
    around dinner time, you start to wonder who ate lunch first that day, you or
    Bob. How would you find out?

    Puzzle: Assuming that Bob is willing to follow simple instructions, is there
    any way you can guarantee that tomorrow you will eat lunch before Bob?

    -   We could call a day before to synchronize our clocks precisely
    -   We could call each other before having lunch and start together


## Bibliography {#bibliography}

<a id="orgf909852"></a>Downey, Allen. 2008. _The Little Book of Semaphores_. Vol. 2. Green Tea Press. <https://github.com/AllenDowney/LittleBookOfSemaphores>.
