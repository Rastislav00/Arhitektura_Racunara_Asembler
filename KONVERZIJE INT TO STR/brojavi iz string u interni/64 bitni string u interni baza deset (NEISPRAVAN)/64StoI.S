#algoritam konverzije string velikih brojeva u interni al u dvostrukoj preciznosti
#model ne sadrzi provere ispravnosti stringa
#string sadrzi smao dekadni sistem, moze se modifikovati i za hexa

.section .data

	str: .ascii "123456212523\0"

	broj: .quad 0

.section .text
.globl main
main:




	movl $str, %ecx 		#adresa stringa u ecx
	movl $0, %eax 			#rezultat konverzija		
	movl $0, %edx 			#zbog mnozenja
	movl $0, %ebx 
	movl $0, %edi 			#mora 0

	movl $10, %esi 			#baza sistema 10

opet:	movb (%ecx), %bl		#u bl prebacujemo odgvarajuci karakter stringa 
	
		cmpb $0, %bl 			# $0 je zapravo nul terminator u
		je krajK				# slucaju unosa iz terminala staviti $10
	 						#kraj konverzije 		

		subb $'0', %bl 			#da bi dobili pravi broj

		addl %ebx, %eax 

rot:		shll $1, %eax
			rcll $1, %edx 

			shll $1, %eax
			rcll $1, %edx 

			shll $1, %eax
			rcll $1, %edx 

			shll $1, %eax
			rcll $1, %edx 

		addl $1, %ecx 			#incl ecx da bi pristupili sl karakteru

	jmp opet



krajK:
		
	movl %eax, broj 			#manje znacajni brojevi
	movl %edx, broj+4			#vise znacajni brojevi


kraj:
movl $1, %eax
movl $0, %ebx 
int $0x80


