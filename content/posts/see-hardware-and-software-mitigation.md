+++
title = "Software and Hardware Single Event Effect mitigation"
author = ["Ben Mezger"]
date = 2021-02-06T15:28:00-03:00
publishDate = 2021-02-06
tags = ["fault-tolerance", "see", "software", "hardware"]
draft = false
+++

> ❗️Note: This was a class homework for my Master&rsquo;s at the Federal University of
> Rio Grande do Sul and was not peer reviewed. It&rsquo;s intention was to write a
> review of some presentation from the [SERESSA-2020](https://www.ufrgs.br/seressa2020/) event.

#### Introduction {#introduction}

With the continuing trend of higher density devices for faster
processing and lower requirement of electric charge, a comparable amount
of charge can be generated in the semiconductor by the passage of cosmic
rays or alpha particles. These charges may, for example, temporarily
change memory contents or commands in a given instruction stream. The
effects of radiation regarding space-borne electronic systems may
penetrate sensitive nodes in these devices and affect its system
functions and behavior ([Petersen, n.d.](#orgbfca9ed)).

The first satellite inconsistency was first reported in 1975, by D.
Binder _et. al_ on SEU in flip-flops. In 1978, the first SEU was first
observed on earth by alpha particles, caused by packaging material in a
chip and eventually affecting the ram. In 1979, the first report on SEU
due to comic rays was published, and in 1992, the first destructive see
was observed in a memory on a space operating resource satellite
([Buchner 2015](#org76c1800)).

The phenomenon of see arises when a single energetic particle penetrates
these sensitive nodes, causing glitches to the electronic system or
catastrophic failures at the circuit level
([Petersen, n.d.](#orgbfca9ed)). With a variety of possible see,
they can either be transient, permanent, or intermittent.

Faults that may affect the system during its lifetime can be classified
into eight basic viewpoints of phenomenological causes, being of: (i)
natural faults, caused by natural phenomena without human interaction;
(ii) human-made faults, resulted by human interaction such as production
defects; (iii) transient faults, presented within a bounded time-frame; and
(iv) permanent faults, given within a continuous time-frame
([Avizienis et al. 2004](#org5c21a8a)). This paper aims at
reviewing transient fault mitigation.

During the system operation, natural faults can be either internal, due
to the natural process of physical deterioration, or external, due to
the natural process that happens outside the system boundaries and may
cause hardware interference ([Avizienis et al. 2004](#org5c21a8a)).

In fault-tolerant architecture, a fault is a physical defect, such as a
broken transistor. These faults may manifest themselves as an error,
such that having a bit 0 in place of a bit 1, or by not manifesting
itself as an error. An error can be masked or can result in a
user-visible failure ([Sorin 2009](#orgedd241b)).

A fault and/or error does not necessarily become an error and/or a
fault, respectively. This can be mitigated by masking the system at the
design level. The effect of an error at a logical level may not affect
the system, and may not propagate to the architectural level either, as
it depends on which instruction the error will impact. Errors that
propagate to the application level may not be impacted by an error
either, as the error may affect an unused memory location by the
application and never gets triggered
([Sorin 2009](#orgedd241b)).

A transient fault may occur once and not persist across the system,
these are often referred to as _soft error_ or as SEU. Permanent faults
are often called _hard fault_, and persists when the fault occurs and
may manifest itself as a repeated error. An intermittent fault occurs
repeatedly but not over the same place in the system
([Sorin 2009](#orgedd241b)).

Radiation device hardening and see fault tolerance approaches have been taken to
mitigate these issues when they arise
([Petersen, n.d.](#orgbfca9ed)), however, the mitigation
approaches are dependent on their fault duration, as tolerating a transient
fault requires no self-repair due to its non-persistence. Fault tolerance
schemes may treat intermittent faults as either transient or permanent,
depending on how often they occur in the system
([Sorin 2009](#orgedd241b)).

Due to the many physical phenomena that may lead to a fault, a variety
of techniques are available for mitigating these issues according to the
environment they run. Due to the transient high-energy particles, cosmic
rays may produce alpha particles or even electromagnetic interference
from outside sources, generating transient faults to the devices
([Petersen, n.d.](#orgbfca9ed)).

The effects of the fault may change a value of a cell or transistor
output. Due to the one-time disruption, the error will vanish once the
cell or transistor&rsquo;s output is overwritten.
([Sorin 2009](#orgedd241b)) categorizes permanent
phenomena into three categories: (i) permanent wear-out, making a
processor fail due to several physical issues such as thermal cycling
and mechanical stress; (ii) fabrication defects, by manufacturing chips
with inherent defects; and (iii) design bugs, such as a chip not behaving
correctly due to an internal bug. Some physical phenomena may lead to
intermittent faults, such as loss of connection between two wires or
devices.

This work aims at characterizing the types of see and the state-of-the-art that
has been accomplished to mitigate these issues at the circuit- and
software-level. The rest of the paper is organized as follows: section [2](#orgba70270) gives a
brief background over the types of see and how they may affect the system, among
with fault metrics and types of errors, section [3](#org92c5b13) present some techniques for
mitigating single events at the circuit level, section [4](#org241cb21) refers to
software-based approaches for single event mitigation. Finally, section [5](#org074ae44)
provides final conclusions.

#### Background {#background}

<a id="orgba70270"></a>
With the decrease of dimension size of transistors, wires, and smaller chips,
the tendency to transient and permanent faults are much higher, as the dimension
of the chip may impact the temperature directly. Given Moore&rsquo;s law increase the
number of transistors per chip, more opportunities arise for faults in the field
of application and manufacturing. The complexity of processor design increases
the likelihood of design bugs during production, which may bring permanent
faults to the processor during execution time
([Sorin 2009](#orgedd241b)). This section overviews the
types of SEE and how they arise during the life-type of a system.

<!--list-separator-->

- Types of Single Event Effect

  SEE depends on the interaction of a single particle penetrating the device,
  which can be caused by the passage of a single heavy ion by a cosmic ray. As
  cosmic rays are highly energetic in space, they may pass through the device and
  be collected in the device&rsquo;s electrodes. The ion produces an electric pulse that
  may appear to the device as if it should respond and eventually causing a
  failure. High energy protons can also be a cause of failure, as a proton may
  have a nuclear reaction in the silicon device
  ([Petersen, n.d.](#orgbfca9ed)).

  SEE has a variety of possible effects, each of which is important, as they cause
  malfunctioning of devices in space ionizing radiation environment
  ([Petersen, n.d.](#orgbfca9ed)). These SEE is illustrated in
  Table [1](#table--table:types-of-see) with their respective description.

  <a id="table--table:types-of-see"></a>
   <div class="table-caption">
     <span class="table-number"><a href="#table--table:types-of-see">Table 1</a></span>:
     Types of Single Event Effect
   </div>

  | Term                   | Definition                                                                                    |
  | ---------------------- | --------------------------------------------------------------------------------------------- |
  | Single event upset     | A change of state or transient induced by an energetic particle                               |
  | Single hard error      | Causes permanent changes to the operation of the device                                       |
  | Single event latch-up  | Loss of device functionality induced by high current                                          |
  | Single event burnout   | A condition which causes a device to destruct due to high current state in a power transistor |
  | Single event effect    | A measurable effect to a circuit due to an ion strike                                         |
  | Multiple bit upset     | Event induced by a single energetic particle which may cause multiple upsets or transient     |
  | Linear energy transfer | A measure of energy deposited per unit length                                                 |

<!--list-separator-->

- Fault tolerance metric

  Fault tolerance solution requires experiments to test a hypothesis or compare
  with previous works and knowing which errors may apply within the system.
  ([Sorin 2009](#orgedd241b)) covers several important metrics
  on fault tolerance systems, those including (i) the availability of the system,
  by verifying the system is functioning correctly at a specific time; and (ii)
  reliability, is the probability that the system has been functioning correctly
  from time zero to a specific time.

<!--list-separator-->

- Error detection

  Error detection provides a measure of safety, as it is an important aspect of
  fault tolerance since the processor cannot tolerate a problem it is not aware
  of. Redundancy is fundamental to error detection, as it helps the processor
  detect when a given error occurs. There are three classes of redundancy,
  spatial, temporal and information redundancy
  ([Sorin 2009](#orgedd241b)).

  Spatial redundancy adds redundant hardware to the system. The DMR is a simple
  form of spatial redundancy, which provides error detection by using a voter
  system, which then receives the output of all modules and checks for any error
  ([Sorin 2009](#orgedd241b)).

  Temporal redundancy may perform redundant operations, by requiring a unit to
  operate twice and finally compare the results. Temporal redundancy doubles the
  amount of time for each operation. However, in comparison to Spatial redundancy,
  there is no extra hardware or power cost involved. For reducing performance
  cost, some schemes may use pipelining to hide the latency of a redundant
  operation ([Sorin 2009](#orgedd241b)).

  Finally, information redundancy detects when a datum has been affected by adding
  bits to it. Schemes such as EDC can be used for such redundancy, for example, by
  adding a parity bit to a data word and convert into a codeword. The parity
  scheme is popular, due to its simplicity and inexpensive implementation
  ([Sorin 2009](#orgedd241b)).

<!--list-separator-->

- Error recovery

  Error detection is enough for providing safety to the system, but not recovering
  from the error. By recovering from the error, it hides the effect of the error
  from the end-user and allows the system to resume operation
  ([Sorin 2009](#orgedd241b)). Two primary approaches to error
  recovering is FER and BER.

  FER corrects the error without having to revert to a previous state. FER can be
  implemented through physical, temporal, and information means of redundancy. In
  fer, if a specific amount of redundancy is required to determine if an error has
  occurred, then additional redundancy is required to correct the error
  ([Sorin 2009](#orgedd241b)).

  BER restores the state of the system to a previously known good state, known as
  recovery point on single-core systems and recovery-line on multi-core systems.
  The system architect should think through what state it should be saved for
  recovery, where and when to deallocate, the algorithm, and what to do after the
  system has been restored ([Sorin 2009](#orgedd241b)).

#### Hardware Mitigation {#hardware-mitigation}

<a id="org92c5b13"></a>

<!--list-separator-->

- Soft errors

  ([Reis et al. 2020](#orgabf195c)) explores four single transient mitigation
  by evaluating four techniques that can be applied at the circuit level. These
  techniques are covered in the next sub-sections.

   <!--list-separator-->

  - Schmitt Triggers

    In high noise applications, the st works as a replacement for the internal
    inverter of a circuit. The st has a higher dependency over a source-gate voltage
    of its P1 and N1 transistors, resulting in an enhanced robustness over a VTC
    deviation ([Reis et al. 2020](#orgabf195c)).

   <!--list-separator-->

  - Decoupling Cells

    By connecting capacity elements to the most exposed nodes, one can mitigate
    transient effects. The use of decoupling cells increases the total capacity in
    the output of a node of the NAND2 gate, resulting in a decrease of critical
    charge required to produce a single transient pulse, which by effect improves
    signal degradation ([Reis et al. 2020](#orgabf195c)).

   <!--list-separator-->

  - Sleep Transistors

    Circuit blocks that are not in use can be shut off by using the power-gating
    strategy, widely used in low-power designs for reducing chip&rsquo;s power
    consumption. Sleep transistors act as a supply-voltage regulator. When a sleep
    transistor is in active mode, it improves the process variability of a typical
    logic gate connection to the ground rail by acting as a voltage regulator. While
    in standby, the sleep transistor disconnects the virtual ground from the
    physical ground ([Reis et al. 2020](#orgabf195c)).

   <!--list-separator-->

  - Transistor Reordering

    Optimizing transistors arrangements allows reducing current leakage or dealing
    with bias temperature instability. This technique modifies the transistor
    arrangement by still keeping the same functionality that was aimed at. The
    transistor reordering swaps the electrical and physical characteristics of the
    logic cells, resulting in susceptibility to soft errors. The robustness of
    complex gates where can be improved up to 8% by using this approach and can be
    favorable to improve single effect stability of circuits without including area
    penalty in complex gates ([Reis et al. 2020](#orgabf195c)).

#### Software Mitigation {#software-mitigation}

<a id="org241cb21"></a>
Software approaches can also be used for hardware errors. The primary interest
of using a software redundancy is that it brings no hardware cost and requires
no hardware modification. The software approach may provide good coverage of
possible errors and can be easily tested comparing to hardware approaches. The
cost of software redundancy may be significant, as performance may be lost
depending on the core model and software workload, as instruction duplication
requires more processing ([Sorin 2009](#orgedd241b)). The
following presents some solutions for software-based mitigation

<!--list-separator-->

- Selective Code Duplication

  In Selective code duplication, only parts of the code are duplicated, and their
  results are compared, which reduces fault coverage but improves code size and
  execution time overhead. Multiple techniques use selective code duplication,
  such as SWIFT, VAR3+, CDB, and SEDSR.

   <!--list-separator-->

  - Error detection by duplicated instructions

    EDDI consists of inserting redundant instructions and instructions that also
    compares the results produced by the original instruction and the redundant
    instructions ([Sorin 2009](#orgedd241b)). The SWIFT scheme
    by ([Reis et al. 2005](#org6bcee1d))} improved upon EDDI by combining with the control
    flow checking and optimizing the performance by reducing the number of
    comparison instructions.

    ([James et al. 2019](#orgdd83c5d)) provides a tool named coast, which provides an automated
    compiler modification of software to insert a dual- or triple-modular
    redundancy. The approach adds data flow protection to user-provided programs. By
    default, the tool replicates all compute operations and memory loads/stores.
    while keeping a single set of control flow operations. The coast tool provides
    DWC and TMR protection mode. The replication and/or synchronization of
    instructions is fully automated as part of the compilation process. The produced
    software executable is are more tolerant to SEU, ideal for processing in a high
    radiation environment. Experiments were conducted in 30R flight path at the
    lansce, and neutron beam tests have shown that coast provides a significant
    increase in MWTF.

   <!--list-separator-->

  - Error detection by diverse data and duplicated instructions

    EDDDDI is a full code duplication technique, where all instructions in a block
    are duplicated. Comparison instructions are placed after each original and
    duplicated instruction in each block to compare their results
    ([Thati et al. 2018](#org4164aaf)).

   <!--list-separator-->

  - Overhead reduction

    In a VAR3 technique, all instructions in a block, except for branch and store
    instructions are duplicated. The comparison instructions have to be placed
    before load, store, and branch instructions to compare the results
    ([Thati et al. 2018](#org4164aaf)).

   <!--list-separator-->

  - Critical block duplication

    In CBD technique, critical blocks have to be identified in the control flow
    graph. Any block which has the highest number of fan-outs in the control flow
    graph is considered a critical block. If any mismatch of results is detected, an
    error is reported ([Thati et al. 2018](#org4164aaf)).

<!--list-separator-->

- Soft error detection using software redundancy

  SEDSR in an extended version of DBD, however, comparison instructions have to be
  added after the original and duplicated instruction in each identified block for
  comparing results ([Thati et al. 2018](#org4164aaf)).

#### Conclusions {#conclusions}

<a id="org074ae44"></a>
With the continuous trend of smaller chip sizes, the tendency of transient and
permanent faults are much higher. This paper sought to characterize the types of
SEE and how they affect a system according to the environment, and what metrics
are important when considering a fault-tolerant design. By understanding the
difference between error detection and error recovery allows one to seek a
solution which may fit their requirements. Multiple fields of mitigation&rsquo;s have
been reviewed, from a circuit-level techniques to software-level approaches.
Although software mitigation usually impacts performance, it is a cheaper
alternative in comparison to hardware alternatives.

#### Download {#download}

Download the PDF version of this file [here](/files/Single_Event_Effect_Benjamin_Mezger_PGMICRO.pdf).

## Bibliography {#bibliography}

<a id="org5c21a8a"></a>Avizienis, A., J. -. Laprie, B. Randell, and C. Landwehr. 2004. “Basic Concepts and Taxonomy of Dependable and Secure Computing.” _IEEE Transactions on Dependable and Secure Computing_ 1 (1):11–33.

<a id="org76c1800"></a>Buchner, S. 2015. _Overview of Single Event Effects_. _Proc. 11th Int. School Effects Radiation Embedded Syst. Space Appl.(SERESSA)_.

<a id="orgdd83c5d"></a>James, Benjamin, Heather Quinn, Michael Wirthlin, and Jeffrey Goeders. 2019. “Applying Compiler-Automated Software Fault Tolerance to Multiple Processor Platforms.” _IEEE Transactions on Nuclear Science_ 67 (1). IEEE:321–27.

<a id="orgbfca9ed"></a>Petersen, Edward. n.d. _Single Event Effects in Aerospace / Edward Petersen._ _Single Event Effects in Aerospace_. Piscataway, N.J.? IEEE Press.

<a id="org6bcee1d"></a>Reis, G. A., J. Chang, N. Vachharajani, R. Rangan, and D. I. August. 2005. “SWIFT: Software Implemented Fault Tolerance.” In _International Symposium on Code Generation and Optimization_, 243–54.

<a id="orgabf195c"></a>Reis, R., C. Meinhardt, A. L. Zimpeck, L. H. Brendler, and L. Moraes. 2020. “Circuit Level Design Methods to Mitigate Soft Errors.” In _2020 IEEE Latin-American Test Symposium (LATS)_, 1–3.

<a id="orgedd241b"></a>Sorin, Daniel J. 2009. _Fault Tolerant Computer Architecture_. Morgan and Claypool Publishers.

<a id="org4164aaf"></a>Thati, Venu Babu, Jens Vankeirsbilck, Niels Penneman, Davy Pissoort, and Jeroen Boydens. 2018. “CDFEDT: Comparison of Data Flow Error Detection Techniques in Embedded Systems: An Empirical Study.” In _Proceedings of the 13th International Conference on Availability, Reliability and Security_. ARES 2018. New York, NY, USA: Association for Computing Machinery. <https://doi.org/10.1145/3230833.3230854>.
