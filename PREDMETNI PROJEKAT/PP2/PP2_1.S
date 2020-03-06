.section .text
#iz stringa u interni
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.globl StoI
StoI:
#(Nstr, N)


	pushl %ebp
	movl %esp, %ebp

	subl $8, %esp 	#??

	pushl %esi
	pushl %ebx

		movl $0, %ebx 				#zbog bl 
		movl $0, %edx 				#zbog mnozenja
		movl $0, %eax  				#rezultat konverije 
		movl $10, %esi 				#baza 10 u esi
		movl 8(%ebp), %ecx 			#adresa stringa

	konv:	movb (%ecx), %bl
			cmpb $10, %bl 
			je krajK 				#kraj konverzije

			subb $'0', %bl 			#da bi dobio prave cifre

			mull %esi 				#eax*esi = edx:eax
			addl %ebx, %eax 

			addl $1, %ecx
			jmp konv 


krajK:	movl 12(%ebp), %edx 		#adresu lokacije promenljive N
		movl %eax, (%edx) 			#stavljanje vrednosti na lokaciju N

krajP:

popl %ebx
popl %esi
movl %ebp, %esp
popl %ebp
ret

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#interni broj u string
.globl ItoS
ItoS:
	#($brstr, br)

	pushl %ebp
	movl %esp, %ebp

	pushl %esi 
	pushl %ebx

	movl $0, %ebx 			#zbog bl
	movl $10, %esi 			#baza
	movl $0, %edx 			#ostatak pri deljenju
	movl 8(%ebp), %ecx		#ecx adresa stringa
	movl 12(%ebp), %eax 	#broj


konv1:	divl %esi 			#eax/esi = eax , ostatak u edx 
		addb $'0', %dl 		#da bi dobio ascii karakter

		cmpb $0, (%ecx)
		je krajK1

		movb %dl, (%ecx)
		addl $1, %ecx 		#pristupanje sl karakteru stringa
		movl $0, %edx 		#ciscenje edx

		cmpl $0, %eax 		#ako imamo nulu na eax 
		je krajK2

		jmp konv1



krajK1: #treba obrnuti string
		subl $1, %ecx 		#da ne bi pokazivali vise na \0

krajK2: movl 8(%ebp), %eax
		movl $0, %ebx
		movl $0, %edx


obrni1:	movb (%eax), %bl
		movb (%ecx), %dl

		movb %bl, (%ecx)
		movb %dl, (%eax)

		addl $1, %eax
		subl $1, %ecx

		cmpl %eax, %ecx
		jle krajP1

		jmp obrni1



krajP1:

popl %ebx
popl %esi
movl %ebp, %esp
popl %ebp
ret







