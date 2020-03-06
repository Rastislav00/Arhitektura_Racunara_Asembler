.section .data
.section .text
.global main
main:

	movl $0, %eax
	movl $1, %ebx
	movl $1, %ecx

ponovo:	
	movl %ebx, %ecx
	addl %eax, %ebx
	movl %ebx, %eax
	addl %ecx, %ebx
	

	jmp ponovo




exit:
movl $1, %eax
movl $0, %ebx
int $0x80

