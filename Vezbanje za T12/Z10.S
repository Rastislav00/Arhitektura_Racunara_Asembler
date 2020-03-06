#zadata dva niza sa istim brojem elemenata treba u novi niz smestiti elemente koji se nalaze u nizu 1 a ne nalaze u nizu 2
#=========================================================================================================================
.section .data

	A: .quad 0x7, 0x9, 0x5, 0x3
	B: .quad 0x5, 0x6, 0x3, 0x8

	str_len = . - A					#broj bajtova
	br_len = (. - A)/8				#broj elemenata
	n: .long 0					#ovde cu da drzim broj elemenata
	c: .quad 0x1, 0x1, 0x1, 0x1
				

.section .text
.globl main
main:
#====================================================

	movl br_len, %eax
	movl %eax, n			#sada u n imamo broj clanova u nizu




	movl $0, %esi
	movl $0, %edi


opet1:	movl A(,%esi,8), %eax			#manje znacajne
	movl A+4(,%esi,8), %ebx			#vise znacajne


opet2:	movl B(,%edi,8), %ecx
	movl B+4(,%edi,8), %edx


	cmpl %eax, %ecx
	jne 				#jne nije jednako
	cmpl %ebx, %edx				#ovo ce se desiti samo ako su jednaki
	je





















kraj:
movl $1, %eax
movl $0, %ebx
int $0x80
