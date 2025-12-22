+++
title = "System Design - Network"
author = ["Ben Mezger"]
date = 2025-12-20T12:05:00+01:00
slug = "system_design_network"
tags = ["networking", "system-design"]
type = "notes"
draft = false
bookCollapseSection = true
+++

Review of some computer networking concepts and architecture.


## Network protocols {#network-protocols}

-   Defines a communication pattern
    -   How one or more system can communicate with each other
-   Set of rules that define the format and sequence of messages
    -   How they should be sent, received, structured.
-   Ensures correct interpretation between different systems
-   Different protocol implementation, with different standards and rules.


## OSI model {#osi-model}

Conceptual model of how these different protocols relate to each other. Works
like a map of where each functionality of these protocols lie.

-   Open System Interconnection
-   Standardizes the functionality of these protocols
-   7 abstraction layers

    {{< figure src="/imgs/osi-model.png" >}}

    Software engineers generally work with `Application`, `Presentation` and
    `Session` layers.

    1.  **Application**: HTTP, HTTPS, FTP, gRPC, Websockets, etc.
    2.  **Presentation**: SSL/TLS, MIME, JPEG, GIF, etc.
    3.  **Session**: RPC, SCP, SOCKS,
    4.  **Transport**: TCP/UDP, etc.
    5.  **Network**: IPv4, IPv6, etc.
    6.  **Data link**: Point-to-Point Protocol, Mac Address
    7.  **Physical**: Wires, WiFi, Binary, etc.

Flow of communication:

Request: 1..7
Response: 7..1


## IP, IPv4 and IPv6 Protocol {#ip-ipv4-and-ipv6-protocol}

-   Operates in the `Network` layer of the OSI model
-   Heart of data communication of the Internet.
-   Allows devices to connect in an internal or external network
-   Defines unique IP addresses for each device in the network
-   IPv4 and IPv6 are the most common examples


### IPv4 (Internet Protocol Version 4) {#ipv4--internet-protocol-version-4}

-   Oldest version and most used protocol
-   32-bit address format -- allows 4.3 billion addresses of IPs
-   Lack of IPv4 IPs available
-   Private IP allocation
-   NAT (Network Address Translation)

Most used protocol at the moment.


#### NAT (Network Address Translation) {#nat--network-address-translation}

It's a strategy/pattern

-   Proxy between networks (`private -> public`)
-   Allows multiple devices with private IPs to access the network through an
    unique IP

    {{< figure src="/imgs/networking-nat.svg" >}}


### IPv6 (Internet Protocol Version 6) {#ipv6--internet-protocol-version-6}

-   Developed to resolve the problem of lack of IP addresses
-   128-bit format -- Trilion of IP addresses
-   IPsec (Internet Protocol Security)
-   Packet processing in routers and offers a better security


#### Dual Stack {#dual-stack}

Not all device network implementation works with IPv6. Dual stack allows IPv4
and IPv6 to live with each other and communicate with each other.

-   Communication between networks that use IPv4 and IPv6
-   Transition mechanism
-   Requires a transition mechanism
-   Direct addressing is not compatible
-   Can communicate with IPv4 and IPv6
-   Chooses between the appropriate protocol based on the destiny.


## TCP and UDP {#tcp-and-udp}

Transport protocol.


### UDP (User Datagram Protocol) {#udp--user-datagram-protocol}

-   Belongs to the `Transport` layer of the OSI model
-   Smaller packets called Datagrams
-   Unreliable data transmission between hosts in the network
    -   We may loose packets during transmission
    -   No need to ACK whether we received the packet
-   Fire and forget: no delivery guarantee


### TCP (Transmission Control Protocol) {#tcp--transmission-control-protocol}

-   Belongs to the `Transport` layer of the OSI model
-   Protocol based on connection
-   Opens, maintains, verifies and closes the connection
-   Data sent to the host are reliable and ordered.
-   Establishes a connection BEFORE any transmission of data between the hosts
-   _Three-way_ handshake
    -   SYN, SYN-ACK and ACK

{{< figure src="/imgs/udp-tcp.jpg" >}}


## SSL/TLS {#ssl-tls}


