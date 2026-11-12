# 02.asm – Function Calls and Stack Frames

## 1. Introduction

This program demonstrates how the stack is used during function calls in 64-bit x86 assembly. It illustrates how `CALL`, `PUSH`, `POP`, and `RET` manage return addresses, saved registers, and local variables.

## 2. Program Execution and Stack Operations

### Step 1: Calling the Function

- Execution begins at `_start`.
- `CALL` pushes the return address onto the stack.
- The return address is `0x401005`, which points to the instruction immediately after the call.
- RSP decreases by 8 bytes.
- Execution jumps to the `work` function.

### Step 2: Saving the Previous Base Pointer

- `push rbp` saves the previous RBP value (0) onto the stack.
- RSP decreases by another 8 bytes.
- `mov rbp, rsp` establishes a new stack frame.
- RBP now provides a stable reference point for accessing local variables.

### Step 3: Allocating Space for Local Variables


- RSP decreases by 16 bytes.
- This reserves 16 bytes of stack memory for two 8-byte local variables.

### Step 4: Storing Local Variables

- The value 100 is stored at the memory address `RBP - 8`.
- The value 200 is stored at `RBP - 16`.
- These instructions write directly to stack memory.
- RSP and RBP remain unchanged.

### Step 5: Retrieving Local Variables


- The value 100 is loaded into RAX.
- The value 200 is loaded into RBX.
- GDB confirmed RAX = 100 (`0x64`) and RBX = 200 (`0xc8`).
- The stack pointer remains unchanged.

### Step 6: Releasing Local Variable Space

- RSP is restored to the address held by RBP.
- This releases the 16 bytes reserved for local variables.
- RSP and RBP now have the same address.

### Step 7: Restoring the Previous Base Pointer

- The saved previous RBP value is retrieved from the stack.
- RBP is restored to 0.
- RSP increases by 8 bytes.
- The return address becomes the top item on the stack.

### Step 8: Returning from the Function
- `RET` retrieves the return address from the stack.
- Execution returns to `_start`, immediately after the `CALL` instruction.
- RSP increases by another 8 bytes and returns to its original value.

### Step 9: Program Termination

- RAX is assigned 60, the Linux exit system call number.
- RDI is set to zero to indicate successful termination.
- `syscall` terminates the program.

## 3. GDB Observations

GDB was used to inspect the stack pointer, base pointer, registers, and stack memory.

The observations confirmed that:

- `CALL` stored the return address `0x401005` on the stack.
- `PUSH RBP` saved the previous base pointer.
- RBP became the reference point for the function's stack frame.
- RAX contained 100, while RBX contained 200 after loading the local variables.
- `mov rsp, rbp` released the local variable space.
- `POP RBP` restored the previous base pointer.
- `RET` returned execution to `_start`.

The final GDB inspection showed:

- RSP = `0x7fffffffdcc0`
- RIP = `0x401005` (`_start+5`)

This confirmed that the function returned successfully and restored the original stack position.

## 4. Conclusion

The program demonstrated how function calls use the stack to store return addresses, preserve registers, and allocate local variables. It also showed how RSP and RBP manage a function's stack frame and how `RET` restores execution to the calling location.
