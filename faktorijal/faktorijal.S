.section .data
.section .text
.global main
main:

		#faktorijal

	movl $7, %eax
	movl %eax, %ebx    #brojac
	movl %eax, %ecx

for:    subl $1, %ebx
	cmpl $1, %ebx
	movl %ebx, %edx
	je exit
	jmp ponovo		



ponovo:	addl %ecx, %eax
	subl $1, %edx
	cmpl $1, %edx
	je next
	jmp ponovo

next:   movl %eax, %ecx
	jmp for
	






exit:
movl $1, %eax
movl $0, %ebx
int $0x80

