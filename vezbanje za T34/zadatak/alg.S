#	int RazmeniBit(unsigned short *A, unsigned N);
.section .text
.globl RazmeniBit
RazmeniBit:


	pushl %ebp
	movl %esp, %ebp
	pushl %ebx
	pushl %esi
	pushl %edi

	movl $0, %ecx
	movw $1, %cx				#cx maska
	movl $0, -4(%ebp)			#na -4(%ebp) cu da drzim broj jedinica 
	movl $0, -8(%ebp)			#broj el niza koji imaju paran broj jedinica
	movl $0, %ebx
	movl $0, %esi				#esi brojac

	movl 12(%ebp), %edi			#na 12(%ebp) imam broj elemenata niza sada je i na %edi
	movl 8(%ebp), %edx			#adresa pocetka niza u edx

opet:	movw (%edx,%esi,2), %bx		#prvi clan niza u bx
		andw %cx, %bx				#cx je maska
		cmpw $0, %bx
		je shift						#nije jednako
		addl $1, -4(%ebp)				#ovo se desi ako nije nula na ebx nakon operacije and

shift:	shlw $1, %cx					#siftujem cx za jedno mesto u levo
		cmpw $0, %cx					#ako je nula na cx znaci da smo isiftali 16bitne br
		je analiza
		jmp opet

analiza:
		shrl -4(%ebp)			#pomeri u desno i u carry dodje manje znacajan bit 0 ili 1
		jc neparni				#jc jump for carry skoci za prenost (c=1)
		jnc parni				#jnc nije prenos tj (c=0)


parni:							#prva 3 i poslednja 3 bita inverotavati
		addl $1, -8(%ebp)		#u lokalnoj promenljivoj -8(%ebp) cuvam broj el niza sa parnim br jed
		movw (%edx,%esi,2), %bx
		xorw $0xe007, %bx		#0xe007 == 1110000000000111, invertovanje reci (word)w
		movw %bx, (%edx,%esi,2)	#na ovaj nacin sam upisao tu vrednost nazad
		jmp sledeci

neparni:						#invertovati prvi i zadni bit
		movw (%edx,%esi,2), %bx
		xorw $0x8001, %bx		#invertujem sa maskom $0x8001 == 1000000000000001
		movw %bx, (%edx,%esi,2)
		jmp sledeci



sledeci:
		movl $0, -4(%ebp)			#anuliranje brojaca parnosti ili neparnosti
		movw $1, %cx				#cx maska
		addl $1, %esi				#da bi pristupili sledecem el niza
		cmpl %edi, %esi				#u edi nam je broj elemenata niza, kad sve lepo ispucamo kraj
		je krajP		
		jmp opet



krajP:
	movl -8(%ebp), %eax				#povratna vrednost broj el niza sa parnim brojem jedinica
	popl %edi
	popl %esi
	popl %ebx
	movl %ebp, %esp
	popl %ebp
	ret


