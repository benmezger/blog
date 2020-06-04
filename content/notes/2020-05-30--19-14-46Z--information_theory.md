+++
title = "Information Theory"
author = ["Ben Mezger"]
date = 2020-05-30T16:14:00-03:00
lastmod = 2020-06-04T00:47:00-03:00
slug = "information_theory"
type = "posts"
draft = false
bookCollapseSection = true
+++

### Backlinks {#backlinks}

- [Coding Theory]({{< relref "2020-05-31--19-10-00Z--coding_theory" >}})

tags
: [Computer Science]({{< relref "2020-05-31--15-29-21Z--computer_science" >}})

Related content: <https://www.khanacademy.org/computing/computer-science/informationtheory/info-theory/>

Humans express themselves using a variations of communication, such as language,
physical gestures, drawing and etc. Language allows us to take a thought and
break it down to a series of chunks. These chunks are externalized using a
series of signals or symbols.
Informally we can think of _information_ as some message, stored or transmitted
using some medium.

Information is a collection of possible symbols. For example, the alphabet
allows us to choose between symbols to create words within the current context.
Everyday, we look for faster and efficient ways to transporting information
across spaces.

No matter the type of information, all of them can be **measured** using a
fundamental unit, just like measuring weights and heights with kilograms and
centimeters.

Information can be measured and compared using a measurement called **entropy**.
A page of a book doesn't have the same weight (due to less information) than the
complete book. We can weight information using the **bit** unit. No matter how the
person wants to communicate the information, be music, computer code or
drawings, each would contain the same number of bits though in different
**densities**.

`Key contents: entropy; density, information`

## What is the density of a bit? {#what-is-the-density-of-a-bit}

Bit density measures how many bits can be stored in some area or volume. As far
as I'm aware there is no formal definition but you can get an informal idea from
a few examples.

A typed paper has some number of letters on it, let's say 1000. Then a rough
estimate for the bit density would be 1 KB per sheet of paper, assuming 1 byte
per character. There could be many ways to increase the density, e.g. use a
smaller font or use something more efficient than letters, like tiny squares
that can either be on (black) or off (white). I've heard of software to back up
information on paper that can store 500 KB per sheet.

On the other hand there are fingernail-sized microSD cards that can store 64
GB - a much higher bit density!

Given that a sheet of paper has an area of ~ 624 cm^2 that means its bit density
is about 1 KB / 624 cm^2 = 0.0016 KB / cm^2. But a microSD card has an area of
about 1.65 cm^2 so its bit density is about 64 GB / 1.65 cm^2 = 38.8 GB / cm^2.
So, by this rough calculation the bit density of a microSD card is about
24,250,000 times greater than that of a sheet of paper.

## <span class="org-todo todo CURRENT">CURRENT</span> Measuring information {#measuring-information}

How can we quantify/measure an information source? Let's say Alice and Bob live
on the opposite road of each other and they want to communicate during the
night. To easy the communication, Bob and Alice agreed on only using the set of
symbols from the alphabet:
`A B C D E F G H I J K L M N O P Q R S T U V W X Y Z`

Alice developed a simple encoder/decoder to use with their communication system.
The encoder is responsible for translating a symbol to a binary digit, and the
decoder is responsible for `questioning the sender on which symbol it is`.
Alice sends a message to Bob with the symbol `J`. How many questions does Bob
need to ask Alice on which symbol it is? There are 26 symbols

```go
package main
import "fmt"

func alphabet(c chan string){
	letters := "abcdefghijklmnopqrstunwxyz"
	for _, l := range letters {
		c <- string(l)
	}

}

func main(){
	fmt.Println("HERE")
	letters := make(chan string, 26)
	alphabet(letters)

	for l := range(letters){
		fmt.Println(l)
	}
}

```
