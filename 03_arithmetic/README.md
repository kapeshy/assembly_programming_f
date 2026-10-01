# 03_arithmetic - Assembly Flags Analysis

Student number - 159442
Name - Otieno Patience Atieno

This directory contains assembly programs demonstrating basic arithmetic operations in 32-bit x86 architecture using NASM: Addition, Subtraction, Multiplication, and Division.
# CPU Flags Overview

During arithmetic operations, the x86 CPU updates several status flags in the **EFLAGS** register depending on the result.

* (Carry Flag): Set when an unsigned addition produces a carry out of the most significant bit or when subtraction requires a borrow.

* (Zero Flag): Set when the result of an operation is zero.

* (Sign Flag): Set when the most significant bit of the result is `1`, indicating a negative signed result.

* OF (Overflow Flag): Set when a signed arithmetic operation produces a result outside the range that can be represented by the operand size.

* AF (Auxiliary Carry Flag): Set when there is a carry or borrow between bit 3 and bit 4 of the result.

* (Parity Flag): Set when the lowest byte of the result contains an even number of `1` bits.

# 1. Addition Programs (`Add*.asm`)

# Add1.asm
# Operation

120 + 10 = 130

In hexadecimal:

0x78 + 0x0A = 0x82

The 8-bit result is:
10000010b
# Flags results

* CF = 0: There is no carry out of the 8-bit range. The unsigned result `130` fits within `0–255`.
* ZF = 0: The result is not zero.
* SF = 1: The most significant bit of `0x82` is `1`.
* OF = 1: The signed values `120 + 10 = 130`, but the maximum positive signed 8-bit value is `127`. Therefore, signed overflow occurs.
* AF = 1: The addition of the lower nibbles produces a carry from bit 3 to bit 4.
* PF = 1: `10000010` contains two `1` bits, which is an even number.


# Add2.asm
# Operation

32000 + 500 = 32500

The result is:

0x7EF4

# Flags results

* CF = 0: No unsigned carry occurs because `32500` fits within 16 bits.
* ZF = 0:  The result is not zero.
* SF = 0: The most significant bit of `0x7EF4` is `0`.
* OF = 0: The signed result `32500` is within the 16-bit signed range `-32768` to `32767`.
* AF = 0: No carry occurs between bit 3 and bit 4.
* PF = 0: The lowest byte `F4` contains five `1` bits, which is odd parity.

# `XOR` instruction

The program then executes:
xor ebx, ebx


This XORs `EBX` with itself:

EBX XOR EBX = 0


Therefore:

* ZF = 1: The result is zero.
* CF = 0: XOR clears the Carry Flag.
* OF = 0: XOR clears the Overflow Flag.

The `XOR` instruction is separate from the addition operation; it changes the flags after the `ADD`.

# Add3.asm
# Operation

The program performs:
0xFFFF + 1

The mathematical result is:

65535 + 1 = 65536
However, `AX` is only 16 bits, so the result wraps around:

AX = 0x0000

# Flags results

* CF = 1: A carry is produced beyond the 16-bit range.
* ZF = 1: The 16-bit result is zero.
* SF = 0: The most significant bit of `0x0000` is `0`.
* OF = 0: There is no signed overflow because `0xFFFF` represents `-1` when interpreted as signed, and `-1 + 1 = 0`.
* AF = 1: A carry occurs from the lower nibble.
* PF = 1: The lowest byte is `00`, containing zero `1` bits, which is even parity.

# `ADC` instruction

The program then executes:

adc ax, 0
 It adds the source operand together with the current Carry Flag:

AX = AX + 0 + CF
AX = 0 + 0 + 1
AX = 1
Therefore:

* CF = 0: No new carry is produced.
* ZF = 0: The result is `1`, not zero.
* SF = 0: The most significant bit is `0`.
* OF = 0: No signed overflow occurs.
* AF = 0 
* PF = 0: The value `1` contains one `1` bit, giving odd parity.



# 2. Subtraction Programs (`Sub*.asm`)
# Sub1.asm

# Operation
50 - 80 = -30

The 8-bit representation of `-30` is:

0xE2

Binary:
11100010b

# Flags results

