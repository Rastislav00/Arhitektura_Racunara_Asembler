#int broj(long long *A);
.section .text
.globl broj
broj:

	pushl %ebp
	movl %esp, %ebp
	pushl %ebx

	movl $0, -4(%ebp)			#broj jedinica pojavljenih u broju
	movl $1, -8(%ebp)			#brojac, ovo cu da koristim da znam kad sam preso na vise znacajne bite
	subl $8, %esp

	movl 12(%ebp), %ebx 		#u ebx imam adresu one vrednosti
	movl 8(%ebp), %edx			#u edx imam adresu 64bitnog broja
	movl $1, %ecx   			#maska u ecx

opet:	movl (%edx), %eax		#manje znacajnih 4bajta u eax
		andl %ecx, %eax				
		cmpl $0, %eax
		je shift
		addl $1, -4(%ebp)		#brojac pojavlijvanja jedinica

shift:	shll $1, %ecx 			
		cmpl $0, %ecx
		jne opet 				#jne nije jednako
		addl $4, %edx 			#ovako cemo da pristupimo vise znacajnim bajtovima broja
		movl $1, %ecx			#vracanje maske na pocetak
		cmpl $0, -8(%ebp)
		je alg
		subl $1, -8(%ebp)		#ovako osiguvam da ce se ovo desiti samo jednom
		jmp opet

alg:	#u ovom momentu mi na -4(%ebp) imamo broj pojavljivanja 1 ok super
		movl $0, %edx			#aniliranje edx (visi deo)
		movl $0, %eax			#da bi anulirali eax (nizi deo)
		movl $0, %ecx  			#da bi anulira oregistar ecx (lopata brate :D)
		
		movw (%ebx), %cx		#najmanje znacajna 2 bajta
		orw -4(%ebp), %cx
		addl %ecx, %eax
		adcl $0, %edx			#ako dodje do prenosa :D

		movw 2(%ebx), %cx
		orw -4(%ebp), %cx
		addl %ecx, %eax
		adcl $0, %edx

		movw 4(%ebx), %cx
		orw -4(%ebp), %cx
		addl %ecx, %eax
		adcl $0, %edx

		movw 6(%ebx), %cx
		orw -4(%ebp), %cx
		addl %ecx, %eax
		adcl $0, %edx

		movl %eax, (%ebx)		#stavljanje vrednosti na adresu
		movl %edx, 4(%ebx)



krajP:
movl -4(%ebp), %eax
popl %ebx
movl %ebp, %esp
popl %ebp
ret