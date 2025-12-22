+++
title = "System Design - CAP theorem, ACID, BASE and PACELC"
author = ["Ben Mezger"]
date = 2025-12-22T18:16:00+01:00
slug = "system_design_cap_theorem_acid_base_and_pacelc"
tags = ["system-design", "data"]
type = "notes"
draft = false
bookCollapseSection = true
+++

-   Related pages
    -   [System Design - RAID and Storage]({{<relref "2025-12-20--14-59-27Z--system_design_raid_and_storage.md#" >}})
    -   [System Design - Network]({{<relref "2025-12-20--11-05-22Z--system_design_network.md#" >}})

---

Notes on CAP theorem, ACID, BASE and PACELC regarding system design.


## <span class="org-todo todo TODO">TODO</span> ACID {#acid}

-   Related to transactional models
-   Atomicity, Consistency, Isolation, Durability
-   Transactional databases
    -   SQL Databases
-   Atomic and reliable transactions
-   Prioritization of transaction and commits
-   Detriments performance and availability


### Atomicity {#atomicity}

-   Ensures that each transaction is treated as an indivisible unit
    -   "_All or nothing_"
-   All operations within the transaction should be completed
    -   Otherwise, nothing will be applied
-   Strong consistency
-   Operations that require dependency
    -   i.e: create an order row of a particular product, while decrementing from
        the quantity of available product
    -   Financial market -- persist the credit while decrementing the users balance


### Consistency {#consistency}

-   Guarantees that all transactions that are happens, can only bring the current
    consistent state, to another consistent state
-   Ensures that we do not corrupt/invalidate the data -- data integrity
-   Transaction validation
    -   Respects that all data restrictions is respected: Types, Foreign Keys,
        Nullability, Triggers, etc.
    -   I.e. if we try to insert a string in a INT column


### <span class="org-todo todo TODO">TODO</span> Isolation {#isolation}


### <span class="org-todo todo TODO">TODO</span> Durability {#durability}


## <span class="org-todo todo TODO">TODO</span> CAP Theorem {#cap-theorem}

-   3 principles: Consistency, Availability and Partition Tolerance
-   Conceptual model
-   Helps classify distributed and non-distributed databases
-   Helps us consider scenarios and architectural choices that vary on
    Consistency, Availability and Partition Tolerance
-   Can 2 of the 3 principles (choose 2)
    -   CA, CP, AP, etc.
-   In a distributed system, we cannot achieve all three principles
-   Offers a base for us to identify the limitations of any database
