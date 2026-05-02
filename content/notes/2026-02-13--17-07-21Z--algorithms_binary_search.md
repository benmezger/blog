+++
title = "Algorithms: Binary Search"
author = ["Ben Mezger"]
date = 2026-02-13T18:07:00+01:00
slug = "algorithms_binary_search"
tags = ["algorithms"]
type = "notes"
draft = false
bookCollapseSection = true
+++

&gt; [!info]
&gt; This and the following posts, are all based on following books:
&gt;
&gt; + Introduction to Algorithms, by Thomas Cormen
&gt; + Grokking Algorithms, by Aditya Bhargava
&gt;
&gt; As well as some online resources.

{{< katex />}}

While revisiting some common algorithms, I decided to document them with
explanations covering how they work, why they're used, and their time
complexity. Some of these we use so frequently in our daily work that we forget
how they're actually implemented.

Suppose you want to call your friend Sara, so you open your contact book in your
phone to find her number, but you have more than 100 contacts stored, while your
phone stores these contacts **ordered** alphabetically. You could go one by one to
find Sara, but instead, you will probably scroll all the way to the middle of
your contact list. If you end up in the letter `k`, you will probably scroll a
little more until you reach `s` and find Sara. You are unconsciously using
binary search.

Binary search will eliminate half of the remaining contact list every time,
until you are left with only one item.

Binary search requires an **ordered** list. A binary search can return the position
of where an item is located, or `null` when it's not in the list.

```nil
binary_search("Sara", ["Ana", "Ben", "Kay", "Mathew", "Sara", "William"])
=> 4
binary_search("Bob", ["Ana", "Ben", "Kay", "Mathew", "Sara", "William"])
=> null
```

For any list of \\(n\\), binary search will take \\(\log\_2(n)\\) steps to run in the worst
case.

<a id="code-snippet--binary-search-fn"></a>
```python
def binary_search(arr: list[int], v: int) -> int | None:
    # left and right keeps track of which parts of the list
    # we are currently searching. For example:
    # left       right
    #  ∨           ∨
    # [1, 2, 3, 4, 5]
    left = 0
    right = len(arr) - 1

    # While we haven't narrowed down to a single element
    while left <= right:
        # check the middle element each time. Make sure to round the
        # number
        mid = (left + right) // 2
        # current value we are looking at in the current iteration
        current = arr[mid]

        # check if current is too high
        if current > v:
            right = mid - 1
        # check if current is too low
        elif current < v:
            left = mid + 1
        # we found the item, so we return its position
        else:
            return mid
    # we haven't found the item
    return None
```

With that, if we were to find \\(6\\) in a list of \\([1, 2, 3, 4, 5, 6, 7, 8, 9,
10]\\), the following would happen:

```text
arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
v = 6

Step 1: left=0, right=9, mid=(0+9)//2=4
        arr[4]=5, 5 < 6 => left = mid+1 = 5

Step 2: left=5, right=9, mid=(5+9)//2=7
        arr[7]=8, 8 > 6 => right = mid-1 = 6

Step 3: left=5, right=6, mid=(5+6)//2=5
        arr[5]=6, 6 == 6 => return 5
```

If we are looking at an array of 180K items, the worst search would take
\\(\log\_2(180K) = 17\\) steps to find the item.

{{% details "Logarithms" "[true]" %}}

\\(\log\_{10}{100}\\) is like asking "_how many $10$s do we multiply together to get
\\(100\\)?_"

\\(\log\_{n}\\) is the opposite of exponentials:

| \\(a^b = c\\)     | \\(\log\_{a}{c} = b\\)     |
|-------------------|----------------------------|
| \\(10^2 = 100\\)  | \\(\log\_{10}{100} = 2\\)  |
| \\(10^3 = 1000\\) | \\(\log\_{10}{1000} = 3\\) |
| \\(2^3 = 8\\)     | \\(\log\_{2}{8} = 3\\)     |
| \\(2^4 = 16\\)    | \\(\log\_{2}{16} = 4\\)    |
| \\(2^5 = 32\\)    | \\(\log\_{2}{32} = 5\\)    |

{{% /details %}}

So to sum it up, binary search runs in **logarithmic time**, of \\(O(\log\_{n})\\).


## Binary search vs linear search {#binary-search-vs-linear-search}

Below is how long each search takes, based on the number of elements in a list

Binary search:

```python
from helpers import benchmark

for size in [100, 1000, 10000, 100000]:
    arr = list(range(size))
    benchmark(lambda a: binary_search(a, size - 1), arr, size, number=10000, name="binary_search")
```

```text
100 binary_search: 0.000540 ms
1000 binary_search: 0.001462 ms
10000 binary_search: 0.015824 ms
100000 binary_search: 0.157571 ms
```

Linear search:

