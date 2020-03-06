#===============potprogram============
#int alg(int *niz, int br);
.section .text
.globl alg
alg:
#================START================
	pushl %ebp
	movl %esp, %ebp
	pushl %esi
	pushl %ebx
	pushl %edi

	
	movl $0, %esi				#brojac esi

	movl $0, -4(%ebp)			#broj jedinica
	movl $0, -8(%ebp)			#broj nula
	movl $0, -12(%ebp)			#broj elemenata sa istim brojem 0 i 1

	movl 12(%ebp), %edi			#broj elemenata imamo u edi
	subl $1, %edi				#n-1
	movl 8(%ebp), %edx			#adresa prvog el niza u edx

	movl $1, %ebx				#maska u ebx
	jmp opet

sledeci:movl $1, %ebx				#maska u ebx
		addl $1, %esi
		cmpl %esi, %edi
		je krajP
opet:	movl (%edx,%esi,4), %eax	#elemente niza emo imati uvek u eax

		andl %ebx, %eax
		cmpl $0, %eax				
		je nula
		addl $1, -4(%ebp)			#broj jedinica
		jmp shift
nula:	addl $1, -8(%ebp)			#broj nula

shift:	shll %ebx
		cmpl $0, %ebx
		je analiza
		jmp opet


analiza:					#treba uporediti br jedinica i br nula
							#i dejstvovati po tome


		movl -4(%ebp), %ecx
		cmpl -8(%ebp), %ecx
		je isto
		jg vise_jedinica		#jg vece, broj jedinica veci od br nula
		jl vise_nula			#jl manje znaci manje jedinica a visen ula

isto:	addl $1, -12(%ebp)
	jmp dalje

vise_jedinica:
	movl (%edx,%esi,4), %eax
	xorl $1, %eax
	jmp dalje


vise_nula:		#treba invertovati sve bite
	movl (%edx,%esi,4), %eax
	xorl $0xffffffff, %eax				#invertovanje svih bita
	jmp dalje



dalje:

	jmp sledeci


#=============================
krajP:
movl -12(%ebp), %eax		#u eax povratna adresa neizmenjih brojeva
popl %edi
popl %ebx
popl %esi
movl %ebp, %esp
popl %ebp
ret
#============KRAJ=============