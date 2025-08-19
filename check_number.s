.globl main

.section .data
number:
    .quad 4

oddstring:
    .ascii "The number is odd\n"

oddstring_end:
    .equ oddstring_length, oddstring_end - oddstring

evenstring:
    .ascii "The number is even\n"

evenstring_end:
    .equ evenstring_length, evenstring_end - evenstring

.section .text
main:

    movq number, %rbx               # Move number to check into %rbx
    movq $1, %rax                   # System call number for writing
    movq $1, %rdi                   # File descriptor for stdout
    andq $1, %rbx                   # Check if last bit is set (number is odd)
    jz is_even                      # If not, prepare to print even string
    movq $oddstring, %rsi           # Pointer to odd string
    movq $oddstring_length, %rdx    # Length of string
    jmp end


is_even:

    ### Prepare even string

    movq $evenstring, %rsi
    movq $evenstring_length, %rdx


end:
    
    syscall                         # Execute write system call
    movq $60, %rax                  # System call number for exit
    xorq %rdi, %rdi                 # Exit code 0
    syscall                         # Execute exit system call
