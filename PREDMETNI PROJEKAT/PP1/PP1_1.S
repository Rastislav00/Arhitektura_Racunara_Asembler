.section .text
.globl StoI
StoI:
#(adresu stringa, adresu operacija, adresu greska, broj karaktera u stringu,
#  prvi OP 24, drugi OP 28)

	pushl %ebp
	movl %esp, %ebp

	subl $12, %esp 					#zbog lokalnih promenljivih

	movl $0, -4(%ebp) 				#broj pojavljivanja znaka = (dozvoljeno jednom)
	movl $0, -8(%ebp) 				#lp za prvi operand
	movl $0, -12(%ebp) 				#lp za drugi operand


	pushl %ebx
	pushl %esi 						#zbog konverzija zbog baze 10

	movl $10, %esi 

	movl $0, %eax 				
	movl 8(%ebp), %ecx 			#adresa stringa u ecx
	movl $0, %ebx 				#jer mi treba bl

	movb (%ecx), %bl 
	cmpb $0, %bl 				#dal je string prazan
	je greska	

	#treba proveriti dal ima znaka jednako negde (obavezno je =)

		PJ:	movb (%ecx), %bl
			cmpb $0, %bl  				#kraj stringa 
			je analiza1
			cmpb $'=', %bl
			jne sl 
			    addl $1, -4(%ebp) 		#brojac pojavljivanja znaka =
			sl: addl $1, %ecx
				jmp PJ


	analiza1: cmpl $1, -4(%ebp) 
			  jne greska1    			#fali ili ima vise znakova = 	




	#treba proveriti dal je znak jednako sa skroz desne strane 
	#da se ne desi da je znak jednako na pocetku

	#nama u ovom momnetu nakon gornjeg alg ecx pokazuje na nul terminator
	subl $1, %ecx 			#sada nam pokazuje na zadnji karakter


		PJ2:movb (%ecx), %bl
			cmpb $38, %bl
			jne mora_da_bude_znak_jednakosti
			subl $1, %ecx
			jmp PJ2




			mora_da_bude_znak_jednakosti:
			subl $1, %ecx 			#jer ja i enter klinem
			movb (%ecx), %bl
			cmpb $'=', %bl
			jne greska1 				#mora da bude znak jednako

	#aa * bb =&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&\0
	#to je ispravan zapis pa tom logikom i idemo



	#ako smo dosli do ovde ok ima samo jedno znak = i na ok mestu je
	#sada treba proveriti operaciju dal ima jedne operacije			
	#opet cu da koristim -4(%ebp) da utvrdimo dal ima vise operacija ili jedna samo
	movl $0, -4(%ebp)  			#nuliranje 
	movl 12(%ebp), %edx 		#u edx adresu operacije

	movl 8(%ebp), %ecx 			#adresa stringa

trazi_operaciju:

		movb (%ecx), %bl

		cmpb $0, %bl
		je analiza2

		cmpb $'+', %bl
		je op_plus

		cmpb $'-', %bl
		je op_minus

		cmpb $'*', %bl
		je op_mnozi

		cmpb $':', %bl
		je op_deli

		cmpb $'/', %bl
		je op_deli

		addl $1, %ecx 			#pristupi sl el
		jmp trazi_operaciju


op_plus:
	movl $1, (%edx) 		#stavljanje od znaka zbog operacije na adresu op
	addl $1, -4(%ebp) 		#brojac operacija
	addl $1, %ecx
	jmp trazi_operaciju

op_minus:
	movl $2, (%edx)
	addl $1, -4(%ebp) 		#brojac operacija
	addl $1, %ecx
	jmp trazi_operaciju

op_mnozi:
	movl $3, (%edx)
	addl $1, -4(%ebp) 		#brojac operacija
	addl $1, %ecx
	jmp trazi_operaciju

op_deli:	
	movl $4, (%edx)
	addl $1, -4(%ebp) 		#brojac operacija
	addl $1, %ecx
	jmp trazi_operaciju



analiza2: 			#treba proveriti dal ima vise operacija
		cmpl $1, -4(%ebp) 
		jne greska2 		#mora da bude samo jedna operacija 

#ako je kod doso do ovde to znaci sigurno da ima samo jedne operacije 
#treba proveriti i operande 

#==============================================================================

	movl 8(%ebp), %ecx 		#adresa stringa u ecx
#ovaj kod ce da nadje prvi operand al ce da ignorise unesene pauze sa leve strane
T1:		movb (%ecx), %bl
		cmpb $' ', %bl
		je shift1
		jne prvi_operand


shift1: addl $1, %ecx
		jmp T1


#sada treba proveriti dal su sve cifre dozvljovamo cifre dekadne

