# assignment number: 4 (MIPS Assignment-3)
# problem number: 1
# semester: autumn 2022-23
# group_name = "Group 55"
# group_members = ["Kulkarni Pranav Suryakant(20CS30029)", "Vineet Amol Pippal(20CS30058)"]

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
det_promt: .asciiz "Final determinant of the matrix A is: "
space: .asciiz " "
new_line: .asciiz "\n"
############ data declarations #############


############ program instructions #############
# text section contains program instructions
.text
# program variables:
# for function main:
# $s0: will store value of $sp after taking inputs n,a,r,m
# 12($s0) = n
# 8($s0) = a
# 4($s0) = r
# 0($s0) = m
# $s1: will store 1st address of matrix A


# branch for printing warning after entering number less than or equal to 0
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

# function which allocates space for n × n (stored in $a0) memory 
# locations (each of 4 bytes for each integer) in the stack and 
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

    FOR_PRINT_I:
        li $t4, 0                                                       # set j = 0, at start of the loop for i
        FOR_PRINT_J:
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
            blt $t4, $t1, FOR_PRINT_J                                   # if j < n, go to FOR_J
        
        li $v0, 4                                                       # set $v0 to print a new line
        la $a0, new_line                                                # set $a0 to new_line
        syscall                                                         # print a new line

        add $t3, $t3, 1                                                 # increment i by 1
        blt $t3, $t0, FOR_PRINT_I                                       # if i < m, go to FOR_I

    jr $ra                                                              # jump to return address $ra

CONTINUE_I:
    add $t3, $t3, 1                                                     # increment i by 1
    j FOR_COFACTOR_I                                                    # go to FOR_COFACTOR_I

CONTINUE_J:
    add $t4, $t4, 1                                                     # increment j by 1
    j FOR_COFACTOR_J                                                    # go to FOR_COFACTOR_J


# this function will take 3 arguments
# $a0: address of matrix A
# $a1: row index to be ignored
# $a2: column index to be ignored
# $a3: size of matrix
getCofactor:
    sub $sp, $sp, 4                                                     # decrease stack pointer by 4 bytes to allote memory for return address
    sw $ra, 0($sp)                                                      # store return address in stack

    move $t0, $a0                                                       # move address of A to $t0
    move $t1, $a1                                                       # move row index to be ignored to $t1
    move $t2, $a2                                                       # move column index to be ignored to $t2
    move $t5, $a3                                                       # move size of matrix to $t5

    sub $a0, $t5, 1                                                     # $a0 = size of matrix - 1
    mul $a0, $a0, $a0                                                   # $a0 = (size of matrix - 1) * (size of matrix - 1)
    jal mallocInStack                                                   # call mallocInStack to allocate memory for cofactor matrix
    move $s0, $v0                                                       # move address of cofactor matrix to $s0
    move $s1, $s0                                                       # move address of cofactor matrix to $s1

    sub $sp, $sp, 4                                                     # decrease stack pointer by 4 bytes to allote memory for size of matrix
    sub $a0, $t5, 1                                                     # $a0 = size of matrix - 1
    sw $a0, 0($sp)                                                      # store size of matrix in stack

    li $t3, 0                                                           # initialize $t3 to 0, used for loop counter i
    li $t4, 0                                                           # initialize $t4 to 0, used for loop counter j

    FOR_COFACTOR_I:
        bge $t3, $t5, END_I                                             # if i >= size of matrix, go to END_I
        beq $t3, $t1, CONTINUE_I                                        # if i = row index to be ignored, skip this iteration
        li $t4, 0                                                       # set j = 0, at start of the loop for i
        FOR_COFACTOR_J:
            bge $t4, $t5, END_J                                         # if j >= size of matrix, go to END_J
            beq $t4, $t2, CONTINUE_J                                    # if j == column index to be ignored, go to CONTINUE_J

            move $t6, $t3                                               # $t6 = $t3(i)
            mul $t6, $t6, $t5                                           # $t6 = i * (# of columns)
            add $t6, $t6, $t4                                           # $t6 = i * (# of columns) + j
            sll $t6, $t6, 2                                             # $t6 = (i*(# of columns)+j)*4   
            add $t6, $t0, $t6                                           # $t6 = 1st memory of A + (i*(# of columns)+j)*4

            lw $t7, 0($t6)                                              # $t7 = M[1st memory of A + (i*(# of columns)+j)*4]
            sw $t7, 0($s1)                                              # M[Current elemet in B] = $t7
            add $s1, $s1, 4                                             # increment $s1 by 4

            add $t4, $t4, 1                                             # increment j by 1
            blt $t4, $t5, FOR_COFACTOR_J                                # if j < n, go to FOR_J
    END_J:
        add $t3, $t3, 1                                                 # increment i by 1
        blt $t3, $t5, FOR_COFACTOR_I                                    # if i < n, go to FOR_I
