#int brojParnihSamoglasnika(char* str);
.section .text
.globl brojParnihSamoglasnika
brojParnihSamoglasnika:

	pushl %ebp
	movl %esp, %ebp
	pushl %esi

	movl $0, %esi
	movl $0, %ecx				#da u ecx imam sigurno 0
	movl 8(%ebp), %edx			#u edx imamo adresu stringa
	movl $0, -4(%ebp)			#u -4(%ebp) broj reci sa parnim samoglasnika
	movl $0, -8(%ebp)			#broj samoglasnika po reci

opet:	movb (%edx, %esi, 1), %cl
		
cmp:	cmpb $0, %cl
		je izuzetak_analiza

		cmpb $'a', %cl
		je SG
		cmpb $'e', %cl
		je SG
		cmpb $'i', %cl
		je SG
		cmpb $'o', %cl
		je SG
		cmpb $'u', %cl
		je SG

		cmpb $'A', %cl
		je SG
		cmpb $'E', %cl
		je SG
		cmpb $'I', %cl
		je SG
		cmpb $'O', %cl
		je SG
		cmpb $'U', %cl
		je SG

		cmpb $' ', %cl
		je separator
		cmpb $'.', %cl
		je separator
		cmpb $',', %cl
		je separator

		addl $1, %esi
		jmp opet

SG:		addl $1, %esi
		addl $1, -8(%ebp)		#broj samoglasnika po reci
		jmp opet

separator:
		addl $1, %esi
		movb (%edx, %esi, 1), %cl
		cmpb $' ', %cl
		je opet
		cmpb $'.', %cl
		je opet
		cmpb $',', %cl
		je opet
		jmp analiza





analiza:

		shrl $1, -8(%ebp)		#siftujemo broj samoglasnika
		movl $0, -8(%ebp)  		#nuliramo ovaj broj
		jc opet					#jc (c=1) neparan broj
		addl $1, -4(%ebp)		#uvecavamo, u -4(%ebp) broj reci sa parnim samoglasnika
		jmp opet


izuzetak_analiza:
		
		shrl $1, -8(%ebp)
		jc krajP
		addl $1, -4(%ebp)
		jmp krajP


krajP:
movl -4(%ebp), %eax
popl %esi
movl %ebp, %esp
popl %ebp
ret

