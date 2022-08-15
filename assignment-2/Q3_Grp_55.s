# assignment number: 2
# problem number: 3
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
input_promt: .asciiz "Enter four positive integers m, n, a and r: "
error_message: .asciiz "Error: Invalid input"
product_promt: .asciiz "Product of the two numbers are: "
new_line: .asciiz "\n"
############ data declarations #############


############ program instructions #############
# text section contains program instructions
.text
# program variables: