# MicroOS

> **An operating system built for optimization, minimalism, and learning.**

MicroOS is a tiny **16-bit x86 operating system** designed around one simple idea:

**Why use a kernel if you don't strictly need one?**

MicroOS runs directly in **16-bit real mode** and is designed to be as small and lightweight as possible. No modern OS stack. No kernel. No unnecessary abstraction layers.

Just the CPU, memory, BIOS, and code.

## ⚡ Features

* 🧠 **No kernel**
* 💻 **16-bit x86 real mode**
* 💾 **MBR / Legacy BIOS**
* 🐚 **Basic built-in shell**
* 🪶 **Extremely small memory footprint**
* ⚙️ **Direct register-oriented execution**
* 🚀 **Fast command execution**
* 🧩 Designed for learning and experimentation
* 🛠️ Can be emulated with `make emulate`

MicroOS is intentionally limited. That's the point.

## 📦 Requirements

To run MicroOS on real hardware, you'll need:

* A **16-bit-capable x86 CPU**
* x86 architecture
* At least **~0.1 MB of RAM** *(potentially much less)*
* **Legacy BIOS**
* An **MBR-compatible disk**
* A tool capable of writing the MicroOS binary directly to a disk

> ⚠️ **UEFI is not supported.**
> MicroOS is built around the classic BIOS + MBR boot process.

### Emulation

You can also run MicroOS without touching real hardware:

```bash
make emulate
```

This launches MicroOS in an emulator for quick testing.

## 🧠 Philosophy

Modern operating systems are built on many layers of abstraction.

MicroOS asks a simpler question:

> **Do we actually need a kernel?**

For a conventional multitasking, protected, hardware-independent operating system, a kernel is extremely useful.

But MicroOS isn't trying to be conventional.

It operates directly in **16-bit real mode**, where code can interact with the machine without needing a traditional kernel architecture.

Instead of:

```text
Applications
     ↓
Libraries
     ↓
System Calls
     ↓
Kernel
     ↓
Hardware
```

MicroOS aims for something closer to:

```text
MicroOS
   ↓
Hardware
```

Less abstraction.

Less overhead.

Less code.

## 🚫 Kernel?

**No.**

MicroOS currently has **no kernel and no plans to add one**.

Maybe someday that philosophy will change.

But for now:

> **No kernel. No problem.**

## 🎯 Why was MicroOS built?

Mostly because it's fun.

MicroOS is a learning and experimentation project focused on:

* x86 architecture
* BIOS booting
* MBR boot sectors
* 16-bit real mode
* Assembly programming
* Direct hardware interaction
* Operating-system fundamentals
* Extreme minimalism

It's not designed to replace Linux, Windows, or any modern operating system.

It's designed to answer one question:

**How small can an operating system get?**

## 🗂️ Project Status

MicroOS is an experimental project and is actively being developed.

Expect:

* bugs
* weird hardware behavior
* ancient CPU vibes
* questionable design decisions
* and probably a lot of `int 0x10` 😭

That's part of the experience.

## 📜 License

See the repository's license file for details.
