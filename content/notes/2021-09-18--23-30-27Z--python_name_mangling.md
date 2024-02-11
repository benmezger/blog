+++
title = "Python's name mangling"
author = ["Ben Mezger"]
date = 2021-09-18T20:30:00
slug = "python_name_mangling"
tags = ["testing", "python"]
type = "notes"
draft = false
bookCollapseSection = true
+++

-   Related pages
    -   [Python]({{<relref "2020-05-31--16-04-33Z--python.md#" >}})
    -   [Programming]({{<relref "2020-05-31--15-33-23Z--programming.md#" >}})

---

Python's convention of prefixing a name with an underscore (`_handle_error()`)
is treated as a non-public part of the API by the community, but we can still
access it if we want. This Python convention also eases the work when
unit-testing these methods.

```python
class Account:
    def name(self):
        return self._name

    @property
    def _name(self):
        return "Anonymous"

acc = Account()

print(acc.name())
print(acc._name)
```

```text
Anonymous
Anonymous
```

But what happens when we use two underscores (`__handle_error()`)?

```python
class Account:
    def name(self):
        return self.__name

    @property
    def __name(self):
        return "Anonymous"

acc = Account()

print(acc.name())
print(acc.__name)
```

```text
Anonymous
```

```python
Traceback (most recent call last):
  File "<stdin>", line 12, in <module>
AttributeError: 'Account' object has no attribute '__name'
```

Although Python has limited support to such mechanisms, it does do some name
mangling to provide such functionality. We can still access the `__name=`
property by calling the property through its mangled name.

```python
class Account:
    def name(self):
        return self.__name

    @property
    def __name(self):
        return "Anonymous"

acc = Account()

print(acc.name())
print(acc._Account__name)
```

```text
Anonymous
Anonymous
```

> Since there is a valid use-case for class-private members (namely to avoid name
> clashes of names with names defined by subclasses), there is limited support for
> such a mechanism, called name mangling. Any identifier of the form \_\_spam (at
> least two leading underscores, at most one trailing underscore) is textually
> replaced with \_classname\_\_spam, where classname is the current class name with
> leading underscore(s) stripped. This mangling is done without regard to the
> syntactic position of the identifier, as long as it occurs within the definition
> of a class.
>
> -- <https://docs.python.org/3/tutorial/classes.html#private-variables>

The mangled name is in the form of `__<classname>__<name>`. The name mangling
helps let subclasses override methods without breaking intraclass method calls.

****What about testing?****

Now things are much easier when we want to test a doubled underscore
method/property: use the `_classname_name` attribute of the object:

```python
class Account:
    def name(self):
        return self.__name

    @property
    def __name(self):
        return "Anonymous"

# somewhere in your test..
# ..

acc = Account()
assert acc.name() == "Anonymous" # passes
assert acc._Account__name == "Anonymous" # pass
```

****Cython****

Python seems to define the mangling object in the [`pycore_compile.h`](https://github.com/python/cpython/blob/bb3e0c240bc60fe08d332ff5955d54197f79751c/Include/internal/pycore%5Fcompile.h#L26) header and
implement it in the [`compile.c`](https://github.com/python/cpython/blob/c2f1e953371c25f6c42b599ba3d8797effbb503e/Python/compile.c#L353) file, enabling us to access through the [`ctype`](https://docs.python.org/3/library/ctypes.html)
library like so:

```python
from ctypes import pythonapi, py_object
py_mangle = pythonapi._Py_Mangle
py_mangle.argtypes = py_object, py_object
py_mangle.restype = py_object

print(py_mangle('MyClass', '__privmethod'))
```

Further, the symbol lookup seems to happen in the [`symtable_lookup`](https://github.com/python/cpython/blob/054e9c84ac7c394941bba3ea1829d14dce1243fc/Python/symtable.c#L1016) function.
