# 04.asm – 32-bit Function Calls and Stack Frames

## 1. Introduction

This program demonstrates how the stack is used during function calls in 32-bit x86 assembly. It illustrates how `CALL`, `PUSH`, `POP`, and `RET` manage return addresses, saved base pointers, and local variables.

Unlike the previous 64-bit programs, this program uses 32-bit registers such as ESP, EBP, EAX, EBX, and EIP. Each push or pop operation changes ESP by 4 bytes.

## 2. Program Execution and Stack Operations

### Step 1: Calling the Function


- Execution begins at `_start`.
- `CALL` pushes the return address onto the stack.
- The return address is `0x08049005`, pointing to the instruction immediately after the call.
- ESP decreases by 4 bytes.
- Execution jumps to the `work` function.

### Step 2: Saving the Previous Base Pointer

- `push ebp` saves the previous EBP value (0) onto the stack.
- ESP decreases by another 4 bytes.
- `mov ebp, esp` establishes a new stack frame.
- EBP becomes the reference point for accessing local variables.

### Step 3: Allocating Space for Local Variables

- ESP decreases by 8 bytes.
- This reserves 8 bytes of stack memory for two 4-byte local variables.

### Step 4: Storing Local Variables

- The value 100 is stored at `EBP-4`.
- The value 200 is stored at `EBP-8`.
- GDB confirmed that `0xffffce04` contained `0x00000064` (100).
- GDB confirmed that `0xffffce00` contained `0x000000c8` (200).
- ESP and EBP remain unchanged because these instructions write directly to memory.

### Step 5: Retrieving Local Variables

- The value 100 is loaded into EAX.
- The value 200 is loaded into EBX.
- GDB confirmed EAX = 100 and EBX = 200.
- ESP and EBP remain unchanged.

### Step 6: Releasing Local Variable Space

- ESP is restored to the address held by EBP.
- The 8 bytes reserved for local variables are released.
- ESP and EBP now have the same address.

### Step 7: Restoring the Previous Base Pointer

- The saved previous EBP value is retrieved from the stack.
- EBP is restored to 0.
- ESP increases by 4 bytes.
- The return address becomes the top item on the stack.

### Step 8: Returning from the Function

- `RET` retrieves the return address from the stack.
- Execution returns to `_start`, immediately after the `CALL` instruction.
- ESP increases by another 4 bytes and returns to its original position.

### Step 9: Program Termination

- EAX is assigned 1, the Linux 32-bit exit system call number.
- EBX is set to zero to indicate successful termination.
- `int 0x80` invokes the Linux system call to terminate the program.


## 3. GDB Observations

GDB was used to inspect the registers and stack memory during execution.

The observations confirmed that:

- The executable was successfully rebuilt as a 32-bit ELF executable.
- `CALL` stored the return address `0x08049005` on the stack.
- `PUSH EBP` saved the previous base pointer.
- EBP became the reference point for the function's stack frame.
- The value 100 was stored at `0xffffce04`.
- The value 200 was stored at `0xffffce00`.
- EAX contained 100, while EBX contained 200 after retrieving the local variables.
- `MOV ESP, EBP` released the local variable space.
- `POP EBP` restored the previous base pointer.
- `RET` returned execution to `_start`.

## 4. Conclusion

The program successfully demonstrated stack management during function calls in 32-bit assembly. It showed how return addresses and saved registers are stored, how local variables are allocated and accessed, and how the stack is restored when a function returns. It also demonstrated that 32-bit push and pop operations change ESP by 4 bytes.
