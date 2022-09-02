# assignment number: 4 (MIPS Assignment-4)
# problem number: 1
# semester: autumn 2022-23
# group_name = "Group 55"
# group_members = ["Kulkarni Pranav Suryakant(20CS30029)", "Vineet Amol Pipal(20CS30058)"]

# This program will allocate memory for a matrix A
# with dimensions n*n.
# The program will propagate matrix A with a GP having first term a and
# common ratio r. Such that A[i] = (a(r^i) mod m)


############ global variables #############
# globl will make main symbol accessible from outside the current file
.globl main 
############ global variables #############


############ data declarations #############
# declares variable names used in program; storage allocated in main memory (RAM)
.data
input_promt: .asciiz "Enter four positive integers n, a, r and m: "
error_message: .asciiz "Error: Invalid input"
print_promt: .asciiz "Matrix:\n"
det_promt: .asciiz "Final determinant of the matrix A is\n"
space: .asciiz " "
new_line: .asciiz "\n"
############ data declarations #############


############ program instructions #############
# text section contains program instructions
.text
# program variables:
# for function main:
# $s0: will store value of $sp after taking inputs m,n,a,r
# 12($s0) = m
# 8($s0) = n
# 4($s0) = a
# 0($s0) = r
# $s1: will store 1st address of matrix A
# $s2: will store 1st address of matrix B


# branch for printing warning after entering number less than 0
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

# function which will Initialise the stack pointer ($sp) and frame pointer ($fp)
initStack:
    add $sp, $sp, -4                                                    # expand stack pointer downwards to allot space for storing fp   
    sw $fp, 0($sp)                                                      # store frame pointer in the memory
    move $fp, $sp                                                       # set $fp = $sp
    jr $ra                                                              

# function which will take one argument as input (in $a0) and push it to the stack
pushToStack:
    # push argument to stack
    sub $sp, $sp, 4                                                     # decrease stack pointer by 4 bytes to allote memory for argument
    sw $a0, 0($sp)                                                      # store argument in stack
    jr $ra                                                              # jump to return address $ra

# function which allocates space for m × n (stored in $a0) memory 
# locations (each of 4 bytes for each integer) in the stack and '
# returns the first address ($v0)
mallocInStack:
    sll $a0, $a0, 2                                                     # multiply $a0 by 4 to get number of bytes to be allocated
    sub $sp, $sp, $a0                                                   # decrease stack pointer by $a0 to allote memory for matrix
    move $v0, $sp                                                       # return first address of matrix
    jr $ra                                                              # jump to return address $ra

# This function takes three parameters- the positive integers m
# (in $a0), n (in $a1) and the address of a two-dimensional m × n integer
# array A (in $a2) storing the matrix in row major form. It prints the
# elements of A in a row major manner
printMatrix:
    move $t0, $a0                                                       # move m to $t0
    move $t1, $a1                                                       # move n to $t1
    move $t2, $a2                                                       # move address of A to $t2

    li $t3, 0                                                           # initialize $t3 to 0, used for loop counter i
    li $t4, 0                                                           # initialize $t4 to 0, used for loop counter j

    FOR_I:
        li $t4, 0                                                       # set j = 0, at start of the loop for i
        FOR_J:
            move $t5, $t3                                               # $t5 = $t3(i)
            mul $t5, $t5, $t1                                           # $t5 = i * (# of columns)
            add $t5, $t5, $t4                                           # $t5 = i * (# of columns) + j
            sll $t5, $t5, 2                                             # $t5 = (i*(# of columns)+j)*4   
            add $t5, $t2, $t5                                           # $t5 = 1st memory of A + (i*(# of columns)+j)*4

            li $v0, 1                                                   # set $v0 to print an integer
            lw $a0, 0($t5)                                              # set $a0 = M[$s1 - (i*(# of columns)+j)*4]
            syscall                                                     # print the integer

            li $v0, 4                                                   # set $v0 to print a space
            la $a0, space                                               # set $a0 to space
            syscall                                                     # print a space

            add $t4, $t4, 1                                             # increment j by 1
            blt $t4, $t1, FOR_J                                         # if j < n, go to FOR_J
        
        li $v0, 4                                                       # set $v0 to print a new line
        la $a0, new_line                                                # set $a0 to new_line
        syscall                                                         # print a new line

        add $t3, $t3, 1                                                 # increment i by 1
        blt $t3, $t0, FOR_I                                             # if i < m, go to FOR_I

    jr $ra                                                              # jump to return address $ra