### TLS (Transport Layer Security) {#tls--transport-layer-security}

-   Successor of SSL
-   Privacy and integrity of data
-   Handshake during the session
-   Public and private keys are exchanged
-   Unique key per session
-   Encrypts the transmitted data
-   Belongs to the `Presentation` layer of the OSI model


## DNS (Domain Name Service) {#dns--domain-name-service}

-   Domain name system
-   Translates domain names into IPs
    -   Swaps friendly names to IPs
-   Telephone list of the network
-   Finds the proper IP for a particular site or service
-   Recursive


### Root Servers {#root-servers}

-   Base hierarchy of the DNS
-   13 sets of the root DNS


### TLD (Top-Level Domain) {#tld--top-level-domain}

-   Find top level domain for `.com`


### Authoritative {#authoritative}

-   Responsible for knowing all the details of a domain

{{< figure src="/imgs/root-dns.jpg" >}}


### Example {#example}

DNS calls when we type `seds.nl`:

```shell
dig +trace seds.nl
```

```text
; <<>> DiG 9.20.17 <<>> +trace seds.nl
;; global options: +cmd
.			513157	IN	NS	a.root-servers.net.
.			513157	IN	NS	b.root-servers.net.
.			513157	IN	NS	c.root-servers.net.
.			513157	IN	NS	d.root-servers.net.
.			513157	IN	NS	e.root-servers.net.
.			513157	IN	NS	f.root-servers.net.
.			513157	IN	NS	g.root-servers.net.
.			513157	IN	NS	h.root-servers.net.
.			513157	IN	NS	i.root-servers.net.
.			513157	IN	NS	j.root-servers.net.
.			513157	IN	NS	k.root-servers.net.
.			513157	IN	NS	l.root-servers.net.
.			513157	IN	NS	m.root-servers.net.
.			513157	IN	RRSIG	NS 8 0 518400 20260102050000 20251220040000 61809 . Fq0uact6cCRSrn/ej8lKyE5IjrOU/uljNMBx5tcVxhKb91S+MbroWVLy g35UAVS9lfS8xt5FwXE6r20603Kqz94A/8CSd++26L9Z2W0Sk31lSAPq 2xY5hhDJLLOMd/IG/xy617TYnf2wwN5F+qPsdwIqiajEwydmer2YdznL hu9PdR7kyAjUOwmn4RebH5GfQtJwmujsEhgynNhhjLTSy16kw9zg3XnR LLFDId8nocYZda8KDDAv0rYOXEmHHyRLCVp8sm7eWyOOLzdWRUfFsQ7A kOibT1HWwOW236W7TEGa931ACQpFfULRkTE3xJQuZulzLF+RoUJmHZRT Igj7RA==
;; Received 525 bytes from 192.168.50.1#53(192.168.50.1) in 14 ms

;; UDP setup with 2001:503:ba3e::2:30#53(2001:503:ba3e::2:30) for seds.nl failed: network unreachable.
;; no servers could be reached
;; UDP setup with 2001:503:ba3e::2:30#53(2001:503:ba3e::2:30) for seds.nl failed: network unreachable.
;; no servers could be reached
;; UDP setup with 2001:503:ba3e::2:30#53(2001:503:ba3e::2:30) for seds.nl failed: network unreachable.
;; UDP setup with 2001:500:2::c#53(2001:500:2::c) for seds.nl failed: network unreachable.
nl.			172800	IN	NS	ns1.dns.nl.
nl.			172800	IN	NS	ns3.dns.nl.
nl.			172800	IN	NS	ns4.dns.nl.
nl.			86400	IN	DS	17153 13 2 C5DFDDC91E7532562A35F3C2CD30823894BE08F20101F1ABF45C8AB9 739F3F49
nl.			86400	IN	RRSIG	DS 8 1 86400 20260102050000 20251220040000 61809 . Q/uCDGUgvNI/rBKEPpL5rJLUuE1LXpGIL+MIt9IBX6BvjemxCuHJ+w0J +a+6FRutGC14+iOd0LDrZwvHAy+xP7HPbcEAKsluJwXY1wHPk3aPk9UD pH4HEhfi7aU1nFvQtDkCaKhuHfdIxvLRXoERKAiqK2/RqmvSqtQIZAfY J9KHc09QzVJcDhFDtAxm5aD6q72eCzDM6NbplzODkHaYTiwFARkgB1XF F1blw1e9oW2TN4viAYF1Uuq0+n+awu/JBxWcMNDezKr6PSkG45OjxiB2 WyBWnuTSWNGW5+xmumyYVlo5JbkgJRPEYMr/EuxaZh12tgHr8Xw5dezQ ATv3pA==
;; Received 561 bytes from 192.58.128.30#53(j.root-servers.net) in 16 ms

;; UDP setup with 2001:678:20::24#53(2001:678:20::24) for seds.nl failed: network unreachable.
;; UDP setup with 2620:10a:80ac::200#53(2620:10a:80ac::200) for seds.nl failed: network unreachable.
seds.nl.		3600	IN	NS	dave.ns.cloudflare.com.
seds.nl.		3600	IN	NS	diva.ns.cloudflare.com.
seds.nl.		3600	IN	DS	2371 13 2 3C8B70CBFBDBE8E6605CE6205274B5955A929D84C4A8BD49088CD835 8CF5335B
seds.nl.		3600	IN	RRSIG	DS 13 2 3600 20260101220704 20251219070720 37807 nl. ubYajyZrOJccCp2GK+VAmbvf6RzSIFQXVLr37JeYOKB/DXfnWVKYgcen IrSYn/86cUDY0WPXw8L0pcKJPROcTg==
;; Received 237 bytes from 185.159.199.200#53(ns4.dns.nl) in 20 ms

;; UDP setup with 2606:4700:58::adf5:3b6d#53(2606:4700:58::adf5:3b6d) for seds.nl failed: network unreachable.
seds.nl.		120	IN	A	63.176.8.218
seds.nl.		120	IN	A	35.157.26.135
seds.nl.		120	IN	RRSIG	A 13 2 120 20251221151738 20251219131738 34505 seds.nl. Ha58AyZ9+CuXk9KyN4n50xk9e7Qcgjp3i41dd3IXdfbGzCv82QS7lnyM 3EmIp+OO5uNDsvFt6rRBXXu6T3YW8Q==
;; Received 171 bytes from 172.64.33.109#53(dave.ns.cloudflare.com) in 18 ms
```


