.section .data
.section .text
.global main
main:

				#mnozenje 3 broja preko sabiranja
	
	movl $56, %eax		#eax resenje
	movl $14, %ebx
	movl $7, %edx
	movl %eax, %ecx

ponovo:	addl %ecx, %eax
	subl $1, %ebx
	cmpl $1, %ebx
	je zamena
	jmp ponovo

zamena: movl %eax, %ebx
	jmp next
	
next:   addl %ebx, %eax
	subl $1, %edx
	cmpl $1, %edx
	je exit
	jmp next



exit:
movl $1, %eax
movl $0, %ebx
int $0x80


