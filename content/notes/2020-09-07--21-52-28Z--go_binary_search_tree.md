+++
title = "Go binary search tree"
author = ["Ben Mezger"]
date = 2020-09-07T18:52:00-03:00
slug = "go_binary_search_tree"
tags = ["go", "algorithms", "programming"]
type = "notes"
draft = false
bookCollapseSection = true
+++

tags
: [Go Programming]({{< relref "2020-05-31--15-31-36Z--go_programming" >}}) [Software Engineering]({{< relref "2020-06-23--12-50-55Z--software_engineering" >}})

## Requirements {#requirements}

- Sorted array of lenght `N`

## Performance {#performance}

- Say an array contains `N` (search space o `N`) elements, and we divide `N/2`,
  getting a search space of `N/2`, how many steps do we need until we get down
  to just one an array of 1 element.
- `O(log2 n)` problem.

## Implementation {#implementation}

- Can be implemented recursively or non-recursively.
- An array of `N` elements.

## Code {#code}

```go

```
