#========================Vezbanje potprograma unutar asemblera=============
.section .data

	a: .long 10
	b: .long 7

	z: .long 0


.section .text
.globl main
main:
#==============START====================



	movl a, %eax
	movl b, %ebx
	movl $z, %ecx

	pushl %ecx
	pushl %ebx
	pushl %eax

	call program
	addl $12, %esp






kraj:
movl $1, %eax
movl $0, %ebx
int $0x80
#=================KRAJ=============




program:

	
	pushl %ebp
	movl %esp, %ebp
	subl $12, %esp
	pushl %ebx
	pushl %esi


	movl 8(%ebp), %eax
	addl 12(%ebp), %eax




krajP:
	movl 16(%ebp), %ebx
	movl %eax, (%ebx)

	popl %esi
	popl %ebx
	movl %ebp, %esp
	popl %ebp
	ret













