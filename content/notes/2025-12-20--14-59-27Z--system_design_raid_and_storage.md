+++
title = "System Design - RAID and Storage"
author = ["Ben Mezger"]
date = 2025-12-20T15:59:00+01:00
slug = "system_design_raid_and_storage"
tags = ["system-design", "storage"]
type = "notes"
draft = false
bookCollapseSection = true
+++

-   Related pages
    -   [System Design - Network]({{<relref "2025-12-20--11-05-22Z--system_design_network.md#" >}})

---

Notes on computer storage architecture regarding system design.


## Storage {#storage}

-   Persisting data in a organized manner
    -   Even on system failure
-   Recovering and accessing when needed
-   Long-term storage
-   Security, performance, latency, scalability, redundancy, replication,
    availability, etc.
-   HDD, SSD, Network Systems, etc.
    -   Where to store the data, depending on our use-case
    -   Best storage model for cases where we write a lot, or read a lot
-   We want to expand the size in case we reach the maximum capacity


## Metrics and dimensions {#metrics-and-dimensions}

Some metrics can help guide us based on our requirements, which storage to
choose.


### Throughput {#throughput}

Number of operations a system can handle within a determined period of time.

-   Operations / time
-   Data transferred to a storage unit
-   Number of reads and writes
-   Megabytes per second (MB/s)
-   Gigabytes per second (GB/s)

Disks with higher throughput are generally more expensive and used for systems
that the amount of read/write are extremely high. They need to work with a large
amount of request, etc.

Throughput is the amount of data we are writing within a time range.


### Bandwidth {#bandwidth}

The max capacity of my throughput.

-   Maximum quantity of data in my communication channel
-   Represents my maximum throughput
-   MB/s, GB/s, etc.

Bandwidth is the max throughput our channel can accept.


### I/O and IOPS {#i-o-and-iops}

I/O represents a read/write operation that happens within a system and a storage
unit.

-   I/O operations per second
-   Read/Write operations

I/O and IOPS shows the number of read/write operation within a unit of a second.
We want to keep in mind the number of IOPS a storage can handle, and how much
are we using now.


## Storage Models {#storage-models}

Similarly to the OSI model, we can also have a similar layered model for
storage.


### DAS (Direct-Attached Storage) {#das--direct-attached-storage}

-   Traditional model, generally connected to the host through SATA, USB, etc.
-   Disk allocation is done within the host
-   Direct access
-   No additional latency
-   No complex protocol, nor any networking connection
-   Frequent and intense disk access
-   Does not support attaching to simultaneous systems (can be done through
    software)
-   Hard to scale horizontally.
-   Centralized


### NAS (Network-Attached Storage) {#nas--network-attached-storage}

-   NFS (Network File System)
-   Directly connected to the network
-   Allows multiple hosts to connect to the volume
-   SMB
-   Modifies the same data simultaneously
-   Data is available through a network
-   Centralized server
-   Can scale horizontally
-   Requires additional software and network layers, so there are more latency,
    network bandwidth limits, can be affected by network bottlenecks or spike of
    requests


### Block Storage {#block-storage}

-   Allows storing scattered data in a block
-   Direct access through the OS and as a mounted storage
-   The server responsible for managing the blocks can wipe them, and use them as a
    file system
-   Addressing is unique and can be organized individually
-   Isolated disk but can also be used virtually
-   The size of the block is generally fixed-set, unless it supports resizing
    dynamically


### File Storage {#file-storage}

-   File-level or file-based storage
-   Hierarchy structured system of files and directories
-   Has metadata (`created_at`, `updated_at`, `permissions`, etc.)
-   The name of the file with a hierarchy structure forms the unique identifier
-   These systems can be configured using RAID and are attached to a NAS system


### Object Storage {#object-storage}

-   Architectured more oriented to services -- more scalable than the others
-   Implemented at a protocol level (they offer APIs so we can access them) --
    layer 7