# The function takes (positive) integers m and n and
# addresses of two integer arrays A and B. It is to compute the transpose
# matrix of the matrix A and store in the n × m matrix B
transposeMatrix:
    move $t0, $a0                                                       # move m to $t0
    move $t1, $a1                                                       # move n to $t1
    move $t2, $a2                                                       # move address of A to $t2
    move $t3, $a3                                                       # move address of B to $t3

    li $t4, 0                                                           # initialize $t4 to 0, used for loop counter i
    li $t5, 0                                                           # initialize $t5 to 0, used for loop counter j

    FOR_I_1:
        li $t5, 0                                                       # set j = 0, at start of the loop for i
        FOR_J_1:
            move $t6, $t4                                               # $t6 = $t4(i)
            mul $t6, $t6, $t1                                           # $t6 = i * (# of columns)
            add $t6, $t6, $t5                                           # $t6 = i * (# of columns) + j
            sll $t6, $t6, 2                                             # $t6 = (i*(# of columns)+j)*4   
            add $t6, $t2, $t6                                           # $t6 = 1st memory of A + (i*(# of columns)+j)*4

            move $t7, $t5                                               # $t7 = $t3(j)
            mul $t7, $t7, $t0                                           # $t7 = j * (# of rows)
            add $t7, $t7, $t4                                           # $t7 = j * (# of rows) + i
            sll $t7, $t7, 2                                             # $t7 = (j*(# of rows)+i)*4
            add $t7, $t3, $t7                                           # $t7 = 1st memory of B + (j*(# of rows)+i)*4

            lw $t8, 0($t6)                                              # $t8 = A[$s1 + (i*(# of columns)+j)*4]
            sw $t8, 0($t7)                                              # B[$s1 + (j*(# of rows)+i)*4] = A[$s1 + (i*(# of columns)+j)*4]

            add $t5, $t5, 1                                             # increment j by 1
            blt $t5, $t1, FOR_J_1                                       # if j < n, go to FOR_J

        add $t4, $t4, 1                                                 # increment i by 1
        blt $t4, $t0, FOR_I_1                                           # if i < m, go to FOR_I

    jr $ra                                                              # jump to return address $ra


# power function, take base (in $a0) and exponent (in $a1) and return the power of base to the exponent
power:
    li $v0, 1                                                           # set $v0 to 1
    FOR:
        beq $a1, $zero, END                                             # if exponent is not equal to 0, then continue loop
        mul $v0, $v0, $a0                                               # multiply the output with the base 
        addi $a1, $a1, -1                                               # decrement exponent by 1
        j FOR                                                           # continue loop
    END:
        jr $ra                                                          # jump to return address $ra

# main program
main:
# stack and frame pointer initilization
    jal initStack                                                       # jump and link to branch initStack

# making first system call to display prompt for asking input for M
    li $v0, 4                                                           # system call number 4, as we want to print a string
    la $a0, input_promt                                                 # store the string to be printed in $a0
    syscall                                                             # system call to print the string

    li $v0, 4                                                           # system call number 4, as we want to print a string
    la $a0, new_line                                                    # print a new line
    syscall                                                             # system call to print a new line

# input for M, N, A and R
    # reading input for m
    li $v0, 5                                                           # system call number 5, as we want to read an integer
    syscall                                                             # system call to read an integer
    move $t0, $v0                                                       # store value of input M from default registor $v0 to $t0
    # checking if input for m is less than 0
    blez $t0, throw_negative                                            # if input for m is less than equal to 0, jump to throw_negative
    # reading input for n
    li $v0, 5                                                           # system call number 5, as we want to read an integer
    syscall                                                             # system call to read an integer
    move $t1, $v0                                                       # store value of input N from default registor $v0 to $t1
    # checking if input for n is less than 0
    blez $t1, throw_negative                                            # if input for n is less than equal to 0, jump to throw_negative
    # reading input for a
    li $v0, 5                                                           # system call number 5, as we want to read an integer
    syscall                                                             # system call to read an integer
    move $t2, $v0                                                       # store value of input A from default registor $v0 to $t2
    # checking if input for a is less than 0
    blez $t2, throw_negative                                            # if input for a is less than equal to 0, jump to throw_negative
    # reading input for r
    li $v0, 5                                                           # system call number 5, as we want to read an integer
    syscall                                                             # system call to read an integer
    move $t3, $v0                                                       # store value of input R from default registor $v0 to $t3
    # checking if input for r is less than 0
    blez $t3, throw_negative                                            # if input for r is less than equal to 0, jump to throw_negative

