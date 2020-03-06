.section .data

	str: .fill 1,1,32 

	

.section .text
.globl main
main:

	movl $0, %ebx
	movl $str, %ecx 
	
	trazi1: movb (%ecx), %bl
		cmpb $0, %bl
		je krajS1
		addl $1, %ecx
		jmp trazi1

krajS1:


	movl $3, %eax 				#u eax imamo broj unetih cifara
	movl $0, %ebx
	movl $str, %ecx
	movl $10, %edx 
	int $0x80

	#ok u eax ce uci toliko karaktera kolko smo nakucali al ce i tipka enter na kraju da udje tako da n+1


	#aj da vidimo sta se desava sa stringom
	
	movl $0, %ebx
	movl $str, %ecx 
	
	trazi:  movb (%ecx), %bl
		cmpb $0, %bl
		je krajS
		addl $1, %ecx
		jmp trazi



krajS:





kraj:
movl $0, %eax
movl $1, %ebx
int $0x80



#poenta je znaci da kad imas .fill 10,1,32 to znaci obezbedi mi 10 komada velicine 1 bajt i smesti ascii kod 32
#ako ukucam 10 to znaci da cu moci da unesem 10 karaktera a na 11 mestu se automatsi nalazi \0 kojeg fill stavlja
#medjutim kad unosim string preko terminala ja ukucam abc i stisnem enter i taj enter udje u string zato nama treba 11 mesta 
#ako zelimo da unesemo broj od 10 cifra jer moramo na kraju i enter da kliknemo znaci "xxxxxxxxx\n\0"









