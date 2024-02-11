+++
title = "Locking Python scripts with flock"
author = ["Ben Mezger"]
date = 2021-08-22T01:42:00
aliases = ["/notes/locking_python_scripts_with_flock"]
slug = "locking-python-scripts-with-flock"
tags = ["python", "programming"]
type = "notes"
draft = false
bookCollapseSection = true
+++

-   Related pages
    -   [Python]({{<relref "2020-05-31--16-04-33Z--python.md#" >}})
    -   [Python temporary file]({{<relref "2020-08-02--19-44-21Z--python_temporary_file.md#" >}})
    -   [Synchronization]({{<relref "2021-04-04--22-25-14Z--synchronization.md#" >}})

---


## The problem {#the-problem}

I wanted to make a Python script that synchronized my emails and indexed them
with [`mu`](https://www.djcbsoftware.nl/code/mu/mu4e.html). The script would run on `systemd` and/or `launchd` every 5 minutes,
however, I would like to run the script manually too. I needed a solution
similar to a `mutex`, but file-like, nothing too complex neither 100%.


## UNIX's `flock` {#unix-s-flock}

Unix flock enables one to lock a file while the file is open by the executing
command.

```plain
NAME
        flock - manage locks from shell scripts

SYNOPSIS
        flock [options] file|directory command [arguments]
        flock [options] file|directory -c command
        flock [options] number

DESCRIPTION
        This utility manages flock(2) locks from within shell scripts or from
        the command line.

        The first and second of the above forms wrap the lock around the
        execution of a command, in a manner similar to su(1) or newgrp(1). They
        lock a specified file or directory, which is created (assuming
        appropriate permissions) if it does not already exist. By default, if
        the lock cannot be immediately acquired, flock waits until the lock is
        available.

        The third form uses an open file by its file descriptor number. See the
        examples below for how that can be used.
```

<div class="src-block-caption">
  <span class="src-block-number">Code Snippet 1</span>:
  From Archlinux's <a href="https://man.archlinux.org/man/flock.1.en">manpage</a>
</div>

This means we can use a file-based lock type with `flock` to prevent a script from
running when another script locks the file. `flock` requires a file descriptor
and an operation. The `LOCK_SH` places a shared lock, `LOCK_EX` places an
exclusive lock and `LOCK_UN` removes an existing lock.

We can `OR` `LOCK_EX` and `LOCK_NB` operation to not wait for the lock to
release and get `fcntl` to raise a `BlockingIOError`, otherwise, we can use
`LOCK_EX` to wait for the lock to release.

Python has an interface to `flock` through the [`fcntl`](https://docs.python.org/3/library/fcntl.html) module. I am not sure if
Windows supports this though.


## Implementation {#implementation}

Before we implements there is one thing we need to remember: we can never close
the file unless we want to release the lock.

```text
fcntl.flock(fd, operation)
        Perform the lock operation operation on file descriptor fd (file objects
        providing a fileno() method are accepted as well). See the Unix manual
        flock(2) for details. (On some systems, this function is emulated using
        fcntl().)

        If the flock() fails, an OSError exception is raised.

        Raises an auditing event fcntl.flock with arguments fd, operation.
```

<div class="src-block-caption">
  <span class="src-block-number">Code Snippet 2</span>:
  <a href="https://docs.python.org/3/library/fcntl.html#fcntl.flock">Python's</a> <code>flock</code> interface
</div>

Import the required Modules. Remember that we don't want any external library.

```python
import fcntl
import os
import pathlib
```

Create the lock file and save it to a common place.

```python
def lock_acquire(operation: int = fcntl.LOCK_EX | fcntl.LOCK_NB):
    """
    Acquire the flock lockfile

    Parameters
    ----------
    operation : int, optional
        The flock operation to perform (default is LOCK_EX | LOCK_NB)

    Raises
    ------
    BlockingIOError
        If perform is ORed with LOCK_NB, it raises if the file is
        already acquired by another process.

    Returns
    ------
    File
        The flock lockfile
    """
    lockname = __file__.split("/")[-1].strip(".py")
    lockfile = open(pathlib.Path().joinpath(f"/tmp/{lockname}.flock"), "w")
    fcntl.flock(lockfile, fcntl.LOCK_EX | fcntl.LOCK_NB)

    return lockfile
```

Release and close the lockfile.

```python
def lock_release(lockfile):
    """
    Release the flock lockfile

    Parameters
    ----------
    lockfile: file descriptor, required
        The lock file to release
    """
    fcntl.flock(lockfile, fcntl.LOCK_UN)
    os.close(lockfile.fileno())
```

Using the lockfile.

```python
...
lockfile = lock_acquire()
do_crazy_computation()
lock_release(lockfile)
...
```

Definitely there is lots of improvements points. We could for example create a
`class` for the lock file and implement `__exit__` and `__enter__` for context
management. But the [task](https://github.com/benmezger/dotfiles/blob/main/dot%5Fbin/executable%5Fsyncmail.tmpl) I needed was simple: run `mbsync`, then sync `mu4e`
with `emacsclient` or with `mu`.
