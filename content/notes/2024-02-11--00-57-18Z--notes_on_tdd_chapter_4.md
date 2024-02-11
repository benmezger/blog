+++
title = "Notes on TDD - chapter 4"
author = ["Ben Mezger"]
date = 2024-02-11T01:57:00+01:00
slug = "notes_on_tdd_chapter_4"
tags = ["tdd", "python"]
type = "notes"
draft = false
bookCollapseSection = true
+++

-   Related pages
    -   [Test driven development]({{<relref "2024-02-05--12-22-06Z--test_driven_development.md#" >}})

---

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
