#Interni HexaDecimalni (pozitivni +)(16), u string ... :D 
.section .data

	broj: .long 0x123AB

	str: .fill 30,1,32  			#.fill kolicina,velicina,karakter (32=spejs)

	n: .long 1 						#bafer izlazi :D  (pocinje od 1 da bi ubacio na kraju jedan spejs)

.section .text
.globl main
main:
	
	movl $0, %edx				#ostatak pri deljenju
	movl broj, %eax 			#broj koji konvertujemo
	movl $16, %esi 				#baza hexa je 16
	movl $str, %ecx 			#adresa stringa u ecx 

konv:
		divl %esi 					#eax/esi = eax,edx
		cmpl $10, %edx
		jge hex 					#jge vece ili jednako pogledaj komentar [1]
		
dec:	addb $'0', %dl  			#ovo se desava u slucaju 0-9 	
		jmp ubaci

hex:	subb $10, %dl 				#komentar[2] dole ispod kraja programa
		addb $'A', %dl

ubaci: 	cmpb $0, (%ecx)
		je greska  					#greska je jer nema dovoljno mesta u stringu

		movb %dl, (%ecx) 			#smesti karakter na odg mesto u stringu
		addl $1, n 					#brojac koliko puta smo ubacili karakter

		movl $0, %edx 				#nuliranje zbog sledeceg ostatka

		cmpl $0, %eax 				#konv je gotova kad eax sadrzi 0
		je krajK 				

		addl $1, %ecx 				#pristupi sl karakteru	

		jmp konv






krajK: #imamo konvertovani broj u string koji jos treba obrnuti 
		#skok na ovu petlju znaci da nije doslo do greske i 
		#i da nama ecx pokazuje na zadnji ubacen karakter u string

		movl $0, %ebx 			#nuliranje zbog bl 
		movl $0, %edx 			#dl

		movl $str, %eax 		#da pristupamo prvom karakteru stringa

obrni: 		movb (%eax), %bl
			movb (%ecx), %dl 

			movb %bl, (%ecx)
			movb %dl, (%eax)

			addl $1, %eax
			subl $1, %ecx 

			cmpl %eax, %ecx
			jle krajO 			#kraj obrtanja je kad se susretnu adrese ili preskoce

			jmp obrni




krajO: #kraj obrtanja

	#ispis na terminal
	movl $4, %eax
	movl $1, %ebx
	movl $str, %ecx
	movl n, %edx 		#izlazni bafer
	int $0x80
	jmp kraj 



greska:



kraj:
movl $1, %eax
movl $0, %ebx
int $0x80
#=================================
#komentar[1], poenta je u tome sto mi uporedimo sa 10 
#da bi znali dal treba da dodajedmo ascii vrednost 0 ili A
#kako bi adekvatno preveli broj u string 
#
#komentar[2]: oduzeli smo za 10 jer je to deseta cifra ako idemo redom
























