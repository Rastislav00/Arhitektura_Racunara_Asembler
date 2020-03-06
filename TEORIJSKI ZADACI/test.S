#============TEST================
.section .data

	bajt: .byte 0xff, 0x64

	rec: .word 0xee56, 0x2, 0x32

	duga_rec: .long 0xabcd1234, 0x5, 0xff

.section .text
.globl main
main:
#===============START====================
#da bi se ispratile vrednosti potrebno je otvoriti debager koristiti eax i pokayati eeax u hexadecimalnim vrednostima vrednosti
	movl $0, %eax
	

	movb duga_rec, %al
	movb duga_rec+1, %al
	movb duga_rec+2, %al
	movb duga_rec+3, %al
	movb duga_rec+4, %al
	movb duga_rec+5, %al
	movb duga_rec+6, %al
	movb duga_rec+7, %al
	movb duga_rec+8, %al
	movb duga_rec+9, %al
	movb duga_rec+10, %al
	movb duga_rec+11, %al
	movb duga_rec+12, %al
	movb duga_rec+13, %al
	movb duga_rec+14, %al
	movb duga_rec+15, %al
	movb duga_rec+16, %al

	movl $0, %eax

	movw duga_rec, %ax
	movw duga_rec+1, %ax
	movw duga_rec+2, %ax
	movw duga_rec+3, %ax
	movw duga_rec+4, %ax
	movw duga_rec+5, %ax
	movw duga_rec+6, %ax
	movw duga_rec+7, %ax
	movw duga_rec+8, %ax
	movw duga_rec+9, %ax
	movw duga_rec+10, %ax
	movw duga_rec+11, %ax
	movw duga_rec+12, %ax

	movl $0, %eax

	movl duga_rec, %eax
	movl duga_rec+1, %eax
	movl duga_rec+2, %eax
	movl duga_rec+3, %eax
	movl duga_rec+4, %eax
	movl duga_rec+5, %eax
	movl duga_rec+6, %eax
	movl duga_rec+7, %eax
	movl duga_rec+8, %eax


	#pravilan pristup pri koriscenju bajtova npr movb je +1 (al)
	#pravilan pristup pri koriscenju reci, tj words je movw +2 (ax)
	#pravilan pristup pri koriscenju dugih reci tj long je movl +4 (eax)

	#primer pravilnog koriscenja longa
	movl $0, %eax

	movl duga_rec, %eax
	movl duga_rec+4, %eax

	#primer pravilnog pristupanja za word
	movl $0, %eax	#samo zbog anuliranja vrednosti registra

	movw duga_rec, %ax
	movw duga_rec+2, %ax
	movw duga_rec+4, %ax
	movw duga_rec+6, %ax
#========================================================
	movl $0, %eax


	movb bajt, %al
	movw bajt, %ax
	movl bajt, %eax













kraj:
movl $1, %eax
movl $0, %ebx
int $0x80







































