+++
title = "Notes on TDD - chapter 2"
author = ["Ben Mezger"]
date = 2024-02-11T01:51:00+01:00
slug = "notes_on_tdd_chapter_2"
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

With this modification, we now removed the **dollar side effect**, which we had
everytime we multiplied our dollar object.

With that, we now have **2/3 strategies** to quickly get the tests to pass:

1.  Fake it: Return a constant and gradually replace constants with variables
    until we end with the real code
2.  Use obvious implementations: type in the real implementation
