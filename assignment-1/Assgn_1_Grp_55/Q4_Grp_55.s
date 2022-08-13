# assignment number: 1
# problem number: 4
# semester: autumn 2022-23
# grouop_name = "Group 55"
# group_members = ["Kulkarni Pranav Suryakant", "Vineet Amol Pipal"]

# This program will take a positive integer greater than 10 from the user.
# After sanity checking the program will output wheather the number is prime or composite.


############ global variables #############
# globl will make main symbol accessible from outside the current file
.globl main 
############ global variables #############


############ data declarations #############
# declares variable names used in program; storage allocated in main memory (RAM)
.data
input_promt: .asciiz "Enter a positive integer: "
error_message: .asciiz "Error: Invalid input"
perfect_promt: .asciiz "Entered number is a perfect number"
non_perfect_promt: .asciiz "Entered number is not a perfect number"
new_line: .asciiz "\n"
############ data declarations #############


############ program instructions #############
# text section contains program instructions
.text

# program variables:
# n : $s0
# i : $s1
# sum : $s2

# branch for printing warning after entering non postive number
throw_error:
    li $v0, 4
    la $a0, error_message
    syscall

    li $v0, 4
    la $a0, new_line
    syscall
    li $v0, 4
    la $a0, new_line
    syscall

    b main

# branch for printing perfect number
print_perfect:
    # print perfect number
    li $v0, 4
    la $a0, perfect_promt
    syscall

    # print two new lines
    li $v0, 4
    la $a0, new_line
    syscall
    li $v0, 4
    la $a0, new_line
    syscall

    # terminate program
    li      $v0, 10         # terminate the program
    syscall

# branch for printing non_perfect number
print_non_perfect:
    # print non_perfect number
    li $v0, 4
    la $a0, non_perfect_promt
    syscall
    
    # print two new lines
    li $v0, 4
    la $a0, new_line
    syscall
    li $v0, 4
    la $a0, new_line
    syscall
    
    # terminate program
    li      $v0, 10         # terminate the program
    syscall

update_sum:
    # update sum
    add $s2, $s2, $s1
    addi $s1, $s1, 1 # increment $s1 by 1 
    j for
    

# main program
main:
    # making first system call to display prompt for asking input for n
    li $v0, 4 # system call number 4, as we want to print a string
    la $a0, input_promt # $a0 is the address of the string in memory
    syscall # system call to print the string

    # reading input for n
    li $v0, 5 # system call number 5, as we want to read an integer
    syscall # system call to read an integer
    move $s0, $v0 # store value of input n from default registor $v0 to $s0

    # checking if n is a positive integer
    ble $s0, $zero, throw_error # if n is less than, jump to throw_error label

    # perfect number check
    li $s1, 1 # i is set to 1
    li $s2, 0 # sum is set to 0

    for:
        bge $s1, $s0, check # if $s1 is greater than or equal to $s0, jump to check label
        div $s0, $s1 # divide $s0 by $s1 and store the reminder in HI and quotient in LO
        mfhi $t1 # $t1 is used to store the value of HI
        beq $t1, $zero, update_sum # if $t1 is equal to 0, jump to update_sum label
        addi $s1, $s1, 1 # increment $s1 by 1
        j for # jump to for label
    
    check:
        beq $s2, $s0, print_perfect # if $s2 is equal to $s0, jump to print_perfect label
        j print_non_perfect # jump to print_non_perfect label