## DHCP (Dynamic Host Configuration Protocol) {#dhcp--dynamic-host-configuration-protocol}

-   Eases IP attribution in small networks (home, bars, etc)
-   Dynamic configuration of hosts
-   Designates automatically an IP address for a particular host
-   Reduces address conflict
-   DORA -- 4 main steps
    -   Discovery
    -   Offer
    -   Request
    -   Acknowledgment

{{< figure src="/imgs/dhcp.jpg" >}}


## HTTP/1, HTTP/2 and HTTP/3 Protocols {#http-1-http-2-and-http-3-protocols}

-   Layer 7 of the OSI model
-   Built on top of TCP/IP
-   Request/Response
-   Client/Server
-   Synchronous protocols
-   Body, headers, cookies, status code, etc.
-   `HTTP/1.x`, `HTTP/2` and `HTTP/3`

{{< figure src="/imgs/http-1-2-3.jpg" >}}


### HTTP/1 {#http-1}

-   Discontinued
-   Persistent connection
    -   Eliminates the need of a new connection in every request
-   Pipeline
    -   Resolves Head-of-Line Blocking
-   Allows sending numerous request without waiting for the previous response


### HTTP/2 {#http-2}

-   Released in 2015
-   Format, prioritizes and transport data
-   Request priority
-   Multiplexing
    -   Multiple request and responses within the same TCP connection
-   Server push


### HTTP/3 (QUIC) {#http-3--quic}

-   Started by Google
-   New updates to the protocol
-   Substitutes TCP for UDP
-   Latency, security and efficiency when transfering data
-   Reduces latency and handshake
-   Improves multiplexing
-   Streaming


## Response time {#response-time}

Big difference between latency and response time.

```text
Latency             Processing time     Response latency
========================================================
###############-------------------------################
========================================================
```

The sum of latency + processing time is the **response time**.
