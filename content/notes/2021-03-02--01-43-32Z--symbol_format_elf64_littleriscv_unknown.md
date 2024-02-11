+++
title = "Symbol format 'elf64-littleriscv' unknown"
author = ["Ben Mezger"]
date = 2021-03-01T22:43:00
slug = "symbol_format_elf64_littleriscv_unknown"
tags = ["riscv", "compilers"]
type = "notes"
draft = false
bookCollapseSection = true
+++

tags
: [RISCV]({{<relref "2020-05-31--15-37-29Z--riscv.md#" >}}) [Compiler]({{<relref "2020-05-31--16-03-15Z--compiler.md#" >}})

After an hour of compiling RISC-V's [toolchain](https://github.com/riscv/riscv-gnu-toolchain), I ran `riscv64-unknown-elf-gdb`
remotely against my Rust kernel running in Qemu. This happened.

```text
riscv64-unknown-elf-gdb \
        -q \
        -ex 'file target/riscv64gc-unknown-none-elf/debug/strail-rs' \
        -ex 'target remote localhost:3333' \
        -ex "b main"
Reading symbols from target/riscv64gc-unknown-none-elf/debug/strail-rs...
I'm sorry, Dave, I can't do that.  Symbol format `elf64-littleriscv' unknown.
Remote debugging using localhost:3333
make: *** [gdb] Abort trap: 6
```

What the hell. I immediately started to investigate what is going on, is it my
build system? Is Rust compiling my binary in a wrong format (although it seems
correct from the output)?

~~It seems that I **did not** configure RISC-V's toolchain with `=--enable-multilib`~~
~~flag. The following solved the issue:~~

{{< details "RISC-V toolchain compilation flags" >}}

```shell
./configure \
	--prefix=$HOME/workspace/opt/riscv64 \
	--with-arch=rv64imac \
	--with-abi=lp64 \
	--enable-multilib
make -j8
```

{{</details >}}

~~One more hour wasted at compiling everything again.~~

~~❗ **️Update:** This didn't work. I ended up downloading RISC-V's OSX pre-compiled~~
~~toolchain from their [website](https://static.dev.sifive.com/dev-tools/riscv64-unknown-elf-gcc-8.3.0-2020.04.0-x86%5F64-apple-darwin.tar.gz). I need to find free time to figure out what flag I~~
~~am missing.~~

❗ **️Update:** This issue got addressed in [GDB's upstream](https://github.com/bminor/binutils-gdb/commit/b413232211bf7c7754095b017f27774d70646489), but for some reason
RISC-V's toolchain did not cherry-pick that commit. Either you cherry-pick that
commit to your toolchain repository, or use GDB's upstream.

See [riscv-gnu-toolchain/issues/867](https://github.com/riscv/riscv-gnu-toolchain/issues/867) and thanks @jrtc27 for helping me out with
the issue.

Fun fact: The error message `I'm sorry, Dave, I can't do that.`, comes from a
scene of A Space Odyssey (1968). It seems to have been [committed](https://sourceware.org/git/?p=binutils-gdb.git;a=blob;f=gdb/symfile.c;h=31aa1e22fc7fc07764d41b5bf6a3638fb89f6f07;hb=bd5635a1e2b38ee8432fcdaa6456079191375277#l577) in 28 March
1991, by K. Richard Pixley.

{{< youtube 97b6FfQbibM >}}
