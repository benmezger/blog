+++
title = "Algorithms: Selection and Insertion Sort"
author = ["Ben Mezger"]
date = 2026-02-15T14:55:00+01:00
slug = "algorithms_selection_and_insertion_sort"
tags = ["algorithms"]
type = "notes"
draft = false
bookCollapseSection = true
+++

-   Related pages
    -   [Algorithms: Binary Search]({{< relref "2026-02-13--17-07-21Z--algorithms_binary_search.md" >}})

---

&gt; [!info]
&gt; This and the following posts, are all based on following books:
&gt;
&gt; + Introduction to Algorithms, by Thomas Cormen
&gt; + Grokking Algorithms, by Aditya Bhargava
&gt;
&gt; As well as some online resources.

{{< katex />}}

Suppose we have an array of movies, where each item contains a tuple with the
name and the average of number of views, and we want to sort them from
highest-rated to lowest-rated:

```text
movies = [
    ("Movie A", 8.3),
    ("Movie B", 9.3),
    ("Movie C", 10.0),
    ("Movie D", 7.4),
    ("Movie E", 10.0)
]
```

Two simple sorting algorithms we could use are **insertion sort** and **selection
sort**.


## Insertion sort {#insertion-sort}

Insertion sort will insert each element into the sorted portion of the array,
and shifts **multiple elements per iteration**. The best case for a insertion sort
is \\(O(n)\\). Worst case is \\(O(n^2)\\).

<a id="code-snippet--insertion-sort-fn"></a>
```python
def sort_movies(arr: list[tuple[str, float]]) -> None:
    n = len(arr)

    for i in range(1, n):
        current = arr[i]
        j = i - 1

        # Worst case O(n^2): reverse-sorted input causes inner loop to run i times per i,
        # totaling n(n-1)/2 iterations
        # Best case O(n): already sorted input means inner loop never executes
        while (j >= 0 and arr[j][1] < current[1]):
            arr[j + 1] = arr[j]
            j -= 1

        arr[j + 1] = current
```

If we run insertion sort against our input:

```python
movies = [
    ("Movie A", 8.3),
    ("Movie B", 9.3),
    ("Movie C", 10.0),
    ("Movie D", 7.4),
    ("Movie E", 10.0)
]
sort_movies(movies)
print(movies)
```

We have the input sorted (inplace, without returning a new array):

```text
[('Movie C', 10.0), ('Movie E', 10.0), ('Movie B', 9.3), ('Movie A', 8.3), ('Movie D', 7.4)]
```

And if we look at how long it takes to sort arrays of different sizes:

```python
from helpers import benchmark
import random

for size in [10, 100, 1000, 10000]:
    arr = [(f"Movie {i}", float(i)) for i in range(size)]
    random.shuffle(arr)
    benchmark(sort_movies, arr, size)
```

```text
10 sort_movies: 0.002805 ms
100 sort_movies: 0.095999 ms
1000 sort_movies: 7.946168 ms
10000 sort_movies: 930.988337 ms
```

What if the array is already sorted?

```python
from helpers import benchmark
import random

for size in [10, 100, 1000, 10000]:
    arr = [(f"Movie {i}", float(i)) for i in reversed(range(size))]
    benchmark(sort_movies, arr, size)
```

```text
10 sort_movies: 0.000712 ms
100 sort_movies: 0.006189 ms
1000 sort_movies: 0.060314 ms
10000 sort_movies: 0.429885 ms
```

Woah! Sorted arrays have a big difference in comparison to unsorted arrays in an
insertion-sort.


## Selection sort {#selection-sort}

Selection sort is very similar. It finds the min (or max) in the unsorted list
and swaps it into position (one swap per outer loop). Selection sort is always
\\(O(n^2)\\), **even on sorted arrays**.

<a id="code-snippet--selection-sort-fn"></a>
```python
def sort_movies(arr: list[tuple[str, float]]) -> None:
    n = len(arr)
    for i in range(n):
        # start from the unsorted portion for array
        largest_idx = i
        largest = arr[largest_idx]

        # only search from i onwards
        for j in range(i, len(arr)):
            if arr[j][1] > largest[1]:
                largest = arr[j]
                largest_idx = j

        # swap
        arr[i], arr[largest_idx] = arr[largest_idx], arr[i]
```

And if we run against our dataset:

```python
movies = [
    ("Movie A", 8.3),
    ("Movie B", 9.3),
    ("Movie C", 10.0),
    ("Movie D", 7.4),
    ("Movie E", 10.0)
]
sort_movies(movies)
print(movies)
```

```text
[('Movie C', 10.0), ('Movie E', 10.0), ('Movie B', 9.3), ('Movie A', 8.3), ('Movie D', 7.4)]
```

Now let's time it:

```python
from helpers import benchmark
import random

for size in [10, 100, 1000, 10000]:
    arr = [(f"Movie {i}", float(i)) for i in range(size)]
    random.shuffle(arr)
    benchmark(sort_movies, arr, size)
```

```text
10 sort_movies: 0.001973 ms
100 sort_movies: 0.078989 ms
1000 sort_movies: 8.249798 ms
10000 sort_movies: 825.025834 ms
```

That's a lot slower than insertion sort. What if the array is already sorted?

```python
from helpers import benchmark
import random

for size in [10, 100, 1000, 10000]:
    arr = [(f"Movie {i}", float(i)) for i in reversed(range(size))]
    benchmark(sort_movies, arr, size)
```

```text
10 sort_movies: 0.001976 ms
100 sort_movies: 0.079155 ms
1000 sort_movies: 8.002832 ms
10000 sort_movies: 801.328924 ms
```

Just like expected, no difference, because selection sort is **always** \\(O(n^2)\\).
