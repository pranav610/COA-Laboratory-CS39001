# assignment number: 2
# problem number: 1
# semester: autumn 2022-23
# grouop_name = "Group 55"
# group_members = ["Kulkarni Pranav Suryakant", "Vineet Amol Pipal"]

# This program will take two 16-bit integers from the user.
# Then the program will calculate their product using the 
# Booth's Multiplication Algorithm


############ global variables #############
# globl will make main symbol accessible from outside the current file
.globl main 
############ global variables #############


############ data declarations #############
# declares variable names used in program; storage allocated in main memory (RAM)
.data
input_promt_1: .asciiz "Enter first number: "
input_promt_2: .asciiz "Enter second number: "
error_message: .asciiz "Error: Invalid input"
product_promt: .asciiz "Product of the two numbers are: "
new_line: .asciiz "\n"
############ data declarations #############


############ program instructions #############
# text section contains program instructions
.text

# program variables:
# input argument1, multiplicand (M): $a0
# iutput argument2, multiplier (Q): $a1
# final prodcut : $v0

# branch to print product after calculation
print_product:
    sub $v0, $zero, $v0
    move $s0, $v0                                                   # move product to $s0

    # print the promt before printing the product
    li $v0, 4
    la $a0, product_promt
    syscall

    li $v0, 1                                                       # system call number 1, as we want to print a int
    move $a0, $s0                                                   # $a0 = $s0, store integere in $a0
    syscall                                                         # system call to print a integer  

    # print new line character after printing the product
    li $v0, 4
    la $a0, new_line
    syscall

    # end of program
    li      $v0, 10         # terminate the program
    syscall

product_is_zero:
    li      $v0, 1     
    move $a0, $zero                                                 # $a0 = 0, store integere in $a0
    syscall                                                         # system call to print a integer   

    # end of program
    li      $v0, 10         # terminate the program
    syscall

# branch to calculate product using Booth's algorithm
multiply_booth:
    # .if M or Q is 0, then product is 0
    beq $a0, $zero, product_is_zero                                 # if $a0 is 0, then goto product_is_zero
    beq $a1, $zero, product_is_zero                                 # if $a1 is 0, then goto product_is_zero

    # convert input to 16-bit 2s complement form

    # storing MSB
    srl $s0, $a0, 31                                                # shift right logical $a0 by 31 bits, this will give us the sign bit              
    sll $s0, $s0, 15                                                # shift left logical $s0 by 15 bits, this will give us the sign bit at 16bit MSB
    
    # keeping only 1st 15 bits
    sll $a0, $a0, 17                                                # shift left logical $a0 by 17 bits, this will eliminate 1st 17 bits of the input
    srl $a0, $a0, 17                                                # shift right logical $a0 by 17 bits, this will give us the 1st 15 bits of the input

    # $s0 is the sign bit at 16bit MSB
    add $a0, $a0, $s0                                               # add $s0 to $a0, this will give us the 1st 15 bits of the input with sign bit at 16bit MSB

    # storing MSB
    srl $s0, $a1, 31                                                # shift right logical $a1 by 31 bits, this will give us the sign bit
    sll $s0, $s0, 15                                                # shift left logical $s0 by 15 bits, this will give us the sign bit at 16bit MSB

    # keeping only 1st 15 bits
    sll $a1, $a1, 17                                                # shift left logical $a1 by 17 bits, this will eliminate 1st 17 bits of the input
    srl $a1, $a1, 17                                                # shift right logical $a1 by 17 bits, this will give us the 1st 15 bits of the input

    # $s0 is the sign bit at 16bit MSB
    add $a1, $a1, $s0                                               # add $s0 to $a1, this will give us the 1st 15 bits of the input with sign bit at 16bit MSB

    # move 16 bits of Q to left by 16 bits
    sll $a1, $a1, 16                                                # shift left logical $a1 by 1 bit, this will make multiplicand at 1st 16 bits

    # $t0 to store counts
    # $t1 to store previous LSB
    # $t2 to store current LSB
    li $t0, 1                                                       # $t0 will store the count of iterations
    li $t1, 0                                                       # previous LSB set to 0

    # set product to $v0
    move $v0, $a0                                                   # $v0 = $a0, store integere in $v0

    FOR:
        bgt $t0, 16, print_product                                  # if $t0 is greater than 16, then jump to print_product
        add $t0, $t0, 1                                             # else add 1 to $t0

        sll $t2, $v0, 31                                            # shift left logical $v0 by 31 bits, this will give us LSB of multiplier at MSB
        srl $t2, $t2, 31                                            # shift right logical $t2 by 31 bits, this will give us LSB of multiplier at proper position

        # now we have previous LSB stored in $t1 and current LSB stored in $t2

        # check for cases 00,01,10,11
        xor $t3, $t1, $t2                                           # XOR $t1 and $t2

        # for cases 00 & 11 xor($t3) will have value 0
        beq $t3, $zero, perform_asr                                 # if $t3 is equal to 0, then jump to perform_asr
        beq $t2, $zero, add_multiplicand                            # if $t2 is equal to 0, then jump to add_multiplicand

    # branch for case 10
    sub_multiplicand:
        sub $v0, $v0, $a1                                           # subtract $a1 from $v0
        j perform_asr                                               # jump to perform_asr 

    
    # branch for case 01
    add_multiplicand:
        add $v0, $v0, $a1                                           # add $a1 to $a0, this will give us the next 16 bits of the input
        j perform_asr                                               # jump to perform_asr


    # branch for performing ASR operation on the product
    perform_asr:
        # 1st store MSB of $v0 in $t3
        srl $t3, $v0, 31                                            # shift $v0 to the right by 31 bits
        sll $t3, $t3, 31                                            # shift $t3 to the left by 31 bits

        srl $v0, $v0, 1                                             # shift $v0 to the right by 1 bit
        add $v0, $v0, $t3                                           # add $t3 to $a0

        # update previous LSB
        move $t2, $t1                                               # $t2(LSB of previous product) = $t1(previos LSB)

        j FOR                                                       # jump to FOR loop


