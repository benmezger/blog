+++
title = "Integral Calculus"
author = ["Ben Mezger"]
date = 2020-05-31T13:05:00-03:00
slug = "integral-calculus"
tags = ["calculus", "math"]
type = "notes"
draft = false
bookCollapseSection = true
+++

tags
: [Math]({{< relref "2020-05-31--16-06-38Z--math" >}})

> These are the two ways we commonly think about definite integrals: they describe
> an accumulation of a quantity, so the entire definite integral gives us the net
> change in that quantity.[^fn:1]

## Why Integral Calculus {#why-integral-calculus}

Figure [1](#org6ded7a4) represents 2 graphs of `y = cos(x)`. Let's say we would
like to calculate the area of {{<katex>}} x_1 {{</katex>}}. We could calculate
the area by aproximation, for example, Graph B is filled with the area we would
like to calculate, so we could divide this area by equal sections of
\\(\Delta x_n\\) from `a` to `b` rectangles, then we could calculate the area of
these rectangles by \\(f(x_i) \* \Delta x_n\\) where \\(f\\) is the area of each of
the rectangles. We do this for each rectangle then sum them up: \\(\sum\_{i=1}^n f(x_i) \*
\Delta x_n\\). This will give us an approximation of our area, we could have a
better approximation by having our \\(\Delta x_n\\) smaller, but this implies that
our `n` becomes bigger and bigger. The smaller \\(\Delta x_n\\) gets, the more `n`
approaches infinity.

We could use \\(\liminf\\) of `n` as `n` approaches &infin; or \\(\Delta x_n\\) as it
gets very small.

```gnuplot
set multiplot layout 1, 2 title "f(x) = -x ** 2 + 4"

set terminal pngcairo enhanced color size 350,262 font "Verdana,10" persist
set linetype 1 lc rgb '#A3001E'
set style fill transparent solid 0.35 noborder

f(x) = -x ** 2 + 4

set title "A"
plot f(x) with lines linestyle 1

set title "B"
set style fill transparent solid 0.50 noborder
plot f(x) fs solid 0.3 lc rgb '#A3001E'

unset multiplot
```

<a id="org6ded7a4"></a>

{{< figure src="/imgs/graph-example.png" >}}

The idea of getting better and better approximations is the what constitutes
Integral Calculus.

[^fn:1]: : Source: [Exploring accumulation of change](https://www.khanacademy.org/math/integral-calculus/ic-integration/ic-integral-calc-intro/a/accumulation-and-net-change-in-context)