END_I:
    move $a0, $t5                                                       # move size of matrix to $a0
    sub $a0, $a0, 1                                                     # $a0 = size of matrix - 1
    move $a1, $s0                                                       # move address of cofactor matrix to $a1
    jal calDeterminant                                                  # call determinant function to calculate determinant of cofactor matrix

    lw $t5, 0($sp)                                                      # load size of matrix from stack
    add $sp, $sp, 4                                                     # increase stack pointer by 4 bytes to free memory for size of matrix
    mul $t5, $t5, $t5                                                   # $t5 = size of matrix * size of matrix
    sll $t5, $t5, 2                                                     # $t5 = (size of matrix * size of matrix) * 4
    add $sp, $sp, $t5                                                   # increase stack pointer by size of matrix * size of matrix to free memory for cofactor matrix
    
    lw $ra, 0($sp)                                                      # load return address from stack
    add $sp, $sp, 4                                                     # increase stack pointer by 4 bytes to free memory for return address

    jr $ra                                                              # jump to return address $ra

END_DET:
    lw $v0, 0($a1)                                                      # load return value from 1st element of array
    jr $ra                                                              # jump to return address $ra

# function procedure to calculate determinant of a n*n matrix (n passed through $a0)
# starting address passed through $a1
calDeterminant:
    # store value of $ra in stack
    sub $sp, $sp, 4                                                     # decrease stack pointer by 4 bytes to allote memory for argument
    sw $ra, 0($sp)                                                      # store argument in stack

    move $s0, $a0                                                       # move size of matrix to $t0
    move $s1, $a1                                                       # move address of matrix to $t1
    
    li $v0, 4                                                           # system call number 4, as we want to print a string
    la $a0, new_line                                                    # print a new line
    syscall                                                             # system call to print a new line

    li $v0, 4                                                           # system call number 4, as we want to print a string
    la $a0, print_promt                                                 # print matrix A
    syscall                                                             # system call to print a string

    move $a0, $s0                                                       # move size of matrix to $a0
    move $a1, $s0                                                       # move size of matrix to $a1
    move $a2, $s1                                                       # move address of matrix to $a2
    jal printMatrix                                                     # call printMatrix to print matrix

    lw $ra, 0($sp)                                                      # load return address from stack
    add $sp, $sp, 4                                                     # increase stack pointer by 4 bytes to free memory for return address

    move $a0, $s0                                                       # move size of matrix to $a0
    move $a1, $s1                                                       # move address of matrix to $a1

    beq $a0, 1, END_DET                                                 # if size of matrix is 1, go to END_DET

    # store value of $ra in stack
    sub $sp, $sp, 4                                                     # decrease stack pointer by 4 bytes to allote memory for argument
    sw $ra, 0($sp)                                                      # store argument in stack
    
    # pushing 1st argument to the stack
    jal pushToStack                                                     # jump and link to branch pushToStack
    # pushing 2nd argument to the stack
    move $a0, $a1                                                       # move 2nd argument given to calDeterminant function to 1st argument for push to stack function
    jal pushToStack                                                     # jump and link to branch pushToStack

    li $a0, 0                                                           # inititalise value of determinant = 0  
    jal pushToStack                                                     # push value of determinant to stack

    li $a0, 0                                                           # set value of iterator to 0
    jal pushToStack                                                     # push value of iterator to stack

    # now following are the local variables stored in the stack
    # 0($sp) = value of iterator
    # 4($sp) = value of determinant
    # 8($sp) = 1st address of input matrix
    # 12($sp) = size of input matrix
    # 16($sp) = return address

    FOR_DET_I:
        lw $a0, 8($sp)                                                  # move 1st address of input matrix to $a0
        li $a1, 0                                                       # set value of row index to be ignored to 0
        lw $a2, 0($sp)                                                  # move value of iterator to $a2
        lw $a3, 12($sp)                                                 # move size of input matrix to $a3
        jal getCofactor                                                 # call calCofactor function to calculate cofactor of element at row 0 and column i
        
        move $t0, $v0                                                   # move cofactor of element at row 0 and column i to $t0
        lw $t1, 4($sp)                                                  # move value of determinant to $t1
        
        li $a0, -1                                                      # set value of sign to -1
        lw $a1, 0($sp)                                                  # move value of iterator to $a1
        li $a2, 1                                                       # set value of modulo to 1
        jal power                                                       # call power function to calculate (-1)^i
        
        mul $t0, $t0, $v0                                               # multiply result of power function with value of determinant
        
        lw $t2, 0($sp)                                                  # move value of iterator to $t2
        sll $t2, $t2, 2                                                 # $t2 = i * 4
        lw $t3, 8($sp)                                                  # move 1st address of input matrix to $t3 
        add $t3, $t3, $t2                                               # $t3 = 1st address of input matrix + iterator
        lw $t3, 0($t3)                                                  # $t3 = M[1st address of input matrix + iterator]
        mul $t0, $t0, $t3                                               # $t0 = cofactor of element at row 0 and column i * value of determinant * element at row 0 and column i
        
        add $t1, $t1, $t0                                               # $t1 = $t1 + cofactor
        sw $t1, 4($sp)                                                  # move $t0 to value of determinant
        
        lw $t0, 0($sp)                                                  # move value of iterator to $t0
        add $t0, $t0, 1                                                 # $t0 = $t0 + 1
        sw $t0, 0($sp)                                                  # move $t0 to value of iterator
        
        lw $t0, 0($sp)                                                  # move value of iterator to $t0
        lw $t1, 12($sp)                                                 # move size of input matrix to $t1
        blt $t0, $t1, FOR_DET_I                                         # if iterator < size of matrix, go to FOR_DET_I
    
    lw $v0, 4($sp)                                                      # move value of determinant to $v0
    lw $ra, 16($sp)                                                     # load return address from stack
    add $sp, $sp, 20                                                    # increase stack pointer by 20 bytes to free memory for local variables
    jr $ra                                                              # jump to return address $ra

