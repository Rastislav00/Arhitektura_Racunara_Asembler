#Program za sabiranje dva neoznacena broja u proizvoljnoj bazi, bilo koja baza od 2 do 36

.section .data

	baza10: .long 10 	#baza koja se podrazumava pri unosenju baze

	greska: .long 0 	# 0 nije grska 

	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	msg1: .ascii "Unesite bazu prvog broja: \0"
	str_len1 = . - msg1

		str_B_1: .fill 8,1,32 			#string za prvu bazu
		B1: .long 0 					#broj baze

	msg2: .ascii "Unesite prvi broj: \0"
	str_len2 = . - msg2

		str_N_1: .fill 51,1,32 			#string 
		N1: .long 0 					#interni oblik
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	msg3: .ascii "Unesite bazu drugog broja: \0"
	str_len3 = . - msg3

		str_B_2: .fill 8,1,32 			#string za drugu bazu
		B2: .long 0

	msg4: .ascii "Unesite drugi broj: \0"
	str_len4 = . - msg4

		str_N_2: .fill 51,1,32 			#string 
		N2: .long 0
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	msg5: .ascii "Unesite bazu rezultata: \0"
	str_len5 = . - msg5

		str_B_3: .fill 8,1,32 			#string za bazu rezultata
		B3: .long 0

	msg6: .ascii "Rezultat zbira je:  \0"
	str_len6 = . - msg6

		N3: .long 0 
		str_N_3: .fill 51,1,32 			#string
		N3B: .long 0 					#bafer za stampanje 
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	msg7: .ascii "GRESKA \0"
	str_len7 = . - msg7

	msg8: .ascii "Prazan string \n\0"
	str_len8 = . - msg8

	msg9: .ascii "van opsega \n\0"
	str_len9 = . - msg9

	msg10: .ascii "Pogresna cifra \n\0"
	str_len10 = . - msg10


.section .text 
.globl main
main:


ispis1:	#Ispis poruke
	movl $4, %eax
	movl $1, %ebx
	movl $msg1, %ecx
	movl $str_len1, %edx
	int $0x80 

	movl $3, %eax
	movl $0, %ebx
	movl $str_B_1, %ecx
	movl $8, %edx
	int $0x80 

		movl $greska, %eax 	#adresa greske
		pushl %eax 

		movl $baza10, %eax	#adresa baze na stek
		pushl %eax  

		movl $B1, %eax		#adresa promenljive za cuvanje internog oblika baze
		pushl %eax 

		movl $str_B_1, %eax	#adres stringa
		pushl %eax 

		#(str_B_1, B1, baza10, greska)
		call StoI			
		addl $8, %esp 		#brisanje sa steka

	#proveriti dal je bilo gresaka?
	cmpl $0, greska 
	je dalje1

	cmpl $1, greska
	je GRESKA_PRAZAN_STRING

	cmpl $2, greska 
	je GRESKA_POGRESNA_CIFRA

	cmpl $3, greska 
	je GRESKA_VANOPSEGA






#=====GRESKE=================

GRESKA_PRAZAN_STRING:
	movl $0, greska 
	movl $4, %eax
	movl $1, %ebx
	movl $msg8, %ecx
	movl $str_len8, %edx
	int $0x80 
	jmp ispis1


GRESKA_POGRESNA_CIFRA:
	movl $0, greska 
	movl $4, %eax
	movl $1, %ebx
	movl $msg10, %ecx
	movl $str_len10, %edx
	int $0x80 
	jmp ispis1


GRESKA_VANOPSEGA:
	movl $0, greska 
	movl $4, %eax
	movl $1, %ebx
	movl $msg9, %ecx
	movl $str_len9, %edx
	int $0x80 
	jmp ispis1
#======================
#a11111111111111111111111111


dalje1:

ispis2:	#Ispis poruke
	movl $4, %eax
	movl $1, %ebx
	movl $msg2, %ecx
	movl $str_len2, %edx
	int $0x80 

	movl $3, %eax
	movl $0, %ebx
	movl $str_N_1, %ecx
	movl $8, %edx
	int $0x80 

		movl $greska, %eax 	#adresa greske
		pushl %eax 

		movl $B1, %eax	#adresa baze na stek
		pushl %eax  

		movl $N1, %eax		#adresa promenljive za cuvanje internog oblika baze
		pushl %eax 

		movl $str_N_1, %eax	#adres stringa
		pushl %eax 

		#(str_B_1, B1, baza10, greska)
		call StoI			
		addl $8, %esp 		#brisanje sa steka

	#proveriti dal je bilo gresaka?
	cmpl $0, greska 
	je dalje2

	cmpl $1, greska
	je GRESKA_PRAZAN_STRING2

	cmpl $2, greska 
	je GRESKA_POGRESNA_CIFRA2

	cmpl $3, greska 
	je GRESKA_VANOPSEGA2






