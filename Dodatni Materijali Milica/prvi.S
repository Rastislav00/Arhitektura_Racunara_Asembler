# Smestiti ga u 8-bitnu promenljivu van_opsega i vratiti je kao izlazni kod programa.
# -5 000 000 000 == 0xFFFF FFFE D5FA 0E00
# 6 000 000 000 == 0x1 65A0 BC00
# niz: 767637222, 362168161684376, -863217638162, 72

.section .data
	NELEM = 4
	niz: .quad 767637222, 362168161684376, -863217638162, 72
	van_opsega: .byte 0
.section .text
.globl main
main:
	movl $0, %esi
petlja:
	movl niz(, %esi, 8), %eax
	movl niz+4(, %esi, 8), %edx
	cmpl $0xFFFFFFFE, %edx
	jl povecaj_vo
	jg proveri_gornju
	cmpl $0xD5FA0E00, %eax
	jb povecaj_vo
proveri_gornju:
	cmpl $0x1, %edx
	jg povecaj_vo
	jl dalje
	cmpl $0x65A0BC00, %eax
	jbe dalje
povecaj_vo:
	incb van_opsega
dalje:
	incl %esi
	cmpl $NELEM, %esi
	jb petlja
kraj:
	movl $1, %eax
	movl $0, %ebx
	movb van_opsega, %bl
	int $0x80	
		
 