<a id="code-snippet--linear-search-fn"></a>
```python
def linear_search(arr: list[int], v: int) -> int | None:
    for index, item in enumerate(arr):
        if item == v:
            return index
    return None
```

```python
from helpers import benchmark

for size in [100, 1000, 10000, 100000]:
    arr = list(range(size))
    benchmark(lambda a: linear_search(a, size - 1), arr, size, number=10000, name="linear_search")
```

```text
100 linear_search: 0.001979 ms
1000 linear_search: 0.013516 ms
10000 linear_search: 0.141513 ms
100000 linear_search: 1.447564 ms
```

Big difference right there 😌.


## Alternative binary search {#alternative-binary-search}

With some reading, I found out there is an alternative implementation to our
binary search. In our implementation, we checked if \\(mid\\) is equal to our target
value in every iteration. There is a way for us to leave this out during each
iteration and it would perform this check only when we are left with a single
element (\\(left = right\\)), resulting in a faster comparison loop, because we
elimitate one comparison per iteration.

<a id="code-snippet--binary-search-alt-1-fn"></a>
```python
def binary_search(arr: list[int], v: int) -> int | None:
    left = 0
    right = len(arr) - 1

    # While we haven't narrowed down to a single element
    while left < right:
        # check the middle element each time. Make sure to round the
        # number
        mid = left + (right - left) // 2
        # current value we are looking at in the current iteration
        current = arr[mid]

        # check if current is too high
        if current < v:
            left = mid + 1
        # check if current is too low
        else:
            right = mid

    if arr[left] == v:
        return left
    return None
```

If we were to find for \\(6\\) in an array of \\([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]\\), it
would take a slightly different steps:

```text
arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
v = 6

Step 1: left=0, right=9, mid=0+(9-0)//2=4
        arr[4]=5, 5 < 6 => left = mid+1 = 5

Step 2: left=5, right=9, mid=5+(9-5)//2=7
        arr[7]=8, 8 >= 6 => right = mid = 7

Step 3: left=5, right=7, mid=5+(7-5)//2=6
        arr[6]=7, 7 >= 6 => right = mid = 6

Step 4: left=5, right=6, mid=5+(6-5)//2=5
        arr[5]=6, 6 >= 6 => right = mid = 5

Step 5: left=5, right=5 => loop exits (left < right is false)

Final check: arr[left]=arr[5]=6, 6 == 6 => return 5
```

And if we run a little benchmark to compare with our previous binary search
implementation:

```python
from helpers import benchmark

for size in [100, 1000, 10000, 100000]:
    arr = list(range(size))
    benchmark(lambda a: binary_search(a, size - 1), arr, size, number=10000, name="binary_search")
```

```text
100 binary_search: 0.000769 ms
1000 binary_search: 0.001918 ms
10000 binary_search: 0.014585 ms
100000 binary_search: 0.163134 ms
```

A little faster! This was first proposed by Hermann Bottenbruch.


## Recursive binary search {#recursive-binary-search}

We can also implement a binary search recursively:

<a id="code-snippet--binary-search-alt-2-fn"></a>
```python
def binary_search(arr: list[int], v: int) -> int | None:
    left = 0
    right = len(arr) - 1
    return _rbinary_search(arr, v, right, left)


def _rbinary_search(arr: list[int], v: int, right: int, left: int) -> int | None:
    while left <= right:
        mid = (left + right) // 2
        current = arr[mid]

        if current > v:
            right = mid - 1
            return _rbinary_search(arr, v, right, left)
        elif current < v:
            left = mid + 1
            return _rbinary_search(arr, v, right, left)

        return mid
```

And if we look at its performance in comparison to our non-recursive
implementation:

```python
from helpers import benchmark

for size in [100, 1000, 10000, 100000]:
    arr = list(range(size))
    benchmark(lambda a: binary_search(a, size - 1), arr, size, number=10000, name="recursive_binary_search")
```

```text
100 recursive_binary_search: 0.000914 ms
1000 recursive_binary_search: 0.002077 ms
10000 recursive_binary_search: 0.012314 ms
100000 recursive_binary_search: 0.106165 ms
```

It's slightly slower. Although at larger sizes the recursive version appears
faster, this is likely due to my benchmark variance.


## Summary {#summary}

-   Binary search is a **lot** faster than linear search when dealing with ordered
    lists
-   \\(O(\log\_n)\\) is faster than \\(O(n)\\), and it gets a **lot faster** once the list of
    items grows


## Questions {#questions}

1.  With a sorted list of 238 items, using a binary search, what would be the
    maximum numbers of steps it would take?

    **Answer: \\(\log\_{2}{238} = ~7.8\\)**
2.  And 128 names?

    **Answer: \\(\log\_{2}{128} = 7\\)**
3.  What about 96,000?

    **Answer: \\(\log\_{2}{96,000} = ~16.5\\)**
