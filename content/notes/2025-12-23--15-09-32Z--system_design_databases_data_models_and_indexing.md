+++
title = "System Design - Databases, data models and indexing"
author = ["Ben Mezger"]
date = 2025-12-23T16:09:00+01:00
slug = "system_design_databases_data_models_and_indexing"
tags = ["system-design", "databases"]
type = "notes"
draft = false
bookCollapseSection = true
+++

-   Related pages
    -   [System Design - Network]({{<relref "2025-12-20--11-05-22Z--system_design_network.md#" >}})
    -   [System Design - RAID and Storage]({{<relref "2025-12-20--14-59-27Z--system_design_raid_and_storage.md#" >}})
    -   [System Design - CAP theorem, ACID, BASE and PACELC]({{<relref "2025-12-22--17-16-20Z--system_design_cap_theorem_acid_base_and_pacelc.md#" >}})

---


## Database {#database}


### What they are {#what-they-are}

-   Abstracted organization of data
-   Software layer between the client and the storage
-   Considerations in a distributed system
-   Replication, Geo-Distribution and consistency
-   Implements some of the BASE and/or ACID models
-   Additional complexity due to architectural decisions
-   Different types of databases
    -   Databases NewSQL
    -   Non-relational databases
    -   Relational databases
    -   Timeseries databases
    -   Memory databases


### Relational Databases (SQL) {#relational-databases--sql}

-   Tables, Tuples and columns
-   Rigid and declarative schema
    -   We define all restrictions, types, cohesion rules, foreign key constraints,
        etc.
    -   Column id(int) does not allow a string, for example
-   Strong consistency
-   ACID
-   Strong reference integrity
-   Transaction model
-   Focusses on integrity and durability
-   Attributes that they can relate to each other (FKs, etc)
-   Examples are:
    -   PostgreSQL
    -   MySQL / MariaDB
    -   Oracle
    -   SQLServer
    -   Etc.


### Non Relational Databases (NoSQL) {#non-relational-databases--nosql}

-   Flexible schemas
-   Eventual consistency
-   Different data formats
-   Documents, key-value, graphs, column
-   Optimized horizontal scaling
-   Generally higher write performance, geo distribution, etc. (in exchange of not
    so much consistency)
-   No guarantee of integrity and atomicity
-   Data semi-structured
-   Examples are:
    -   MongoDB
    -   MemcachedDB
    -   Cassandra
    -   Redis
    -   Elasticsearch
    -   Etc.
-   One of the characteristics is to prevent costly joins
    -   Non relational = not relation between the data
-   For example, in MongoDB, we can have relationship between the collections, but
    it is not recommended, given we have to make many queries to relate them
-   If we need to relate entities, use a related database


### NewSQL Databases {#newsql-databases}

-   ACID + Horizontal scalability
-   Sharding and replication
-   RAFT/Paxos
-   New proposal that focuses on resolving the trade-offs of SQL and NoSQL
    regarding strong consistency, performance and horizontal scalability
-   Seek to provide some reliability in terms of transactions
-   Not yet super mature
-   Examples are:
    -   CockroachDB
    -   Google Cloud Spanner
    -   MemSQL
    -   VoltDB
    -   AltiBase


### In-Memory Database {#in-memory-database}

-   Uses volatile memory -- non-persistent in disk
-   Latency of nanoseconds in RAM
-   Key-value model
-   Non structured
-   Volatile and performance
-   Scales through consistent hash
-   Layer of cache and intensive reads
-   Data needs to be reconstructible
    -   Focuses on non-durable data
-   Useful for data that doesn't change much, caching, etc
-   Trade-off of now having the most updated value
-   Important data is generally not stored in these databases
-   Examples are:
    -   MemcachedDB
    -   Redis
    -   Valkey
    -   Apache Ignite
    -   Aerospike


### Time-Series Databases (TSDB) {#time-series-databases--tsdb}

-   Append Only
    -   Generally we do not update data
-   Temporal indexing
-   High ingestion
-   Analytical queries
-   Used in metrics and logs
-   Automatic expurge
-   Supports high load of write operations
-   Mathematical operations
-   Sequential and segmented based on the collection time
-   Examples are:
    -   Timescale
    -   InfluxDB
    -   Prometheus
    -   VictoriaMetrics
    -   Graphite
    -   Grafana Mimir


## Levels of consistency {#levels-of-consistency}

-   When discussing distributed systems, the choice of level of consistency of
    data is an important factor
-   Knowing when to choose eventual consistency of strong consistency can either
    elevate the scalability of the system, as well as generate scalability
    problems. Race-conditions problem, data loss, high-throughput reads/writes,
    data durability, etc.
-   Strong consistency vs Eventual consistency
-   Impact in client experience
-   Reliability vs performance
-   Integrity vs Scalability
-   Levels of integrity


### Strong consistency {#strong-consistency}

-   Linearity
-   Synchronous Quorum
-   Paxos and Raft
-   Write latency
-   More reliability
-   Atomicity and transactions
-   Consistent state -> consistent state
-   Flow of synchronous commits
-   Critical and atomic operations
-   Examples of databases are:
    -   MySQL
    -   MariaDB
    -   PostgreSQL
    -   Oracle
    -   Cassandra (requires configuration)


### Eventual consistency {#eventual-consistency}

-   Asynchronous replication
-   High availability
-   Tolerance and partitions
-   Strategies to resolve conflicts
-   Last-Write-Wins, CRDT (Conflict-free Replicated Data Type)
    -   The last version of the data, is the one that stays (generally based on a timestamp)
-   High throughput and low latency
-   Requires time to reflect data in all nodes
-   Examples are:
    -   ScyllaDB
    -   DynamoDB
    -   CouchDB
    -   MongoDB
    -   Elasticsearch
    -   Etc.


## <span class="org-todo todo TODO">TODO</span> Data Models {#data-models}


### Tuple (Row-Oriented) {#tuple--row-oriented}

-   OLTP
-   Row = tuple, where each item in the tuple corresponds to the column
-   Cache of pages
    -   Page size
-   Low latency per row
-   Groups attributes of the same entity physically in the same block


### Column-Oriented {#column-oriented}


### Documents {#documents}


### Wide-Column {#wide-column}


### Key-Value {#key-value}


### Graphs {#graphs}
