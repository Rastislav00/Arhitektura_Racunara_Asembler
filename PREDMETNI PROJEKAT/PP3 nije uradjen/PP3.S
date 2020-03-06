#ovaj program nije dovrsen, treba ga dovrsiti al posto trazi puno ispitivanja
#mozdacu ga dovrsiti jednog dana preko leta jer sad nemam vremena za ovo



#Napisati program koji resava jednacine 
#nepoznata moze da bude X 
#ovako izgleda A +/- X = B ili X +/- A = B
#5 + X = 8    znaci X=3
#dozvolicemo simbol za promenljivu bilo koji karakter abcede (ABCEDE)
#program podrzava samo plus i minus operacije 
#dozvoljen unos je i B = x + A
#igorisati spejsove i tabulatore
#jednacina je neispravna ako nema 2 ispravna operanda operaciju +- i =
#================================================
.section .data

	msg1: .ascii "Unesite jednacinu: \n\0"
	str_len1 = . - msg1

	msg2: .ascii "Uneli ste vise promenljivih \n\0"
	str_len2 = . - msg2 

	msg3: .ascii "Pogresna operacija izaberite [+,-]\n\0"
	str_len3 = . - msg3 

	msg4: .ascii "GRESKA\n\0"
	str_len4 = . - msg4 

	msg5: .ascii "Greska u vezi znaka jednakosti = \n\0"
	str_len5 = . - msg5

	str: .fill 51,1,32 			#ovde cemo da unesemo jednacinu
	k: .long 0 					#broj unetih karaktera

	X: .long 0 					#promenljiva npr x ili y zavisi
	P: .long 0 					#orjentacija to jest polozaj znak jednakosti
	A: .long 0 					#jedan operand
	B: .long 0 					#rezultat kao 
	op: .long 0 				#operacija +(1), -(2) 	ako je (0)nema operacije

	G: .long 0 					#greska (0)nema greske, (1)operacija pogresna, (2), nema =, (3) vise operanda ili fale

.section .text
.globl main
main: 

ispis:	#ispis unesite jednaciu
	movl $4, %eax
	movl $1, %ebx
	movl $msg1, %ecx
	movl $str_len1, %edx
	int $0x80

unos:	#unos
	movl $3, %eax
	movl $0, %ebx 
	movl $str, %ecx
	movl $51, %edx
	int $0x80

	movl %eax, k 		#cuvanje broj karaktera u unetom stringu
	cmpl $50, %eax
	jge kraj 			#ako je uneto vise od 50 idi na kraj (da ne bi doslo do segmentated...)

	#proverimo dal string nije prazan
	movl $str, %ecx 	#adresa stringa u ecx pristupamo el
	cmpb $10, (%ecx) 	#provera dal nije unet samo enter (10)
	je ispis 			#ako niste uneli nista treba da unesete :D 

	#proverimo dal korisnik nije uneo samo spejsove ili tabulatore
	movl $0, %ebx 		#zbog dl

	PS:	movb (%ecx), %bl 	#na bl nam je odg karakter
		cmpb $10, %bl 		#dal smo dosli do kraja stringa sa proveravanjem (ovo se nece desiti nikada prvo)
		je ispis 			#ako se ovo desi znaci da u stringu nema nista osim spejs i tab

		cmpb $32, %bl 		#32 je spejs
		je sl_k 			#sledeci karakter

		cmpb $9, %bl 		#9 je tab
		je sl_k 

		jmp unet_string 	#ne znamo sta je unjemu samo znamo da nije prazan


	sl_k:	addl $1, %ecx 		#da bi pristupi.i sl karakteru
			jmp PS 				#PS provera stringa

unet_string:	#samo znaci da ima neke u sebi karaktere koji nisu spejsovi i tabulatori
				#al tek sad treba proveriti dal je sve na svom mestu

		#napravicemo funckiju gde cemo izvrsiti detaljen provere i konverzije
		#(str, op, B, A, P, X, G)

		movl $G, %eax			#adresa greske
		pushl %eax 	

		movl $X, %eax  			#adresa promenljive x
		pushl %eax 				#stavljanje na stek

		movl $P, %eax
		pushl %eax 

		movl $A, %eax
		pushl %eax 

		movl $B, %eax
		pushl %eax 

		movl $op, %eax
		pushl %eax 

		movl $str, %eax 		#adresa stringa
		pushl %eax 

		call A_P_K 				#algoritam_provera_konverzija
		addl $24, %esp 			#brisanje sa steka 




