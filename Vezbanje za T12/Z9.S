#mnozenje preko sabiranja u dvostrukoj preciznosti
#==================================================

.section .data

	a: .quad 0x110000035
	b: .quad 0x100000008


.section .text
.globl main
main:
#=====================POCETAK=====================



	movl a, %eax
	movl a+4, %ebx

	movl b, %ecx
	movl b+4, %edx

	subl $1, %ecx	
	sbbl $0, %edx


	
opet:	cmpl $0, %ecx
	jle dalje1			#jle manje ili jednako
	cmpl $0, %edx
	je kraj

dalje1:	addl a, %eax
	adcl a+4, %ebx

	subl $1, %ecx
	sbbl $0, %edx
	jmp opet


kraj:
movl $1, %eax
movl $0, %ebx
int $0x80
#===================KRAJ==================
