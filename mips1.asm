.data

msg1: .asciiz "Enter first number: "
msg2: .asciiz "Enter second number: "

menu: .asciiz "\nChoose operation:\n1. Addition\n2. Subtraction\n3. Multiplication\n4. Division\nEnter choice: "

resultMsg: .asciiz "\nResult = "

invalidMsg: .asciiz "\nInvalid operation!\n"

divZeroMsg: .asciiz "\nError: Division by zero!\n"

againMsg: .asciiz "\nChoose:\n1. New Operation\n2. Exit\nEnter choice: "

invalidChoice: .asciiz "\nInvalid choice! Please enter 1 or 2.\n"

exitMsg: .asciiz "\nProgram ended. Last result = "

.text
.globl main

main:

# First Number
li $v0, 4
la $a0, msg1
syscall

li $v0, 5
syscall
move $t0, $v0

# Second Number
li $v0, 4
la $a0, msg2
syscall

li $v0, 5
syscall
move $t1, $v0

# Menu
li $v0, 4
la $a0, menu
syscall

li $v0, 5
syscall
move $t2, $v0

# Check Operation
beq $t2, 1, addition
beq $t2, 2, subtraction
beq $t2, 3, multiplication
beq $t2, 4, division

j invalidOperation

# Addition
addition:
add $t3, $t0, $t1
j printResult

# Subtraction
subtraction:
sub $t3, $t0, $t1
j printResult

# Multiplication
multiplication:
mul $t3, $t0, $t1
j printResult

# Division
division:

beq $t1, $zero, divZero

div $t0, $t1
mflo $t3

j printResult

# Division by Zero
divZero:
li $v0, 4
la $a0, divZeroMsg
syscall

j askAgain

# Invalid Operation
invalidOperation:
li $v0, 4
la $a0, invalidMsg
syscall

j askAgain

# Print Result
printResult:

li $v0, 4
la $a0, resultMsg
syscall

li $v0, 1
move $a0, $t3
syscall

# Ask Again
askAgain:

li $v0, 4
la $a0, againMsg
syscall

li $v0, 5
syscall
move $t4, $v0

beq $t4, 1, main
beq $t4, 2, exitProgram

li $v0, 4
la $a0, invalidChoice
syscall

j askAgain

# Exit Program
exitProgram:

li $v0, 4
la $a0, exitMsg
syscall

li $v0, 1
move $a0, $t3
syscall

li $v0, 10
syscall