# storing the inouts m,n,a,r in stack
    # pushing input for m to stack
    move $a0, $t0                                                       # store input M in $a0
    jal pushToStack                                                     # jump and link to branch pushToStack
    # pushing input for n to stack
    move $a0, $t1                                                       # store input N in $a0
    jal pushToStack                                                     # jump and link to branch pushToStack
    # pushing input for a to stack
    move $a0, $t2                                                       # store input A in $a0
    jal pushToStack                                                     # jump and link to branch pushToStack
    # pushing input for r to stack
    move $a0, $t3                                                       # store input R in $a0
    jal pushToStack                                                     # jump and link to branch pushToStack

    # store value of $sp in $s0
    move $s0, $sp                                                       # $s0 = $sp

# calling function mallocInStack to allocate space for m × n matrix in stack
    lw $t0, 12($s0)                                                     # $t0 = m
    lw $t1, 8($s0)                                                      # $t1 = n
    mul $a0, $t0, $t1                                                   # $a0 = m * n
    jal mallocInStack                                                   # jump and link to branch mallocInStack

    # storing address of matrix in $s1
    move $s1, $v0                                                       # $s1 = $v0

# calling function mallocInStack to allocate space for n × m matrix in stack
    lw $t0, 12($s0)                                                     # $t0 = m
    lw $t1, 8($s0)                                                      # $t1 = n
    mul $a0, $t0, $t1                                                   # $a0 = n * m
    jal mallocInStack                                                   # jump and link to branch mallocInStack

    # storing address of matrix in $s2
    move $s2, $v0                                                       # $s2 = $v0

# population of matrix A by GP with first term a and common ratio a
    li $s3, 0                                                           # $s3 = 0, store iterator i in $s3 
    FOR1:
        sll $t1, $s3, 2                                                 # $t1 = $s3 * 4
        add $t1, $s1, $t1                                               # $t1 = $s1 + $t1, $t1 = address of M[i][j]
        lw $a0, 0($s0)                                                  # $a0 = r
        move $a1, $s3                                                   # $a1 = $s3(i)
        jal power                                                       # jump and link to branch power, $v0 = $a0(r) ^ $a1(i)
        lw $t0, 4($s0)                                                  # $t0 = a
        mul $v0, $v0, $t0                                               # $v0 = $v0 * a    
        sw $v0, 0($t1)                                                  # store $v0 in matrix A

        addi $s3, $s3, 1                                                # $s3 = $s3 + 1  (i = i + 1)
        lw $t0, 12($s0)                                                 # $t0 = m
        lw $t1, 8($s0)                                                  # $t1 = n
        mul $t0, $t0, $t1                                               # $t0 = m * n   
        blt $s3, $t0, FOR1                                              # if i is less than n * m, then continue loop

# printing matrix A
    li $v0, 4                                                           # system call number 4, as we want to print a string
    la $a0, new_line                                                    # print a new line
    syscall                                                             # system call to print a new line

    li $v0, 4                                                           # system call number 4, as we want to print a string
    la $a0, outputA_promt                                               # print matrix A
    syscall                                                             # system call to print a string

    lw $a0, 12($s0)                                                     # $a0 = m
    lw $a1, 8($s0)                                                      # $a1 = n
    move $a2, $s1                                                       # $a2 = 1st address of matrix A
    jal printMatrix                                                     # jump and link to branch printMatrix

# transposing matrix A
    lw $a0, 12($s0)                                                     # $a0 = m
    lw $a1, 8($s0)                                                      # $a1 = n
    move $a2, $s1                                                       # $a2 = 1st address of matrix A
    move $a3, $s2                                                       # $a3 = 1st address of matrix B
    jal transposeMatrix                                                 # jump and link to branch transposeMatrix

# printing matrix B
    li $v0, 4                                                           # system call number 4, as we want to print a string
    la $a0, new_line                                                    # print a new line
    syscall                                                             # system call to print a new line

    li $v0, 4                                                           # system call number 4, as we want to print a string
    la $a0, outputB_promt                                               # print matrix B
    syscall                                                             # system call to print a string

    lw $a0, 8($s0)                                                      # $a0 = n
    lw $a1, 12($s0)                                                     # $a1 = m
    move $a2, $s2                                                       # $a2 = 1st address of matrix B
    jal printMatrix                                                     # jump and link to branch printMatrix
    
    # end of program
    li      $v0, 10                                                     # terminate the program
    syscall