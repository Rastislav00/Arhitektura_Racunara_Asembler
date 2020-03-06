.section .data
	poruka1: .ascii "Unesi string: "
	duzina1= .-poruka1
	ima: .ascii "String ima samoglasnik."
	dima= .-ima
	nema: .ascii "String nema samoglasnik."
	dnema= .-nema
	MAX=40
	string: .fill MAX
	a: .byte 0
	i: .byte 0
	e: .byte 0
	o: .byte 0
	u: .byte 0
.section .text
.globl main
main:
ispis1:
	movl $4,%eax
	movl $1,%ebx
	movl $poruka1,%ecx
	movl $duzina1,%edx
	int $0x80
upis1:
	movl $3,%eax
	movl $0,%ebx
	movl $string,%ecx
	movl $MAX,%edx
	int $0x80
pretprogram:
	movl $string,%esi
	movb $0,%cl
	movb $0,%ah
	movb $0,%al
	movb $0,%bh
	movb $0,%bl
	movb $0,%ch
nula:
	cmpb $0,(%esi)
	je racunaj
provera:
	cmpb $'a',(%esi)
	je ua
	cmpb $'e',(%esi)
	je ue
	cmpb $'i',(%esi)
	je ui
	cmpb $'o',(%esi)
	je uo
	cmpb $'u',(%esi)
	je uu
	incl %esi
	jmp nula
ua:
	incb %ah
	incl %esi
	jmp nula
ue:
	incb %al
	incl %esi
	jmp nula
ui:
	incb %bh
	incl %esi
	jmp nula
uo:
	incb %bl
	incl %esi
	jmp nula
uu:	
	incb %ch
	incl %esi
	jmp nula
racunaj:
	addb %al,%cl
	addb %ah,%cl
	addb %bl,%cl
	addb %bh,%cl
	addb %ch,%cl
	cmpb $0,%cl
	jg ispis2
ispis3:
	movl $4,%eax
	movl $1,%ebx
	movl $nema,%ecx
	movl $dnema,%edx
	int $0x80
	jmp kraj
ispis2:
	movl $4,%eax
	movl $1,%ebx
	movl $ima,%ecx
	movl $dima,%edx
	int $0x80
kraj: 
	movl $1,%eax
	movl $0,%ebx
	int $0x80
