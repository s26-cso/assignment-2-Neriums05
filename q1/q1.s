.text

.globl make_node
make_node:
    # a0: int val
    addi sp, sp, -16
    sd ra, 8(sp)
    sw a0, 0(sp)     # save the value temporarily

    addi a0, zero, 24        # 24 bytes for struct Node
    call malloc      
    
    lw t0, 0(sp)     
    sw t0, 0(a0)     # node->val = val
    sd zero, 8(a0)   # node->left = NULL
    sd zero, 16(a0)  # node->right = NULL

    ld ra, 8(sp)
    addi sp, sp, 16
    ret


.globl insert
insert:
    # a0 = root, a1 = val
    # simple recursive insertion
    bne a0, zero, insert_step_2
    
    # if root == NULL, return a new node
    add a0, a1, zero
    j make_node

insert_step_2:
    addi sp, sp, -32
    sd ra, 24(sp)
    sd s0, 16(sp)      # s0 will hold root
    sd s1, 8(sp)       # s1 will hold val

    add s0, a0, zero          
    add s1, a1, zero          

    lw t0, 0(s0)       # root->val
    beq s1, t0, end_insert  # ignore duplicate
    blt s1, t0, insert_left

insert_right:
    # root->right = insert(root->right, val)
    ld a0, 16(s0)
    add a1, s1, zero
    call insert
    sd a0, 16(s0)
    j end_insert

insert_left:
    # root->left = insert(root->left, val)
    ld a0, 8(s0)
    add a1, s1, zero
    call insert
    sd a0, 8(s0)

end_insert:
    add a0, s0, zero          # return root
    ld ra, 24(sp)
    ld s0, 16(sp)
    ld s1, 8(sp)
    addi sp, sp, 32
    ret


.globl get
get:
    # a0 = root, a1 = val
    beq a0, zero, get_done
    
    lw t0, 0(a0)
    beq a1, t0, get_done    # return current node if found

    blt a1, t0, get_left
    
    # go right
    ld a0, 16(a0)
    j get
    
get_left:
    # go left
    ld a0, 8(a0)
    j get

get_done:
    ret


.globl getAtMost
getAtMost:
    # a0 = val, a1 = root
    addi a2, zero, -1          # keep track of the largest valid element

loop_start:
    beq a1, zero, end_of_func
    lw t0, 0(a1)       # root->val
    
    beq t0, a0, found_the_value 
    bgt t0, a0, gam_left  
    
    add a2, t0, zero          # save the best element we've seen so far!
    ld a1, 16(a1)      # keep searching right for potentially larger valid ones
    j loop_start

gam_left:
    ld a1, 8(a1)       # go left
    j loop_start

found_the_value:
    add a0, t0, zero          # return exact match
    ret

end_of_func:
    add a0, a2, zero          # return the largest valid one recorded
    ret