#=====GRESKE=================

GRESKA_PRAZAN_STRING2:
	movl $0, greska 
	movl $4, %eax
	movl $1, %ebx
	movl $msg8, %ecx
	movl $str_len8, %edx
	int $0x80 
	jmp ispis2


GRESKA_POGRESNA_CIFRA2:
	movl $0, greska 
	movl $4, %eax
	movl $1, %ebx
	movl $msg10, %ecx
	movl $str_len10, %edx
	int $0x80 
	jmp ispis2


GRESKA_VANOPSEGA2:
	movl $0, greska 
	movl $4, %eax
	movl $1, %ebx
	movl $msg9, %ecx
	movl $str_len9, %edx
	int $0x80 
	jmp ispis2
#======================

#a2222222222222222222222222222

dalje2:

ispis3:	#Ispis poruke
	movl $4, %eax
	movl $1, %ebx
	movl $msg3, %ecx
	movl $str_len3, %edx
	int $0x80 

	movl $3, %eax
	movl $0, %ebx
	movl $str_B_2, %ecx
	movl $8, %edx
	int $0x80 

		movl $greska, %eax 	#adresa greske
		pushl %eax 

		movl $baza10, %eax	#adresa baze na stek
		pushl %eax  

		movl $B2, %eax		#adresa promenljive za cuvanje internog oblika baze
		pushl %eax 

		movl $str_B_2, %eax	#adres stringa
		pushl %eax 

		#(str_B_1, B1, baza10, greska)
		call StoI			
		addl $8, %esp 		#brisanje sa steka

	#proveriti dal je bilo gresaka?
	cmpl $0, greska 
	je dalje3

	cmpl $1, greska
	je GRESKA_PRAZAN_STRING23

	cmpl $2, greska 
	je GRESKA_POGRESNA_CIFRA23

	cmpl $3, greska 
	je GRESKA_VANOPSEGA23






#=====GRESKE=================

GRESKA_PRAZAN_STRING23:
	movl $0, greska 
	movl $4, %eax
	movl $1, %ebx
	movl $msg8, %ecx
	movl $str_len8, %edx
	int $0x80 
	jmp ispis3


GRESKA_POGRESNA_CIFRA23:
	movl $0, greska 
	movl $4, %eax
	movl $1, %ebx
	movl $msg10, %ecx
	movl $str_len10, %edx
	int $0x80 
	jmp ispis3


GRESKA_VANOPSEGA23:
	movl $0, greska 
	movl $4, %eax
	movl $1, %ebx
	movl $msg9, %ecx
	movl $str_len9, %edx
	int $0x80 
	jmp ispis3
#======================

dalje3:
#a3333333333333333333333333333333333333333

ispis4:	#Ispis poruke
	movl $4, %eax
	movl $1, %ebx
	movl $msg4, %ecx
	movl $str_len4, %edx
	int $0x80 

	movl $3, %eax
	movl $0, %ebx
	movl $str_N_2, %ecx
	movl $8, %edx
	int $0x80 

		movl $greska, %eax 	#adresa greske
		pushl %eax 

		movl $B2, %eax	#adresa baze na stek
		pushl %eax  

		movl $N2, %eax		#adresa promenljive za cuvanje internog oblika baze
		pushl %eax 

		movl $str_N_2, %eax	#adres stringa
		pushl %eax 

		#(str_B_1, B1, baza10, greska)
		call StoI			
		addl $8, %esp 		#brisanje sa steka

	#proveriti dal je bilo gresaka?
	cmpl $0, greska 
	je dalje4

	cmpl $1, greska
	je GRESKA_PRAZAN_STRING234

	cmpl $2, greska 
	je GRESKA_POGRESNA_CIFRA234

	cmpl $3, greska 
	je GRESKA_VANOPSEGA234






#=====GRESKE=================

GRESKA_PRAZAN_STRING234:
	movl $0, greska 
	movl $4, %eax
	movl $1, %ebx
	movl $msg8, %ecx
	movl $str_len8, %edx
	int $0x80 
	jmp ispis4


