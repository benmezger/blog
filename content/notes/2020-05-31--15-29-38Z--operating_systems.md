+++
title = "Operating Systems"
author = ["Ben Mezger"]
date = 2020-05-31T12:29:00
slug = "operating-systems"
tags = ["operating-systems", "cs"]
type = "notes"
draft = false
bookCollapseSection = true
+++

-   Related pages
    -   [Thesis]({{<relref "2020-05-31--15-35-57Z--thesis.md#" >}})
    -   [Computer Science]({{<relref "2020-05-31--15-29-21Z--computer_science.md#" >}})
    -   [Computer Architecture]({{<relref "2020-05-31--16-01-33Z--computer_architecture.md#" >}})

---


## OS Kit {#os-kit}

The OSKit is a framework and a set of [34 component libraries](https://www.cs.utah.edu/flux/oskit/html/oskit-wwwch1.html)
oriented to operating systems, together with extensive documentation. By
providing in a modular way not only most of the infrastructure "grunge"
needed by an OS, but also many higher-level components, the OSKit's goal
is to lower the barrier to entry to OS R&D and to lower its costs. The
OSKit makes it vastly easier to create a new OS, port an existing OS to
the x86 (or in the future, to other architectures supported by the
OSkit), or enhance an OS to support a wider range of devices, file
system formats, executable formats, or network services. The OSKit also
works well for constructing OS-related programs, such as boot loaders or
OS-level servers atop a microkernel


## Memory management {#memory-management}


### Parkinson's law {#parkinson-s-law}

Programs and their data expand to fill the memory available to hold them


### Memory hierarchy {#memory-hierarchy}


#### Small fast and expensive memory up to a very slow and cheap memory {#small-fast-and-expensive-memory-up-to-a-very-slow-and-cheap-memory}

<!--list-separator-->

-  Processor registers

<!--list-separator-->

-  Processor cache

<!--list-separator-->

-  Random access memory (RAM)

<!--list-separator-->

-  Flash/USB memory

<!--list-separator-->

-  Hard drive

<!--list-separator-->

-  Tape backups


#### The part that handles memory in the operating system is called memory manager {#the-part-that-handles-memory-in-the-operating-system-is-called-memory-manager}

<!--list-separator-->

-  The manager should be capable of allocating/deallocating memory for processes

<!--list-separator-->

-  Keep track of which location in memory is in use


#### Lowest cache level is _generally_ handled by the hardware {#lowest-cache-level-is-generally-handled-by-the-hardware}


#### Not having any memory abstraction at all is the simplest abstraction {#not-having-any-memory-abstraction-at-all-is-the-simplest-abstraction}

The simplest memory abstraction is to have no abstraction at all,
that being said, the programmer sees all the memory and may read/write
from anywhere, however, this implies one program is running, otherwise
one program may interfere with the other

<!--list-separator-->

-  One solution for allowing two or more programs running

    simultaneously is if one program knows about the existence of the other.
    With this approach, the programmer requires to divide memory into 2
    "blocks", and allocate each block to the corresponding program, for
    example, the kernel may be at the button of memory and the program on
    top of it. It's worth noting this implies the program may wipe (or
    read/write) the kernel address

<!--list-separator-->

-  Another solution is to store the kernel in ROM, and keep the program in RAM

<!--list-separator-->

-  When the kernel needs to switch process, it will load the the

    program from disk and overwrite the current running program

<!--list-separator-->

-  All the kernel needs to do is save the memory context to disk and

    load the new program

<!--list-separator-->

-  With the help of extra hardware, it is possible to divide memory

    into blocks and protect other programs from accessing blocks of other
    programs loaded in memory

    <!--list-separator-->

    -  This brings a problem since programs may move data from physical

        memory, say program A jumps to address \`0x12\` and program b copies data
        from in memory address \`0x12\`. When program A jumps to address \`0x12\` it
        would instead crash, since that was not the expected address. The
        problem is that both programs reference physical memory and this is
        ****totally undesirable****, what is desirable is that programs reference a
        private set of local address to it

        See: <https://imgur.com/a/5FlWN4A>

    <!--list-separator-->

    -  ****Static relocation****: modify the second program on the fly as

        it loaded into memory (IBM 360 did this)


#### The operating system should coordinate on how these memories are handled {#the-operating-system-should-coordinate-on-how-these-memories-are-handled}

<!--list-separator-->

-  It should handle:

    <!--list-separator-->

    -  Keep track which parts of memory are in used and which aren't

    <!--list-separator-->

    -  Allocate and deallocate memory

    <!--list-separator-->

    -  Swapping between main memory to disk when main memory is too small to hold the process


#### Memory abstractions {#memory-abstractions}

<!--list-separator-->

-  Address spaces

    <!--list-separator-->

    -  Allows multiple applications to be in memory at the same time

    <!--list-separator-->

    -  Prevents applications from interfering with each other

    <!--list-separator-->

    -  Abstract memory for programs to be stored in

    <!--list-separator-->

    -  Works like a telephone number

        in Brazil, it is common for local cities to have a 8-digit phone number, so the
        address space for the telephone number starts in 0000,0000 up to 9999,9999.

<!--list-separator-->

-  Stack pointer

    <!--list-separator-->

    -  RISC-V ABI's stack pointer

        The stack pointer points to the next available memory location on the stack, and
        the frame pointer points to the base of the <span class="underline"><span class="underline">stack frame</span></span>.


### Physical Memory management {#physical-memory-management}


#### Direct memory address to access a real location in RAM {#direct-memory-address-to-access-a-real-location-in-ram}


## Code {#code}


### Linux trap handler {#linux-trap-handler}

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


### Send S-mode interrupts and most exceptions to S-mode {#send-s-mode-interrupts-and-most-exceptions-to-s-mode}

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


### Timer interrupt in assembly {#timer-interrupt-in-assembly}


#### <https://forums.sifive.com/t/beginner-trying-to-set-up-timer-irq-in-assembler-how-to-print-csrs-in-gdb/2764> {#https-forums-dot-sifive-dot-com-t-beginner-trying-to-set-up-timer-irq-in-assembler-how-to-print-csrs-in-gdb-2764}


### Freedom metal Interrupt {#freedom-metal-interrupt}


#### Initialize CPU interrupt controller {#initialize-cpu-interrupt-controller}

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


#### Set trap vector configuration {#set-trap-vector-configuration}

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


### For `DIRECT_ACCESS` interrupt vector configuration {#for-direct-access-interrupt-vector-configuration}
