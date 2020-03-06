#Hexadecimalni string u inteni oblik
#dozvolje cifre 0123456789 ABCDEF abcdef
.section .data

	str: .ascii "123abc\0"

	broj: .long 0x0 			#hexa decimalni broj 

.section .text
.globl main
main:


	movl $0, %eax  			#interni oblik
	movl $16, %esi 			#baza hexa 
	movl $str, %ecx 		#adresa stringa 
	movl $0, %edx 			#zbog mnozenja 
	movl $0, %ebx 			#zbog bl


	#treba proveriti dal string nije prazan?
	cmpb $0, (%ecx)  		#dal nije \0
	je greska1
	cmpb $10, (%ecx) 		#dal nije samo enter
	je greska1 


	#treba proveriti dal su ispravne cifre unutar stringa
prov:	movb (%ecx), %bl 

		cmpb $10, %bl 			#podrazumeva se da je enter kliknut :D 
		je krajProvere

		cmpb $0, %bl 			#komentar[1]
		je krajProvere

		cmpb $'0', %bl
		jl greska2 				#skoci za jednako

		cmpb $'9', %bl
		jle cifra 				#jle skoci za manje ili jednako

		cmpb $'A', %bl
		jl greska2

		cmpb $'F', %bl
		jle cifra

		cmpb $'a', %bl
		jl greska2

		cmpb $'f', %bl
		jle cifra

		jmp greska2 			#greska2 je pogresna cifra

cifra:	addl $1, %ecx 			#da pristupimo sl karakteru stringa
		jmp prov


krajProvere: #ako skocimo vamo string je ispravan tehnicki


	movl $str, %ecx 			#da idemo ispocetka 


konv:	movb (%ecx), %bl
		#proveriti dal je 0-9, A-F, a-f
		cmpb $'9', %bl
		jle dec

		cmpb $'F', %bl
		jle V_hexa

		cmpb $'f', %bl
		jle m_hexa

dec:		subb $'0', %bl 		#da bi dobili pravu decimalnu cifru	
			jmp konvertuj

V_hexa:		subb $'A', %bl 		#da dobijemo hexa cifru
			addb $10, %bl 	 	#a one pocinju od desete cifre	
			jmp konvertuj

m_hexa:		subb $'a', %bl
			addb $10, %bl
			jmp konvertuj

konvertuj:

				mull %esi 			#eax*esi= edx:eax
				cmpl $0, %edx 
				jne greska3

				addl %ebx, %eax 	#ubacujemo prave brojke u interni
				jc greska3

				addl $1, %ecx 		#pristupanje sl karakteru stringa
				
				cmpb $10, (%ecx) 	#proveri dal nije doslo do entera
				je krajK

				cmpb $0, (%ecx) 	#proveri kraj stringa
				je krajK 

				jmp konv


krajK:
movl %eax, broj
jmp kraj 

greska1:
greska2:
greska3:



kraj:
movl $1, %eax
movl $0, %ebx
int $0x80
#============================

#komentar[1]: sta aako string nema entera tj dal je moguce ukucati
#neki string i da iskoristimo sve karaktere i da nema mesta za enter
# da li se takav slucaj moze desiti ???
#ono sto znamo sigurno je da moze da se ne unese enter kucajuci prek
#preko ovog fajla kao sto trenutno ni nema entera :D 

#pri konverziji treba voditi racuna dal je cifra 0-9 A-F a-f
#jer se razlicite konstante oduzimaju od ascii karaktera


































