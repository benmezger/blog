+++
title = "Lay developer"
author = ["Ben Mezger"]
date = 2020-04-23T00:00:00-03:00
publishDate = 2021-06-16T00:00:00-03:00
tags = ["software"]
draft = true
+++

Developer-oriented software aims to make developer life more effortless and
support other programs and applications. Curl, Git, Bash, terminal emulators,
GNU Coreutils, and compilers are examples of tools developers write to
developers. Computers have been reasonably accessible, and programming languages
encapsulate most of the computing overhead from a programmer. Today, a developer
can work most of his life without knowing much about memory allocation, how the
operating system handles processes, I/O, or how the HTTP protocol functions.

Recently, I&rsquo;ve been thinking and comparing computer software and how they play a
significant role in many developers not comprehending computing fundamentals. In
this respect, I will talk about alternatives to popular software and how they
may play the role of making lay developers.

Two developers may work on an API in a web development team without too much
detail, while two developers work on the front end. The back-end team is
responsible for architecting the API, writing tests, and manually testing the
requests to ensure everything works well. Instead of manually trying the
requests using Curl, one developer may open up Postman, configure the
environment variables from a workspace, and test the client to server
communication – this is where I believe the problem starts.

Graphical interfaces allow us to visualize software differently from a CLI-based
tool – you click here and there, you have no idea what is going on, and things
work. Visual tools such as Postman generally hide too many details that are
important for engineers to know. One may never try to use Curl because Postman
exists, moving the new lay developer further away from the command line. A
senior developer may not know how to send HTTP POST data through Curl but surely
knows how to do it with Postman. Postman is handy to share the endpoints with
your team but not be dependent on it.

Git clients, such as the one provided by VSCode or Sourcetree, are all examples
of software that encourages lay engineers. I have nothing against using a
client, but knowing more than the basics of Git through Git&rsquo;s official client
will make a developer a lot better and more susceptible to different
environments. Learning how to use the command line will improve developer
skills.

However, all developers are lay developers, and so am I.
