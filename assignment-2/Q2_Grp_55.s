# Assignment number: 2
# Problem number: 2
# Semester: Autumn 2022
# Group_name = "Group 55"
# Group_members = ["Kulkarni Pranav Suryakant", "Vineet Amol Pippal"]

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
print_sorted_array:                         
    la $t0, arr                             # $t0 stores the address of the array
    move $t1, $s2                           # $t1 stores the value of k initially

    la $a0, sort_msg                        # print sort_msg
    li $v0, 4
    syscall

    for_print:                              # to print the sorted array
        blez $t1, end_print                 # if $t1 is 0, then end the loop
        lw $a0, ($t0)                       # $a0 stores the value of the array element
        li $v0, 1
        syscall

        la $a0, space
        li $v0, 4
        syscall

        addiu $t0, $t0, 4                   # to move to the next array element
        addiu $t1, $t1, -1                  # decrement $t1
        j for_print                         # loop back to for_print

    end_print:                              
        li $v0, 4                           
        la $a0, newline                     # sorted array printed, newline printed    
        syscall

        jal find_k_largest                  # to find and print the kth largest element, find_k_largest called

        li $v0, 10                          ### --- end of program --- ###
        syscall

# function to find the kth largest element in the array and print it
find_k_largest:
    move $a0, $s1                           # $a0 stores the value of k
    sub $a0, $s2, $a0                       # $a0 = $s2 - $a0 = n - k
    sll $a0, $a0, 2                         # $a0 = 4 * ($s2 - $a0) = 4 * (n - k)
    add $a0, $a0, $s0                       # $a0 = $s0 + 4 * (n - k) = &arr[k]
    
    lw $t0, 0($a0)                          # $t0 = arr[k]

    li $v0, 4                               # $v0 = 4: to print msg3
    la $a0, msg3                            # $a0 <-- msg3
    syscall                                 # print msg3

    li $v0, 1                               # $v0 = 1: to print k
    move $a0, $s1                           # $a0 <-- k
    syscall                                 # print k

    li $v0, 4                               # $v0 = 4: to print msg4
    la $a0, msg4                            # $a0 <-- msg4
    syscall                                 # print msg4

    li $v0, 1                               # $v0 = 1: to print t0 = arr[k]
    move $a0, $t0                           # $a0 <-- t0
    syscall                                 # print t0

    la $a0, newline
    li $v0, 4
    syscall

    la $a0, newline
    li $v0, 4
    syscall

    jr $ra                                  # transfering control back to print_sorted_array

# SWAP: swaps two consecutive elements of the array; a[j] and a[j+1]
SWAP:                                       
    la $s0, arr                             # $s0 stores the address of the array
    sub $t3, $s2, 1                         # if j == n-1 we return since we are already at the last element
    bge $a0, $t3, back                      # a0 stores j

    sll $t6, $a0, 2                         # t6 = 4 * j
    add $t6, $t6, $s0                       # t6 = &arr[j]

    lw $t3, 0($t6)                          # $t3 stores a[j]
    lw $t4, 4($t6)                          # $t4 stores a[j+1]

    bgt $t3, $t4, swap                      # if a[j] > a[j+1] we move to swap the numbers
    jr $ra                                  # else if a[j] <= a[j+1] we return back to sort_array

    swap:                           
        sw $t4, 0($t6)                      # a[j] <-- original value of a[j+1]
        sw $t3, 4($t6)                      # a[j+1] <-- original value of a[j]
        jr $ra                              # control is transferred back to sort_array

# to sort an array in ascending order
sort_array:                                 
    li $s4, 0                               # $s4 is the counter for the i loop (outer loop)

    for_i:
        bge $s4, $s2, end_for_i             # if i == n, array has been sorted and we jump to end_for_i
        li $s5, 0                           # $s5 is the counter for the j loop (inner loop)

        for_j:
            move $t2, $s2                   # stop inner loop when j = n-i = 10-i
            sub $t2, $t2, $s4
            bge $s5, $t2, end_for_j         # if j == n-i, we jump to end_for_j

            move $a0, $s5                   # $a0 stores j
            jal SWAP                        # SWAP function is called to swap a[j] and a[j+1] if a[j] > a[j+1]

            add $s5, $s5, 1                 # increment j
            j for_j                         # jump to for_j

            end_for_j:                      
                add $s4, $s4, 1             # increment i
                b for_i                     # jump to for_i

    end_for_i:
        j print_sorted_array                # sorting has been completed and we jump to print_sorted_array

invalid_input:                              # if k is not a valid input
    li $v0, 4                               # print k_msg
    la $a0, k_msg
    syscall

    li $v0, 5                               # read k again
    syscall
    move $s1, $v0
    bgt $s1, $s2, invalid_input             # until a valid value of k is passed,
    blez $s1, invalid_input                 # loop back to invalid_input

    j sort_array                            # if k is a valid value, proceed to sort the array: control is transferred to sort_array

main:
    li $v0, 4                               # print msg1
    la $a0, msg1
    syscall

    li $s2, 10                              # $s2 stores the number of elements in the array (n)

    la $s0, arr                             # $s0 stores the address of the array arr
    move $a0, $s2

    jal read_array                          # read_array is called to read the array from the user

    li $v0, 4                               # print msg2
    la $a0, msg2
    syscall

    li $v0, 5                               # read k in $s1
    syscall
    move $s1, $v0                           

    bgt $s1, $s2, invalid_input             # if k > n or if k <= 0, invalid input
    jal sort_array                          # if k is a valid value, proceed to sort the array: control is transferred to sort_array