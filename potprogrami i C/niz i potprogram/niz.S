.section .data

	niz: .long 3,7,2,8,9,46,84,23,36,73


.section .text
.globl main
main:

	pushl niz+8
	pushl niz+4
	pushl niz

	call alg
	addl $40, %esp













kraj:
movl $1, %eax
movl $0, %ebx
int $0x80




alg:

	pushl %ebp
	movl %esp, %ebp

	movl 8(%ebp), %eax
	movl 12(%ebp), %eax
	movl 16(%ebp), %eax
	movl 20(%ebp), %eax





krajP:

movl %ebp, %esp
popl %ebp
ret






