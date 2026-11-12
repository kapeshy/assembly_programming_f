# Program 05: Stack Operations with 64-bit Values

## 1. Introduction

This program demonstrates how the stack stores and retrieves 64-bit values using the `PUSH` and `POP` instructions. It also demonstrates the Last In, First Out (LIFO) principle.

## 2. How the Program Works

1. **Initialize registers:** RAX is assigned `0x1122334455667788`, while RBX is assigned `0x1234`. RSP initially points to `0x7fffffffdcc0`.

2. **PUSH RAX:** The value in RAX is pushed onto the stack. RSP decreases by 8 bytes to `0x7fffffffdcb8`.

3. **PUSH RBX:** The value in RBX is pushed onto the stack. RSP decreases by another 8 bytes to `0x7fffffffdcb0`.

4. **NOP:** This instruction performs no operation and does not change the stack.

5. **POP RBX:** The last value pushed, `0x1234`, is retrieved into RBX. RSP increases by 8 bytes to `0x7fffffffdcb8`.

6. **POP RAX:** The remaining value, `0x1122334455667788`, is retrieved into RAX. RSP returns to its original value, `0x7fffffffdcc0`.

7. **Program termination:** The program uses the Linux exit system call to terminate successfully.

## 3. Observations from GDB

- Each PUSH operation decreased RSP by 8 bytes because the program uses 64-bit registers.
- Each POP operation increased RSP by 8 bytes.
- The stack followed the LIFO principle: the last value pushed was the first value popped.
- Both registers recovered their original values.
- RSP returned to its initial position after all values were popped.

## 4. Conclusion

The program demonstrates how 64-bit values are stored and retrieved using PUSH and POP instructions. It confirms that the stack follows the LIFO principle and that each 64-bit stack operation changes RSP by 8 bytes.