GRESKA_POGRESNA_CIFRA234:
	movl $0, greska 
	movl $4, %eax
	movl $1, %ebx
	movl $msg10, %ecx
	movl $str_len10, %edx
	int $0x80 
	jmp ispis4


GRESKA_VANOPSEGA234:
	movl $0, greska 
	movl $4, %eax
	movl $1, %ebx
	movl $msg9, %ecx
	movl $str_len9, %edx
	int $0x80 
	jmp ispis4
#======================

#a4444444444444444444444444444
dalje4:#sada treba rezultat
#aZZZZZZZZZZZZZZZZZZZZZZZZZZZ

ispis5:	#Ispis poruke
	movl $4, %eax
	movl $1, %ebx
	movl $msg5, %ecx
	movl $str_len5, %edx
	int $0x80 

	movl $3, %eax
	movl $0, %ebx
	movl $str_B_3, %ecx
	movl $8, %edx
	int $0x80 

		movl $greska, %eax 	#adresa greske
		pushl %eax 

		movl $baza10, %eax	#adresa baze na stek
		pushl %eax  

		movl $B3, %eax		#adresa promenljive za cuvanje internog oblika baze
		pushl %eax 

		movl $str_B_3, %eax	#adres stringa
		pushl %eax 

		#(str_B_1, B1, baza10, greska)
		call StoI			
		addl $8, %esp 		#brisanje sa steka

	#proveriti dal je bilo gresaka?
	cmpl $0, greska 
	je dalje5

	cmpl $1, greska
	je GRESKA_PRAZAN_STRING2345

	cmpl $2, greska 
	je GRESKA_POGRESNA_CIFRA2345

	cmpl $3, greska 
	je GRESKA_VANOPSEGA2345






#=====GRESKE=================

GRESKA_PRAZAN_STRING2345:
	movl $0, greska 
	movl $4, %eax
	movl $1, %ebx
	movl $msg8, %ecx
	movl $str_len8, %edx
	int $0x80 
	jmp ispis5


GRESKA_POGRESNA_CIFRA2345:
	movl $0, greska 
	movl $4, %eax
	movl $1, %ebx
	movl $msg10, %ecx
	movl $str_len10, %edx
	int $0x80 
	jmp ispis5


GRESKA_VANOPSEGA2345:
	movl $0, greska 
	movl $4, %eax
	movl $1, %ebx
	movl $msg9, %ecx
	movl $str_len9, %edx
	int $0x80 
	jmp ispis5
#======================

dalje5:

	zbir:

	movl N1, %eax
	addl N2, %eax 		#rezultat u eaxu

	movl %eax, N3 		#rezultat je u N3 

	movl $N3, %eax 
	pushl %eax 			#stavljamo na stek adresu rezultata

	movl $N3B, %eax 	#broj karaktera u konvertovanom stringu zbog bafera
	pushl %eax 			

	movl $B3, %eax 			#baza
	pushl %eax 			

	movl $str_N_3, %eax 	#adresa stringa u eax
	pushl %eax 		

	#(String, Baza, Brojkaraktera, broj koji konvertujemo)
	call ItoS
	addl $16, %esp 		#brisanje sa steka



	#ispis broja

	movl $4, %eax
	movl $1, %ebx
	movl $msg6, %ecx
	movl $str_len6, %edx
	int $0x80 

	movl $4, %eax
	movl $1, %ebx
	movl $str_N_3, %ecx
	movl N3B, %edx
	int $0x80 








kraj:
movl $1, %eax
movl $0, %ebx
int $0x80 
#=============KRAJ======================================







#===========String u interni oblik======================
.globl StoI
StoI:
##(string, broj, baza, greska)

	pushl %ebp
	movl %esp, %ebp

	pushl %esi
	pushl %edi 
	pushl %ebx

	movl $0, %eax 			#rezultat konverzije
	movl $0, %ebx 			#zbog bl

	movl 8(%ebp), %esi 		#adresa stringa 
	movl 16(%ebp), %edx 	#adresa baze
	movl (%edx), %ecx 		#sada imamo bazu u ecx
	movl $0, %edx 			#zbog mnozenja 

	#samo da proverimo dal string nije prazan?
	movb (%esi), %bl
	cmpb $10, %bl 			#ako je unet samo enter
	je prazan_string 		

