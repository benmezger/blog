+++
title = "Notes"
author = ["Ben Mezger"]
publishDate = 2020-04-25T00:00:00-03:00
lastmod = 2020-05-01T01:37:53-03:00
categories = ["notes"]
type = "docs"
draft = false
[menu.before]
  identifier = "notes"
  title = "notes"
  weight = 5
  name = "notes"
+++

{{< hint warning >}}
:warning: Some notes I wrote and some of them are snippets I copied around the
Internet. Unfortunately I don&rsquo;t have the source for all of them, but I will try
to keep this updated.

Notes that are tagged or start with `TODO` are notes that or I am still working
on or that are simply incomplete :pensive:
{{< /hint >}}

> I have discovered the reason for this code and it&rsquo;s really
> quite necessary. Unfortunately this comment block is too short to
> contain it &#x2013; Fermat

## Compilers {#compilers}

### Syntax Analysis {#syntax-analysis}

Syntax analysis happens after the Lexical phase, and it is responsible for detecting
syntax errors.

### Grammar {#grammar}

Be design, computer languages have defined structure of what constitutes a
valid program. in Python, a program is made up of functions/classes/imports, a
function requires declarations and/or statements and so on. In C, a valid
program needs to have a least a function called main, otherwise the GNU&rsquo;s linker is
unable to link the program.

