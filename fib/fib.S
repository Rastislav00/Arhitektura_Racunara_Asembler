.section .data

  A = 3
  B = 7

a: .long 0
b: .long 0

suma: .long 0

.section .text
.globl main
main:


#==========FIBONACI============ 
#suma fibonacijevih brojeva od nekog do nekog broja

	movl $A, a		#A i B su nepromenljive koje su fixirane 
	subl $2, a
	
	movl $B, b
	subl $2, b

	
	movl $1, %eax		#tu ce biti rezultat
	movl $1, %ebx
	movl $1, %ecx
	movl $0, %esi
	
	
opet:	movl %eax, %ecx
	addl %ebx, %eax
	movl %ecx, %ebx

	addl $1, %esi
	

cmp_1:	cmpl a, %esi
	jge cmp_2			#jge kada esi bude vece ili jednako od A
	jmp opet

cmp_2:	cmpl b, %esi
	jle zbir			#dok je esi manji ili jednak u odnosu na B
	jmp kraj

zbir:	addl %eax, suma
	jmp opet

	






kraj:
movl $1, %eax
movl $0, %ebx
int $0x80
#==============================

