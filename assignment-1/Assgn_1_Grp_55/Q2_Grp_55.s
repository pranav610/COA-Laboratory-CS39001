# assignment number: 1
# problem number: 2
# semester: autumn 2022-23
# grouop_name = "Group 55"
# group_members = ["Kulkarni Pranav Suryakant", "Vineet Amol Pipal"]

# This program will take two positive integers for the user.
# After sanity checking the program will output their GCD.


############ global variables #############
# globl will make main symbol accessible from outside the current file
.globl main 
############ global variables #############


############ data declarations #############
# declares variable names used in program; storage allocated in main memory (RAM)
.data
input_promt_1: .asciiz "Enter the first positive integer: "
input_promt_2: .asciiz "Enter the second positive integer: "
error_message: .asciiz "Error: Invalid input"
gcd_promt: .asciiz "GCD of the two integers is: "
new_line: .asciiz "\n"
############ data declarations #############


############ program instructions #############
# text section contains program instructions
.text

# program variables:
# n1 : $s0
# n2 : $s1
# GCD : $s2

# branch for printing warning after entering negative number
throw_negative:
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

# branch for printing value of GCD after calculating it
print_gcd_a:
    # print text prompt 
    li $v0, 4
    la $a0, gcd_promt
    syscall

    # print GCD
    li      $v0, 1          
    move    $a0, $s0
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

# branch for printing value of GCD after calculating it
print_gcd_b:
    # print text prompt 
    li $v0, 4
    la $a0, gcd_promt
    syscall

    # print GCD
    li      $v0, 1          
    move    $a0, $s1
    syscall

    # print two new lines
    li $v0, 4
    la $a0, new_line
    syscall
    li $v0, 4
    la $a0, new_line
    syscall

    li      $v0, 10         # terminate the program
    syscall

update_n1:
    sub $s0, $s0, $s1
    b while

# main program
main:
    # making first system call to display prompt for asking inout for n1
    li $v0, 4 # system call number 4, as we want to print a string
    la $a0, input_promt_1 # $a0 is the address of the string in memory
    syscall # system call to print the string

    # reading input for n1
    li $v0, 5 # system call number 5, as we want to read an integer
    syscall # system call to read an integer
    move $s0, $v0 # store value of input n1 from default registor $v0 to $s0

    # checking if n1 is positive
    ble $s0, $zero, throw_negative # if n1 is negative, jump to throw_negative label

    # making first system call to display prompt for asking inout for n2
    li $v0, 4 # system call number 4, as we want to print a string
    la $a0, input_promt_2 # $a0 is the address of the string in memory
    syscall # system call to print the string

    # reading input for n2
    li $v0, 5 # system call number 5, as we want to read an integer
    syscall # system call to read an integer
    move $s1, $v0 # store value of input n2 from default registor $v0 to $s1

    # checking if n2 is positive
    ble $s1, $zero, throw_negative # if n2 is negative, jump to throw_negative label

    # calculating GCD
    beq $s0, $zero, print_gcd_b # if n1 is zero, jump to print_gcd_b label

    while:
        beq $s1, $zero, print_gcd_a # if n2 is zero, jump to print_gcd_a label
        bgt $s0, $s1, update_n1 # if n1 is greater than n2, jump to update_n1 label
        sub $s1, $s1, $s0 # subtract n1 from n2
        j while # jump to while label
    
    # end of program
    li      $v0, 10         # terminate the program
    syscall
