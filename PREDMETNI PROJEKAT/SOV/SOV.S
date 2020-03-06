#obezbediti unos stringa do 100 karaktera dekadni brojevi sve osim cifre je greska 
#separatori su razmaci spejs
#zatim konvertovati u oktalni i ispisati string u redosledu od najmanjeg do najveceg


.section .data

	msg1: .ascii "Unesite string dekadnih brojeva i razmake: \0"
	str_len1 = . - msg1

	msg2: .ascii "Uneli ste prazan string \n\0"
	str_len2 = . - msg2

	msg3: .ascii "Sortirani oktalni string: \0"
	str_len3 = . - msg3

	msg4: .ascii "Greska je u broju: \0"
	str_len4 = . - msg4

	msg6: .ascii "\n\0"
	str_len6 = . - msg6


	str: .fill 101,1,32 			#ovde cemo da unesemo brojeve

	niz: .long 0,0,0,0,0,0,0,0,0,0  	#do 10 brojeva 

	P: .long 0 							#pomocna promenljiva

	n: .long 0 							#samo da imamo informaciju u koju treba adresu da se ubaci broj u nizu

	gstr: .fill 50,1,32 				#stringu vezi greske

	ostr: .fill 102,1,32 				#oktalni string



.section .text
.globl main
main:

ispis:
	movl $4, %eax
	movl $1, %ebx 
	movl $msg1, %ecx
	movl $str_len1, %edx 
	int $0x80

unos:
	movl $3, %eax
	movl $0, %ebx 
	movl $str, %ecx
	movl $101, %edx 
	int $0x80

	cmpl $100, %eax 
	jg kraj 			#ne sme se uneti vise od dozvoljenog 

	movl $str, %ecx 	#adresa stringa u ecx 
	cmpb $10, (%ecx)	#dal je string prazan
	je greska_prazan_string

	movl $0, %ebx 		#zbog bl

PR1:	movb (%ecx), %bl 

		cmpb $10, %bl 
		je greska_prazan_string

		cmpb $32, %bl  		#32 je spejs
		je sl_k

		cmpb $9, %bl 		#9 je tabulatro
		je sl_k

		jmp nije_prazan 	#znaci da nije prazan i idemo da proverimo dalje 


		sl_k:	addl $1, %ecx 	#da bi pristupili sl karakteru u stringu
				jmp PR1 		#provera 1


#============================
greska_prazan_string:
	movl $4, %eax
	movl $1, %ebx 
	movl $msg2, %ecx
	movl $str_len2, %edx 
	int $0x80
	jmp ispis 
#============================


nije_prazan: #skok ovde znaci string nije prazan


	#treba proveriti dal se nalazi jos nesto u njemu sto nije dozvoljeno
	#dozvoljene su samo cifre od 0 do 9 i samo spejsovi i samo tabulatori

	movl $str, %ecx 	#adresa stringa u ecx 
	movl $0, %ebx 		#zbog bl

	PR2:movb (%ecx), %bl

		cmpb $10, %bl 
		je ispravan 		#znaci da je string ispravan ako smo dosli do kraja

		cmpb $9, %bl		#tabulator
		je sl_k2

		cmpb $32, %bl   	#32 je spesj
		je sl_k2

		cmpb $'0', %bl 
		jl greska_cifra

		cmpb $'9', %bl 
		jle sl_k2

		jmp greska_cifra



		sl_k2:  addl $1, %ecx 	#pristupi sl karakteru
				jmp PR2 		#provera 2


greska_cifra: #ovde mos skocili ako je korisnik uneo npr nesto sto nije cifra 

		movl $gstr, %ecx
		movb %bl, (%ecx)


	movl $4, %eax
	movl $1, %ebx 
	movl $msg4, %ecx
	movl $str_len4, %edx 
	int $0x80

	movl $4, %eax
	movl $1, %ebx 
	movl $gstr, %ecx
	movl $50, %edx 
	int $0x80

	movl $4, %eax
	movl $1, %ebx 
	movl $msg6, %ecx
	movl $str_len6, %edx 
	int $0x80






		jmp ispis 


ispravan:



	movl $str, %ecx 		#adresa stringa u ecx 
	movl $0, %ebx 		
	movl $0, %esi 			#indeski
	movl $0, %edi 			#indeksi


trazi:	movb (%ecx,%esi,1), %bl
		cmpb $10, %bl 
		je krajK1

		cmpb $32, %bl 
		je pres
		cmpb $9, %bl 
		je pres

		jmp cifra 			#znaci ako nije ni spejs ni tabulator onda je cifra

pres:	addl $1, %esi 
		jmp trazi


cifra:	movl %esi, %edi 	#edijem cemo kroz broj sve dok ne dodjemo do spejsa sperator
		movl $0, %eax 		#spreman da konvetuje brojke 

	C1:	movb (%ecx,%edi,1), %bl 
		cmpb $10, %bl 		#kraj stringa, treba izvrsiti zadnje ubacivanje 
		je ubaci 	
		cmpb $32, %bl  		#spejs
		je ubaci
		cmpb $9, %bl		#tabulator
		je ubaci 


		subb $'0', %bl 		#da bi dobio pravi broj 

		movl $0, %edx 
		movl $10, %esi 		#esi trenutna baza 
		mull %esi 			#eax*esi= edx:eax
		cmpl $0, %edx 
		jne greska_v32

		addl %ebx, %eax 	#ubacivanje u rezultat konverzije
		jc greska_v32 		#znaci da broj izaso iz opsega

		addl $1, %edi

		jmp C1 				#trazenje sl cifre 