# power mod function, take base (in $a0) and exponent (in $a1) and modulo in ($a2) and return the power of base to the exponent
powerMod:
    li $v0, 1                                                           # set $v0 to 1
    FOR_POW:
        beq $a1, $zero, END_MOD                                         # if exponent is not equal to 0, then continue loop
        div $a0, $a2                                                    # find base % m
        mfhi $v1                                                        # store base % m in $v1
        mul $v0, $v0, $v1                                               # multiply the output with the base 
        div $v0, $a2                                                    # find current product % m
        mfhi $v0                                                        # store modulo in current product
        addi $a1, $a1, -1                                               # decrement exponent by 1
        j FOR_POW                                                       # continue loop
    END_MOD:
        jr $ra                                                          # jump to return address $ra

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

# input for N, A, R and M
    # reading input for n
    li $v0, 5                                                           # system call number 5, as we want to read an integer
    syscall                                                             # system call to read an integer
    move $t0, $v0                                                       # store value of input N from default registor $v0 to $t1
    # checking if input for n is less than 0
    blez $t0, throw_negative                                            # if input for n is less than equal to 0, jump to throw_negative
    # reading input for a
    li $v0, 5                                                           # system call number 5, as we want to read an integer
    syscall                                                             # system call to read an integer
    move $t1, $v0                                                       # store value of input A from default registor $v0 to $t2
    # checking if input for a is less than 0
    blez $t1, throw_negative                                            # if input for a is less than equal to 0, jump to throw_negative
    # reading input for r
    li $v0, 5                                                           # system call number 5, as we want to read an integer
    syscall                                                             # system call to read an integer
    move $t2, $v0                                                       # store value of input R from default registor $v0 to $t3
    # checking if input for r is less than 0
    blez $t2, throw_negative                                            # if input for r is less than equal to 0, jump to throw_negative
    # reading input for m
    li $v0, 5                                                           # system call number 5, as we want to read an integer
    syscall                                                             # system call to read an integer
    move $t3, $v0                                                       # store value of input M from default registor $v0 to $t0
    # checking if input for m is less than 0
    blez $t3, throw_negative                                            # if input for m is less than equal to 0, jump to throw_negative

