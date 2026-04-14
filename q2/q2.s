

.text
.globl main
main:
    
    addi sp, sp, -80
    sd ra, 72(sp)
    sd s0, 64(sp)
    sd s1, 56(sp)
    sd s2, 48(sp)
    sd s3, 40(sp)
    sd s4, 32(sp)
    sd s5, 24(sp)
    sd s6, 16(sp)

    addi s0, a0, -1      
    add s1, a1, zero            

    blez s0, main_empty

    
    slli a0, s0, 2
    call malloc
    add s2, a0, zero            

    
    slli a0, s0, 2
    call malloc
    add s3, a0, zero            

    
    slli a0, s0, 2
    call malloc
    add s4, a0, zero            

    
    addi s5, zero, 0             
loop_1:
    bge s5, s0, done_1
    
    
    addi t0, s5, 1
    slli t0, t0, 3
    add t0, s1, t0
    ld a0, 0(t0)
    call atoi
    
    slli t0, s5, 2
    add t0, s2, t0
    sw a0, 0(t0)

    
    addi t1, zero, -1
    slli t0, s5, 2
    add t0, s4, t0
    sw t1, 0(t0)

    addi s5, s5, 1
    j loop_1
done_1:

    addi s6, zero, -1            
    
    addi s5, s0, -1      
outer_loop:
    bltz s5, done_with_logic

inner_while:
    bltz s6, end_inner_while
    
    slli t0, s6, 2
    add t0, s3, t0
    lw t1, 0(t0)         
    
    
    slli t2, t1, 2
    add t2, s2, t2
    lw t2, 0(t2)

    
    slli t3, s5, 2
    add t3, s2, t3
    lw t3, 0(t3)

    
    bgt t2, t3, end_inner_while
    
    addi s6, s6, -1
    j inner_while

end_inner_while:
    bltz s6, skip_result
    
    
    slli t0, s6, 2
    add t0, s3, t0
    lw t1, 0(t0)

    slli t0, s5, 2
    add t0, s4, t0
    sw t1, 0(t0)

skip_result:
    
    addi s6, s6, 1
    slli t0, s6, 2
    add t0, s3, t0
    sw s5, 0(t0)

    addi s5, s5, -1
    j outer_loop

done_with_logic:
    
    addi s5, zero, 0
print_loop:
    bge s5, s0, print_done
    
    slli t0, s5, 2
    add t0, s4, t0
    lw a1, 0(t0)

    la a0, fmt_int
    call printf

    addi t0, s0, -1
    bge s5, t0, print_skip_space
    
    la a0, fmt_space
    call printf

print_skip_space:
    addi s5, s5, 1
    j print_loop

print_done:
    la a0, fmt_newline
    call printf

    addi a0, zero, 0
    j main_ret

main_empty:
    la a0, fmt_newline
    call printf
    addi a0, zero, 0

main_ret:
    ld ra, 72(sp)
    ld s0, 64(sp)
    ld s1, 56(sp)
    ld s2, 48(sp)
    ld s3, 40(sp)
    ld s4, 32(sp)
    ld s5, 24(sp)
    ld s6, 16(sp)
    addi sp, sp, 80
    ret

.section .rodata
fmt_int: .string "%d"
fmt_newline: .string "\n"
