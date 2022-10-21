# Assignment Number: 4 (MIPS Assignment-3)
# Problem Number: 2
# Semester: Autumn 2022
# Group_name = "Group 55"
# Group_members = ["Kulkarni Pranav Suryakant(20CS30029)", "Vineet Amol Pippal(20CS30058)"]

# This program takes a 10-element array from user, sorts it and prints it.

############ global variables #############
# globl will make main symbol accessible from outside the current file
.globl main 
############ global variables #############

############ data declarations #############
# declares variable names used in program; storage allocated in main memory (RAM)
.data
    .align 2

    arr: .word 10

    msg1: .asciiz "Enter ten integer elements of the array:-\n"

    sort_msg: .asciiz "Sorted array: "
    
    newline: .asciiz "\n"

    space: .asciiz " "
############ data declarations #############

############ program instructions #############
# text section contains program instructions
.text

back:
    jr $ra

# function to read array elements from user
# input: arr - array to store elements ($a0), size - size of array ($a1)
read_array:
    move $t0, $a0                           # $t0 = arr
    move $t1, $a1                           # $t1 = size

    read_array_rec:
        li $v0, 5                           # read element from user
        syscall

        sw $v0, 0($t0)                      # store element in array
        addi $t0, $t0, 4                    # increment array pointer
        addi $t1, $t1, -1                   # decrement size

        beqz $t1, read_array_end            # check if $t1 is zero
        j read_array_rec                    # check if size is not zero
    
    read_array_end:
        jr $ra                              # return from function

# function to print the sorted array
# arguments passed: $a0 = address of first element in array, $a1 = number of elements in array
print_array:                         
    move $t0, $a0                           # $t0 stores the address of the array
    move $t1, $a1                           # $t1 stores the value of k initially

    li $v0, 4
    la $a0, newline                         
    syscall

    la $a0, sort_msg                        # print sort_msg
    li $v0, 4
    syscall

    for_print:                              # to print the sorted array
        blez $t1, end_print                 # if $t1 is 0, then end the loop
        lw $a0, ($t0)                       # $a0 stores the value of the array element
        li $v0, 1
        syscall

        la $a0, space                       # print space
        li $v0, 4
        syscall

        addiu $t0, $t0, 4                   # to move to the next array element
        addiu $t1, $t1, -1                  # decrement $t1
        j for_print                         # loop back to for_print

    end_print:                              
        li $v0, 4
        la $a0, newline
        syscall

        li $v0, 4                           
        la $a0, newline                     # sorted array printed, newline printed    
        syscall

        jr $ra                              # return to main

# SWAP: swaps two elements of the array; a[i] and a[j]
# arguments passed: address of values that are to be swapped : $a0 = &a[i], $a1 = &a[j]
SWAP:
    addi $sp, $sp, -8                       # decrement stack pointer by 8
    sw $s0, 0($sp)                          # store $s0 in stack
    sw $s1, 4($sp)                          # store $s1 in stack

    lw $s0, 0($a0)                          # $s0 stores the value of a[i]
    lw $s1, 0($a1)                          # $s1 stores the value of a[j]
    sw $s1, 0($a0)                          # a[i] = a[j]
    sw $s0, 0($a1)                          # a[j] = a[i]

    # restore s0 and s1 from stack
    lw $s0, 0($sp)                          # $s0 stores the value of a[i]
    lw $s1, 4($sp)                          # $s1 stores the value of a[j]
    addi $sp, $sp, 8                        # increment stack pointer by 8
    jr $ra                                  # control is transferred back to recursive_sort