* CF = 1: A borrow is required because `50 < 80` in unsigned arithmetic.
* ZF = 0: The result is not zero.
* SF = 1: The most significant bit of `0xE2` is `1`.
* OF = 0: The signed result `-30` is within the 8-bit signed range.
* AF = 0: No borrow occurs between bit 3 and bit 4.
* PF = 1:`11100010` contains four `1` bits, giving even parity.

# Sub2.asm
# Operation

1000 - 2000 = -1000

The 16-bit representation is:
0xFC18

# Flags results

* CF = 1: A borrow occurs because `1000 < 2000` in unsigned arithmetic.
* ZF = 0: The result is not zero.
* SF = 1: The most significant bit of `0xFC18` is `1`.
* OF = 0: `-1000` is within the signed 16-bit range.
* AF = 0: No borrow occurs between bit 3 and bit 4.
* PF = 1: The lowest byte `18` contains two `1` bits, giving even parity.

# Sub3.asm
# Operation

The program first performs:
0 - 1 = -1

The 16-bit result is:
0xFFFF

### Flags results

* CF = 1: A borrow occurs because `0 < 1`.
* ZF = 0: The result is not zero.
* SF = 1: The most significant bit of `0xFFFF` is `1`.
* OF = 0: The signed result `-1` is within the 16-bit signed range.
* AF = 1: A borrow occurs from bit 4.
* PF = 1: The lowest byte `FF` contains eight `1` bits, giving even parity.

# `SBB` instruction

The program then executes:
sbb ax, 0

`SBB` means **Subtract with Borrow**. It subtracts the source operand and the current Carry Flag:

AX = AX - 0 - CF
AX = 0xFFFF - 0 - 1
AX = 0xFFFE

This demonstrates how the Carry Flag can be used as a borrow when performing multi-word subtraction.

# 3. Multiplication Programs (`Mul*.asm`)

# Mul1.asm
# Operation
25 × 10 = 250

The result is:

0x00FA

For an 8-bit multiplication:

AL × operand → AX

Therefore:
AX = 00FA
AH = 00
AL = FA

# Flags results

* CF = 0: The upper half (`AH`) is zero.
* OF = 0: The upper half (`AH`) is zero.

# Mul2.asm
# Operation

3000 × 200 = 600000

The result is:
0x000927C0

For 16-bit multiplication:
AX × operand → DX:AX

Therefore:
DX = 0x0009
AX = 0x27C0
### Flags results

* CF = 1: The upper half of the result (`DX`) is non-zero.
* OF = 1: The result does not fit entirely in `AX`.

# Mul3.asm
# Operation

100000 × 300000 = 300000000

The result requires more than 32 bits, so it is stored across:

EDX:EAX

The result is:
EDX:EAX = 0x00000006FC23AC00
Therefore:

EDX = 0x00000006
EAX = 0xFC23AC00

# Flags results

* CF = 1: The upper 32 bits (`EDX`) are non-zero.
* OF = 1: The result does not fit entirely within `EAX`.


# 4. Division Programs (`Div*.asm`)

# Div1.asm
# Operation
100 ÷ 7 = 14 remainder 2

The instruction:
div bl
uses `AX` as the dividend.

The results are:
AL = 14    ; Quotient
AH = 2     ; Remainder

# Flags results
Undefined

The flags cannot be reliably predicted from the division result.

# Div2.asm
# Operation
50000 ÷ 300 = 166 remainder 200

The dividend is stored in:
DX:AX

The results are:
AX = 166    ; Quotient
DX = 200    ; Remainder

# Flags results
Undefined

`DIV` does not define the arithmetic status flags.

# Div3.asm
# Operation

300000000 ÷ 1000 = 300000 remainder 0
The dividend is stored in:

EDX:EAX

The results are:
EAX = 300000    ; Quotient
EDX = 0         ; Remainder

# Flags results
Undefined

The arithmetic flags should not be relied upon after `DIV`.

# 6. Importance of Flags

The CPU flags allow programs to make decisions based on arithmetic results.

* CF is useful for detecting unsigned carry or borrow.
* ZF can be used to determine whether a result is zero.
* SF indicates the sign of a result.
* OF detects signed arithmetic overflow.
* AF is mainly used for certain arithmetic operations involving the lower four bits.
* PF indicates the parity of the lowest byte.
* ADC uses the Carry Flag to include a previous carry in an addition.
* SBB uses the Carry Flag to include a previous borrow in a subtraction.

