#konverzija stringa u oktalni interni 
.section .data

	str: .ascii "25693\0"			#string koji cemo da konvertujemo

	rez: .long 0					#rezultat konverijze

.section .text
.globl main
main:
		movl $0, %ebx			#treba proveriti dal su cifre ispravne
		movl $str, %ecx 		#adresa stringa
		movb (%ecx), %bl 
		cmpb $0, %bl
		je greska				#greska prazan string



provera:	movb (%ecx), %bl

			cmpb $0, %bl
			je konverzija 		#skok sa ovog uslova znaci da je ceo str ok

			cmpb $'0', %bl
			jl greska 			#skoci za manje, 
								#dozvoljavamo samo cifre od 0 do 7	
			cmpb $'7', %bl
			jg greska  			#jg skoci za vece

			addl $1, %ecx 		#brojac za pristupanje el stringa
			jmp provera


konverzija:

	movl $str, %ecx 			#adresa stringa u ecx
	movl $8, %esi 				#osnova brojnog sistema okalnih br
	movl $0, %ebx 				#zbog registra bl konverijze
	movl $0, %eax 				#rezultat u eax
	movl $0, %edx				#zbog para edx:eax

konv:	movb (%ecx), %bl			#hvatanje odgovarajucih karaktera 
		cmpb $0, %bl 				#dal nismo uhvatili slucajno vec nulterminator
		je krajK
		subb $'0', %bl 				#dobijanje pravih brojeva

		mull %esi					#eax*esi -> edx:eax	

			jc greska				#dal nije vece od 32bita
			cmpl $0, %edx
			jne greska				#jne nije jednako


		addl %ebx, %eax 			#smestanje dobijenih brojeva u rezultat u eax
		jc greska					#jer mozemo izaci iz opsega
		movl $0, %ebx 				#praznjenje ebx zbog novog karaktera
		addl $1, %ecx 				#pristupanje sl karakteru stringa

		jmp konv




krajK:	movl %eax, rez
		jmp kraj

greska:	movl $1, %eax
		jmp kraj



kraj:
movl $0, %eax
movl $1, %ebx
int $0x80
























