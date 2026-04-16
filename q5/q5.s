.text
.globl main
main:
    
    addi sp, sp, -32
    sd ra, 24(sp)
    sd s0, 16(sp)
    sd s1, 8(sp)
    sd s2, 0(sp)
    addi sp, sp, -32

    
    la a0, filename
    addi a1, zero, 0         
    call open
    add s0, a0, zero        

    
    add a0, s0, zero
    addi a1, zero, 0
    addi a2, zero, 2         
    call lseek
    add s2, a0, zero        
    addi s2, s2, -1  

    addi s1, zero, 0         

loop:
    
    bge s1, s2, success

fetch_l:
    
    add a0, s0, zero
    add a1, s1, zero
    addi a2, zero, 0         
    call lseek
    
    
    add a0, s0, zero
    addi a1, sp, 31 
    addi a2, zero, 1
    call read
    lbu a4, 31(sp)   

    
    addi t2, zero, 97        
    addi t3, zero, 122       
    blt a4, t2, skip_l
    bgt a4, t3, skip_l
    j fetch_r

skip_l:
    addi s1, s1, 1
    j loop

fetch_r:
    
    add a0, s0, zero
    add a1, s2, zero
    addi a2, zero, 0         
    call lseek
    
    
    add a0, s0, zero
    addi a1, sp, 31 
    addi a2, zero, 1
    call read
    lbu a5, 31(sp)   

    
    addi t2, zero, 97        
    addi t3, zero, 122       
    blt a5, t2, skip_r
    bgt a5, t3, skip_r

    
    bne a4, a5, fail

    
    addi s1, s1, 1
    addi s2, s2, -1
    j loop

skip_r:
    addi s2, s2, -1
    j loop

success:
    la a0, str_yes
    call printf
    j exit

fail:
    la a0, str_no
    call printf

exit:
    
    add a0, s0, zero
    call close
    
    addi sp, sp, 32
    ld ra, 24(sp)
    ld s0, 16(sp)
    ld s1, 8(sp)
    ld s2, 0(sp)
    addi sp, sp, 32
    addi a0, zero, 0
    ret

.section .rodata
filename: .string "input.txt"
str_yes: .string "Yes\n"
str_no: .string "No\n"
