+++
title = "Notes on TDD - chapter 1"
author = ["Ben Mezger"]
date = 2024-02-11T01:48:00+01:00
slug = "notes_on_tdd_chapter_1"
tags = ["tdd", "python"]
type = "notes"
draft = false
bookCollapseSection = true
+++

-   Related pages
    -   [Test driven development]({{<relref "2024-02-05--12-22-06Z--test_driven_development.md#" >}})

---

Below are notes/tests I made during my reading session of the [Test Driven
Development: By Example](https://www.amazon.com/Test-Driven-Development-Kent-Beck/dp/0321146530) book, by Kent Beck.

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

```python
def test_multiplication():
    d = Dollar(5)
    d.times(2)
    assert d.amount == 10
```
