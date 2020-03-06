#suma svih clanova niza u dvostrukoj preciznosti

.section .data

  niz: .quad 0x6, 0x67, 0x23, 0x74, 0xc5, 0x2d, 0x157b, 0xf, 0x237, 0x3
  duzina = . - niz
  broj = (. - niz)/8

  br: .long 0

  suma: .quad 0x0


.section .text
.globl main
main:

	movl suma, %ecx			#u ecx cu imati manje znacajne brojke sume
	movl suma+4, %edx		#vise znacajne brojke sume
	

	movl $broj, %esi
	movl %esi, br
	addl %esi, br			#dodao sam jos jednom da bi imo duplo vise zato sto mi brojac ide stalno plus dva
	movl $0, %esi

opet:	cmpl %esi, br
	jle kraj		#jle manje ili jednako


	movl niz(,%esi,4), %eax		#manje znacajne brojke niza
	movl niz+4(,%esi,4), %ebx	#vise znacajne brojke sume
	
	addl %eax, %ecx
	adcl %ebx, %edx
	
	addl $2, %esi
	jmp opet










kraj:
movl $1, %eax
movl $0, %ebx
int $0x80






