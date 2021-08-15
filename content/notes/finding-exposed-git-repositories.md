+++
title = "Finding exposed .git repositories"
author = ["Ben Mezger"]
date = 2017-10-30T21:59:00-02:00
publishDate = 2017-10-30
aliases = ["/posts/finding-exposed-git-repositories/"]
tags = ["git", "security"]
categories = ["web"]
draft = false
+++

Developers use `git` to version control their source code. We all do, in fact,
this blog is currently versioned by `git`. However, we not only use `git`
to version control, but also to deploy applications. Usually we push new code to
a remote server, where the server takes care of testing the code and then
deploying the application. There are different ways of deploying an application,
but this is one of them.

Some developers/sys-admins simply clone the respository to their server, then
simply point their web-server to that directory. Most of the VCS keep a hidden
directory at the root of the project. `git` keeps a `.git` directory at the root
of the repository, where all the information of that project is stored, such as
logs, versions, tags, configs, previous revisions and so on.

Not only some developers/sys-admins clone the repository in their server, but
they also point their web-server to that directory. _Not only that_, they also
sometimes change the source to set some configurations files with sensitive
information (email/password, and so on).

If the web-server is pointing to the git repository and has directory listing
enabled, we could download the `.git` using `wget=/=curl` recursively, then
simply checkout a master and voilà.

For example, say <https://seds.nl/.git> exists, containing all the objects of this
blog, we could simply run `wget --mirror -I .git https://seds.nl/.git` to
download the repository.


## How to find exposed git repositories {#how-to-find-exposed-git-repositories}

We can simply try out every URL we know by adding `/.git` at the end of the TLD.

Just kidding.

An easy way of finding websites which currently expose `.git` is using Google
D0rks. If you are not familiar with Google D0rks, it&rsquo;s basically a few operators
Google offers you to filter out a few queries. [Here](http://www.googleguide.com/advanced%5Foperators%5Freference.html) is a list of some of them.
The one we need is the `intext:` operator.

```text
intext:"Index of /.git"
```

This query makes use of the `intext` operator. It allows us to ask Google to
find all the pages that have a specific word in the body somewhere forcing
inclusion on the page ([source](https://edu.google.com/coursebuilder/courses/pswg/1.2/assets/notes/Lesson3.5/Lesson3.5IntextandAdvancedSearch%5FText%5F.html)).

Let&rsquo;s see.

{{< figure src="/imgs/google-intext-query_censored.jpg" >}}

Holy sh1t. That&rsquo;s ~89,900 results from Google. Can you imagine how much
sensitive information there must be?


## How to fix this {#how-to-fix-this}

Well, first of all, find a better way to getting your source code to a remote
server and simply pointing your web-server to that directory. If you don&rsquo;t feel
like finding a better way, or just want to keep things simple, here is what you
need to do.


### Nginx {#nginx}

Add the following telling Nginx to deny any request to a `.git` directory:

```text
  location ~ /.git/ {
      deny all;
  }
```


### Apache {#apache}

Add the following telling Apache to deny any request to a `.git` directory:

```text
  <DirectoryMatch "^/.*/\.git/">
      Order deny,allow
      Deny from all
  </Directory>
```

The only question that remains is: Is there anyway you could extract a `.git`
from a web-server that has directory listing disabled? I haven&rsquo;t looked much
into it, but I wonder if there is anyway we could use `git` against itself.
