# Power from Stdin (x86-64, Linux)

## Goal

Write a tiny **x86-64 Linux** assembly program that:

1. **Reads two ASCII digits** from **stdin**: the **base** and the **exponent** (no spaces; e.g., typing `23` means $2^3$).
2. Computes **base^exponent** using integer multiplication.
3. **Prints** the result as a decimal number to **stdout**.
4. **Exits** with the result in the **exit status** (mod 256, as usual for Unix exit codes).

You can check the exit code with:

```bash
echo $?
```

### Input format (keep it simple)

* Exactly **two digits** (`'0'`–`'9'`) with **no newline** required.
  Examples: `23` → $2^3=8$, `50` → $5^0=1$, `94` → $9^4=6561$.

### Build & run

```bash
as -o power.o power.s
ld -o power power.o
./power
# then type two digits and press Enter if your terminal needs it
```

### Notes

* Input must be **two digits** with no spaces: e.g., `23`, `50`, `94`.
* The **printed** result is the full integer; the **exit status** is that result modulo 256 (Unix convention).
