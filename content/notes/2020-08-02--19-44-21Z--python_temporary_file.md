+++
title = "Python temporary file"
author = ["Ben Mezger"]
date = 2020-08-02T16:44:00
slug = "python_temporary_file"
tags = ["python", "programming", "libs"]
type = "notes"
draft = false
bookCollapseSection = true
+++

tags
: [Python]({{<relref "2020-05-31--16-04-33Z--python.md#" >}}) [Programming]({{<relref "2020-05-31--15-33-23Z--programming.md#" >}})

Python's [tempfile](https://docs.python.org/3/library/tempfile.html) standard library is pretty neat when we need to create a
temporary file and/or directories. Instead of having a much of code like this:

```python
import pathlib

def create_file(filename):
    if pathlib.Path(filename).exists():
        # handle path removal/rewrite/backup
        pass
    with open(filename, "w") as f:
        # write to file
        pass

```

We can ask Python to take care of handling this type of tasks for us. `tempfile`
handles most of the OS API, so we can focus on writting the logic instead.

```python
import tempfile

def create_file():
    return tempfile.NamedTemporaryFile(mode="w", encoding="utf-8")

# file one
print(create_file())
print(create_file().name)

# file two
print(create_file())
print(create_file().name)
```

```text
<tempfile._TemporaryFileWrapper object at 0x1025b3d10>
/var/folders/hx/ld063wqn10g7090nkfj7jkj80000gn/T/tmprjkyct75
<tempfile._TemporaryFileWrapper object at 0x102510dd0>
/var/folders/hx/ld063wqn10g7090nkfj7jkj80000gn/T/tmpbk2ciu6k
```

[NamedTemporaryFile](https://docs.python.org/3/library/tempfile.html#tempfile.NamedTemporaryFile) returns a file-like object that can be used as a temporary
storage, however, contrary to [TemporaryFile](https://docs.python.org/3/library/tempfile.html#tempfile.TemporaryFile), a file created with
`NamedTemporaryFile` is guaranteed to have a visible name during its lifetime.
`TemporaryFile` gets destroyed as soon as the file is closed, `NamedTemporaryFile`
has support for the `delete` flags, which defaults to `True`

You can also change the default filename prefix and suffix.

```python
import tempfile

def create_file(suffix=".json", prefix="tmpfile"):
    return tempfile.NamedTemporaryFile(
        mode="w",
        encoding="utf-8",
        suffix=suffix,
        prefix=prefix,
    )

# file one

print(create_file(suffix=".csv"))
print(create_file(suffix=".csv").name)
print(create_file(suffix=".csv", prefix="hello-world").name)
```

```text
<tempfile._TemporaryFileWrapper object at 0x104db3e10>
/var/folders/hx/ld063wqn10g7090nkfj7jkj80000gn/T/tmpfile1ercgq16.csv
/var/folders/hx/ld063wqn10g7090nkfj7jkj80000gn/T/hello-worldgm4b0uc_.csv
```

With `TemporaryFile` it returns a `TextIOWrapper`:

```python
import tempfile

def create_file(suffix=".json", prefix="tmpfile"):
    return tempfile.TemporaryFile(
        mode="w",
        encoding="utf-8",
        suffix=suffix,
        prefix=prefix,
    )

# file one
print(create_file(suffix=".csv"))
print(create_file(suffix=".csv", prefix="hello-world").name)
```

```text
<_io.TextIOWrapper name=3 mode='w' encoding='utf-8'>
3
```