# branch for printing warning after entering non 16-bit number
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

# branch multiply_booth, this branch will take arguments from $a0, $a1 
# and calculate their product using booth's algorithm and store result in $v0

# main program
main:
    # making first system call to display prompt for asking input for M
    li $v0, 4                                                       # system call number 4, as we want to print a string
    la $a0, input_promt_1                                           # store the string to be printed in $a0
    syscall                                                         # system call to print the string

    # reading input for M
    li $v0, 5                                                       # system call number 5, as we want to read an integer
    syscall                                                         # system call to read an integer
    move $s0, $v0                                                   # store value of input M from default registor $v0 to $a0

    # checking if input is 16-bit number
    li $s2, 1                                                       # $s2 = 1
    sll $s2, $s2, 15                                                # $s2 = 1 << 15
    sub $s2, $s2, 1                                                 # $s2 = 2^15 - 1 (uppper limit for 16-bit signed integer)
    bgt $s0, $s2, throw_error                                       # if $s0 > $s2 goto throw_error
    
    li $s3, -1                                                      # $s3 = -1
    sub $s2, $s3, $s2                                               # $s2 = -2^15 (lower limit for 16-bit signed integer)
    blt $s0, $s2, throw_error                                       # if $s0 < $s2 goto throw_error
    
    # making second system call to display prompt for asking input for Q
    li $v0, 4                                                       # system call number 4, as we want to print a string
    la $a0, input_promt_2                                           # store the string to be printed in $a0
    syscall                                                         # system call to print the string

    # reading input for Q
    li $v0, 5                                                       # system call number 5, as we want to read an integer
    syscall                                                         # system call to read an integer
    move $s1, $v0                                                   # store value of input Q from default registor $v0 to $a1

    # checking if input is 16-bit number
    li $s2, 1                                                       # $s2 = 1
    sll $s2, $s2, 15                                                # $s2 = 1 << 15
    sub $s2, $s2, 1                                                 # $s2 = 2^15 - 1 (uppper limit for 16-bit signed integer)
    bgt $s1, $s2, throw_error                                       # if $s1 > $s2 goto throw_error

    li $s3, -1                                                      # $s3 = 1
    sub $s2, $s3, $s2                                               # $s2 = -2^15 (lower limit for 16-bit signed integer)
    blt $s1, $s2, throw_error                                       # if $s1 < $s2 goto throw_error

    # calculating product of M and Q using Booth's algorithm
    move $a0, $s0                                                   # $a0 = $s0, provide 1st argument as $s0
    move $a1, $s1                                                   # $a1 = $s1, provide 2nd argument as $s1
    j multiply_booth

    
    # end of program
    li      $v0, 10         # terminate the program
    syscall
