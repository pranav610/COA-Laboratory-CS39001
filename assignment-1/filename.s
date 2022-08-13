# The following program will read one positive integer and print the sum of all the numbers from 1 to that number.

# globl will make main symbol accessible from outside the current file
.globl main 

# declares variable names used in program; storage allocated in main memory (RAM)
.data
input_promt: .asciiz "Enter a positive integer: "
error_message: .asciiz "Error: Invalid input"
sum_promt_1: .asciiz "The sum of the first "
sum_promt_2: .asciiz " integers is "
new_line: .asciiz "\n"

# text section contains program instructions
.text

# program variables:
# n : $s0
# sum : $s1
# i : $s2

# brach for printing warning after entering negative number
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

# main program
main:
    # making first system call to display prompt for asking inout for n
    li $v0, 4 # system call number 4, as we want to print a string
    la $a0, input_promt # $a0 is the address of the string in memory
    syscall # system call to print the string

    # reading input for n
    li $v0, 5 # system call number 5, as we want to read an integer
    syscall # system call to read an integer
    move $s0, $v0 # store value of input n from default registor $v0 to $s0

    # checking if n is positive
    ble $s0, $zero, throw_negative # if n is negative, jump to throw_negative label

    # initializing sum to 0
    li $s1, 0
    # initializing i to 1
    li $s2, 1
    # looping through i from 1 to n
    for:
        blt     $s0, $s2, endf  # if i is greater than n, jump to endf label
        add     $s1, $s1, $s2   # sum = sum + i
        addi     $s2, $s2, 1     # i = i + 1
        b       for             # move for next iteration

    endf:
        li      $v0, 4          # print "The sum of the first "
        la      $a0, sum_promt_1
        syscall

        li      $v0, 1          # print n
        move    $a0, $s0
        syscall

        li      $v0, 4          # print " integers is "
        la      $a0, sum_promt_2
        syscall

        li      $v0, 1          # print sum
        move    $a0, $s1
        syscall

        li      $v0, 4          # print two newlines
        la      $a0, new_line
        syscall
        li      $v0, 4
        la      $a0, new_line
        syscall

        li      $v0, 10         # terminate the program
        syscall
    