Programmers may define language grammars using the Backus-Naur Form (BNF)
notation. Defining grammars offer a lot of benefits for the language designer.
Like code, language grammars may change overtime. For example, one of Python&rsquo;s
3.5 new feature was the [support](https://bugs.python.org/issue24017) to coroutines with `async` and `await` syntax.

The following [diff](https://github.com/python/cpython/commit/7544508f0245173bff5866aa1598c8f6cce1fc5f#diff-cb0b9d6312c0d67f6d4aa1966766cedd) shows some of the changes the developer needed to add
support for the `async` before the function definition or allow an `async`
function definition to be used as a decorator.

```diff
diff -r ccac513ee610 Grammar/Grammar
--- a/Grammar/Grammar	Mon Apr 20 21:05:23 2015 +0200
+++ b/Grammar/Grammar	Mon Apr 20 15:54:06 2015 -0400
@@ -21,8 +21,11 @@

 decorator: '@' dotted_name [ '(' [arglist] ')' ] NEWLINE
 decorators: decorator+
-decorated: decorators (classdef | funcdef)
-funcdef: 'def' NAME parameters ['->' test] ':' suite
+decorated: decorators (classdef | funcdef | async_funcdef)
+
+async_funcdef: ASYNC funcdef
+funcdef: ('def' NAME parameters ['->' test] ':' suite)
+
 parameters: '(' [typedargslist] ')'
 typedargslist: (tfpdef ['=' test] (',' tfpdef ['=' test])* [','
        ['*' [tfpdef] (',' tfpdef ['=' test])* [',' '**' tfpdef] | '**' tfpdef]]
@@ -37,18 +40,19 @@
 simple_stmt: small_stmt (';' small_stmt)* [';'] NEWLINE
 small_stmt: (expr_stmt | del_stmt | pass_stmt | flow_stmt |
              import_stmt | global_stmt | nonlocal_stmt | assert_stmt)
```

Other than making it easier for the language designer to design the language, it
allows the grammar to be easily documented and maintained by other language
designers.

Some grammars allow parsers (syntax analyzers) to be constructed to determine
the syntactic structure of the program. By relying on the structured grammar, it
allows the parsers to be developed more easily and testable.

### Types of parsers {#types-of-parsers}

There are 3 types of parsers we can use to write a syntax parser.

1.  Universal: this method can parse any grammar
2.  Top-down: this method builds parse trees from the top (root) to the button (leaves)
3.  Bottom-up: this method builds parse trees from the button (leaves) to the top (root)

The last two methods reads the input from left to right and one symbol at a time.

The top-down and bottom-up are known to be more efficient in production use[^fn:1].

## <span class="org-todo todo TODO">TODO</span> Math {#math}

### Integral Calculus {#integral-calculus}

> These are the two ways we commonly think about definite integrals: they describe
> an accumulation of a quantity, so the entire definite integral gives us the net
> change in that quantity.[^fn:1]

#### Why Integral Calculus {#why-integral-calculus}

Figure [1](#org03c041d) represents 2 graphs of `y = cos(x)`. Let&rsquo;s say we would
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

<a id="org03c041d"></a>

{{< figure src="/assets/imgs/graph-example.png" >}}

The idea of getting better and better approximations is the what constitutes
Integral Calculus.

## Programming notes {#programming-notes}

### C programming {#c-programming}

#### C project architecture guidelines {#c-project-architecture-guidelines}

<!--list-separator-->

- Functions exposed in the header are like public methods

  Think of each module like a class. The functions you expose in the
  header are like public methods. Only put a function in the header if it
  part of the module&rsquo;s needed interface.

<!--list-separator-->

- Avoiding circular module dependencies

  Avoid circular module dependencies. Module A and module B should
  not call each other. You can refactor something into a module C to avoid
  that.

<!--list-separator-->

- Operatins within the same module should have a `create` and `delete` function interface

  Again, following the C++ pattern, if you have a module that can
  perform the same operations on different instances of data, have a
  create and delete function in your interface that will return a pointer
  to struct that is passed back to other functions. But for the sake of
  encapsulation, return a void pointer in the public interface and cast to
  your struct inside of the module.

<!--list-separator-->

- Avoid module scope variables

  Avoid module-scope variables &#x2013; the previously described pattern
  will usually do what you need. But if you really need module-scope
  variables, group them under a struct stored in a single module-scope
  variable called &ldquo;m&rdquo; or something consistent. Then in your code whenever
  you see &ldquo;m.variable&rdquo; you will know at a glance it is one of the
  module-scope structs.

<!--list-separator-->

- Define HEADER name to avoid double including and/or header problems

  To avoid header trouble, put `#ifndef MY_HEADER_H` `#define MY_HEADER_H`
  declaration that protects against double including. The header .h file for your
  module, should only contain `#includes` needed FOR THAT HEADER FILE. The module
  `.c` file can have more includes needed for the compiling the module, but don&rsquo;t
  add those includes into the module header file. This will save you from a lot of
  namespace conflicts and order-of-include problems.

### Go programming {#go-programming}

#### Packages {#packages}

In Go, programs start running in package `main`. Package names are defined by
the last element of the import path: `import math/rand` has files which begin
with the `package rand`. Packages consists of a bunch of `.go` files.

Package identifiers (functions, variables, struct and other data), may be used
in other packages, with a few exceptions. Go allows only exported identifiers to
be called after the package import. An exported identifier is any identifier
which the first character starts in `UPPER CASE`. Any identifier which starts
with a `lower case` letter is not exported.

Exported identifiers can be thought of `public` and `private` we see in other
languages. This approach allows us to separate public API by using upper case
character from private logic.

Private identifier within a package may be referenced within its package.

#### Functions {#functions}

A function can have 0 or more arguments. All arguments must be typed: `x int, y int`, when 2 or consecutives arguments share the same type, arguments may be
defined as so: `x, y int`.

Functions can return 0 or more number of results: `return x, y`. Function return
values may be named, and must be defined after the function declaraction and
before the beginning `{`

```go
func foobar(x, y int) (z int){
	z = x * y
	return
}
```

The empty return will return the z value. Named return values should be used to
document the meaning of the return values. Named return values should be used on
short functions, as named values in large functions may become confusing.

#### Defer {#defer}

## Code snippets {#code-snippets}

### Python run HTTP server locally {#python-run-http-server-locally}

{{< highlight sh "linenos=table, linenostart=1" >}}
python -m http.server 8000 --bind 127.0.0.1
{{< /highlight >}}

## Thesis {#thesis}

### OS Kit {#os-kit}

The OSKit is a framework and a set of [34 component libraries](https://www.cs.utah.edu/flux/oskit/html/oskit-wwwch1.html)
oriented to operating systems, together with extensive documentation. By
providing in a modular way not only most of the infrastructure &ldquo;grunge&rdquo;
needed by an OS, but also many higher-level components, the OSKit&rsquo;s goal
is to lower the barrier to entry to OS R&D and to lower its costs. The
OSKit makes it vastly easier to create a new OS, port an existing OS to
the x86 (or in the future, to other architectures supported by the
OSkit), or enhance an OS to support a wider range of devices, file
system formats, executable formats, or network services. The OSKit also
works well for constructing OS-related programs, such as boot loaders or
OS-level servers atop a microkernel

### Memory management {#memory-management}

#### Parkinson&rsquo;s law {#parkinson-and-rsquo-s-law}

Programs and their data expand to fill the memory available to hold them

#### Memory hierarchy {#memory-hierarchy}

<!--list-separator-->

- Small fast and expensive memory up to a very slow and cheap memory

   <!--list-separator-->

  - Processor registers

   <!--list-separator-->

  - Processor cache

   <!--list-separator-->

  - Random access memory (RAM)

   <!--list-separator-->

  - Flash/USB memory

   <!--list-separator-->

  - Hard drive

   <!--list-separator-->

  - Tape backups

<!--list-separator-->

- The part that handles memory in the operating system is called memory manager

   <!--list-separator-->

  - The manager should be capable of allocating/deallocating memory for processes

   <!--list-separator-->

  - Keep track of which location in memory is in use

<!--list-separator-->

- Lowest cache level is _generally_ handled by the hardware

<!--list-separator-->

- Not having any memory abstraction at all is the simplest abstraction

  The simplest memory abstraction is to have no abstraction at all,
  that being said, the programmer sees all the memory and may read/write
  from anywhere, however, this implies one program is running, otherwise
  one program may interfere with the other

   <!--list-separator-->

  - One solution for allowing two or more programs running

    simultaneously is if one program knows about the existence of the other.
    With this approach, the programmer requires to divide memory into 2
    &ldquo;blocks&rdquo;, and allocate each block to the corresponding program, for
    example, the kernel may be at the button of memory and the program on
    top of it. It&rsquo;s worth noting this implies the program may wipe (or
    read/write) the kernel address

   <!--list-separator-->

  - Another solution is to store the kernel in ROM, and keep the program in RAM

   <!--list-separator-->

  - When the kernel needs to switch process, it will load the the

    program from disk and overwrite the current running program

   <!--list-separator-->

  - All the kernel needs to do is save the memory context to disk and

    load the new program

   <!--list-separator-->

  - With the help of extra hardware, it is possible to divide memory

    into blocks and protect other programs from accessing blocks of other
    programs loaded in memory

     <!--list-separator-->

    - This brings a problem since programs may move data from physical

      memory, say program A jumps to address \`0x12\` and program b copies data
      from in memory address \`0x12\`. When program A jumps to address \`0x12\` it
      would instead crash, since that was not the expected address. The
      problem is that both programs reference physical memory and this is \***\*totally undesirable\*\***, what is desirable is that programs reference a
      private set of local address to it

      See: <https://imgur.com/a/5FlWN4A>

     <!--list-separator-->

    - \***\*Static relocation\*\***: modify the second program on the fly as

      it loaded into memory (IBM 360 did this)

<!--list-separator-->

- The operating system should coordinate on how these memories are handled

   <!--list-separator-->

  - It should handle:

     <!--list-separator-->

    - Keep track which parts of memory are in used and which aren&rsquo;t

     <!--list-separator-->

    - Allocate and deallocate memory

     <!--list-separator-->

    - Swapping between main memory to disk when main memory is too small to hold the process

<!--list-separator-->

- Memory abstractions

   <!--list-separator-->

  - Address spaces

     <!--list-separator-->

    - Allows multiple applications to be in memory at the same time

     <!--list-separator-->

    - Prevents applications from interfering with each other

     <!--list-separator-->

    - Abstract memory for programs to be stored in

     <!--list-separator-->

    - Works like a telephone number

      in Brazil, it is common for local cities to have a 8-digit phone number, so the
      address space for the telephone number starts in 0000,0000 up to 9999,9999.

   <!--list-separator-->

  - Stack pointer

     <!--list-separator-->

    - RISC-V ABI&rsquo;s stack pointer

      The stack pointer points to the next available memory location on the stack, and
      the frame pointer points to the base of the <span class="underline"><span class="underline">stack frame</span></span>.

#### Physical Memory management {#physical-memory-management}

<!--list-separator-->

- Direct memory address to access a real location in RAM

### Understanding RISC-V stack pointer {#understanding-risc-v-stack-pointer}

#### [L06 RISCV Functions(6up).pdf](https://dynalist.io/u/5cYI9hHNgUYs0U47UXe0RZ6U) {#l06-riscv-functions--6up--dot-pdf}

### Code {#code}

#### Linux trap handler {#linux-trap-handler}

```C
void __init trap_init(void)
{
    /*
    * Set sup0 scratch register to 0, indicating to exception vector
    * that we are presently executing in the kernel
    */
    csr_write(CSR_SCRATCH, 0);
    /* Set the exception vector address */
    csr_write(CSR_TVEC, &handle_exception);
    /* Enable all interrupts */
    csr_write(CSR_IE, -1);
}
```

#### Send S-mode interrupts and most exceptions to S-mode {#send-s-mode-interrupts-and-most-exceptions-to-s-mode}

```C
// send S-mode interrupts and most exceptions straight to S-mode
static void delegate_traps() {
  if (!supports_extension('S'))
    return;

  uintptr_t interrupts = MIP_SSIP | MIP_STIP | MIP_SEIP;
  uintptr_t exceptions =
      (1U << CAUSE_MISALIGNED_FETCH) | (1U << CAUSE_FETCH_PAGE_FAULT) |
      (1U << CAUSE_BREAKPOINT) | (1U << CAUSE_LOAD_PAGE_FAULT) |
      (1U << CAUSE_STORE_PAGE_FAULT) | (1U << CAUSE_USER_ECALL);

  write_csr(mideleg, interrupts);
  write_csr(medeleg, exceptions);
  assert(read_csr(mideleg) == interrupts);
  assert(read_csr(medeleg) == exceptions);
}
```

#### Timer interrupt in assembly {#timer-interrupt-in-assembly}

<!--list-separator-->

- <https://forums.sifive.com/t/beginner-trying-to-set-up-timer-irq-in-assembler-how-to-print-csrs-in-gdb/2764>

#### Freedom metal Interrupt {#freedom-metal-interrupt}

<!--list-separator-->

- Initialize CPU interrupt controller

  ```C
  void __metal_driver_riscv_cpu_controller_interrupt_init(
      struct metal_interrupt *controller) {
    struct __metal_driver_riscv_cpu_intc *intc = (void *)(controller);
    uintptr_t val;

    if (!intc->init_done) {
      /* Disable and clear all interrupt sources */
      asm volatile("csrc mie, %0" ::"r"(-1));
      asm volatile("csrc mip, %0" ::"r"(-1));

      /* Read the misa CSR to determine if the delegation registers exist */
      uintptr_t misa;
      asm volatile("csrr %0, misa" : "=r"(misa));

      /* The delegation CSRs exist if user mode interrupts (N extension) or
       * supervisor mode (S extension) are supported */
      if ((misa & METAL_ISA_N_EXTENSIONS) || (misa & METAL_ISA_S_EXTENSIONS)) {
        /* Disable interrupt and exception delegation */
        asm volatile("csrc mideleg, %0" ::"r"(-1));
        asm volatile("csrc medeleg, %0" ::"r"(-1));
      }

      /* The satp CSR exists if supervisor mode (S extension) is supported */
      if (misa & METAL_ISA_S_EXTENSIONS) {
        /* Clear the entire CSR to make sure that satp.MODE = 0 */
        asm volatile("csrc satp, %0" ::"r"(-1));
      }

      /* Default to use direct interrupt, setup sw cb table*/
      for (int i = 0; i < METAL_MAX_MI; i++) {
        intc->metal_int_table[i].handler = NULL;
        intc->metal_int_table[i].sub_int = NULL;
        intc->metal_int_table[i].exint_data = NULL;
      }
      for (int i = 0; i < METAL_MAX_ME; i++) {
        intc->metal_exception_table[i] = __metal_default_exception_handler;
      }
      __metal_controller_interrupt_vector(METAL_DIRECT_MODE,
                                          &__metal_exception_handler);
      asm volatile("csrr %0, misa" : "=r"(val));
      if (val & (METAL_ISA_D_EXTENSIONS | METAL_ISA_F_EXTENSIONS |
                 METAL_ISA_Q_EXTENSIONS)) {
        /* Floating point architecture, so turn on FP register saving*/
        asm volatile("csrr %0, mstatus" : "=r"(val));
        asm volatile("csrw mstatus, %0" ::"r"(val | METAL_MSTATUS_FS_INIT));
      }
      intc->init_done = 1;
    }
  }
  ```

<!--list-separator-->

- Set trap vector configuration

  ```C
  void __metal_controller_interrupt_vector(metal_vector_mode mode,
                                           void *vec_table) {
    uintptr_t trap_entry, val;

    asm volatile("csrr %0, mtvec" : "=r"(val));
    val &= ~(METAL_MTVEC_CLIC_VECTORED | METAL_MTVEC_CLIC_RESERVED);
    trap_entry = (uintptr_t)vec_table;

    switch (mode) {
    case METAL_SELECTIVE_VECTOR_MODE:
      asm volatile("csrw mtvt, %0" ::"r"(trap_entry | METAL_MTVEC_CLIC));
      asm volatile("csrw mtvec, %0" ::"r"(val | METAL_MTVEC_CLIC));
      break;
    case METAL_HARDWARE_VECTOR_MODE:
      asm volatile("csrw mtvt, %0" ::"r"(trap_entry | METAL_MTVEC_CLIC_VECTORED));
      asm volatile("csrw mtvec, %0" ::"r"(val | METAL_MTVEC_CLIC_VECTORED));
      break;
    case METAL_VECTOR_MODE:
      asm volatile("csrw mtvec, %0" ::"r"(trap_entry | METAL_MTVEC_VECTORED));
      break;
    case METAL_DIRECT_MODE:
      asm volatile(
          "csrw mtvec, %0" ::"r"(trap_entry & ~METAL_MTVEC_CLIC_VECTORED));
      break;
    }
  }
  ```

#### For `DIRECT_ACCESS` interrupt vector configuration {#for-direct-access-interrupt-vector-configuration}

### IRC {#irc}

#### [Switching from machine-mode to supervisor-mode!](https://dynalist.io/u/33rH8mexp0c1%5FS2JNvLTcwEJ) {#switching-from-machine-mode-to-supervisor-mode}

### Privilege modes {#privilege-modes}

| Level | Encoding | Name             | Abbreviation |
| ----- | -------- | ---------------- | ------------ |
| 0     | 00       | User/Application | U            |
| 1     | 01       | Supervisor       | S            |
| 2     | 10       | Reserved         |              |
| 3     | 11       | Machine          | M            |

#### Provides protection between different components of the software stack {#provides-protection-between-different-components-of-the-software-stack}

#### Any attempts to perform an operation not allowed by the current mode will cause an exception to be raised {#any-attempts-to-perform-an-operation-not-allowed-by-the-current-mode-will-cause-an-exception-to-be-raised}

#### These exceptions will normally cause traps into the underlying execution environment {#these-exceptions-will-normally-cause-traps-into-the-underlying-execution-environment}

#### Machine mode {#machine-mode}

<!--list-separator-->

- Highest privilege

<!--list-separator-->

- \***\*Mandatory\*\*** privilege level for RISC-V hardware platform

<!--list-separator-->

- Trusted code environment

<!--list-separator-->

- Low level access to the machine implementation

<!--list-separator-->

- Manage secure execution environments

#### User mode and supervisor mode are indented for conventional application and operating systems {#user-mode-and-supervisor-mode-are-indented-for-conventional-application-and-operating-systems}

| Number of levels | Supported modes | Indented Usage              |
| ---------------- | --------------- | --------------------------- |
| 1                | M               | Simple embedded systems     |
| 2                | M, U            | Secure embedded systems     |
| 3                | M, S U          | Unix-like operating systems |

#### Exceptions {#exceptions}

<!--list-separator-->

- Any attempts to access non-existent CSR, read or write a read-only register raises an \***\*illegal instruction\*\***

<!--list-separator-->

- A read/write register might also contain bits that are read-only, in which writes to read-only bits \***\*are ignored\*\***

#### Supervisor mode {#supervisor-mode}

<http://www-inst.eecs.berkeley.edu/~cs152/sp12/handouts/riscv-supervisor.pdf>

#### \***\*Steps to reproduce the behavior\*\*** {#steps-to-reproduce-the-behavior}

<!--list-separator-->

- Switch to machine mode (if not already by default)

## Books {#books}

### List {#list}

<div class="table-caption">
  <span class="table-number">Table 1</span>:
  Clock summary at <span class="timestamp-wrapper"><span class="timestamp">[2020-04-30 Thu 23:17]</span></span>
</div>

| Headline                                                                         | Time     |     |      |      |
| -------------------------------------------------------------------------------- | -------- | --- | ---- | ---- |
| **Total time**                                                                   | **3:10** |     |      |      |
| &ensp;&ensp;&ensp;&ensp;List                                                     |          |     | 3:10 |      |
| &ensp;&ensp;&ensp;&ensp;&ensp;&ensp;Nonviolent Communication: A language&#x2026; |          |     |      | 3:10 |

#### <span class="org-todo todo READING">READING</span> Nonviolent Communication: A language for life {#nonviolent-communication-a-language-for-life}

- State &ldquo;READING&rdquo; from &ldquo;TODO&rdquo; <span class="timestamp-wrapper"><span class="timestamp">[2020-04-29 Wed 17:50]</span></span>

#### <span class="org-todo todo NEXT">NEXT</span> Clean Code {#clean-code}

### \***\*Mídia\*\*** - Noam Chomsky {#mídia-noam-chomsky}

#### Duas concepções diferentes de democracia {#duas-concepções-diferentes-de-democracia}

1.  Uma sociedade democrática é aquela em que o povo dispõe de

condições de participar de maneira significativa na condução de seus
assuntos pessoais e na qual os canais de informação são acessíveis e
livres

1.  O povo deve ser impedido de conduzir seus assuntos pessoais e os

canais de informação devem ser estreita e rigidamente controlados

- Essa é a concepção predominante
- Primeiras revoluções democráticas na Inglaterra do século XVII
  (17) expressam em grande medida esse ponto de vista

#### Primeira operação de propaganda governamental {#primeira-operação-de-propaganda-governamental}

<!--list-separator-->

- Governo de [Woodrow Wilson](https://en.wikipedia.org/wiki/Woodrow%5FWilson)

  [[<https://dynalist.io/u/ZQA1dAc7Eut0bwSRwZeMRqQ0>]]

<!--list-separator-->

- Presidente dos Estados Unidos em 1916

   <!--list-separator-->

  - Plataforma &ldquo;Paz sem Vitória&rdquo;

     <!--list-separator-->

    - Metade da Primeira Guerra Mundial

#### População bastante pacifista e sem motivo algum que justificasse envolvimento em guerra Europeia {#população-bastante-pacifista-e-sem-motivo-algum-que-justificasse-envolvimento-em-guerra-europeia}

#### Constituída uma comissão de propaganda governamental {#constituída-uma-comissão-de-propaganda-governamental}

<!--list-separator-->

- [ComissãoCreel](https://en.wikipedia.org/wiki/Committee%5Fon%5FPublic%5FInformation)

  <https://dynalist.io/u/7sEyNdz3VqlLWY9GpIypishZ>

   <!--list-separator-->

  - Committee on Public Information

   <!--list-separator-->

  - 1917 - 1919

   <!--list-separator-->

  - Transformou uma população dentro de 6 meses

    Conseguiua dentro de 6 meses transformar uma população pacifista
    em uma população histérica e belicosa que queria destruir tudo que fosse
    alemão

     <!--list-separator-->

    - Efeito importante que levou a outros efeitos

#### Após a guerra, forma utilizadas as mesmas técnicas para gerar um Pânico Vermelho {#após-a-guerra-forma-utilizadas-as-mesmas-técnicas-para-gerar-um-pânico-vermelho}

<!--list-separator-->

- Obteve êxito considerável na destruição de sindicatos e na eliminação de problemas perigosos como

   <!--list-separator-->

  - Liberdade de imprensa

   <!--list-separator-->

  - Liberdade de pensamento político

<!--list-separator-->

- Grande apoio dos lideres empresariais e da mídia

   <!--list-separator-->

  - Ambos organizaram e investiram muito na iniciativa

#### Intelectuais progressistas participaram ativamente {#intelectuais-progressistas-participaram-ativamente}

<!--list-separator-->

- Pessoas do circulo de [JohnDewey](https://en.wikipedia.org/wiki/John%5FDewey)

  <https://dynalist.io/u/4O4qv1%5Fwmp2T5nHYLMIiMcDD>

## Political thoughts {#political-thoughts}

### Abortion should be legal, safe and rare {#abortion-should-be-legal-safe-and-rare}

[^fn:1]: I am not really sure why this is, as I haven&rsquo;t studied Universal methods]
