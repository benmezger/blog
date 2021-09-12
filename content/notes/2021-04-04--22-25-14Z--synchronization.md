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

-   Related pages
    -   [Operating Systems]({{<relref "2020-05-31--15-29-38Z--operating_systems.md#" >}})
    -   [Programming]({{<relref "2020-05-31--15-33-23Z--programming.md#" >}})
    -   [Computer Science]({{<relref "2020-05-31--15-29-21Z--computer_science.md#" >}})
    -   [Software Engineering]({{<relref "2020-06-23--12-50-55Z--software_engineering.md#" >}})
    -   [Computer Architecture]({{<relref "2020-05-31--16-01-33Z--computer_architecture.md#" >}})

---

Notes from the Little book of Semaphores ([Downey 2008](#org499677f)).


## Shared variables {#shared-variables}

-   Many applications enforce the constraint that the reader should not read until
    after the writer writes, this is because the reader may read an old value if
    the writer hasn't written to the variable yet
-   A thread may also interact as concurrent writes (two or more writers) and
    concurrent updates (two or more threads performing a read followed by a
    write)
-   Think about what paths (execution paths) are possible and what are the
    possible effects. Ask yourself if you can you prove that a given (desirable)
    effect is necessary or that a undesirable effect is impossible


## Semaphores {#semaphores}

-   A semaphore is like an integer, with three differences
    -   A semaphore can have its value initialized to any number, but after that
        only an increment and decrement operation is allowed, and you are not
        allowed to read the current value of the semaphore
    -   When a thread decrements the semaphore, if the result is negative, the
        thread blocks itself and cannot continue until another thread increments the
        semaphore
    -   When a thread increments the semaphore, if there are other threads waiting,
        one of the waiting threads gets unblocked
-   If the value of the semaphore is positive, it representes the number of
    threads that can decrement without blocking. If it is negative, it represents
    the number of threads that have blocked and are waiting. If the value is zero,
    it means there are no threads waiting.


## Quizzes and exercises {#quizzes-and-exercises}


### Shared variables {#shared-variables}

1.  _Imagine that you and your friend Bob live in different cities, and one day,_
    _around dinner time, you start to wonder who ate lunch first that day, you or_
    _Bob. How would you find out?_

    _Puzzle: Assuming that Bob is willing to follow simple instructions, is there_
    _any way you can guarantee that tomorrow you will eat lunch before Bob?_

    -   We could call a day before to synchronize our clocks precisely
    -   We could call each other before having lunch and start together
2.  Given the following threads, and a shared variable `x`:

    | # | Thread A | Thread B |
    |---|----------|----------|
    | 1 | x = 5    | x = 7    |
    | 2 | print(x) |          |

For example, given thread A as `a` and thread B as `b`, we could have: _a1 <
a2 < b1_

1.  What path yields output 5 and final value 5?
2.  What path yields output 7 and final value 7?
3.  Is there a path that yields output 7 and final value 5? Can you prove it?

---

1.  _a1 < a2 < a1_ or _a1 < a2_
2.  _b1 < a2 < b1_ or _b1 < a2_
3.  Yes, _b1 < a2 < a1_


## Bibliography {#bibliography}

<a id="org499677f"></a>Downey, Allen. 2008. _The Little Book of Semaphores_. Vol. 2. Green Tea Press. <https://github.com/AllenDowney/LittleBookOfSemaphores>.