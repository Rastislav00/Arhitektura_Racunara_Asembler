#glavni algoritam
.section .text
.globl glavni_algoritam
glavni_algoritam:
#utvrdjeno je da dolazak do ovoog alg prethodi provera dal je string prazan
#znaci nije 

	#($text, N, $br)

	pushl %ebp
	movl %esp, %ebp

	subl $12, %esp 				#zbog lokalnih promenljivih
	movl $0, -4(%ebp) 			#lp za brojanje reci sa malim slovima
	movl $0, -8(%ebp) 			#ovde camo imamo konstantu N
	movl $0, -12(%ebp) 			#indikator dal smo editovali slova

	pushl %ebx
	pushl %esi
	pushl %edi

	movl $0, %esi 				#pokazivac 
	movl $0, %edi				#pokazivac takodje kod indeksnog adresiranja
	movl $0, %ebx 				#zbog bl
	movl 8(%ebp), %ecx 			#adresa texta na ecx
	movl 12(%ebp), %eax 		#u eax imamo konstantu N 
	movl %eax, -8(%ebp)


P1:		movb (%ecx, %esi,1), %bl
		cmpb $10, %bl 				#uporedjujemo sa (enterom)
		je kraj_texta

		cmpb $0, %bl 				#uporedjujemo sa (\0)
		je kraj_texta

		cmpb $' ', %bl
		jne P2
		addl $1, %esi 				#da bi trazili prvu rec
		jmp P1 

	P2: 	movl %esi, %edi 			#unutar reci 
			cmpl $0, -8(%ebp) 			#proveravamo dal smo presli sve reci
			je izvrseno_N
			subl $1, -8(%ebp) 			#umanjujemo N za 1
		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		P3:		movb (%ecx,%edi,1), %bl  	#odgovarajuce slovo unutar reci

				cmpb $'a', %bl
				jl sledeci1

				cmpb $'z', %bl
				jg sledeci1

				subb $'a'-'A', %bl 			#umanjimo bl za razliku

				movb %bl, (%ecx,%edi,1) 	#vracanje editovanog bajta 

		sledeci1:	addl $1, %edi  				#pristupi sl karakteru unutar reci

		sledeci:	movb (%ecx,%edi,1), %bl

					cmpb $10, %bl 			#enter
					je separator

					cmpb $' ', %bl
					je separator

					cmpb $'0', %bl
					jl separator

					cmpb $'9', %bl
					jle nije_separator

					cmpb $'A', %bl
					jl separator

					cmpb $'Z', %bl
					jle nije_separator

					cmpb $'_', %bl
					je nije_separator

					cmpb $'a', %bl
					jl separator

					cmpb $'z', %bl
					jle nije_separator

					jmp separator	


			nije_separator: 	#ako nije separator, treba eventualna velika slova prebaciti u mala

						cmpb $'A', %bl
						jl sl

						cmpb $'Z', %bl
						jg sl 

							addb $'a'-'A', %bl 		# X -> x
							movb %bl, (%ecx,%edi,1)
							movl $1, -12(%ebp) 

						sl: addl $1, %edi
							jmp sledeci

			separator:	#svi karakteri osim cifre slova i donje crte(_)
					addl $1, %edi
					movl %edi, %esi
					jmp P1		




#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
izvrseno_N:

		cmpl $1, -12(%ebp)
		jne S1
				addl $1, -4(%ebp) 			#brojac br malih reci
		

	S1:	movl %esi, %edi 			#unutar reci 
		movl $0, -12(%ebp) 			#nuliranje indikatora smanjivanja reci

		jmp sledeci
	

		




kraj_texta:

	movl 16(%ebp), %edx 			#stavljanje broj reci osim N
	subl $1, -4(%ebp) 				#jer smo jedan dodali prvi put bzvz
	movl -4(%ebp), %eax
	movl %eax, (%edx)




krajP:

popl %edi
popl %esi
popl %ebx
movl %ebp, %esp
popl %ebp
ret
