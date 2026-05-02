+++
title = "Algorithms: Quicksort"
author = ["Ben Mezger"]
date = 2026-02-18T17:35:00+01:00
slug = "algorithms_quicksort"
tags = ["algorithms"]
type = "notes"
draft = false
bookCollapseSection = true
+++

-   Related pages
    -   [Algorithms: Binary Search]({{< relref "2026-02-13--17-07-21Z--algorithms_binary_search.md" >}})
    -   [Algorithms: Selection and Insertion Sort]({{< relref "2026-02-15--13-55-28Z--algorithms_selection_sort.md" >}})

---

{{< katex />}}

We talked about [Selection and Insertion Sort]({{< relref "2026-02-15--13-55-28Z--algorithms_selection_sort.md" >}}) previously and we learned that it
is a slow sorting algorithm, but there are faster alternatives. One of them is
Quicksort. Quicksort runs in \\(O(n \log\_2 n)\\) on average and best case, and \\(O(n^2)\\) as
the worst case.

Quicksort is actually quite common, and it uses a divide and conquer approach
and runs recursively. There are two cases where we can easily return without
sorting: an empty array, and an array with one element. This is our base case
for our recursion. We can implement quicksort in two different ways: in-place or
out-of-place. Both of these implementations have different \\(O\\) space. Here, we
will implement out-of-place, which is slower, given there is a list allocation
for each recursive call, giving us \\(O(n)\\) space and bad cache performance, as we
are not working within the same memory region.

Quicksort is simple. We start by picking an element from the array (the pivot),
and then we find all elements that are smaller than our pivot, as well as larger
than our pivot (partitioning). At this point, we have:

-   A subarray containing all elements less than the pivot (unsorted)
-   Our pivot
-   A subarray containing all elements greater than our pivot (unsorted)

Given both of our subarrays are not sorted, we can sort them by calling
`quicksort` against the subarrays. With a naive pivot, quicksort can degrade to
\\(O(n^2)\\) on sorted input. In-place quicksort has good cache locality during
partitioning, though our out-of-place implementation sacrifices this.


## Out-of-place quicksort {#out-of-place-quicksort}

<a id="code-snippet--out-of-place-quicksort-fn"></a>
```python
def quicksort(arr: list[int]) -> list[int]:
    if len(arr) < 2:
        return arr

    pivot = arr[0]
    less = [i for i in arr[1:] if i <= pivot]
    greater = [i for i in arr[1:] if i > pivot]

    return quicksort(less) + [pivot] + quicksort(greater)
```

If we trace our `quicksort` against the array: \\([3, 1, 4, 1, 5]\\), we will get:

```text
quicksort([3, 1, 4, 1, 5])
  pivot=3, less=[1,1], greater=[4,5]
  ├── quicksort([1, 1])
  │     pivot=1, less=[1], greater=[]
  │     ├── quicksort([1])  -> [1]
  │     └── quicksort([])   -> []
  │     → [1] + [1] + [] = [1, 1]
  │
  └── quicksort([4, 5])
        pivot=4, less=[], greater=[5]
        ├── quicksort([])   -> []
        └── quicksort([5])  -> [5]
        → [] + [4] + [5] = [4, 5]

  -> [1, 1] + [3] + [4, 5] = [1, 1, 3, 4, 5]
```

And if we benchmark our `quicksort` implementation, we will get much better
results when comparing to our `selection` sort algorithm.

```python
from helpers import benchmark
import random

for size in [10, 100, 1000, 10000]:
    arr = list(range(size))
    random.shuffle(arr)
    benchmark(lambda a: quicksort(a), arr, size, number=10000, name="quicksort")
```

```text
10 quicksort: 0.002337 ms
100 quicksort: 0.043107 ms
1000 quicksort: 0.591251 ms
10000 quicksort: 7.304412 ms
```

But how fast is it if the array is already sorted?

```python
from helpers import benchmark
import random

for size in [10, 100, 1000, 10000]:
    arr = list(range(size))
    benchmark(lambda a: quicksort(a), arr, size, number=10000, name="quicksort")
```

```text
10 quicksort: 0.003452 ms
100 quicksort: 0.162750 ms
1000 quicksort: error
```

Oh, what happened to the results of 1000 elements? This raised a
`RecursionError`:

> `RecursionError: maximum recursion depth exceeded`

The reason this returned a recursion error is because we are always picking the
first element of the list as our pivot. When the input is already sorted (or
almost sorted), every partition puts all elements into our `less` array and
nothing into `greater`, which gives us a \\(O(n)\\) recursion depth instead of
\\(O(\log\_2 n)\\).

One way to avoid this, is to use a Median-of-3 pivot. This will pick the pivot
as the median of the first, middle, and last elements. It's an okay deterministic strategy that
avoids worst-case on sorted/reversed input.

<a id="code-snippet--out-of-place-quicksort-2-fn"></a>
```python
def quicksort(arr: list[int]) -> list[int]:
    n = len(arr)
    if n < 2:
        return arr

    mid = n // 2
    candidates = [arr[0], arr[mid], arr[-1]]
    pivot = sorted(candidates)[1]
    pivot_idx = arr.index(pivot)

    rest = arr[:pivot_idx] + arr[pivot_idx + 1:]
    less = [i for i in rest if i <= pivot]
    greater = [i for i in rest if i > pivot]

    return quicksort(less) + [pivot] + quicksort(greater)
```

```python
from helpers import benchmark

for size in [10, 100, 1000, 10000]:
    arr = list(range(size))
    benchmark(lambda a: quicksort(a), arr, size, number=10000, name="quicksort")
```

```text
10 quicksort: 0.003253 ms
100 quicksort: 0.038333 ms
1000 quicksort: 0.442558 ms
10000 quicksort: 5.520427 ms
```

Voila. Now we were able to sort our sorted array :). How much difference
does it make when comparing our quicksort using a simple pivot, and a
Median-of-3 pivot against unsorted arrays?

```python
from helpers import benchmark
import random

for size in [10, 100, 1000, 10000]:
    arr = list(range(size))
    random.shuffle(arr)
    benchmark(lambda a: quicksort(a), arr, size, number=10000, name="quicksort")
```

```text
10 quicksort: 0.003748 ms
100 quicksort: 0.044259 ms
1000 quicksort: 0.606765 ms
10000 quicksort: 7.595240 ms
```

Based on that, we can see that quicksort is a lot faster in comparison to
selection sort, once the number of elements in an array grows. With selection
sort, it took ~930ms to sort an array of 10000 elements, while quicksort just
took ~7ms.

But we can go faster and we will see that in later articles.
