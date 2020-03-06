#Za uneti string sa tastature proveri da li sadrzi vise slova ili znakova koji nisu slova

.section .data

 msg: .ascii "Unesite string: \0"
 str_len = . - msg

 msg1: .ascii "vise SLOVA \0"
 str_len1 = . - msg1

 msg2: .ascii "vise NE SLOVA \0"
 str_len2 = . - msg2

 msg3: .ascii "ISTI BROJ\0"
 str_len3 = . - msg3

 rec: .fill 50,1,42
 broj_reci: .long 0


	S: .long 0		#broj slova

	K: .long 0		#broj karaktera koji nisu slova




.section .text
.globl main
main:

#=============RASTISLAV==============

	
	movl $4, %eax
	movl $1, %ebx
	movl $msg, %ecx
	movl $str_len, %edx
	int $0x80

	#sada treba unos

	movl $3, %eax
	movl $0, %ebx
	movl $rec, %ecx
	movl $50, %edx
	int $0x80

	movl %eax, broj_reci		#sada ovde imamo broj karaktera naseg unetog stringa
	

	movl $rec, %eax			#adresa stringa u eax
	jmp opet1

opet:	addl $1, %eax
opet1:	cmpb $10, (%eax)
	je racun



	cmpb $'A', (%eax)
	jl karakter			#jl manje
	jge cmp1			#jge vece ili jednako

cmp1:	cmpb $'Z', (%eax)
	jle slovo			#jle manje ili jednako

cmp2:	cmpb $'a', (%eax)
	jl karakter			#jl manje	

cmp3:	cmpb $'z', (%eax)
	jle slovo			#jle manje ili jednako	
	jg karakter			#jg vece



karakter:	addl $1, K
		jmp opet

slovo:		addl $1, S
		jmp opet


racun:	movl K, %eax
	cmpl %eax, S
	je isto
	jg vise
	jl manje
	



vise:	movl $4, %eax
	movl $1, %ebx
	movl $msg1, %ecx
	movl $str_len1, %edx
	int $0x80
	jmp kraj

manje:	movl $4, %eax
	movl $1, %ebx
	movl $msg2, %ecx
	movl $str_len2, %edx
	int $0x80
	jmp kraj

isto:	movl $4, %eax
	movl $1, %ebx
	movl $msg3, %ecx
	movl $str_len3, %edx
	int $0x80
	jmp kraj




kraj:
movl $1, %eax
movl $0, %ebx
int $0x80
