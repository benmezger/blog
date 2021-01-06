+++
title = "Modeling C-based systems with UML"
author = ["Ben Mezger"]
date = 2020-11-14T12:54:00-03:00
slug = "modeling_c_based_systems_with_uml"
tags = ["programming", "c", "methodologies"]
type = "posts"
draft = false
bookCollapseSection = true
+++

tags
: [Software Engineering]({{< relref "2020-06-23--12-50-55Z--software_engineering" >}}) [Methodologies]({{< relref "2020-06-23--12-50-09Z--methodologies" >}})

## Introduction {#introduction}

The Unified Modeling Language (UML) is used almost exclusively for Object
Oriented Programming (OOP). Since embedded system design has become increasingly
more complex, designers have been searching for new methodologies to manage
these complexities and allowing higher productivity. Due to the exclusivity of
UML for OOP, it makes it difficult for functional programmers to integrate UML
concepts into the modeling because the transformation of many UML concepts to C
is difficult and confusing ([Wang 2009](#org0cc8c75)).

The problem when integrating UML tools into modeling a embedded system happens
because programmers require to two different ways of thinking: (i) OO way and
(ii) functional oriented way. ([Wang 2009](#org0cc8c75)) presents a set of mapping rules
on which allows UML to be applied in modeling embedded system.

### Unified Modeling Language (UML) {#unified-modeling-language--uml}

There are six basic UML elements:

1.  Class
    Defines the state, attributes and behaviour. It can be called active or
    abstract. The active class means a thread class that has a defined state,
    behaviour, attributes and has the instances of it as objects. A class can be
    abstract when it is in one or more states, when operations or behavior are
    not completely defined, when in an abstract stage, or when it is not for
    creating objects but only inheritance can create the objects.
2.  Package
    A packed collection of classes and objects.
3.  Stereotype
4.  Object
    An instance of a class that is a functional entity formed by copying the
    states, attributes and behavior from a class.
5.  Anonymous object
6.  State
    A defined state, for example, rounded rectangle with state name for its
    identity.

A conceptual design can use the User Case Diagram (UCD), Object Model Diagram
(OMD), Structure Diagram (SD), Sequence Diagram (SD), Activity Diagram and
State-chart UML approaches.

1.  Use Case Diagram
    Shows the main functions of the system (use case) and the entities that are
    outside the system (actors). UCDs show how classes and objects interact with
    each other. UCDs allow requirements specifications for the system and the
    interactions between the system and external actors.
2.  Structure Diagram
    Helps defining the system structure and identify large-scale organizational
    pieces of the system. It allows flow visualization of information between
    system components and the interface definition through ports.
3.  Object Model Diagram
    Specifies the structure of the classes, objects and interfaces in the system
    and the static relationship that exist between them.
4.  Sequence Diagram
    Describes how structural elements communicate with one another over time and
    identifies the required relationships and messages.
5.  Activity Diagram
    Describes the dynamic aspects of a system and the flow of control from
    activity to activity, allowing visualization of interactions between the
    system, the environment and the interconnections of behaviors for which the
    subsystem or components are responsible.
6.  State-chart
    Defines the behavior of classifiers (actors, use case or classes), objects,
    including the states they may enter over their lifetime, messages, events or
    operations on which causes the transition from state to state.

## <span class="org-todo todo TODO">TODO</span> UML To C {#uml-to-c}

A C-language software is a function oriented design with header files, function
files, local and global variables, flow charts, state diagram and etc. Due to
UML having no direct support for C-language, ([Wang 2009](#org0cc8c75)) does not cover
all the aspects of the code, but rather replaces or transforms some of the
feature.

> In this strategy, we provide rules for UML elements used only the adopted set of
> diagram types. Every use case in the UCDs can describe two C files (one .c and
> another .h header file) because each use case defines a behavior yielding an
> observable result and in order to reuse the result a use can be included by
> another use case [@wang2009modeling].
>
> Sequence diagrams identify the sequence of function calls. In the case where a
> system object can have different states, as specified in the State Machines, it
> can be described using UML statecharts. The Activity Diagram in UML can
> represent the flowchart for a function use. Event triggers in those diagrams are
> implemented by triggering the timers, the user inputs, and interrupts, etc
> [@wang2009modeling].

## Bibliography {#bibliography}

<a id="org0cc8c75"></a>Wang, Guoping. 2009. “Modeling C-Based Embedded System Using UML Design.” In _2009 International Conference on Mechatronics and Automation_, 2973–77.
