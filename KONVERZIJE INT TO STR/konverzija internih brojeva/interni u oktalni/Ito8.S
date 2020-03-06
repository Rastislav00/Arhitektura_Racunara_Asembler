#konverzija iz internog u oktalni (pozitivni brojevi) (algoritam)

.section .data

	broj: .long 586

	br: .long 1				#broj karaktera u stringu

	str: .fill 30,1,42		#.fill broj, veličina, vrednost

.section .text
.globl main
main:

	movl $str, %ecx 	#u ecx imamo adresu stringa
	movl broj, %eax		#broj u registar
	movl $8, %ebx		#baza sa kojom cemo da delimo brojeve
	movl $0, %edx 		#zbog deljenja 

opet:	divl %ebx 			#edx:eax/operand -> eax, ostatak -> edx

		addb $'0', %dl 		#u dl nam je ostatak deljenja 

		cmpb $0, (%ecx)		#provera dal nismo dosli do kraja stringa
		je greska			#ako da onda smo ispucali sve pozicije 

		movb %dl, (%ecx)	#stavljamo odg string na odg poziciju stringa
		addl $1, %ecx 		#da bi pristupali sl el stringa
		addl $1, br 		#brojac da bi na kraju znao koliko treba bafer
							#u sistemskom pozivu da bude
		movl $0, %edx 		#ne treba da imamo ostatak vise iskoristili smo ga vec

		cmpl $0, %eax 		#pravera dal smo zavrsili konverziju
		je alg
		jmp opet

alg:						#algoritam za obrtanje stringa
	movb $10, (%ecx)		#ovo je enter
	subl $1, %ecx 			#pre skoka u ovu petlja ecx se uveca za sledeci, 
							#pa ga sad treba vratiti na onaj zadnji uneti karakter
	movl $0, %ebx			#anuliranje registra ebx zbog podregistra bl
	movl $0, %eax 			#nuliranje zbog dl
	movl $str, %edx			#adresa stringa u edx time pristupam prvom el str

obrni:	movb (%edx), %bl		#u bl odg karakter stringa spreda
		movb (%ecx), %al 		#u dl odg karakter stringa od pozadi

		movb %bl, (%ecx)
		movb %al, (%edx)

		addl $1, %edx 			#da bi pristupili sledecem el
		subl $1, %ecx			#da bi pristupili prethodnom el

		cmpl %edx, %ecx
		jle dalje				#kad ecx bude manji ili jednak to je to kraj
		jmp obrni

dalje:
	movl $4, %eax
	movl $1, %ebx
	movl $str, %ecx
	movl br, %edx
	int $0x80

	jmp kraj



greska:



kraj:
movl $0, %eax
movl $1, %ebx
int $0x80




