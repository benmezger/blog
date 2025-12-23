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


## ACID {#acid}

-   Focuses on precision/data reliability
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

-   Guarantees that all transactions that happen, can only bring the current
    consistent state, to another consistent state
-   Ensures that we do not corrupt/invalidate the data -- data integrity
-   Transaction validation
    -   Respects that all data restrictions are maintained: Types, Foreign Keys,
        Nullability, Triggers, etc.
    -   I.e. if we try to insert a string in a INT column
    -   If we try to insert a FK into a column, and that FK does not exist


### Isolation {#isolation}

-   Operates independently and simultaneously of other transactions
-   Transactions happening at the same moment do not interfere with others
-   Dirty Reads
    -   Reading data that was modified by another transaction which has not yet
        been applied
    -   Say we have 2 transactions reading the same table. One transaction can not
        continue, without the other transaction finishing.
-   Non-repeatable Reads
    -   A transaction reads the same row twice and gets different values each time.
        This happens because another transaction modified (and committed) that row in
        between the two reads.
-   Phantom Reads
    -   A transaction re-executes a query that returns a set of rows, and new rows
        appear or existing rows disappear in the result. Because another transaction
        inserted, deleted, or updated rows that match the query condition and
        committed in between.
    -   Unlike non-repeatable reads (which involve the same row changing), phantom
        reads involve changes to the set of rows.


### Durability {#durability}

-   After the confirmation of a particular operation, the data will not be lost
    -   I.e.: after a `COMMIT`, the data is guaranteed to be stored
-   Confirmed, a transaction will exist permanently
-   Persistence of data in a non-volatile source


## BASE and Eventual State {#base-and-eventual-state}

-   Basic Availability, Soft-State and Eventual Consistency
-   Focuses on flexibility
-   Flexibility for more large-scale distributed systems
-   Partially contrary to ACID
-   Availability and fault-tolerance are a priority
-   Systems that have to deal with eventual consistency
-   Databases BASE are more towards performance and high availability, in exchange
    to not being so consistent
-   Mostly NoSQL databases
    -   Mongo, Cassandra, etc.


### Basic Availability {#basic-availability}

-   Maximizes availability
    -   Guarantees a total and uninterruptible availability, and offers mechanism to
        work in a degraded or partial state
    -   I.e. If we have a database with three nodes, and one node fails, it can show
        a partial number of data (not all)
-   Some data or functionality may not be available
-   Allows replication and partitioning (sharding)
-   Useful for large-scale and high-demand environments, where partial data is
    accepted
    -   Maintain consistent operation is more important than having an 100% up to
        date version of the data


### Soft-State {#soft-state}

-   System can change over time
-   Data can expire (with a TTL) or updated by the database
    -   I.e.: `memcached`, `Redis`, etc.
    -   Ideal for cache systems
-   Volatile databases
-   There is no guarantee that the system maintains consistency


### Eventual Consistency {#eventual-consistency}

-   Non confirmation in all nodes
-   Write operation can happen in a single node and not be confirmed with the
    other nodes
-   Asynchronous replication
    -   For example, on a write operation, it may write in a single node and
        confirm, and later replicate this data to the other nodes
-   The data can be inconsistent in many nodes for a limited time
-   Performance oriented
-   High availability and scalable


## CAP Theorem {#cap-theorem}

-   3 principles: Consistency, Availability and Partition Tolerance
-   Conceptual model
-   Helps classify distributed and non-distributed databases
-   Helps us consider scenarios and architectural choices that vary on
    Consistency, Availability and Partition Tolerance
-   Can choose 2 of the 3 principles (choose 2)
    -   CA, CP, AP, etc.
-   In a distributed system, we cannot achieve all three principles
-   Offers a base for us to identify the limitations of any database


### Components of CAP (`C`, `A` and `P`) {#components-of-cap--c-a-and-p}


#### Consistency (`C`) {#consistency--c}

-   Guarantee that all the nodes of a database with distributed data present the
    same data simultaneously
-   Regardless of the node queried, all of them return the most recent version of
    that data
-   Atomicity
-   Financial systems and hospital registration are examples of such systems that
    require consistency
-   Systems with `Consistency` are ACID with strong consistency


#### Availability (`A`) {#availability--a}

-   Ensures that any request to the system will get a response
-   Regardless whether the data is updated in a node
-   Presumes that the data returned can or cannot be the most recent. Even for
    read or write operations.
-   High performance, high volume and fast response time
-   Detriments the guarantee of the actual data
-   Mostly BASE systems


#### Partition Tolerance (`P`) {#partition-tolerance--p}

