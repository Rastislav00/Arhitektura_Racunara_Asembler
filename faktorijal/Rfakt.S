.section .data
.section .text
.global main
main:

		#faktorijal pomocu drugih registara
		#registari ebp i esp su cudni

	movl $7, %ebp
	movl %ebp, %esi    #brojac
	movl %ebp, %edi

for:    subl $1, %esi
	cmpl $1, %esi
	movl %esi, %esp
	je exit
	jmp ponovo		



ponovo:	addl %edi, %ebp
	subl $1, %esp
	cmpl $1, %esp
	je next
	jmp ponovo

next:   movl %ebp, %edi
	jmp for
	






exit:
movl $1, %eax
movl $0, %ebx
int $0x80

