#omoguciti preko terminala unos i ispis brojeva (sistemski pozivi)
#primer
#Unesite prvi operand, operaciju, drugi operand i znak jednakosti
#xyz @ abc = (rez)  
#program treba da ucita unete brojeve i da prepozna operaciju
#da izvrsi operaciju i povrati vrednost 
#koristiti 3 fajla jedan za main a druga dva za citav algoritam konverzija
#operandi moraju biti celobrojni i pozitivni brojevi 

.section .data

	msg1: .ascii "Unesite (1operand) [operaciju] (2operand) i = \n\0"
	str_len1= . - msg1

	msg2: .ascii "GRESKA, pogresna operacija, fali ili ima vise\0"
	str_len2= . - msg2

	msg3: .ascii "GRESKA, kod prvog operanda\0"
	str_len3= . - msg3

	msg4: .ascii "GRESKA, nema znaka = ili ga ima vise komada\0"
	str_len4= . - msg4

	msg5: .ascii "GRESKA, kod drugog operanda\0"
	str_len5= . - msg5

	str: .fill 30,1,38				#.fill kolicina,velicina,karakter

	n: .long 0 						#broj unetih karaktrea

	greska: .long 0 				#greska 2 pogresna operacija, 3 pogr operand

	op: .long 0 					#operacija +-*/:

	op1: .long 0 					#operand 1

	op2: .long 0 					#operand 2

	rez: .long 0 					#rezultat operanada

	srez: .fill 20,1,32 			#string rezultata

	m: .long 0 						#broj karaktera novog stringa

.section .text
.globl main
main:

	#ispis poruke 
	movl $4, %eax
	movl $1, %ebx
	movl $msg1, %ecx
	movl $str_len1, %edx
	int $0x80

	#unos stringa
	movl $3, %eax 					
	movl $0, %ebx
	movl $str, %ecx
	movl $30, %edx
	int $0x80

	movl %eax, n 					#u eax imamo broj unetih karaktrea

	movl $str, %ecx
	movb $0, (%ecx,%eax,1) 			#stavljanje nul terminator



	#poziv konverzije iz stringa u interno
	#na stek
	movl $op2, %eax 				#promenljive za operande 
	pushl %eax
	movl $op1, %eax
	pushl %eax 

	pushl %eax    					#broj unetih karaktera
	movl $greska, %eax				#adresa promenljive greska
	pushl %eax
	movl $op, %eax
	pushl %eax 
	movl $str, %eax					#adresa stringa
	pushl %eax

	call StoI
	addl $24, %esp 					#brisanje sa steka

#GRESKE=====================================================
cmpl $0, greska
je nema_gresaka


	cmpl $1, greska
	je greska1

	cmpl $2, greska
	je greska2

	cmpl $3, greska
	je greska3

	cmpl $4, greska
	je greska4

	jmp nema_gresaka #ovo se nikad nece desiti al ok :D




greska1:
	movl $4, %eax
	movl $1, %ebx
	movl $msg4, %ecx
	movl $str_len4, %edx
	int $0x80
	jmp kraj
		
greska2:
	movl $4, %eax
	movl $1, %ebx
	movl $msg2, %ecx
	movl $str_len2, %edx
	int $0x80
	jmp kraj

greska3:
	movl $4, %eax
	movl $1, %ebx
	movl $msg3, %ecx
	movl $str_len3, %edx
	int $0x80
	jmp kraj

greska4:
	movl $4, %eax
	movl $1, %ebx
	movl $msg5, %ecx
	movl $str_len5, %edx
	int $0x80
	jmp kraj
#================================




nema_gresaka: #ok sada treba napraviti operacije

#operacija moze da sadrzi nesto od ovog
#1+		2-		3*		4/		4:

		cmpl $1, op
		je op_plus

		cmpl $2, op
		je op_minus

		cmpl $3, op
		je op_mnozi

		cmpl $4, op
		je op_deli


op_plus: #op1 + op2 = rez
	
	movl op2, %eax
	movl %eax, rez
	movl op1, %eax
	addl %eax, rez  
	jmp rezultati

op_minus: # op1-op2=rez

	movl op1, %eax
	subl op2, %eax
	movl %eax, rez
	jmp rezultati

op_mnozi:

	movl op1, %eax
	movl op2, %ebx
	mull %ebx
	movl %eax, rez
	jmp rezultati

op_deli:

	movl op1, %eax
	movl op2, %ebx
	divl %ebx
	movl %eax, rez
	jmp rezultati

rezultati: 	#sada imamo u promelnjivoj rezultati nase rezultate i treba ih stampati
	
	#na stek
	movl $m, %eax
	pushl %eax

	movl rez, %eax
	pushl %eax

	movl $srez, %eax
	pushl %eax

	call ItoS
	addl $12, %esp

	#super sada imamo i string sa rezultatom

	movl $4, %eax
	movl $1, %ebx
	movl $srez, %ecx
	movl m, %edx
	int $0x80





kraj:
movl $1, %eax
movl $0, %ebx
int $0x80























