# Assignment Number: 4 (MIPS Assignment-3)
# Problem Number: 3 
# Semester: Autumn 2022
# Group_name = "Group 55"
# Group_members = ["Kulkarni Pranav Suryakant(20CS30029)", "Vineet Amol Pippal(20CS30058)"]

# This program takes a 10-element array from user, sorts it and prints it.
# It then takes a key input and outputs the index of that key in the array or -1 if the key does not exist in the array.

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
    
    key_msg: .asciiz "Enter key to be searched: "

    found: .asciiz " was FOUND in the array at index "

    dot_newline: .asciiz ".\n"

    not_found: .asciiz " was NOT FOUND in the array.\n"

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

    lw $s0, 0($a0)                          # $t0 stores the value of a[i]
    lw $s1, 0($a1)                          # $t1 stores the value of a[j]
    sw $s1, 0($a0)                          # a[i] = a[j]
    sw $s0, 0($a1)                          # a[j] = a[i]

    # restore s0 and s1 from stack
    lw $s0, 0($sp)                          # $s0 stores the value of a[i]
    lw $s1, 4($sp)                          # $s1 stores the value of a[j]
    addi $sp, $sp, 8                        # increment stack pointer by 8
    jr $ra                                  # control is transferred back to recursive_sort

# t# to sort an array in ascending order
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

# Function to recursively search the array for a given key and return index of key/-1 if not found
# Aruguments passed: $a0 = address of first element in array, $a1 = start index, $a2 = end index, $a3 = key 
# Registers s0 and s1 store mid1 and mid2 respectively
recursive_search:
    # saving ra, a0, a1, a2, a3 in stack
    addi $sp, $sp, -28
    sw $ra, 0($sp)                          # saving ra in stack
    sw $a0, 4($sp)                          # saving &A[0]
    sw $a1, 8($sp)                          # saving start index
    sw $a2, 12($sp)                         # saving end index
    sw $a3, 16($sp)                         # saving key
    sw $s0, 20($sp)                         # saving s0 (mid1)
    sw $s1, 24($sp)                         # saving s1 (mid2)

    while_search:
        li $v0, -1                          # $v0 <-- -1
        bgt $a1, $a2, end_while_search      # if start index > end index, then break

        # mid1 = start + (end - start) /3
        lw $s0, 8($sp)                      # $s0 <-- end
        lw $t0, 12($sp)                     # $t0 <-- start
        sub $t0, $t0, $s0                   # $t0 <-- start - end
        li $t1, 3                           # $t1 <-- 3
        div	$t0, $t0, $t1			        # $t0 = $t0 / $t1 = (end - start) / 3
        add $s0, $s0, $t0                   # $s0 = start + (end - start) / 3

        # mid2 = end -  (end - start) / 3
        lw $s1, 12($sp)                     # $s1 <-- end
        sub $s1, $s1, $t0                   # $s1 <-- end - (end - start) / 3

        #. if key == A[mid1], return mid1
        move $t0, $s0                       # $t0 <-- mid1
        sll $t0, $t0, 2                     # $t0 <-- mid1 * 4
        lw $t1, 4($sp)                      # $t1 <-- &A[0]
        add $t0, $t0, $t1                   # $t0 <-- &A[mid1]
        lw $t1, ($t0)                       # $t1 <-- A[mid1]
        lw $t2, 16($sp)                     # $t2 <-- key
        move $v0, $s0                       # $v0 <-- mid1 (in case of key == A[mid1], return mid1)
        beq $t2, $t1, end_while_search      # if key == A[mid1], then go to end_while_search

        #. else if key == A[mid2], return mid2
        move $t0, $s1                       # $t0 <-- mid2
        sll $t0, $t0, 2                     # $t0 <-- mid2 * 4
        lw $t1, 4($sp)                      # $t1 <-- &A[0]
        add $t0, $t0, $t1                   # $t0 <-- &A[mid2]
        lw $t1, ($t0)                       # $t1 <-- A[mid2]
        lw $t2, 16($sp)                     # $t2 <-- key
        move $v0, $s1                       # $v0 <-- mid2 (in case of key == A[mid2], return mid2)
        beq $t2, $t1, end_while_search      # if key == A[mid2], then go to end_while_search

        #. else if key < A[mid1], then search in left part
        lw $a0, 4($sp)                      # $a0 <-- &A[0]
        lw $a1, 8($sp)                      # $a1 <-- start
        addi $a2, $s0, -1                   # $a2 <-- mid1 - 1
        move $t0, $s0                       # $t0 <-- mid1
        sll $t0, $t0, 2                     # $t0 <-- mid1 * 4
        lw $t1, 4($sp)                      # $t1 <-- &A[0]
        add $t0, $t0, $t1                   # $t0 <-- &A[mid1]
        lw $t1, ($t0)                       # $t1 <-- A[mid1]
        lw $a3, 16($sp)                     # $a3 <-- key
        blt $a3, $t1, call_and_ret          # if key < A[mid1], then call recursive_search(A, start, mid1 - 1, key) and return the value

        #. else if key > A[mid2], then search in right part
        lw $a0, 4($sp)                      # $a0 <-- &A[0]
        addi $a1, $s1, 1                    # $a1 <-- mid2 + 1
        lw $a2, 12($sp)                     # $a2 <-- end
        lw $a3, 16($sp)                     # $a3 <-- key
        move $t0, $s1                       # $t0 <-- mid2
        sll $t0, $t0, 2                     # $t0 <-- mid2 * 4
        lw $t1, 4($sp)                      # $t1 <-- &A[0]
        add $t0, $t0, $t1                   # $t0 <-- &A[mid2]
        lw $t1, ($t0)                       # $t1 <-- A[mid2]
        bgt $a3, $t1, call_and_ret          # if key > A[mid2], then call recursive_search(A, mid2 + 1, end, key) and return the value

        #. else return recursive_search(A, mid1+1, mid2-1, key)
        lw $a0, 4($sp)                      # $a0 <-- &A[0]
        addi $a1, $s0, 1                    # $a1 <-- mid1 + 1
        addi $a2, $s1, -1                   # $a2 <-- mid2 - 1
        lw $a3, 16($sp)                     # $a3 <-- key
        jal recursive_search                # call recursive_search(A, mid1 + 1, mid2 - 1, key) and return the value

    end_while_search:
        lw $ra, 0($sp)                      # restore ra
        addi $sp, $sp, 28                   # restore stack pointer
        jr $ra                              # control is transferred back to caller

    call_and_ret:
        jal recursive_search                # call recursive_search() with pre-loaded arguments in a0-a3
        j end_while_search                  # return the corresponding value by jumping to end_while_search

