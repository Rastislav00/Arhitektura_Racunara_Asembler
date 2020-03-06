#mnozenje preko sabiranja u jednostrukoj preciznosti
#===================================================

.section .data

	a: .long 6
	b: .long 10


.section .text
.globl main
main:
#===================================================



	movl a, %eax
	movl b, %ebx
	movl %eax, %edx

opet:	addl %edx, %eax
	subl $1, %ebx
	cmpl $1, %ebx
	je kraj
	jmp opet





kraj:
movl $1, %eax
movl $0, %ebx
int $0x80
#=================KRAJ===================


