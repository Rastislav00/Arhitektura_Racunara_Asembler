#deljenje preko oduzimanaj u dvostrukoj preciznosti
#==================================================
.section .data

	a: .quad 12345678
	b: .quad 912
	k: .quad 0		#kolicnik
	o: .quad 0		#ostatak


.section .text
.globl main
main:
#================DELJENJE U DVOSTRKOJ PREZIZNOSTI===========


	movl a, %eax
	movl a+4, %ebx

	movl b, %ecx
	movl b+4, %edx

cmp1:	cmpl $0, %ecx		#ne smemo da daleimo sa nulom pa proveravamo dal je nula manje znacajna cifra
	je cmp2			#ako jeste treba da vidimo za vise znacajne, ako nije idemo dalje moze da se deli
	jmp dalje1
cmp2:	cmpl $0, %edx		#ako je i vise znacajna cifra nula onda je to nula i ne mozemo delitii
	je kraj		

dalje1:
				#treba jos uporediti dal je veci a ili b jer ako je a manji onda ne mozemo deliti
opet:	cmpl b+4, %ebx
	je cmp3
	jl stop			#jl manje , postoji sansa da imamo ostatak neki

cmp3:	cmpl b, %eax
	jl stop

	subl b, %eax
	sbbl b+4, %ebx
	
	addl $1, k
	adcl $0, k
	jmp opet







stop:
	movl %eax, o
	movl %ebx, o+4
















kraj:
movl $1, %eax
movl $0, %ebx
int $0x80
#=================KRAJ=====================================




