# Program 06: Stack Operations with 32-bit Values

## 1. Introduction

This program demonstrates stack operations using 32-bit registers and the PUSH and POP instructions. It illustrates the Last In, First Out (LIFO) principle, where the last value pushed onto the stack is the first one retrieved.

## 2. How the Program Works

1. **Initialize registers:** EAX is assigned `0x11223344`, while EBX is assigned `0x1234`. ESP initially points to `0xffffce10`.

2. **PUSH EAX:** The value in EAX is pushed onto the stack. ESP decreases by 4 bytes to `0xffffce0c`.

3. **PUSH EBX:** The value in EBX is pushed onto the stack. ESP decreases by another 4 bytes to `0xffffce08`.

4. **NOP:** This instruction performs no operation and does not change the stack.

5. **POP EBX:** The last value pushed, `0x1234`, is retrieved into EBX. ESP increases by 4 bytes to `0xffffce0c`.

6. **POP EAX:** The remaining value, `0x11223344`, is retrieved into EAX. ESP returns to its original value, `0xffffce10`.

7. **Program termination:** The program uses the Linux 32-bit exit system call (`int 0x80`) to terminate successfully.


## 3. Observations from GDB

- Each PUSH operation decreased ESP by 4 bytes because the program uses 32-bit registers.
- Each POP operation increased ESP by 4 bytes.
- The stack followed the LIFO principle: the last value pushed was the first value popped.
- Both registers recovered their original values.
- ESP returned to its initial position after all values were popped.

## 4. Conclusion

The program demonstrates how 32-bit values are stored and retrieved using PUSH and POP instructions. It confirms that the stack follows the LIFO principle and that each 32-bit stack operation changes ESP by 4 bytes.
