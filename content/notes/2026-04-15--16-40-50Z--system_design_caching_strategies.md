+++
title = "System Design - Caching Strategies"
author = ["Ben Mezger"]
date = 2026-04-15T18:40:00+02:00
slug = "system_design_caching_strategies"
tags = ["system-design", "caching"]
type = "notes"
draft = false
bookCollapseSection = true
+++

-   Related pages
    -   [System Design - Databases, data models and indexing]({{< relref "2025-12-23--15-09-32Z--system_design_databases_data_models_and_indexing.md" >}})
    -   [System Design - Network]({{< relref "2025-12-20--11-05-22Z--system_design_network.md" >}})
    -   [System Design - RAID and Storage]({{< relref "2025-12-20--14-59-27Z--system_design_raid_and_storage.md" >}})
    -   [System Design - CAP theorem, ACID, BASE and PACELC]({{< relref "2025-12-22--17-16-20Z--system_design_cap_theorem_acid_base_and_pacelc.md" >}})

---


## What is cache? {#what-is-cache}

-   Intermediary layer between client and data source
-   Stores results from heavy/expensive operations
-   Reduces latency and dependency load
-   Cheap but hard to do it right :)
-   Needs to be reconstructible -- can only be cached what can be
    retrieved from the origin


## Definitions {#definitions}

-   Weak consistency
-   Eventual consistency
-   Extra layer of the golden source -- cheap layer from the expensive
    layer
-   Challeges of guaranteeing aligment of cache and the data source
-   Writes need to update or invalidate cache
-   Question: how many times can the registration data for a single user
    change?
-   We need to ensure cache data remains up to date, as non-updated data
    can be a problem (i.e. returning an old profile picture when the
    user already updated)


### TTLs {#ttls}

-   Soft-state (BASE)
-   Expires (removes from cache) data
-   TTLs to solve soft-state issues
-   Ensures periodic data recycling


## Eviction policies {#eviction-policies}

-   Defines which items to remove once the cache storage reach its limit
-   **LRU**: removes the least recently used
    -   Assumes that if the item hasn't been used recently, it will
        probably not be used in the future
-   **LFU**: removes the least frequently used
    -   Counter; counts the items that hasn't been used frequently
-   **FIFO**: removes the oldest
    -   Removes the oldest key (the first key that was created)
    -   Not very performatic
-   **RR**: Random replacements
    -   Randomly removes a key
-   Mechnism of defense, but it costs a lot to perform; we try to
    prevent this using good cache validation approaches


## Cache invalidation {#cache-invalidation}

-   Mechanism of removing or marking itens as invalid
-   Can be done manually, logically or through TTLs
-   Consistency
-   Biggest challenges of cache
-   We do cache validation to avoid eviction policies to run


## Cache Hit, Miss and Hit Rate {#cache-hit-miss-and-hit-rate}

-   Caching metrics
-   **Cache Hit**: data is in cache; so response is immediate
-   **Cache Miss**: data is not in cache; so we need to fetch from the
    source
    -   We want to decrease cache miss and increase cache hits
-   **Hit Rate**: cache hits / number of requests (miss + hits)
-   High hit rates = efficient system
-   Low hit rate = inneficient system


## Cache implementation {#cache-implementation}

-   Memory cache (In-Memory)
-   Distributed cache (Redis, Memcached, etc.)
-   Database cache and data layers
    -   Cache-Aside (Lazy Loading)
    -   Write-Through (Double Write)
    -   Write-Behind (Lazy Writing)
    -   Distributed Content Cache (CDN Cache)


### In-Memory {#in-memory}

-   Local memory cache
-   Great access performance
-   Common data structures
-   Key-Value (Hashmap)
-   Scope limited to a process/thread
-   Requires manual invalidation to avoid leaks


### Cache in distributed systems {#cache-in-distributed-systems}

-   Performance, latency reduction and escalability
-   Serves dynamic and static content
-   Shared across N replicas
-   Horizontal scalability throught clustering
-   Replicas and high availability
-   Supports expiration and eviction policies nativaly
-   Technologis: Redis, Memcached


### Cache in data layers {#cache-in-data-layers}

-   Additional layer of data
-   Computational cheaper data
-   Relieves critical components
-   Saves computational resources of the database
-   Caches items least modified
-   Stores the results of hot queries


#### Cache-Aside {#cache-aside}

-   Lazy Loading
-   Only creates the cache once the application needs
-   Most common strategy in data layers
-   If not found, it fetches from the DB
-   Populates the cache and return (creating cache takes a bit of time)
-   Consistency challenges of the DB


#### Write-Through {#write-through}

-   Write is done simultanously -- once the data is stored in the DB,
    its immediatly written to cache
-   DB and cache
-   Ideal for when read operations needs to be done fast since the
    beginning
-   Consistency challenge
-   Combined with Cache-Aside (Fallback)


#### Write-Behind {#write-behind}

-   Write happens first in the cache, and then to the DB (asynchronous)
-   Prioritizes application performance
-   Low latency of writes
-   Risks loosing data before the flush
-   Used with queues, events and intermediary services


#### Distributed Content Cache (CDN cache) {#distributed-content-cache--cdn-cache}

-   Network of distributed geographically servers
-   Edge location (near the user)
-   Stores static content
-   Images, videos, CSS and JS
-   Cache-Aside strategy (miss -&gt; origin, hit -&gt; edge)
-   Geographic replication
-   Invalidation through expiration or manual
-   Reduces geographic latency
-   Reduces origin load
-   Includes segurity (DDoS, Firewall, thread detection, etc)
-   Asynchronous invalidation and non-performatic
-   Large-scale operations
