.data
input:.asciiz "number X="
textA:.asciiz "primeA is:"
textB:.asciiz "\nprimeB is:"
.text
.globl main
main:
	li $v0,4
	la $a0,input
	syscall
	li $v0,5
	syscall
	add $t1,$zero,$v0

#A
	sub $t2,$t1,1
loopA:
	div $t3,$t2,2
	add $t3,$t3,1
	add $t4,$zero,2
loop1:
	rem $t0,$t2,$t4
	beq $t4,$t2,Aisprime
	add $t4,$t4,1
	beq $t0,$zero,Anotprime
	beq $t4,$t3,Aisprime
	j loop1
Anotprime:
	sub $t2,$t2,1
	j loopA

Aisprime:
#B
	add $t4,$t1,1
loopB:
	div $t5,$t4,2
	add $t5,$t5,1
	add $t6,$zero,2
loop2:
	rem $t0,$t4,$t6
	add $t6,$t6,1
	beq $t0,$zero,Bnotprime
	beq $t6,$t5,Bisprime
	j loop2
Bnotprime:
	add $t4,$t4,1
	j loopB
Bisprime:
#Ans
	li $v0,4
	la $a0,textA
	syscall
	add $a0,$zero $t2
	li $v0,1
	syscall
	li $v0,4
	la $a0,textB
	syscall
	add $a0,$zero $t4
	li $v0,1
	syscall
	li $v0,10
	syscall
	

