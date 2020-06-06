+++
title = "Binary calculation"
author = ["Ben Mezger"]
date = 2020-05-31T13:06:00-03:00
slug = "binary-calculation"
type = "posts"
draft = false
bookCollapseSection = true
+++

tags
: [Math]({{< relref "2020-05-31--16-06-38Z--math" >}}) [Computer Science]({{< relref "2020-05-31--15-29-21Z--computer_science" >}}) [Computer Architecture]({{< relref "2020-05-31--16-01-33Z--computer_architecture" >}})

The `b` before the code blocks mean binary number, to avoid confusion

## Binary Addition {#binary-addition}

### Possibilities {#possibilities}

| A   | OP  | B   | \\= |
| --- | --- | --- | --- |
| 1   | +   | 1   | 10  |
| 1   | +   | 0   | 1   |
| 0   | +   | 1   | 1   |
| 0   | +   | 0   | 0   |
| 1   | +   | 1+1 | 11  |

Carry is involved whenever we have a result larger than `bin 1`

## Binary multiplication {#binary-multiplication}

### Possibilities {#possibilities}

| A   | OP   | B   | \\= |
| --- | ---- | --- | --- |
| 0   | \*   | 0   | 0   |
| 1   | \*   | 0   | 0   |
| 1   | \*\* | 1   | 1   |

## Binary subtraction {#binary-subtraction}

### Possibilities {#possibilities}

| A   | OP  | B   | \\=                                         |
| --- | --- | --- | ------------------------------------------- |
| 0   | -   | 0   | 0                                           |
| 1   | -   | 0   | 1                                           |
| 1   | -   | 1   | 0                                           |
| 0   | -   | 1   | (borrow 1 from the next column 10 - 1) = 1) |