kraj:
movl $1, %eax
movl $0, %ebx 
int $0x80 
#===========KRAJ==================

#KOMENTARI

#NEKE IDEJE:
#Komentar[1]:
#mora korisnik da unese tacno jedan simbol jednakosti =
#napisacemo program koji trazi jednakost = i onda proverava sa koje strane
#se nalazi promenljiva



#========ALGORITAM PROVERA I KONVERZIJA====================
.globl A_P_K
A_P_K: 
##(str, op, B, A, P, X, G)
#(string, operacija, broj B, Broja A, Polozaj=, X, Greska)

	pushl %ebp
	movl %esp, %ebp

		subl $24, %esp 			#zbog lokalnih promenljivih

		movl $0, -4(%ebp) 		#orjentacija znaka =
		movl $0, -8(%ebp) 		#broj znaka pojavljivanja znaka =

		movl $0, -12(%ebp) 		#operacija
		movl $0, -16(%ebp) 		#broj pojavljivanja operacija

		movl $0, -20(%ebp) 		#broj operanada zasebnih cifara odvojenih razmakom 

		movl $0, -24(%ebp) 		#broj pojavljivanja promenljive X

	pushl %ebx

	movl $0, %ebx 			#nuliranje zbog bl

	movl 8(%ebp), %ecx 		#adresa stringa

	#odmah cemo proveriti dal se nalaze 0-9 +-= x
	TS1:movb (%ecx), %bl 		#pristupanje odg karakteru

		cmpb $10, %bl 			#kraj stringa 10 je enter treba analiza1
		je analiza1

		cmpb $9, %bl  			#posto je 9 tabulator
		je sl_k1

		cmpb $32, %bl  			#posto je 32 spejs
		je sl_k1

		cmpb $'x', %bl
		je pro_x

		cmpb $'X', %bl 			#ako slucajno ubaci veliko slovo
		je pro_x

		cmpb $'+', %bl 
		je operacija_plus

		cmpb $'-', %bl 
		je operacija_minus

		cmpb $'=', %bl 
		je znak_jednako

		cmpb $'0', %bl 
		jl greska_TS1

		cmpb $'9', %bl 
		jg greska_TS1

		jmp greska_TS1 			#ako nista od ponudjenog moze samo gresak da bude





operacija_plus:
	movl $1, -12(%ebp)
	addl $1, -16(%ebp)
	jmp sl_k1

operacija_minus:
	movl $2, -12(%ebp)
	addl $1, -16(%ebp)
	jmp sl_k1


znak_jednako:
	addl $1, -8(%ebp)
	jmp sl_k1


pro_x:
	addl $1, -24(%ebp)
	jmp sl_k1

sl_k1:
	addl $1, %ecx 		#da bi pristupu sl karakteru stringa
	jmp TS1




analiza1: 	#analiziranje dal je bilo nekih gresaka

		movl 32(%ebp), %edx 			#adresa greske
		
		cmpl $1, -8(%ebp)
		jne greska_nema_jednako

		cmpl $1, -16(%ebp)
		jne greska_operacija

		cmpl $1, -24(%ebp)
		jne greska_promenljiva



#===GRESKE===============#greska (0)nema greske, (1)operacija pogresna, (2), nema =, (3) vise operanda ili fale
greska_nema_jednako:
	movl $2, (%edx)
	jmp krajP

greska_operacija:
	movl $1, (%edx)
	jmp krajP

greska_promenljiva:
	
	jmp krajP

greska_TS1:

	jmp krajP


#========================


krajP:

popl %ebx
movl %ebp, %esp
popl %ebp
ret
#=========================================
#komentari algoritma
#komentar[1.1]: znaci sme da se pojavi jednom + ili jednom - jednom = i nista drugo ni jednom
#kad pocnemo sa leve na desnu da testiramo string
#prvo sto moze da bude je ili slovo abecede (promenljiva) ili cifra nista drugo










