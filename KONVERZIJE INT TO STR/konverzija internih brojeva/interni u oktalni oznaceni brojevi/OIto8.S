#Iz internog u oktalni u string al oznaceni brojevi (+-)...

.section .data

	broj: .long -20686			#broj koji cemo da konvertujemo u string
	n: .long 1 					#broj konvertovanih karaktera

	str: .fill 30,1,42			#.fill broj, veličina, vrednost

.section .text
.globl main
main:

	movl broj, %eax 			#u eax broj koji konvertujemo
	movl $8, %ebx 				#baza 8 zbog oktalnih brojeva
	movl $0, %edx 				#treba nam prazan edx zbog deljenja
	movl $str, %ecx 			#adresa stringa 

	#na pocetku treba proveriti dali je uneti broj pozitivan ili negativan
	andl %eax, %eax				#ovo ce samo da postavi status registre nece promeniti eax
	jns deli					#skoci ako nije minus jump for not sign

			movb $'-', (%ecx)			#stavljamo minus ispred stringa
			addl $1, %ecx		
			negl %eax 					#negiranje +1 (komplement 2 prestava)
			addl $1, n 					#brojac karaktera

deli:	divl %ebx 					#edx:eax/operand -> eax, ostatak -> edx
		addb $'0', %dl 				#uvecavamo ga da bi naboli kod u stringu

		cmpb $0, (%ecx)				#dal smo dosli do kraja stringa
		je greska

		movb %dl, (%ecx)			#stavljanje karaktera na odg mesto u stringu
		addl $1, %ecx 				#da bi pristupili sl el stringa
		addl $1, n    				#brojac karaktera

		movl $0, %edx 				#treba da praznimo edx zbog deljenja

		cmpl $0, %eax				#provera dal smo sve vec ispucali
		je alg
		jmp deli

alg:
	movb $10, (%ecx)			#enter na kraju stringa
	subl $1, %ecx				#da pristupimo posljenjem karakteru
	movl $0, %ebx				#nuliranje zbog bl
	movl $0, %eax				#nuliranje zbog al
	movl $str, %edx				#adresa stringa u eax

			cmpb $'-', (%edx)			#siftovanje u slucaju da imamo minus ispred
			jne obrni					#jne nije jednako
			addl $1, %edx				#pristupanje sl el stringa

obrni:	movb (%edx), %al
		movb (%ecx), %bl

		movb %al, (%ecx)
		movb %bl, (%edx)

		addl $1, %edx
		subl $1, %ecx

		cmpl %edx, %ecx
		jle dalje					#jle manje ili jednako
		jmp obrni


dalje:						#sistemski poziv za ispis na terminal
	movl $4, %eax
	movl $1, %ebx
	movl $str, %ecx
	movl n, %edx
	int $0x80
	jmp kraj




greska: 	



kraj:
movl $0, %eax
movl $1, %ebx
int $0x80



















