#niz[]=(3,7,4,8,1)
#int alg(int niz[]);

.section .text
.globl alg
alg:


	pushl %ebp
	movl %esp, %ebp


	movl 8(%ebp), %eax		#adresa niza u eax

	movl (%eax), %ecx
	addl 4(%eax), %ecx
	addl 8(%eax), %ecx
	addl 12(%eax), %ecx
	addl 16(%eax), %ecx

	movl %ecx, %eax


krajP:
movl %ebp, %esp
popl %ebp
ret