# Function to print appropriate message if key is found/ not found
# Arguments passed: $a0 = index of key, $a1 = key
is_found:
    addi $t0, $zero, -1                     # $t0 <-- -1
    beq $a0, $t0, key_not_found             # if index == -1, then key was not found
    move $t2, $a0                           # $t2 <-- index
    move $t3, $a1                           # $t3 <-- key

    key_found:                              # if key was found
        li $v0, 1                           # $v0 <-- 1
        move $a0, $t3                       # $a0 <-- key
        syscall

        li $v0, 4
        la $a0, found                       # $a0 <-- address of found
        syscall

        li $v0, 1
        move $a0, $t2                       # $a0 <-- index
        syscall
        
        li $v0, 4
        la $a0, dot_newline                 # $a0 <-- address of dot_newline
        syscall

        li $v0, 4
        la $a0, newline                     # $a0 <-- newline
        syscall

        jr $ra

    key_not_found:                          # if key was not found
        li $v0, 1                           # $v0 <-- 1
        move $a0, $a1                       # $a0 <-- key
        syscall

        la $a0, not_found                   # $a0 <-- not_found
        li $v0, 4
        syscall

        li $v0, 4
        la $a0, newline                     # $a0 <-- newline
        syscall

        jr $ra

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

    la $a0, key_msg                         # $a0 stores the address of key_msg
    li $v0, 4                               
    syscall

    li $v0, 5                               # taking input for key
    syscall

    move $s3, $v0                           # key stored in #s3

    move $a0, $s0                           # $a0 stores the address of the array
    li $a1, 0                               # $a1 stores 0, the start index for searching
    li $a2, 9                               # $a2 stores 9, end index for searching
    move $a3, $s3                           # $a3 stores the key
    jal recursive_search                    # calling recursive_search(A, 0, 9, key);

    move $a0, $v0                           # $a0 stores the return value from recursive_search i.e. index of key
    move $a1, $s3                           # $a1 stores the key
    jal is_found                            # calling is_found(index, key);

    li $v0, 10                              ### --- end of program --- ###
    syscall                                 