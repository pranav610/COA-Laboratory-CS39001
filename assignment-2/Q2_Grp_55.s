# Assignment number: 2
# Problem number: 2
# Semester: Autumn 2022
# Group_name = "Group 55"
# Group_members = ["Kulkarni Pranav Suryakant(20CS30029)", "Vineet Amol Pippal(20CS30058)"]

# This program takes a 10-element array from user, sorts it, prints it and finds the kth largest element in the array.

############ global variables #############
# globl will make main symbol accessible from outside the current file
.globl main 
############ global variables #############

############ data declarations #############
# declares variable names used in program; storage allocated in main memory (RAM)
.data
    arr: .space 40

    msg1: .asciiz "Enter ten integer elements of the array:-\n"

    msg2: .asciiz "Enter the value of k: "

    sort_msg: .asciiz "Sorted array: "

    msg3: .asciiz "The "
    
    msg4: .asciiz "th largest element is: "

    k_msg: .asciiz "Enter a valid value of k: "
    
    newline: .asciiz "\n"

    space: .asciiz " "
############ data declarations #############

############ program instructions #############
# text section contains program instructions
.text

# Assumptions:-
# *** It has been assumed that k can be from 1 to n (n = 10); all other inputs for k are deemed invalid *** 

back:
    jr $ra

# function to read array elements from user
read_array:         
    beqz $a0, back                          # if a0 is 0, go to back 
    li $v0, 5                               # to scan another number
    syscall

    sw $v0, 0($s0)                          # $s0 stores the address of current element in array
    addu $s0, $s0, 4                        # increment the address of current element in array by 4; $s0 now stores the address of next element in array
    addi $a0, $a0, -1                       # decrement the number of elements to be read by 1
    b read_array                            # call read_array again

# function to print the sorted array and to move to find_kth_largest
# arguments passed: $a0 = address of first element in array, $a1 = number of elements in array
print_sorted_array:                         
    move $t0, $a0                           # $t0 stores the address of the array
    move $t1, $a1                           # $t1 stores the value of k initially

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
        la $a0, newline                     # sorted array printed, newline printed    
        syscall

        jr $ra                              # return to main

# function to find the kth largest element in the array and print it
# arguments passed: $a0 = address of first element in array, $a1 = number of elements in array, $a2 = value of k
find_k_largest:
    move $t0, $a0                           # $t0 stores the address of the array
    move $t1, $a1                           # $t1 stores the value of k initially
    move $t2, $a2                           # $t2 stores the number of elements in the array

    move $a0, $t1                           # $a0 stores the value of k
    sub $a0, $t2, $a0                       # $a0 = $s2 - $a0 = n - k
    sll $a0, $a0, 2                         # $a0 = 4 * ($s2 - $a0) = 4 * (n - k)
    add $a0, $a0, $t0                       # $a0 = $s0 + 4 * (n - k) = &arr[k]
    
    lw $t0, 0($a0)                          # $t0 = arr[k]

    li $v0, 4                               # $v0 = 4: to print msg3
    la $a0, msg3                            # $a0 <-- msg3
    syscall                                 # print msg3

    li $v0, 1                               # $v0 = 1: to print k
    move $a0, $t1                           # $a0 <-- k
    syscall                                 # print k

    li $v0, 4                               # $v0 = 4: to print msg4
    la $a0, msg4                            # $a0 <-- msg4
    syscall                                 # print msg4

    li $v0, 1                               # $v0 = 1: to print t0 = arr[k]
    move $a0, $t0                           # $a0 <-- t0
    syscall                                 # print t0

    la $a0, newline                         # $a0 <-- newline
    li $v0, 4                               # $v0 = 4: to print newline
    syscall                                 # print newline

    la $a0, newline                         # $a0 <-- newline
    li $v0, 4                               # $v0 = 4: to print newline
    syscall                                 # print newline

    jr $ra                                  # transfering control back to main

# SWAP: swaps two consecutive elements of the array; a[j] and a[j+1]
# arguments passed: address of values that are to be swapped : $a0 = &a[j], $a1 = &a[j+1]
SWAP:                                       
    lw $t3, 0($a0)                          # $t3 = a[j]
    lw $t4, 0($a1)                          # $t4 = a[j+1]
    move $t6, $a0                           # $t6 = &a[j]

    bgt $t3, $t4, swap                      # if a[j] > a[j+1] we move to swap the numbers
    jr $ra                                  # else if a[j] <= a[j+1] we return back to sort_array

    swap:                           
        sw $t4, 0($t6)                      # a[j] <-- original value of a[j+1]
        sw $t3, 4($t6)                      # a[j+1] <-- original value of a[j]
        jr $ra                              # control is transferred back to sort_array

