.section .data

  rec: .ascii "   abc    dgs ddd        brano      rasto kukucka  \0"

 i: .long 0
 j: .long 0

 a: .long 0


.section .text
.globl main
main:


	movl $rec, %eax		#adresa stringa u eax
	
kraj_s:	
	cmpb $0, (%eax)		#uporedi da li je na eax znak kosecrte nule
	je razmaci
	addl $1, %eax		#incl eax 
	jmp kraj_s		#while dok ne dodjemo do kraja

razmaci:
	cmpb $' ', -1(%eax)	#uporedi spejs i jedno mesto ispred mesta backslas
	je brisi		#ako je tacno onda treba obrisati spejs
	jmp napred
brisi:
	movb $0, -1(%eax)	#stavi na jedno mesto iza becklesa beckles
	subl $1, %eax		#brojac
	jmp razmaci

napred:				#brisanje razmaka sa prednje strane
	movl $rec, %eax		#stavili smo pocetnu adresu stringa na eax
	movl $1, %esi		#esi i edx su brojaci
	movl $0, %edx
	
cmp:	cmpb $' ', (%eax)
	movl $1, %esi		#uvek treba da krece od 1 a onaj ispod od 0
	movl $0, %edx
	je alg
	jmp srednje_pauze

alg:    movb (%eax,%esi,1), %bl 	#premesti slovo sa jednog mesta ispred na ebx
	movb %bl, (%eax,%edx,1)	#premesti slovo sa ebx na jedno mesto iza

	cmpb $0, (%eax,%esi,1)		#uporedimo dal smo stigli do kraja stringa
	je cmp

	addl $1, %esi			#povecavamo brojac
	addl $1, %edx
	jmp alg


srednje_pauze: 				#srednja pauza algoritam da skrati spejsove u sredini texta
					#ovaj kod radi tako sto ide redom i proverava dal su dve pauze jedna za drugom
					#ako nema pauze ide dalje
					#ako ima jedne pauze proverice dal ima jos jedne
					#ako su dva spejsa znaci treba sve pomerati u levo
					#nakon ove akcije treba sve otpocetka proveravati
					
	
	movl $rec, %eax
	movl $1, %esi
	movl $0, %edx
	jmp cmp1

dalje:  addl $1, %esi
	addl $1, %edx
dalje1:	cmpb $0, (%eax,%edx,1)		#pogledaj dal nismo stigli do kraja sa proveravanjem ako jesmo gotovo
	je kraj_a               	#ovo je kraj algoritma
	jmp cmp1



cmp1:   cmpb $' ', (%eax, %edx,1)
	je cmp2
	jmp dalje
cmp2:   cmpb $' ', (%eax, %esi,1)
	je alg1	
	jmp dalje



alg1:				#ovde mogu da menjam esi i edx jer na kraju petlje ih vracam na nulu i jedan
				#ovaj algoritam treba da premesta spejsove

	movl %esi, i		#ovo sam cisto radi reda da u memoriji imam broje ovih registara ako zatreba
	movl %edx, j

	
	
alg3:	movb (%eax, %esi, 1), %bl
	movb %bl, (%eax, %edx, 1)

	cmpb $0, (%eax, %esi, 1)
	je alg2

	addl $1, %esi
	addl $1, %edx
	jmp alg3



alg2:	movl $1, %esi
	movl $0, %edx
	jmp dalje1

kraj_a:				






kraj:
movl $1, %eax
movl $0, %ebx
int $0x80
