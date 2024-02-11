+++
title = "Notes on TDD - chapter 3"
author = ["Ben Mezger"]
date = 2024-02-11T01:53:00+01:00
slug = "notes_on_tdd_chapter_3"
tags = ["tdd", "python"]
type = "notes"
draft = false
bookCollapseSection = true
+++

-   Related pages
    -   [Test driven development]({{<relref "2024-02-05--12-22-06Z--test_driven_development.md#" >}})

---

We can use objects as values (similar to how we are using `Dollar). This is
called *Value Object*. The values of the instance variables of the object
*never* changes once they have been set my the constructor. This is exactly the
case with our current =Dollar` implementation, where once we set the amount, it
will stay as is. If we call `times`, it will return a new Value Object.

Using Value Object prevents us from worrying about aliasing problems. **Aliasing**
is when changing the first value of an object inadvertently changes the value of
another object.

> In computing, aliasing describes a situation in which a data location in memory
> can be accessed through different symbolic names in the program.

When dealing with Value Object (and to prevent aliasing), **all operations must
returns a new object**. Another implication, is that Value Objects need to
implement `equals()`.
Say if we use `Dollar` as the key for a dictionary/hash table, then we need to
implement the hash code function if we implement `equals()`.

How can we test equality with our `Dollar` object?

```python
class DollarV3:
    amount: int

    def __init__(self, amount: int):
        self.amount = amount

    def times(self, multipler: int) -> "DollarV3":
        return DollarV3(self.amount * multipler)

    def __eq__(self, value: "DollarV3") -> bool:
        return True
```

```python
def test_equality():
    a = DollarV3(5)
    b = DollarV3(5)
    assert a == b
```

```text
Running test_equality
test_equality passed!
```

Now the bar is green again, but we hardcoded `True` in our `__eq__` method.


## <span class="org-todo done DONE">DONE</span> Triangulation {#triangulation}

_Triangualation_ is a weird concept that took me some minutes to understand the
reason behind it. The idea behind is simple: we only generalize the code when we
have two examples or more (_i.e._ assertions). When we then demand a more
general solution, **then we generalize**.

```python
def test_equality():
    assert DollarV3(5) == DollarV3(5)
    assert DollarV3(5) != DollarV3(6)

run_tests()
```

Our last assertion failed because we've hardcoded `True` as the return type.
The second assertion is our triangulation. At this point, we can move forward
with generalization.

```python
class DollarV4(DollarV3):
    def __eq__(self, value: "DollarV3") -> bool:
        return self.amount == value.amount
```

```python
def test_equality():
    a = DollarV4(5)
    b = DollarV4(6)
    assert DollarV4(5) == DollarV4(5)
    assert DollarV4(5) != DollarV4(6)

run_tests()
```

And voila!

In practice, what we are actually doing is using two assertions to drive the
generalization of the code. Triangulation provides us a way to think about the
problem from a different direction.


## References {#references}

1.  [Aliasing](https://en.wikipedia.org/wiki/Aliasing%5F(computing))
2.  [Value Object](https://en.wikipedia.org/wiki/Value%5Fobject)
