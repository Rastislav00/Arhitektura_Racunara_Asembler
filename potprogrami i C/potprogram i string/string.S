.section .data

	rec: .ascii "programiranje u asembleru\0"
	str_len = . - rec

.section .text
.globl main
main:

	movl rec, %eax			#adresa stringa u eax

	pushl %eax
	call alg







kraj:
movl $1, %eax
movl $0, %ebx
int $0x80





alg:

	pushl %ebp
	movl %esp, %ebp

	movl 8(%ebp), %edx
	movl 12(%ebp), %edx
	movl 16(%ebp), %edx
	movl 20(%ebp), %edx










krajP:
movl %ebp, %esp
popl %ebp
ret









