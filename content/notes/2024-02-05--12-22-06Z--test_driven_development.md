+++
title = "Test driven development"
author = ["Ben Mezger"]
date = 2024-02-05T13:22:00+01:00
slug = "test_driven_development"
tags = ["tdd"]
type = "notes"
draft = false
bookCollapseSection = true
+++

-   Related pages
    -   [Python]({{<relref "2020-05-31--16-04-33Z--python.md#" >}})

---

Below are notes/tests I made during my reading session of the [Test Driven
Development: By Example](https://www.amazon.com/Test-Driven-Development-Kent-Beck/dp/0321146530) book, by Kent Beck.


## Chapter 1 {#chapter-1}

The cycle we want to follow in TDD is as follows.

1.  Add a little test
2.  Run all tests and fail
3.  Make a little change
4.  Run the tests and succeed
5.  Refactor to remove duplication

<!--listend-->

```python
class Dollar:
    amount: int

    def __init__(self, amount: int):
        self.amount = amount

    def times(self, multipler: int) -> None:
        self.amount *= multipler
```

> If dependency is the problem, duplication is the symptom

Something the author mentions which I never thought about it on reducing
duplication, is the fact that `self.amount = self.amount * multiplier` is code
duplication when we compare with `self.amount *​​= multiplier`.

```text
None
```

```python
def test_multiplication():
    d = Dollar(5)
    d.times(2)
    assert d.amount == 10
```

```python
for k, v in globals().items():
    if k.startswith("test_"):
        print(f"Running {k}")
        v()
        print(f"{k} passed!")
```


## Chapter 2 {#chapter-2}

When TDDing, for each step, think about:

1.  Add a little test: think how I wish the interface would look like. Remember
    we are writing a story and include all the elements in the story I think will
    be necessary to reach the right answer.
2.  Run all test: Make the bar go green quickly. If the solution is obvious,
    write it in, but if it takes 1min or more, then make a note about it and get
    back to main problem.
3.  Make a little change: Remove all sins we left in the code, the duplication
    that we introduced and get back to making the test pass.

> Our goal is to have clean code that works.

The previous currency implementation, when we call `times` we are changing the
Dollar object. Before I had 5 dollars, and after calling `times`, I now have 20
dollars. It makes sense to instead return a new Dollar object, keeping the
original value.

```python
class DollarV2:
    amount: int

    def __init__(self, amount: int):
        self.amount = amount

    def times(self, multipler: int) -> "DollarV2":
        return DollarV2(self.amount * multipler)
```

```python
def test_multiplication():
    d = DollarV2(5)
    d_ten = d.times(2)
    assert d_ten.amount == 10
```

```python
for k, v in globals().items():
    if k.startswith("test_"):
        print(f"Running {k}")
        try:
            v()
            print(f"{k} passed!")
        except Exception as err:
            print(f"{k} failed with {err.__class__.__name__}")
```

```text
Running test_equality
test_equality passed!
Running test_times
test_times failed with AttributeError
Running test_multiplication
test_multiplication passed!
```

With this modification, we now removed the **dollar side effect**, which we had
everytime we multiplied our dollar object.

With that, we now have **2/3 strategies** to quickly get the tests to pass:

1.  Fake it: Return a constant and gradually replace constants with variables
    until we end with the real code
2.  Use obvious implementations: type in the real implementation


## Chapter 3 {#chapter-3}

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

```python
def run_tests():
    for k, v in globals().items():
        if k.startswith("test_"):
            print(f"Running {k}")
            try:
                v()
                print(f"{k} passed!")
            except Exception as err:
                print(f"{k} failed with {err.__class__.__name__}")
```

```python
run_tests()
```

Now the bar is green again, but we hardcoded `True` in our `__eq__` method.


### <span class="org-todo done DONE">DONE</span> Triangulation {#triangulation}

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

```text
Running test_equality
test_equality passed!
```

In practice, what we are actually doing is using two assertions to drive the
generalization of the code. Triangulation provides us a way to think about the
problem from a different direction.


## Chapter 4 {#chapter-4}

This chapter is straightforward. The problem is that our `amount` is public.
Anyone can change, and we don't want to allow tests to access it. What happens
if we delete that variable and move it somewhere else? We will have to update
the test. Lets refactor it.

```python
class DollarV5:
    _amount: int

    def __init__(self, amount: int):
        self._amount = amount

    def times(self, multipler: int) -> "DollarV5":
        return DollarV5(self._amount * multipler)

    def __eq__(self, value: "DollarV5") -> bool:
        return self._amount == value.amount
```

We should keep `__eq__` as is. Yes, this will break our next test, but its fine
for now.

```python
def test_times():
    five = DollarV5(5)
    assert five.times(2) == DollarV5(10)

run_tests()
```

Aaaaaand it broke. It says `AttributeError` because it could not find `amount`
attribute when making the comparison against the `value` passed.

```text
Running test_times
test_times failed with AttributeError
```


## <span class="org-todo todo TODO">TODO</span> Chapter 5 {#chapter-5}


## References {#references}

1.  [Aliasing](https://en.wikipedia.org/wiki/Aliasing%5F(computing))
2.  [Value Object](https://en.wikipedia.org/wiki/Value%5Fobject)
