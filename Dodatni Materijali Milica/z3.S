#Jedan niz, prebrojati parne i neparne i ispisati vise parni, vise neparnih ili jednako parnih-neparnih
.section .data
NELEM=10
niz:	.long 1,2,3,4,5,6,7,8,9,10
poruka1: .ascii "ima vise parnih \n"
duzina1= . - poruka1
poruka2: .ascii "ima vise neparnih \n"
duzina2= . - poruka2
poruka3: .ascii "ima ih jednako\n"
duzina3= . - poruka3
.section .text
.globl main
main:
	movl $2,%ebx
	movl $niz,%ecx
	movl $0,%edi #neparni
	movl $0,%esi #parni
proveri:
	movl (%ecx),%eax
	xorl %edx, %edx
	divl %ebx
	cmpl $1,%edx
	je nijep
	jmp jestep
nijep:
	incl %edi
	addl $4,%ecx
	cmpl $niz+NELEM*4,%ecx
	je oduzmi
	jmp proveri
jestep:
	incl %esi
	addl $4,%ecx
	cmpl $niz+NELEM*4,%ecx
	je oduzmi
	jmp proveri
oduzmi:
	movl %edi,%eax
	movl %esi,%ebx	
	cmpl %edi,%esi
	jg jeste
	cmpl %eax,%ebx
	jl nije
	jmp jednako
nije:
	movl $4,%eax
	movl $1,%ebx
	movl $poruka2,%ecx
	movl $duzina2,%edx
	int $0x80
	jmp kraj
jeste:
	movl $4,%eax
	movl $1,%ebx
	movl $poruka1,%ecx
	movl $duzina1,%edx
	int $0x80
	jmp kraj
jednako:
	movl $4,%eax
	movl $1,%ebx
	movl $poruka3,%ecx
	movl $duzina3,%edx
	int $0x80
	jmp kraj
kraj:
	movl $1,%eax
	movl $0,%ebx
	int $0x80
