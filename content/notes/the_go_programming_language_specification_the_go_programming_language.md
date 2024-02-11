+++
title = "The Go Programming Language Specification - The Go Programming Language"
author = ["Ben Mezger"]
slug = "the-go-programming-language-spec"
tags = ["go", "programming"]
type = "notes"
draft = false
bookCollapseSection = true
+++

-   Related pages
    -   [Go Programming]({{<relref "2020-05-31--15-31-36Z--go_programming.md#" >}})
    -   [Programming]({{<relref "2020-05-31--15-33-23Z--programming.md#" >}})
    -   [Go Context package]({{<relref "2020-09-03--20-08-38Z--go_context_package.md#" >}})
    -   [Go interfaces]({{<relref "2020-06-22--23-26-51Z--go_interfaces.md#" >}})

---

For an operand x of type T, the address operation &x generates a pointer of
type \*T to x. The operand must be addressable, that is, either a variable,
pointer indirection, or slice indexing operation; or a field selector of an
addressable struct operand; or an array indexing operation of an addressable
array. As an exception to the addressability requirement, x may also be a
(possibly parenthesized) composite literal. If the evaluation of x would cause
a run-time panic, then the evaluation of &x does too.

For an operand x of pointer type \*T, the pointer indirection \*x denotes the
variable of type T pointed to by x. If x is nil, an attempt to evaluate \*x will
cause a run-time panic.
