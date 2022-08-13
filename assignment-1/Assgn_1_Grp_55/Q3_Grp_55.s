# assignment number: 1
# problem number: 3
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
input_promt: .asciiz "Enter a positive integer greater than equals to 10: "
error_message: .asciiz "Error: Invalid input"
prime_promt: .asciiz "Entered number is a PRIME number"
composite_promt: .asciiz "Entered number is a COMPOSITE number"
new_line: .asciiz "\n"
############ data declarations #############


############ program instructions #############
# text section contains program instructions
.text

# program variables:
# n : $s0
# i : $s1

# branch for printing warning after entering number less than 10
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

# branch for printing composite number
print_composite:
    # print composite number
    li $v0, 4
    la $a0, composite_promt
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

# branch for printing prime number
print_prime:
    # print prime number
    li $v0, 4
    la $a0, prime_promt
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

# main program
main:
    # making first system call to display prompt for asking inout for n
    li $v0, 4 # system call number 4, as we want to print a string
    la $a0, input_promt # $a0 is the address of the string in memory
    syscall # system call to print the string

    # reading input for n
    li $v0, 5 # system call number 5, as we want to read an integer
    syscall # system call to read an integer
    move $s0, $v0 # store value of input n1 from default registor $v0 to $s0

    # checking if n is greater than or equal 10
    li $t0, 10 # $t1 is used to store 10
    blt $s0, $t0, throw_error # if n is less than, jump to throw_error label


    # prime number check
    li $s1, 2 # $s1 is used to store 2

    for:
        bge $s1, $s0, print_prime # if $s1 is greater than or equal to $s0, jump to print_prime label
        div $s0, $s1 # divide $s0 by $s1 and store the reminder in HI and quotient in LO
        mfhi $t1 # $t1 is used to store the value of HI
        beq $t1, $zero, print_composite # if $t1 is equal to 0, jump to print_composite label
        addi $s1, $s1, 1 # increment $s1 by 1
        j for # jump to for label
    


