.text

.globl make_node
make_node:
    addi sp, sp, -16
    sd ra, 8(sp)
    sw a0, 0(sp)     

    addi a0, zero, 24        
    call malloc      
    
    lw t0, 0(sp)     
    sw t0, 0(a0)     
    sd zero, 8(a0)   
    sd zero, 16(a0)  

    ld ra, 8(sp)
    addi sp, sp, 16
    ret


.globl insert
insert:
    bne a0, zero, insert_step_2
    
    add a0, a1, zero
    j make_node

insert_step_2:
    addi sp, sp, -32
    sd ra, 24(sp)
    sd s0, 16(sp)      
    sd s1, 8(sp)       

    add s0, a0, zero          
    add s1, a1, zero          

    lw t0, 0(s0)       
    beq s1, t0, end_insert  
    blt s1, t0, insert_left

insert_right:
    ld a0, 16(s0)
    add a1, s1, zero
    call insert
    sd a0, 16(s0)
    j end_insert

insert_left:
    
    ld a0, 8(s0)
    add a1, s1, zero
    call insert
    sd a0, 8(s0)

end_insert:
    add a0, s0, zero          
    ld ra, 24(sp)
    ld s0, 16(sp)
    ld s1, 8(sp)
    addi sp, sp, 32
    ret


.globl get
get:
    
    beq a0, zero, get_done
    
    lw t0, 0(a0)
    beq a1, t0, get_done    

    blt a1, t0, get_left
    
    
    ld a0, 16(a0)
    j get
    
get_left:
    
    ld a0, 8(a0)
    j get

get_done:
    ret


.globl getAtMost
getAtMost:
    
    addi a2, zero, -1          

loop_start:
    beq a1, zero, end_of_func
    lw t0, 0(a1)       
    
    beq t0, a0, found_the_value 
    bgt t0, a0, gam_left  
    
    add a2, t0, zero          
    ld a1, 16(a1)      
    j loop_start

gam_left:
    ld a1, 8(a1)       
    j loop_start

found_the_value:
    add a0, t0, zero          
    ret

end_of_func:
    add a0, a2, zero          
    ret
