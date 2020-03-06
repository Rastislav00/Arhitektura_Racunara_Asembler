#konverzija internog u rimski
.section .data

	broj: .long 523 		#decimalni -> rimski opseg (1-1000)

	str: .fill 30,1,42 		

	niz: .long 1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1
			#  M     CM   D    CD   C    XC  L   XL  X   IX V  IV I

.section .text
.globl main
main:

	movl broj, %eax 		#broj u eax
	movl $niz, %edx 		#adresa niza u edx	
	movl $str, %ecx 		#adres stringa


rim:	cmpl (%edx), %eax
		je upisi







greska:


kraj:
movl $0, %eax
movl $1, %ebx
int $0x80