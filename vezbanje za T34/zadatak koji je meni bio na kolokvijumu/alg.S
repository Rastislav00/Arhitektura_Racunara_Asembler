#VAZNO OBAVESTENJE NA KOLOKVIJUMU JE BIO ZADAT NIZ U 8BITA AL JA TO U C SAD NMG DA SE SETIM KAKO DA 
#INICIJALIZUJEM 8BITNI NIZ PA SAM URADIO SA 16BITNIM NIZOM TO ZNACI DA CU PRI PRISTUPANJU ELEMENTIMA
#MORATI DA POKAZIVAC POVECAVAM ZA 2


#int alg(short int *niz, int *n);
.section .text
.globl alg
alg:

	pushl %ebp
	movl %esp, %ebp
	pushl %esi
	pushl %ebx

	movl $0, %ebx
	subl $4, %esp 				#zbog lokalnih promenljivih
	movl $0, -4(%ebp)			#anuliramo brojac za brojanje jedinica

	movl $0, %esi				#anuliranje brojaca esi	
	movl $0, %eax				#anuliranje registra eax zbog koriscenja al podregistra
	movl $0, %ecx 				#u ecx ce mi biti maska al naravno cl
	movb $1, %cl				#maska

	movl 8(%ebp), %edx			#u edx imamo adresu niza 

opet:	movb (%edx, %esi, 1), %al 	#u al imam sada el niza
		andb %cl, %al 				#proveravamo odgovarajuci bit da li je 1

		cmpb $0, %al
		je shift
		addl $1, %ebx			#brojac jedinica

shift:	
	addl $2, %esi				#povecavamo esi da bi pristupili sl el niza	
	shlb $1, %cl 				#siftovanje maske za jedno mesto u levo
	cmpb $0, %cl
	je promena 					#to jest sledeca diagonala
	jmp opet


promena:	movl $0, %esi 		#anuliranje brojaca
			movl $0, %ecx		#anuliranje maske
			movb $0x80, %cl		#stavljanje maske hexa 80 je bas 10000000 u binarnom

opet1:	movb (%edx, %esi, 1), %al 	#u al imam sada el niza
		andb %cl, %al 				#proveravamo odgovarajuci bit da li je 1

		cmpb $0, %al
		je shift1
		addl $1, %ebx			#brojac jedinica			


shift1:
	addl $2, %esi				#povecavamo esi da bi pristupili sl el niza	
	shrb $1, %cl 				#siftovanje maske za jedno mesto u levo
	cmpb $0, %cl
	je analiza					#to jest kraj sad treba analiza
	jmp opet1


analiza:
	movl 12(%ebp), %edx			#sada u edx imamo adresu parametra
	movl %ebx, (%edx) 			#taj broj stavili na odg adrsu

	shrl $1, %ebx			#sada pri siftovanju u desno u carry bi trebalo da dodje 
	jc neparan					#0 ako je broj paran a 1 ako br neparan
	jnc paran
	
neparan:	movl $1, %eax		#povratna vrednost u eax
			jmp krajP

paran:		movl $0, %eax		#povratna vrednost
			jmp krajP



krajP:
popl %ebx
popl %esi
movl %ebp, %esp
popl %ebp
ret