#Ryan Horoff
#CDA3101 Programming Assignment 2
#Feb 6 2018 - Feb 14 2018

.data
temp:   .word   1#temp variable
result: .word   1#result variable
x:  .word   0#base
k:  .word   0#exponent
n:  .word   0#modulo
getX: .asciiz "Enter the first integer x: "
getK: .asciiz "Enter the second integer k: "
getN: .asciiz "Enter the third integer n: "
printResult: .asciiz "The result of x^k mod n = "




.text

main:
    li $v0, 4 #Load print string to function result register
    la $a0, getX #Load string into argument register
    syscall #Print string 

    li $v0,5 #Load read int to function result register
    syscall #Read int
    sw $v0, x #Store the value of x

    li $v0, 4 #Load print string to function result register
    la $a0, getK #Load string into argument register
    syscall #Print string 

    li $v0,5 #Load read int to function result register
    syscall #Read int
    sw $v0, k #Store the value of k

    li $v0, 4 #Load print string to function result register
    la $a0, getN #Load string into argument register
    syscall #Print string 

    li $v0,5 #Load read int to function result register
    syscall #Read int
    sw $v0, n #Store the value of n

    lw $s0, x #Load x into s0
    lw $s1, k #Load k into s1
    lw $s2, n #Load n into s2
    lw $t0, temp
    lw $t1, result
    lw $s4, k #keep a global k for final method return
    addi $t5, $t5, 2
    
    jal FME
    
    
    jal calcResult
    
    
    li $v0, 4 #Load print string to function result register
    la $a0, printResult #Load string into argument register
    syscall #Print string 
    
    li $v0,1 #Load print int to function result register
    move $a0, $t1 #move result into argument register
    syscall#Print number
    
    li $v0, 10
    syscall
    
FME:
    bne $s1, $zero, FMERecursion #If base case is not met, jump to recursive step
    jr $ra #Start going back up recursive calls
    
FMERecursion:
    addi $sp, $sp, -16 #Add 4 spaces to the stack
    sw $ra, 0($sp) #Store return address
    sw $s1, 4($sp) #Store k
    sw $t0, 8($sp) #store temp
    sw $t1 12($sp) #store result
     
    
    div $s1, $t5 #Divide k by 2
    mflo $s1 #Store the new k in s1
    jal FME #Recursively call FME, final return address will be here
    div $s1, $t5 #Store division again
    mfhi $s3

    
    addi $t2, $zero, 1 #Set condition for if (k % 2 == 1)
    beq $s3, $t2, kmod2is1 #If k % 2 == 1
    jal calcResult
    
kmod2is1:#If we have to store a result other than 1
    div $s0, $s2#change the current result to x mod n
    mfhi $t1 #Store current result as x mod n
    
    jal calcResult
    
calcResult:
    beq $s1, $s4, recursiveReturn
    mul $t1, $t1, $t0# result = result * temp
    mul $t1, $t1, $t0# * temp
    div $t1, $s2 #divide for modulo n
    mfhi $t1 #store modulo n in result register
    
    
    lw $ra, 0($sp) #Load return address
    lw $s1, 4($sp) #Load k
    move $t0, $t1 #Store result as the temp for the next highest recursive call
    lw $t1, 12($sp) #Load result 
    addi $sp, $sp, 16
    
    jr $ra
    

recursiveReturn:
    mul $t1, $t1, $t0# result = result * temp
    mul $t1, $t1, $t0# * temp
    div $t1, $s2 #divide for modulo n
    mfhi $t1 #store modulo n in result register
    jr $ra
    
    
    
    
    
    


        
    








