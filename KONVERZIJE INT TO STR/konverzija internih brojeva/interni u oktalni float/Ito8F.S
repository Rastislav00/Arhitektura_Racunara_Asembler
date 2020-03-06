#==========================================================================
#interni u oktalni (pozitivni)(float)
.section .data

	broj: .long 27563275 			#31250000 == 0.3125x10^8 == 0.24 (8)
	n: .long 20 						#max dozvoljeni broj cifara iza zareza

	str: .fill 30,1,42 				#.fill broj, veličina, vrednost

.section .text
.globl main
main:
#=====================START==============================================
	movl broj, %eax 				#u eax imamo broj

	addl $3, n 						#zbog 0. i null terminatora
	movl $str, %ecx 				#adresa stringa u ecx

		cmpl $4, n 					#
		jl greska					#jl manje 

			movb $'0', (%ecx)
			addl $1, %ecx
			movb $'.', (%ecx)
			addl $1, %ecx
			movl $3, %esi 			#brojac za bufer
	subl $3, n
#=========================================================================
konv:	movl $8, %ebx		
		mull %ebx						#eax*operand -> edx:eax

		movl $100000000, %ebx
		divl %ebx						#edx:eax/operand -> eax, ostatak -> edx

		addb $'0', %al 					#da bi pokazivali na kodove iz ascii
		movb %al, (%ecx)				#smestanje odg karaktera u odg poziciju stringa
		addl $1, %ecx 					#pristupanje sl el stringa
		addl $1, %esi  					#esi brojac karaktera
		movl %edx, %eax
		movl $0, %edx

				#provere
				subl $1, n 
				cmpl $0, n 
				jle krajA

				cmpl $0, %eax
				je krajA
				jmp konv


krajA:
	movb $10, (%ecx)				#stavljanje entera na kraj stringa

	movl $4, %eax
	movl $1, %ebx
	movl $str, %ecx
	movl %esi, %edx 
	int $0x80
	jmp kraj



greska:



kraj:
movl $0, %eax
movl $1, %ebx
int $0x80
#========================KRAJ==================================================










