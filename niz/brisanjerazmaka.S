.section .data

  rec: .ascii "   abc   \0"


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
	jmp kraj

alg:    movb (%eax,%esi,1), %bl 	#premesti slovo sa jednog mesta ispred na ebx
	movb %bl, (%eax,%edx,1)	#premesti slovo sa ebx na jedno mesto iza

	cmpb $0, (%eax,%esi,1)		#uporedimo dal smo stigli do kraja stringa
	je cmp

	addl $1, %esi			#povecavamo brojac
	addl $1, %edx
	jmp alg








kraj:
movl $1, %eax
movl $0, %ebx
int $0x80