# to sort an array in ascending order
# arguments passed: $a0 = address of first element in array, $a1 = number of elements in array
sort_array:                                 
    # saving ra in stack
    addi $sp, $sp, -4                       # decrementing stack pointer by 4
    sw $ra, 0($sp)                          # saving ra in stack

    li $s4, 0                               # $s4 is the counter for the i loop (outer loop)
    move $t7, $a0                           # $t7 stores the address of the array (arr)
    move $t8, $a1                           # $t8 stores the number of elements in the array (n)

    for_i:
        add $t9, $t8, -1                    # $t9 = n - 1
        bge $s4, $t9, end_for_i             # if i == n - 1, array has been sorted and we jump to end_for_i
        li $s5, 0                           # $s5 is the counter for the j loop (inner loop)

        for_j:
            move $t2, $t8                   # stop inner loop when j = n-i-1 = 10-i-1
            sub $t2, $t2, $s4
            sub $t2, $t2, 1
            bge $s5, $t2, end_for_j         # if j == n-i-1, we jump to end_for_j

            # $a0 will store &a[j]
            sll $t9, $s5, 2                 # $t9 = 4 * j
            add $t9, $t9, $t7               # $t9 = &arr[j]
            move $a0, $t9                   # $a0 stores &arr[j]

            # $a1 will store &a[j+1]
            add $t9, $t9, 4                 # $t9 = &arr[j+1]
            move $a1, $t9                   # $a1 stores &arr[j+1]
            
            jal SWAP                        # SWAP function is called to swap a[j] and a[j+1] if a[j] > a[j+1]

            add $s5, $s5, 1                 # increment j
            j for_j                         # jump to for_j

            end_for_j:                      
                add $s4, $s4, 1             # increment i
                b for_i                     # jump to for_i

    end_for_i:
        # restoring ra from stack
        lw $ra, 0($sp)                      # restoring ra from stack
        addi $sp, $sp, 4                    # incrementing stack pointer by 4
        jr $ra                              # control is transferred back to main

# label to loop until a valid k is provided by user
invalid_input:                              # if k is not a valid input
    li $v0, 4                               # print k_msg
    la $a0, k_msg
    syscall

    li $v0, 5                               # read k again
    syscall

    move $s1, $v0                           # $s1 stores the value of k
    bgt $s1, $s2, invalid_input             # until a valid value of k is passed,
    blez $s1, invalid_input                 # loop back to invalid_input

    j valid_inp                             # if k is a valid value, proceed to sort the array: control is transferred back to main

# main function
main:
    li $v0, 4                               # v0 <-- 4
    la $a0, msg1                            # a0 <-- msg1
    syscall                                 # print msg1

    li $s2, 10                              # $s2 stores the number of elements in the array (n)

    la $s0, arr                             # $s0 stores the address of the array arr
    move $a0, $s2                           # $a0 stores the number of elements in the array (n)
    
    jal read_array                          # read_array is called to read the array from the user

    li $v0, 4                               # v0 <-- 4
    la $a0, msg2                            # a0 <-- msg2
    syscall                                 # print msg2

    li $v0, 5                               # v0 <-- 5
    syscall                                 # read k from user
    move $s1, $v0                           # $s1 stores the value of k

    bgt $s1, $s2, invalid_input             # if k > n or if k <= 0, invalid_input is called until a valid k is provided
    blez $s1, invalid_input                 # loop back to invalid_input

    valid_inp:                              # if a valid k was supplied, below code would subsequently be executed

    la $s0, arr                             # $s0 stores the address of the array arr
    move $a0, $s0                           # $a0 stores the address of the array
    move $a1, $s2                           # $a1 stores the number of elements in the array
    jal sort_array                          # if k is a valid value, proceed to sort the array: control is transferred to sort_array

    move $a0, $s0                           # $a0 stores the address of the array
    move $a1, $s2                           # $a1 stores the number of elements in the array
    jal print_sorted_array                  # control is transferred to print_sorted_array

    move $a0, $s0                           # $a0 stores the address of the array
    move $a1, $s1                           # $a1 stores the value of k
    move $a2, $s2                           # $a2 stores the number of elements in the array
    jal find_k_largest                      # to find and print the kth largest element, find_k_largest(arr, k, n) is called

    li $v0, 10                              ### --- end of program --- ###
    syscall                                 