# to sort an array in ascending order
# arguments passed: $a0 = address of first element in array, $a1 = start index, $a2 = end index
# Registers s0 and s1 store l and r respectively
recursive_sort:                                 
    addi $sp, $sp, -24                      # decrement stack pointer by 24
    sw $ra, 0($sp)                          # saving ra in stack
    sw $a0, 4($sp)                          # saving &A[0]
    sw $a1, 8($sp)                          # saving left
    sw $a2, 12($sp)                         # saving right
    sw $s0, 16($sp)                         # saving s0
    sw $s1, 20($sp)                         # saving s1

    lw $s0, 8($sp)                          # $s0 <-- l
    lw $s1, 12($sp)                         # $s1 <-- r

    while:
        bge $s0, $s1, end_while             # if l >= r, then break
        
        while_l:
            lw $t6, 12($sp)                 # $t6 <-- right
            bge $s0, $t6, end_while_l       # if l >= right, end while_l

            # to compare A[l] and A[p]
            # A[l]:
            move $t6, $s0                   # $t6 = l
            sll $t6, $t6, 2                 # $t6 = l * 4
            lw $t0, 4($sp)                  # $t0 = &A[0]
            add $t6, $t6, $t0               # $t6 = &A[l]

            # A[p]: (= A[left])
            lw $t7, 8($sp)                  # $t7 = left
            sll $t7, $t7, 2                 # $t7 = left * 4
            lw $t0, 4($sp)                  # $t0 = &A[0]
            add $t7, $t7, $t0               # $t7 = &A[left]

            #. if A[l] > A[p], go to end_while_l
            lw $t6, ($t6)                   # $t6 = A[l]
            lw $t7, ($t7)                   # $t7 = A[left]
            bgt $t6, $t7, end_while_l       # if A[l] > A[left], go to end_while_l

            addi $s0, $s0, 1                # increment l
            j while_l                       # jump back to while_l

        end_while_l:

        while_r:
            #. if r <= left, end while_r
            lw $t6, 8($sp)                  # $t6 <-- left
            ble $s1, $t6, end_while_r       # if r <= left, end while_r

            # to compare A[r] and A[p]
            # A[r]:
            move $t6, $s1                   # $t6 = r
            sll $t6, $t6, 2                 # $t6 = r * 4
            lw $t0, 4($sp)                  # $t0 = &A[0]
            add $t6, $t6, $t0               # $t6 = &A[r]

            # A[p]: (= A[left])
            lw $t7, 8($sp)                  # $t7 = left
            sll $t7, $t7, 2                 # $t7 = left * 4
            lw $t0, 4($sp)                  # $t0 = &A[0]
            add $t7, $t7, $t0               # $t7 = &A[left]
            
            #. if A[r] < A[p], go to end_while_r
            lw $t6, ($t6)                   # $t6 = A[r]
            lw $t7, ($t7)                   # $t7 = A[left]
            blt $t6, $t7, end_while_r       # if A[r] < A[left], go to end_while_r

            addi $s1, $s1, -1               # decrement r
            j while_r                       # jump back to while_r

        end_while_r:

        blt $s0, $s1, swap_b                # if l < r, go to swap_b directly
        
        # swapping A[p] and A[r]
        # A[p]:
        lw $a0, 8($sp)                      # $a0 = left
        sll $a0, $a0, 2                     # $a0 = left * 4
        lw $t6, 4($sp)                      # $t6 = &A[0]
        add $a0, $a0, $t6                   # $a0 = &A[left]

        # A[r]:
        move $a1, $s1                       # $a1 = r
        sll $a1, $a1, 2                     # $a1 = r * 4
        lw $t6, 4($sp)                      # $t6 = &A[0]
        add $a1, $a1, $t6                   # $a1 = &A[r]

        jal SWAP                            # SWAP(a[p], a[r])

        # calling recursive_sort(A, left, r-1);
        lw $a0, 4($sp)                      # $a0 <-- &A[0]
        lw $a1, 8($sp)                      # $a1 <-- left
        addi $a2, $s1, -1                   # $a2 <-- r-1
        jal recursive_sort                  # recursive_sort(A, left, r-1)

        # calling recursive_sort(A, r+1, right);
        lw $a0, 4($sp)                      # $a0 <-- &A[0]
        addi $a1, $s1, 1                    # $a1 <-- r+1
        lw $a2, 12($sp)                     # $a2 <-- right
        jal recursive_sort                  # recursive_sort(A, r+1, right)

        j end_while                         # jump to end_while

        swap_b:
            # swapping A[l] and A[r]
            # A[l]:
            move $a0, $s1                   # $a0 = left
            sll $a0, $a0, 2                 # $a0 = left * 4
            lw $t6, 4($sp)                  # $t6 = &A[0]
            add $a0, $a0, $t6               # $a0 = &A[left]

            # A[r]:
            move $a1, $s0                   # $a1 = r
            sll $a1, $a1, 2                 # $a1 = r * 4
            lw $t6, 4($sp)                  # $t6 = &A[0]
            add $a1, $a1, $t6               # $a1 = &A[r]

            jal SWAP                        # SWAP(a[l], a[r])
            j while                         # go to while

    end_while:
        # restoring ra, s0, s1 from stack
        lw $ra, 0($sp)                      # restoring ra from stack
        lw $s0, 16($sp)                     # restoring s0 from stack
        lw $s1, 20($sp)                     # restoring s1 from stack
        addi $sp, $sp, 24                   # incrementing stack pointer by 4
        jr $ra                              # control is transferred back to main

# main function
main:
    li $v0, 4                               # v0 <-- 4
    la $a0, msg1                            # a0 <-- msg1
    syscall                                 # print msg1

    li $s2, 10                              # $s2 stores the number of elements in the array (n)

    la $s0, arr                             # $s0 stores the address of the array arr
    move $a0, $s2                           # $a0 stores the number of elements in the array (n)
    
    move $a0, $s0                           # $a0 stores the address of the array arr
    move $a1, $s2                           # $a1 stores the number of elements in the array (n)
    jal read_array                          # read_array is called to read the array from the user
    
    move $a0, $s0                           # $a0 stores the address of the array arr
    li $a1, 0                               # $a1 stores 0, the start index for sorting
    li $a2, 9                               # $a2 stores 9, end index for sorting
    jal recursive_sort                      # calling recursive_sort(A, 0, 9);

    move $a0, $s0                           # $a0 stores the address of the array
    move $a1, $s2                           # $a1 stores the number of elements in the array
    jal print_array                         # control is transferred to print_array

    li $v0, 10                              ### --- end of program --- ###
    syscall                                 