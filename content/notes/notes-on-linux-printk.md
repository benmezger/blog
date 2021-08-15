+++
title = "Notes on Linux's printk"
author = ["Ben Mezger"]
date = 2017-03-09T22:26:00-03:00
publishDate = 2017-03-09
aliases = ["/posts/notes-on-linux-printk/"]
draft = false
+++

Some of the content might be incorrect, since I am still trying to understand it
thoroughly.

So I started studying the Linux Kernel more in depth, so I decided it would be
nice for me to document my findings, so I can read it from time to time. I will
be daily updating this post, as I am studying it everyday.

Keep in mind that I am using the `x86` architecture.


## `printk(const char * fmt, ...)` {#printk--const-char-fmt-dot-dot-dot}

The `printk` is meant to print a kernel message, which you can later read using
the `dmesg` command. It provides a `printf`-like abstraction. It can be used as
a debugging tool for logging messages from the kernel.

In kernel mode, you cannot use `printf`.

The `* fmt` argument is a format string, whereas the `+...+` are variable
arguments.

The [`include/linux/kern_levels.h`](https://github.com/torvalds/linux/blob/master/include/linux/kern%5Flevels.h) defines 8 different log levels which specifies
the severity of the error message. Those are:

```C
#define KERN_EMERG      KERN_SOH "0"    /* system is unusable */
#define KERN_ALERT      KERN_SOH "1"    /* action must be taken immediately */
#define KERN_CRIT       KERN_SOH "2"    /* critical conditions */
#define KERN_ERR        KERN_SOH "3"    /* error conditions */
#define KERN_WARNING    KERN_SOH "4"    /* warning conditions */
#define KERN_NOTICE     KERN_SOH "5"    /* normal but significant condition */
#define KERN_INFO       KERN_SOH "6"    /* informational */
#define KERN_DEBUG      KERN_SOH "7"    /* debug-level messages */
```

Comments are pretty clear what each one means. With all that, we can easily call
`printk` like this: `printk(KERN_ERR "Something happend`). By default,
`KERN_WARNING` is used when nothing is specified, though this can be changed by
setting `CONFIG_DEFAULT_MESSAGE_LOGLEVEL` kernel option (`+make menuconfig ->
Kernel Hacking -> Default message log level+`).

For convenience, Linux also provides [shorthand definition](https://github.com/torvalds/linux/blob/master/include/linux/printk.h#L294) to those calls:

```C
  /*
   * These can be used to print at the various log levels.
   * All of these will print unconditionally, although note that pr_debug()
   * and other debug macros are compiled out unless either DEBUG is defined
   * or CONFIG_DYNAMIC_DEBUG is set.
   */
  #define pr_emerg(fmt, ...) \
          printk(KERN_EMERG pr_fmt(fmt), ##__VA_ARGS__)
  #define pr_alert(fmt, ...) \
          printk(KERN_ALERT pr_fmt(fmt), ##__VA_ARGS__)
  #define pr_crit(fmt, ...) \
          printk(KERN_CRIT pr_fmt(fmt), ##__VA_ARGS__)
  #define pr_err(fmt, ...) \
          printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
  #define pr_warning(fmt, ...) \
          printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
  #define pr_warn pr_warning
  #define pr_notice(fmt, ...) \
          printk(KERN_NOTICE pr_fmt(fmt), ##__VA_ARGS__)
  #define pr_info(fmt, ...) \
  printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
```

Meaning instead of calling `printk(KERN_EMERG "System is corrupted!")` we could
call `pr_emerg("System is corrupted")` which is basically the same thing. Unless
you compile your kernel in `DEBUG` mode, you can also use `pr_debug` and
`KERN_DEBUG`.

Log level allows the kernel to determine the importance of a message, with that,
it can decide whether it should present the message immediately to the user
(printing in the console, etc).

The [`#define console_loglevel (console_printk[0])`](https://github.com/torvalds/linux/blob/master/include/linux/printk.h#L64) is used to compare the log
level of the message against this defined variable. If the priority is `>` than
this value, the message will then be printed to the current console. Note that
`console_loglevel`&rsquo;s value comes from `console_printk[0]` which is defined as
an array (`extern int console_printk[]`). [`kernel/printk/printk.c`](https://github.com/torvalds/linux/blob/master/kernel/printk/printk.c#L62) defines each
index value:

```C
  int console_printk[4] = {
          CONSOLE_LOGLEVEL_DEFAULT,       /* console_loglevel */
          MESSAGE_LOGLEVEL_DEFAULT,       /* default_message_loglevel */
          CONSOLE_LOGLEVEL_MIN,           /* minimum_console_loglevel */
          CONSOLE_LOGLEVEL_DEFAULT,       /* default_console_loglevel */
  };
```

Your current `console_loglevel` can be found by printing
`/proc/sys/kernel/printk`:

```text
$ cat /proc/sys/kernel/printk
4       4       1       4
```

From left to right, the meaning of those values are as follow: `current`,
`default`, `minimum`, `boot-time-default`. For example, if you would like to get
all messages printed to your current console, you can simply change these values
to `8`:

```text
$ echo 8 > /proc/sys/kernel/printk
```

Or by setting the log level through `dmesg` using the `-n` argument:

```text
$ dmesg -n 8
```


## References {#references}

1.  [Linux Inside - A book-in-progress about the Linux Kernel and its insides](https://www.gitbook.com/book/0xax/linux-insides/details)
