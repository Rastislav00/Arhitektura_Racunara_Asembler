#interni u string
.section .text
.globl ItoS
ItoS:
#(string, broj, m)

	pushl %ebp
	movl %esp, %ebp

	pushl %esi
	pushl %edi
	pushl %ebx

	movl $0, %edx 				#zbog deljenja
	movl $10, %esi 				#baza 10
	movl 8(%ebp), %ecx 			#adresa stringa
	movl 12(%ebp), %eax 		#broj u eax



konv:	divl %esi 					#eax/esi = eax, ostatak u edx
		addb $'0', %dl 				#dobijanje ascii brojeva

		movb %dl, (%ecx) 			#stavljanje karaktera u string
		addl $1, %ecx 				#pristupi sl el stringa
		movl $0, %edx

		cmpl $0, %eax
		je obrni
		jmp konv


obrni:	movb $0, (%ecx) 			#stavljamo nul terminato
		subl $1, %ecx 				#prethodno nul terminatoru cifra 
		movl $0, %ebx 				#zbog bl
		movl $0, %edx 				#zbog dl
		movl 8(%ebp), %edi 			#adresa na pocetak stringa


	algO:	movb (%edi), %bl
			movb (%ecx), %dl 

			movb %bl, (%ecx)
			movb %dl, (%edi)

			addl $1, %edi
			subl $1, %ecx

			cmpl %edi, %ecx
			jle krajO 				#jle manje ili jednako
			jmp algO


krajO:

#treba jos prebrojati bafer tj m

	movl 8(%ebp), %ecx 		#adresa pocetka
	movl $0, %ebx
	movl 16(%ebp), %edx


broji:	movb (%ecx), %bl
		cmpb $0, %bl
		je krajP
		addl $1, %ecx
		addl $1, (%edx)
		jmp broji



krajP:
popl %ebx
popl %edi
popl %esi
movl %ebp, %esp
popl %ebp
ret