# storing the inouts n,a,r,m in stack
    # pushing input for n to stack
    move $a0, $t0                                                       # store input N in $a0
    jal pushToStack                                                     # jump and link to branch pushToStack
    # pushing input for a to stack
    move $a0, $t1                                                       # store input A in $a0
    jal pushToStack                                                     # jump and link to branch pushToStack
    # pushing input for r to stack
    move $a0, $t2                                                       # store input R in $a0
    jal pushToStack                                                     # jump and link to branch pushToStack
     # pushing input for m to stack
    move $a0, $t3                                                       # store input M in $a0
    jal pushToStack                                                     # jump and link to branch pushToStack

    # store value of $sp in $s0
    move $s0, $sp                                                       # $s0 = $sp

# calling function mallocInStack to allocate space for n × n matrix in stack
    lw $t0, 12($s0)                                                     # $t0 = n
    mul $a0, $t0, $t0                                                   # $a0 = n * n
    jal mallocInStack                                                   # jump and link to branch mallocInStack

    # storing address of matrix in $s1
    move $s1, $v0                                                       # $s1 = $v0

# population of matrix A by GP with first term a and common ratio r
    li $s3, 0                                                           # $s3 = 0, store iterator i in $s3 
    FOR_GP:
        sll $t1, $s3, 2                                                 # $t1 = $s3 * 4
        add $t1, $s1, $t1                                               # $t1 = $s1 + $t1, $t1 = address of M[i][j]
        lw $a0, 4($s0)                                                  # $a0 = r
        move $a1, $s3                                                   # $a1 = $s3(i)
        lw $a2, 0($s0)                                                  # $a2 = m
        jal powerMod                                                    # jump and link to branch power, $v0 = $a0(r) ^ $a1(i)
        lw $t0, 8($s0)                                                  # $t0 = a
        mul $v0, $v0, $t0                                               # $v0 = $v0 * a  
        lw $t2, 0($s0)                                                  # $t2 = m  
        div $v0, $t2                                                    # $v0 = $v0 % m
        mfhi $v0                                                        # $v0 = $v0 % m
        sw $v0, 0($t1)                                                  # store $v0 in matrix A

        addi $s3, $s3, 1                                                # $s3 = $s3 + 1  (i = i + 1)
        lw $t0, 12($s0)                                                 # $t0 = n
        mul $t0, $t0, $t0                                               # $t0 = n * n   
        blt $s3, $t0, FOR_GP                                            # if i is less than n * n, then continue loop

# printing matrix A
    li $v0, 4                                                           # system call number 4, as we want to print a string
    la $a0, new_line                                                    # print a new line
    syscall                                                             # system call to print a new line

    li $v0, 4                                                           # system call number 4, as we want to print a string
    la $a0, print_promt                                                 # print matrix A
    syscall                                                             # system call to print a string

    lw $a0, 12($s0)                                                     # $a0 = m
    lw $a1, 12($s0)                                                     # $a1 = n
    move $a2, $s1                                                       # $a2 = 1st address of matrix A
    jal printMatrix                                                     # jump and link to branch printMatrix

# determinant calculation
    lw $a0, 12($s0)                                                     # $a0 = n
    move $a1, $s1                                                       # $a1 = 1st address of matrix A
    jal calDeterminant                                                  # jump and link to branch determinant
    move $s2, $v0                                                       # $s2 = $v0
    
    # printing determinant
    li $v0, 4                                                           # system call number 4, as we want to print a string
    la $a0, new_line                                                    # print a new line
    syscall                                                             # system call to print a new line

    # printing a new line
    li $v0, 4                                                           # system call number 4, as we want to print a string
    la $a0, det_promt                                                   # print determinant
    syscall                                                             # system call to print a string

    li $v0, 1                                                           # set $v0 to print an integer
    move $a0, $s2                                                       # $a0 = determinant
    syscall                                                             # print the integer

    # printing a new line
    li $v0, 4                                                           # system call number 4, as we want to print a string
    la $a0, new_line                                                    # print a new line
    syscall                                                             # system call to print a new line

# end of program
    li $v0, 10                                                          # system call number 10, as we want to exit the program
    syscall                                                             # system call to exit the program


