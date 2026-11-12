# 01.asm – Basic Stack Operations

## 1. Introduction

This program demonstrates basic stack operations using the `PUSH` and `POP` instructions in 64-bit x86 assembly. It illustrates the Last In, First Out (LIFO) principle, where the last value pushed onto the stack is the first value removed.

## 2. Program Execution and Stack Operations

### Step 1: Program Initialization

The program begins at `_start`.

- `RAX` is assigned the value 100.
- `RBX` is assigned the value 200.
- The stack pointer (`RSP`) remains unchanged because no stack operation has occurred.

### Step 2: Pushing Values onto the Stack


- `push rax` places 100 onto the stack. RSP decreases by 8 bytes.
- `push rbx` places 200 onto the stack. RSP decreases by another 8 bytes.
- The value 200 is now at the top of the stack, above 100.

The stack grows towards lower memory addresses.

### Step 3: Retrieving Values from the Stack


- `pop rcx` removes 200 from the top of the stack and stores it in RCX. RSP increases by 8 bytes.
- `pop rdx` removes 100 and stores it in RDX. RSP increases by another 8 bytes.

This demonstrates LIFO because 200 was pushed last but retrieved first.

### Step 4: Program Termination

- RAX is assigned 60, the Linux exit system call number.
- RDI is set to zero to indicate successful termination.
- `syscall` terminates the program.

## 3. GDB Observations

GDB was used to inspect the registers and stack memory during execution.

After loading the values:

- RAX contained 100 (`0x64`).
- RBX contained 200 (`0xc8`).
- RSP remained at its initial address.

After the two PUSH operations, memory inspection showed:

- `0x7fffffffdcb0` contained `0xc8` (200).
- `0x7fffffffdcb8` contained `0x64` (100).

After `pop rcx`:

- RCX contained 200.
- RSP pointed to the remaining value, 100.

After `pop rdx`:

- RDX contained 100.
- RSP returned to its original address.

The final register inspection confirmed RCX = 200 and RDX = 100.

## 4. Conclusion

The program successfully demonstrated how values are stored and retrieved using the stack. It confirmed the LIFO principle, showed how PUSH and POP affect RSP(each PUSH decreases RSP by 8 bytes, while each POP increases it by 8 bytes because the program operates in 64-bit mode ), and demonstrated that the stack pointer returns to its original position when all pushed values are popped.