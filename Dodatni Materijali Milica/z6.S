#Uneti dva stringa: prvi (max=40 karaktera), drugi (tačno 4 karaktera). U drugi string upisati zamenu slova npr. " M=t" i program bi trebalo da u prvom stringu gde god naiđe na slovo M zameni slovom t. 
#Primer:
#Prvi string: Mama
#Drugi string: M=t 
#Rezultat: tama 
#(ako se unese veliko veliko menjas,ako se unese malo malo menjas)
.section .data
poruka1: .ascii "Unesite string od max 40 clanova \0"
duzina1=.-poruka1
poruka2: .ascii "Unesite string od max 4 clana u obliku a=b \0"
duzina2=.-poruka2
MAX1=40
MAX2=4
string1: .fill MAX1
string2: .fill MAX2
.section .text
.globl main
main:
	movl $4,%eax
	movl $1,%ebx
	movl $poruka1,%ecx
	movl $duzina1,%edx
	int $0x80
unos:
	movl $3,%eax
	movl $0,%ebx
	movl $string1,%ecx
	movl $MAX1,%edx
	int $0x80
ispis:
	movl $4,%eax
	movl $1,%ebx
	movl $poruka2,%ecx
	movl $duzina2,%edx
	int $0x80
unos1:
	movl $3,%eax
	movl $0,%ebx
	movl $string2,%ecx
	movl $MAX2,%edx
	int $0x80
pretprogram:
	movb (%ecx), %al
	movb 2(%ecx),%bl
	movl $string1,%ecx
proveri:
	cmpb (%ecx),%al
	je zameni
	incl %ecx
	cmpb $0, (%ecx)
	je ispisi
	jmp proveri
zameni:
	movb %bl,(%ecx)
	incl %ecx
	cmpb $0, (%ecx)
	je ispisi
	jmp proveri
ispisi:
	movl $4,%eax
	movl $1,%ebx
	movl $string1,%ecx
	movl $MAX1,%edx
	int $0x80
kraj:
	movl $1,%eax
	movl $0,%ebx
	int $0x80	
