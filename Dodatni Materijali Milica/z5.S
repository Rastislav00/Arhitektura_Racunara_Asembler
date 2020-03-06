#Ucitati rec maksimalne duzine 20 (npr. fakultet), nju transformisanu staviti u neki string koji je vec zadat. Transformacija je ovakva : fa ak ku ul lt te et.. uz sve to ima zadata i promenljiva 'razmak' koja kad je 1, program ispisuje bas tako kao gore, a kad je 0 faakkuulltteet. (Tako nekako)
.section .data
poruka1:	.ascii "Unesite string \0"
duzina1=.-poruka1
poruka2:	.ascii "Unesite 1 za razmake ili 0 za bezrazmaka \0"
duzina2=.-poruka2
poruka3:	.ascii "Niste uneli ni 1 ni 0. \0"
duzina3=.-poruka3
MAX=20
string:		.fill MAX
string2:	.fill MAX
zadats:		.fill MAX
broj: .long 0
.section .text
.globl main
main:
	movl $4,%eax
	movl $1,%ebx	
	movl $poruka1,%ecx
	movl $duzina1,%edx
	int $0x80
unesi:
	movl $3,%eax
	movl $0,%ebx	
	movl $string,%ecx
	movl $MAX,%edx
	int $0x80
ispis1:
	movl $4,%eax
	movl $1,%ebx	
	movl $poruka2,%ecx
	movl $duzina2,%edx
	int $0x80
unesi1:
	movl $3,%eax
	movl $0,%ebx	
	movl $string2,%ecx
	movl $MAX,%edx
	int $0x80
pretprogram:
	movl $string2,%edi
	movl $string, %ecx
	movl $string, %edx
	incl %edx
	movl $zadats,%esi
provera:
	cmpb $'0',(%edi)
	je bez
	cmpb $'1',(%edi)
	je sa
	jmp greska
greska:
	movl $4,%eax
	movl $1,%ebx	
	movl $poruka3,%ecx
	movl $duzina3,%edx
	int $0x80
	jmp kraj
bez:
	movb (%ecx), %al
	movb %al,(%esi)
	incl %ecx
	incl %esi
	movb (%edx),%al
	movb %al,(%esi)
	incl %edx
	incl %esi
	cmpb $0,1(%edx)
	je stavinul
	jmp bez
stavinul:
	movb $10,(%esi)
stampaj:
	movl $4,%eax
	movl $1,%ebx	
	movl $zadats,%ecx
	movl $MAX,%edx
	int $0x80
	jmp kraj
sa:
	movb (%ecx), %al
	movb %al,(%esi)
	incl %ecx
	incl %esi
	movb (%edx),%al
	movb %al,(%esi)
	incl %edx
	incl %esi
	movb $' ',(%esi)
	incl %esi
	cmpb $0,1(%edx)
	je stavinulu
	jmp sa
stavinulu:
	movb $10,(%esi)
stampaj1:
	movl $4,%eax
	movl $1,%ebx	
	movl $zadats,%ecx
	movl $MAX,%edx
	int $0x80
	jmp kraj
kraj:
	movl $1,%eax
	movl $0,%ebx	
	int $0x80