prvi_operand:
		
		movl $0, %edx  			#nuliranje edx 

		movb (%ecx), %bl
	
		cmpb $'0', %bl
		jl proveri_izuzetak_cifre_i_spakuj_operand

		cmpb $'9', %bl
		jg proveri_izuzetak_cifre_i_spakuj_operand

		#algoritam za konverziju iz stringa u interni decimalni
		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			subb $'0', %bl 		#da bi dobili pravu vrednost cifre

			mull %esi 			#eax*esi = edx:eax (esi=10)
			addl %ebx, %eax

		addl $1, %ecx
		jmp prvi_operand


proveri_izuzetak_cifre_i_spakuj_operand:
		movl %eax, -8(%ebp) 	#na kraju cemo videti dal ovo i vredi da sacuvamo
		movl $0, %eax 			#nuliranje zbog sl operanda
proveri_izuzetak_cifre:
		
		cmpb $'+', %bl
		je znak

		cmpb $'-', %bl
		je znak

		cmpb $'*', %bl
		je znak

		cmpb $'/', %bl
		je znak

		cmpb $':', %bl
		je znak

		cmpb $' ', %bl
		je razmak

		jmp greska3 		#ako nista od ponudjenog onda je pogresna cifra



znak: #ako smo skocili vamo znaci da smo ok prosli sa prvim operandom
		#treba proveriti drugi operand
		jmp drugi_operand

razmak:	movb (%ecx), %bl
		cmpb $' ', %bl
		je shift2
		jmp proveri_izuzetak_cifre 		

shift2: addl $1, %ecx
		jmp razmak




drugi_operand: #opet treba ignorisati ako ima spejsova posle znaka
		addl $1, %ecx 			#jer smo do sada pokazivali na znak a sad na prvi
								#karakter iza znaka operacije

	T2:	movb (%ecx), %bl 		#ovo ignorise spejsove posle operacije
		cmpb $' ', %bl
		jne drugi_operand_cifre
		addl $1, %ecx
		jmp T2





drugi_operand_cifre: #sad moramo da imamo samo cifre a izuzetak sme da bude samo
						#karakter = i onda smo sve provere odradili

		movb (%ecx), %bl

		cmpb $'0', %bl
		jl proveri_izuzetak_cifre_drugog_operanda_i_sacuvaj_operand

		cmpb $'9', %bl
		jg proveri_izuzetak_cifre_drugog_operanda_i_sacuvaj_operand
		#treba algoritam za konverziju iz stringa u interni
		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

			subb $'0', %bl 		#da bi dobili pravu vrednost cifre

			mull %esi 			#eax*esi = edx:eax (esi=10)
			addl %ebx, %eax

		addl $1, %ecx
		jmp drugi_operand_cifre




proveri_izuzetak_cifre_drugog_operanda_i_sacuvaj_operand:
		movl %eax, -12(%ebp) 		#sacuvali smo na loklanu promenljivu drugi operan
		movl $0, %eax 				#naravno tek cemo da vidimo dal nije doslo do greske
proveri_izuzetak_cifre_drugog_operanda:
		
		movb (%ecx), %bl
		cmpb $' ', %bl
		jne znak_jednako
		addl $1, %ecx
		jmp proveri_izuzetak_cifre_drugog_operanda


znak_jednako:
		cmpb $'=', %bl
		jne greska4
#==================================================================
gotove_provere: #proverili smo sve zivo .......... 
				#i uhvatili operande

	#u ovom momentu imamo sacuvanu operaciju
	#i prvi i drugi operand

	movl -8(%ebp), %eax  		#tu se naklazi prvi operand
	movl 24(%ebp), %ecx 		#adresa za prvi operand
	movl %eax, (%ecx)    		#smestili smo prvi operand

	movl -12(%ebp), %eax
	movl 28(%ebp), %ecx
	movl %eax, (%ecx)

	jmp krajP





#GRESKE===============================================
greska:
		jmp krajP
greska1: #fali ili ima vise znakova = 
		movl 16(%ebp), %ecx
		movl $1, (%ecx)
		jmp krajP

greska2: #nema operacije ili ima vise operacija
		movl 16(%ebp), %ecx
		movl $2, (%ecx)
		jmp krajP
greska3: #unutar prvog operanda pogresna cifra
		movl 16(%ebp), %ecx
		movl $3, (%ecx)
		jmp krajP
greska4: #unutar drugog operanda pogresna cifra
		movl 16(%ebp), %ecx
		movl $4, (%ecx)
		jmp krajP
#============================================




krajP:

popl %esi
popl %ebx
movl %ebp, %esp
popl %ebp
ret










