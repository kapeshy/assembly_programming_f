# 03.asm – Function Calls and Return Addresses

## 1. Introduction

This program demonstrates how the stack is used during function calls and returns in 64-bit x86 assembly. It shows how the `CALL` and `RET` instructions manage return addresses while a function performs an arithmetic operation.

## 2. Program Execution and Stack Operations

### Step 1: Loading the Initial Value

- The value 10 is loaded into RAX.
- RSP remains unchanged because no stack operation occurs.

### Step 2: Calling the Function

- The `CALL` instruction pushes the return address onto the stack.
- The return address is `0x40100a`, which points to `after_call`.
- RSP decreases by 8 bytes.
- Execution jumps to the `calculate` function.

### Step 3: Performing the Calculation

- The value 5 is added to RAX.
- RAX changes from 10 to 15.
- RSP remains unchanged because the instruction only modifies a register.

### Step 4: Returning from the Function

- The `RET` instruction retrieves the return address from the stack.
- Execution returns to `after_call`.
- RSP increases by 8 bytes, returning to its original value.
- RAX retains the calculated value of 15.

### Step 5: Program Termination


- RAX is assigned 60, the Linux exit system call number.
- RDI is set to zero to indicate successful termination.
- `syscall` terminates the program.

## 3. GDB Observations

GDB was used to monitor RAX, RSP, RIP, and the stack memory.

The observations confirmed that:

- Initially, RAX contained 0 and RSP was `0x7fffffffdcc0`.
- After loading 10, RAX became 10 while RSP remained unchanged.
- After `CALL`, the return address `0x40100a` was stored at the top of the stack.
- After the addition, RAX contained 15.
- After `RET`, execution returned to `0x40100a` (`after_call`).
- RSP returned to its original value of `0x7fffffffdcc0`.

## 4. Conclusion

The program successfully demonstrated how `CALL` and `RET` use the stack to manage function execution. It confirmed that a function can perform calculations using registers while the stack temporarily stores the return address. It also demonstrated that the stack pointer returns to its original position after the function returns.