konv1:	movb (%esi), %bl

		cmpb $10, %bl 
		je krajK1

		cmpb $'0', %bl 
		jl greska_cifra

		cmpb $'9', %bl 
		jle dec_cifra

		cmpb $'A', %bl 
		jl greska_cifra

		cmpb $'Z', %bl 
		jle abc_cifra

		cmpb $'a', %bl 
		jl greska_cifra

		cmpb $'z', %bl 
		jle abc_cifra_m 		#male cifre

		jmp greska_cifra

		
dec_cifra:

		subb $'0', %bl 			#da bi dobili realnu cifru
		jmp provera1

abc_cifra:
		subb $'A', %bl 		 	#da bi dobili prave vrednosti	
		addb $10, %bl 			#jer je A = 10
		jmp provera1

abc_cifra_m: 
		subb $'a', %bl 		 	#da bi dobili prave vrednosti	
		addb $10, %bl 			#jer je A = 10
		jmp provera1


provera1: 
		cmpb %cl, %bl 
		jge greska_cifra 		#poredimo dal je broj veci ili jednak bazi

		konverzija1:#ovde smo skocili ako je broj manji od baze 

		movl $0, %edx 			#zbog mnozenja
		mull %ecx 				#eax*ecx= edx:eax

		cmpl $0, %edx 
		jne greska_van_opsega

		addl %ebx, %eax 		#ubacivanje broja u eax 
		jc greska_van_opsega

		addl $1, %esi 			#da bi pristupio sl karakteru

		jmp konv1

krajK1: 	#ovim smo konvertovali string
		movl 12(%ebp), %edx
		movl %eax, (%edx) 		#stavljamo rezultat konverije u promenljivu
		jmp krajP1




#==============GRESKE============================================
greska_cifra:#cifra ne pripada brojevnom sistemu te baze 2->greska
		movl 20(%ebp), %eax
		movl $2, (%eax)
		jmp krajP1

prazan_string:	#1->greska
		movl 20(%ebp), %eax
		movl $1, (%eax)
		jmp krajP1

greska_van_opsega: #3->greska
		movl 20(%ebp), %eax
		movl $3, (%eax)
		jmp krajP1
#=========================================



krajP1:

popl %ebx
popl %edi
popl %esi
movl %ebp, %esp
popl %ebp
ret 





#======interni u string u zadatoj bazi=====================
.globl ItoS
ItoS:
	#(String, Baza, Brojkaraktera, broj koji konvertujemo)
	pushl %ebp
	movl %esp, %ebp

	pushl %edi 
	pushl %ebx
	pushl %esi 

	movl $1, %esi 			#brojac za bafer
	movl $0, %edx 			#nuliranje zbog deljenja


	movl 20(%ebp), %ecx 	
	movl (%ecx), %eax 		#u eax imamo broj koji konvertujemo
	movl 8(%ebp), %edi 		#u edi imamo adresu stringa
	movl 12(%ebp), %ecx
	movl (%ecx), %ebx 		#baza u ebx a ecx nam je slobodan

	cmpl $0, %eax 
	jne konv2

	movb $'0', (%edi) 		#hardkodovanje ako je rezultat nula 
	jmp krajK2



konv2:
	cmpl $0, %eax 
	je krajK2
	divl %ebx 				#eax/ebx = eax,edx 

	cmpb $9, %dl 			
	jg abc_cifra_k 

	#decimalna cifra
	addb $'0', %dl  		#da dobijemo ascii karakter
	jmp ubaci

abc_cifra_k:

	addb $'A', %dl 			#da bi dobili ascii karakter

ubaci: 
	movb %dl, (%edi)
	addl $1, %esi  			#brojac za bafer 

	addl $1, %edi 			#da bi pristupili sl karakteru i ubacili ga 
	movl $0, %edx 
	jmp konv2



krajK2: #sada treba da obrnemo 

	subl $1, %edi 			#jer smo unapred uvecali pa treba da se vratimo

	movl 8(%ebp), %ecx 		#pocetak stringa
	movl $0, %edx 			#nuliranje zbog dl
	movl $0, %ebx 			#zbog bl

obrni:	movb (%ecx), %dl 
		movb (%edi), %bl 

		movb %dl, (%edi)
		movb %bl, (%ecx)

		addl $1, %ecx
		subl $1, %edi 

		cmpl %ecx, %edi 
		jle krajP2

		jmp obrni






krajP2:

movl 16(%ebp), %ecx
movl %esi, (%ecx) 		#da ubacimo na adresu bafer 
	
popl %esi
popl %edi 
movl %ebp, %esp
popl %ebp
ret