-   Systems can work when the replicas of my system is partitioned into two
    different versions (not a table partition)
-   Distributed database capacity of maintaining an operational state
-   Even on a degraded state, it can offer system continuity
-   Databases geo-distributed, social networking, log aggregators, brokers, queues
    are all examples of such system
-   More related to BASE systems


### Combination {#combination}


#### Consistency and Partition Tolerance (`CP`) {#consistency-and-partition-tolerance--cp}

-   Prioritizes the consistency and tolerance to partitioning
-   Sacrifices availability
-   Maintains consistency within all nodes that continue to operate in case of a
    network failure or partition
-   Allows disabling inconsistent nodes, makes them unavailable until consistency
    is restored
    -   "I rather be unavailable than inconsistent"
    -   "Inconsistency is non-negotiable"
-   Mix of BASE and ACID systems
-   We need to prioritize data precision, approximate transactional atomicity
-   Examples such as MongoDB, Cassandra, Couchbase, Etcd, Consul, etc.


#### Availability and Partition Tolerance (`AP`) {#availability-and-partition-tolerance--ap}

-   Prioritizes high availability and partition tolerance
-   Sacrifices consistency
-   Every node stays available for querying, independently of its up to date state
-   During the synchronization process, all nodes will continue responding
-   More important than maintaining consistency
-   Examples of such databases are: DynamoDB, CouchDB, Cassandra (depending on its
    configuration), SimpleDB, etc.
-   Base systems


#### Consistency and Availability (`CA`) {#consistency-and-availability--ca}

-   Prioritizes consistency and availability
-   Sensible to data partition
-   In cases of a network failure or partition, the system can stay completely
    inoperational
-   Centralized databases, traditional SQL databases, MySQL/MariaDB, PostgreSQL,
    Oracle, SQL Server, Redis Standalone, Memcached Standalone are all examples
    of such database
-   Leans towards ACID rather than BASE


### CAP model today {#cap-model-today}

-   2/3 is not extremely exclusive
-   Excessive simplification is not real in modern technology
-   Consistency and availability (on/off)
    -   Layers of unavailability -- not on or off
-   Level of Consistency is not binary
    -   We can have different levels of consistency
    -   There are moments where we are 100% consistent, while moments we are not


## PACELC theorem {#pacelc-theorem}

-   Complementary to CAP -- used as an "extension to CAP"
-   Helps us identify gaps that CAP does not cover (partition is not always
    available)
-   Mainly related to AP, CP models
-   Helps us understand the answer of:
    -   "What should the system prioritize when it's not functioning correctly?"
    -   "What should it prioritize when a partitioning happens between the nodes?"
    -   "Is it possible to operate with more than one level of consistency?"
-   When a Partitioning of network (P) happens between the nodes of the system, it
    is necessary to choose between Consistency (C) or Availability (A)
-   If there is a partition (P), we should choose between Availability (A) and
    Consistency (C)
-   If there is no partition, we choose between Latency (L) and Consistency (C)

{{< figure src="/imgs/PACELC-theorem-diagram.jpg" >}}

-   Even on normal conditions, we have to make hard decisions
-   More guarantee in exchange of response time
-   Response time in exchange of Consistency
-   Strong Consistency
-   Eventual Consistency
-   Both theorem are not mutually exclusive, but complementary to each other


### Applying PACELC {#applying-pacelc}

-   PA/EL
    -   **On Partition, Availability; Else, Latency**
    -   Normal: Prioritizes latency instead of consistency
    -   In partition: Prioritizes availability instead of strong consistency
    -   Model of pure eventual consistency
    -   High write performance
    -   Accept versions different of the data
-   PC/EL
    -   **On Partition, Consistency; Else, Latency**
    -   Normal: Prioritizes latency and high throughput in exchange of consistency
    -   In partition: Prioritizes consistency
    -   Can be unavailable until the cluster recovers and it comes back at operating
    -   Minimum consistency during failures is non-negotiable
    -   Accepts eventual consistency, but only when all nodes are available
-   PA/EC
    -   **On Partition, Availability; Else, Consistency**
    -   Normal: Prioritizes strong Consistency
    -   In Partition: Prioritizes availability
    -   Assumes eventual consistency as a last resort
    -   CRDTs - Conflict-Free Replicated Data Types
    -   Hybrid context in microservices
-   PC/EC
    -   **On Partition, Consistency; Else, Consistency**
    -   Normal: Prioritizes consistency instead of latency
    -   In partitions: Prioritizes consistency instead of availability
    -   Conservative model of consistency
    -   Data precision is the most important
