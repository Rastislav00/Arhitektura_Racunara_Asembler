# Sa standardnog ulaza uneti dva stringa do 20 karaktera i izbrojati koliko puta se znak '+'
# pojavljuje u prvom stringu, a koliko puta se znak '-' pojavljuje u drugom stringu.
# Ako ima vise znakova '+', u 8-bitnu promenljivu R smestiti vrednost 1, ako ih ima manje, smestiti
# vrednost 2, a ako ih ima jednak broj, smestiti vrednost 3. Promenljivu R vratiti kao izlazni kod programa

.section .data
	MAX_DUZ = 21
	unesi_str1: .ascii "Unesite prvi string"
	unesi_str1_duz = .-unesi_str1
	unesi_str2: .ascii "Unesite drugi string"
	unesi_str2_duz = .-unesi_str2
	str1: .fill MAX_DUZ, 1, 0
	str2: .fill MAX_DUZ, 1, 0
	br1: .long 0
	br2: .long 0
	R: .byte 0
.section .text
.globl main
main:
	movl $0, %esi
	movl $0, %edi
	
	movl $4, %eax
	movl $1, %ebx
	leal unesi_str1, %ecx #movl $string1
	movl $unesi_str1_duz, %edx
	int $0x80	

