section .data
    message db "Hello, Assembly!", 10
    length equ $ - message

section .text
    global _start

_start:
    mov rcx, 5                  ; Repeat 5 times

repeat:
    push rcx
    ; Print the message
    mov rax, 1              
    mov rdi, 1                  
    mov rsi, message
    mov rdx, length
    push rcx
    syscall
    pop rcx

<<<<<<< HEAD
    pop rcx
    loop repeat    


=======
    loop repeat
    
>>>>>>> 3fc2663 (Fix loop counter preservation across syscall)
    mov rax, 60          
    xor rdi, rdi
    syscall

    







q
exit









































































