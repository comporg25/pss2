# Lab: Find the Largest Value

## Goal

Write a tiny **x86-64 Linux** assembly program that **finds the largest 64-bit integer in an array**.

The program should **exit** with the largest value as its **exit status** (Unix exit codes are 0–255, so the value will be taken modulo 256).
You can check the result with:

```bash
echo $?
```

---

## File to create

* **`largestvalue.s`** — your assembly source (use 64-bit instructions).

---

## Data (put this in your program’s `.data` section)

```asm
        .section .data
numberofnumbers:
        .quad 7
mynumbers:
        .quad 5, 20, 33, 80, 52, 10, 1
```

> With this data, the largest value is **80** → expected exit status: **80**.

---

## What you must do (high level)

1. **Load the count** from `numberofnumbers` into a register (e.g., `%rcx`).
2. **Load the *address*** of `mynumbers` into a pointer register (e.g., `%rbx`), then use **register-indirect** addressing (e.g., `(%rbx)`) to read elements.
3. Keep track of the **current maximum** in a register (e.g., `%rdi`).
4. **Advance** your pointer by **8 bytes** per element (they are quadwords).
5. **Stop** when you have processed `numberofnumbers` elements (handle the **zero-length** case safely).
6. **Exit** via the Linux syscall interface with the largest value in the **exit-status register**.

---

## Build & run (example commands)

```bash
as -o largestvalue.o largestvalue.s
ld -o largestvalue largestvalue.o
./largestvalue
echo $?
```