-   Highly abstracted
-   High amount of data, completely detached from the application
-   Content and metadata support
-   Allows configuring things such as life-cycle, exclusions, etc.
-   Available through cloud provider (GCP, AWS, etc.)
-   Backup, replication and lifecycle support
    -   Transparent from the application
-   Cloud Native architecture
-   High decoupling from the application


## RAID models {#raid-models}

-   Redundant Array of Independent Disks
    Combines multiple volumes of physical disks into a single logical system
-   Tradeoff between resilience, fault tolerance, performance and data integrity
-   RAID `0`, `1`, `5`, `6` and `10` (`1+0`)


### RAID 0 (Striping) {#raid-0--striping}

-   Focuses in space and performance
    -   Data is distributed equally into one or more disks
-   R/W optimized
    -   Parallelizes the IOPs to each disk
-   Lack of availability and resilience
-   Sum of IOPs of the disks
    -   2 disks where each has a limitation of 1000 IOPs, then we our system has 2k
        IOPS
-   If a single disk fails, all data is lost
-   Physical disks can be expanded horizontally
-   Useful for temporary data processing
-   Useful for persistent cache with a low TTL
-   Useful for video and image rendering
-   Useful for CI/CD clusters or stateless with high I/O transitions
-   Avoid critical workflows
-   Useful for when R/W is a priority
-   Useful for temporary or redundant data


### RAID 1 (Mirroring) {#raid-1--mirroring}

-   Focuses on availability and redundancy
-   Applies mirroring of data -- each disk has an exact copy
-   Copies all its data to other disk
-   If a disk has a problem, another disk takes responsibility without any
    interruption or data loss
-   Uses half of the storage due to replication (50% of usable space)
-   Useful for high availability and simplicity
-   Useful for Cluster Management
-   Useful for Etcd, state managers, etc.
-   Useful for Storage with Edge Nodes
-   Useful for file systems
-   Useful for critical systems


### RAID 5 (Striping with Distributed Parity) {#raid-5--striping-with-distributed-parity}

-   RAID 0 and 1 tradeoffs
-   Performs well with R/W without sacrificing availability and security
-   Perform write operations distributed between the volumes
-   Maintains parity metadata distributed between volumes
-   Requires at least 3 disks, with N-1, where 1 is used for parity distribution
-   Performance is reduced when one disk is removed
-   Tolerates 1 disk failure
-   Slow reconstruction
-   Good use of disk space
-   Useful for little mutable data -- data that does not change much -- good for
    read operations
-   Useful for a long-term data
-   Useful for storing logs


### RAID 6 (Striping with double parity) {#raid-6--striping-with-double-parity}

-   Similar to parity distribution of RAID 5
-   Additional layer of distributed parity
-   2 disks can fail simultaneously without data loss
-   RAID 6 requires 2 additional volumes instead of 1 (as of RAID 5)
-   Performance is slightly decreased due to double parity
-   Useful for high data ingestion and retention
-   Useful for geographical replication
-   Useful for Data Lakes and Data Warehouse
-   Generally standard in Datacenters


### RAID 10 (Combination of RAID 1 with RAID 0) {#raid-10--combination-of-raid-1-with-raid-0}

-   Combines RAID 1 and RAID 0
-   Distributes the blocks between different disks
-   High availability
-   Tolerates simultaneous disk faults
-   Total capacity is reduced by half, given 50% is used for data replication
-   Expensive
-   Useful for financial systems, where availability is a priority
-   Useful for systems where the cost of losing data is higher than the cost of
    RAID 10
-   Requires a minimum of 4 disks -- for mirroring and striping


### Comparison {#comparison}

| RAID | Fault Tolerance | Performance | Usable space | Use-case                                       |
|------|-----------------|-------------|--------------|------------------------------------------------|
| 0    | None            | High        | 100          | Data that has no transactional value           |
| 1    | 1 Disk          | Medium      | 50%          |                                                |
| 5    | 1 Disk          | Good        | ~80%         | Critical OSs, we can restore old backups, etc. |
| 6    | 2 Disks         | Regular     | ~65%         | Systems that require more resilience           |
| 10   | 1 per pair      | High        | 50%          |                                                |