greska_v32:
		movl %edi, %esi

		cmpb $32, (%ecx,%edi,1)
		je trazi
		cmpb $9, (%ecx,%edi,1)
		je trazi
		cmpb $10, (%ecx,%edi,1)
		je krajK1					#ako smo dosli do kraja tj ako je bio neispravan broj zadnji
		addl $1, %edi 

		jmp greska_v32


ubaci:	movl n, %esi 				#ovo mozemo jer na kraju u esi ubacujemo vrednost
		
		cmpl $10, %esi 
		je greska_mesto

		movl %eax, niz(,%esi,4)

		addl $1, n 					#cuvamo informaciju o adresi u nizu
		movl %edi, %esi 
		jmp trazi


krajK1: #sada imamo niz i treba ga sortirati

		#pre toga samo da vidimo dal slucajno nije ceo niz prazan
		cmpl $0, niz 		
		je greska_prazan_string 



		movl $0, %eax
		movl $0, %ebx
		movl $0, %edx
		movl $0, %ecx
		movl $0, %esi
		movl $0, %edi 				#ocistili registre

		movl $niz, %ecx 			#adresa niza u ecx 

		movl $0, %esi
		movl $1, %edi 				#indeksni adresiranje esi i edi

sl_b:	cmpl n, %esi 
		jge krajK2 					#kraj sortiranja


		movl (%ecx,%esi,4), %eax
		movl (%ecx,%edi,4), %ebx 

		cmpl %eax, %ebx 
		jg zameni

		addl $1, %esi
		addl $1, %edi 

		jmp sl_b 			#sledeci broj


zameni:	movl %eax, (%ecx,%edi,4)
		movl %ebx, (%ecx,%esi,4)

		movl $0, %esi			#treba opet poceti ispocetka da proverava
		movl $1, %edi 

		jmp sl_b

krajK2:	#sada trreba jos da ovaj niz istampamo na terminalu


		#ispis
	movl $4, %eax
	movl $1, %ebx 
	movl $msg3, %ecx
	movl $str_len3, %edx 
	int $0x80

	movl $8, %edi 				#baza oktalna
	movl $0, %esi 				#indeksni brojac
	movl $ostr, %ecx 			#adresa izlaznog stringa u ecx 
	addl $100, %ecx 			#pocecemo da trpamo slova od pozadi HAHA :D 
	movb $10, (%ecx) 				#vestacki ubacen enter
	subl $1, %ecx 				
	movl $0, %edx 


P3_1:	movl niz(,%esi,4), %eax 	#ok nas broj je u eax treba klasika noverzija

		cmpl $10, %esi
		je krajK3 				#tada smo sve brojeve odstampali


	P3:	cmpl $0, %eax
		je sledeci_el 				#sledeci element

		divl %edi 					#eax/edi=eax,edx

		addb $'0', %dl 				#da bi dobio ascii karakter

		movb %dl, (%ecx) 			#ubaci brojku u string 
		movl $0, %edx 				#praznimo ga 
		subl $1, %ecx 

		jmp P3 

sledeci_el:
		subl $1, %ecx 				#da bi izgledalo da ima spejsa 
		addl $1, %esi 
		movl $0, %eax 
		jmp P3_1 						#petlja 








krajK3:		#treba pobrisati one razmake na prednjoj strani

		
		movl $0, %eax
		movl $0, %ebx
		movl $0, %edx
		movl $0, %ecx
		movl $0, %esi
		movl $0, %edi 				#ocistili registre

		movl $0, %esi
		movl $1, %edi 

		movl $ostr, %ecx 			#adresa stringa 

A1:		cmpb $32, (%ecx,%esi,1)
		jne krajK4

A2:		
		movb (%ecx,%edi,1), %dl 
		movb %dl, (%ecx,%esi,1)

		cmpb $10, %dl 
		je opet

		addl $1, %esi
		addl $1, %edi 

		jmp A2


opet:	movl $0, %esi
		movl $1, %edi 
		jmp A1









krajK4: #jos samo da istampamo

	#samo da izborjimo jos bafer za stampu

	movl $ostr, %ecx
	movl $0, %esi

T1:	cmpb $10, (%ecx)
	je nadjen_kraj

	addl $1, %esi 	#brojac
	addl $1, %ecx 	#da pristupi sl karkareru
	jmp T1




nadjen_kraj:


	movl $4, %eax
	movl $1, %ebx 
	movl $ostr, %ecx
	movl %esi, %edx 
	int $0x80


	movl $4, %eax
	movl $1, %ebx 
	movl $msg6, %ecx
	movl $str_len6, %edx 
	int $0x80




		jmp kraj 




greska_mesto: #ako nema dovoljno mesta u nizu 



kraj:
movl $1, %eax
movl $0, %ebx 
int $0x80























