#konvertovanje stringa u razlomljeni broj
#0.xxx -> xxx0000  octalni (svejedno)
.section .data

	str: .ascii "0.12003546293\0"		#string koji konvertujemo

	rez: .long 0 				#rezultat konverzije

.section .text
.globl main
main:


	#treba nam prvo proveriti dal je unos tacan (0.x\0)
		movl $0, %ebx 				#nuliranje ebx zbog bl
		movl $str, %ecx 			#adresa stringa u ecx 
		movb (%ecx), %bl
		cmpb $0, %bl 				#provera dal str nije prazan
		je greska					#je jednako

		cmpb $'0', %bl
		jne greska 					#jne nije jednako mora na prvom mestu da bude 0

		addl $1, %ecx 				#pristupanje sl karakteru
		movb (%ecx), %bl
		cmpb $'.', %bl 				#mora na drugom mestu da bude tacka
		jne greska					#jne nije jednako -> greska

		addl $1, %ecx				#trecem karakteru pristupamo
		movb (%ecx), %bl			#hvatanje karaktera
		cmpb $0, %bl
		je greska 					#ni ovde ne sme da bude nul terminaot

	#sada treba proveriti ispravnost cifara unutar stringa

test: 	movb (%ecx), %bl

		cmpb $0, %bl  				#uslov da smo dosli do kraja stringa
		je konverzija

		cmpb $'0', %bl
		jl greska  					#jl manje 

		cmpb $'9', %bl
		jg greska  					#jg vece, 9 je najveca cifra deci brojeva

		addl $1, %ecx
		jmp test

konverzija: 	#ako kod dodje do ovde znaci da je uneti string ispravan
		subl $1, %ecx 				#pristupanje zadnjoj brojci neposredno pre nulterminatora

		movl $0, %eax  				#
		movl $10, %esi  			#baza u esi
		movl $0, %edx 
		movl $0, %edi  				#u edi imamo rezutlat

konv:	movb (%ecx), %bl
		cmpb $'.', %bl				#kraj konverzije ako smo dosli do tacke
		je krajK

			subb $'0', %bl 				#da bi dobijali prave cifre
			movl %ebx, %eax
			movl $100000000, %esi
			mull %esi

			addl %eax, %edi 			#u edi rezultat

			movl %edi, %eax 
			movl $10, %esi 				#10 je baza 
			divl %esi

			movl %eax, %edi 			

		subl $1, %ecx
		jmp konv 









krajK: 	movl %edi, rez 
		jmp kraj


greska:	movl $0, rez
		jmp kraj 


kraj:
movl $0, %eax
movl $1, %ebx
int $0x80

























