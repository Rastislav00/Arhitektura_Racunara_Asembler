.section .text
.globl fakt
fakt:

	pushl %ebp
	movl %esp, %ebp
	pushl %ebx			#koristicemo ebx pa treba nam njegova vrednost stara

	movl 8(%ebp), %eax		#sad u eax imam prvi parametar iz funkcije fakt iz c
	
		#faktorijal

	movl %eax, %ebx    #brojac
	movl %eax, %ecx

for:    subl $1, %ebx
	cmpl $1, %ebx
	movl %ebx, %edx
	je exit
	jmp ponovo		



ponovo:	addl %ecx, %eax			#nama se u eax cuva taman ono sto nam i treba :D jes
	subl $1, %edx
	cmpl $1, %edx
	je next
	jmp ponovo

next:   movl %eax, %ecx
	jmp for
	

exit:	popl %ebx
	movl %ebp, %esp
	popl %ebp
	ret
	







