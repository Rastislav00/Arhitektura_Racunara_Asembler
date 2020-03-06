.section .data
MAX=20
NELEM=10
string:		.fill 10*20
.section .text
.globl main
main:
	movl $string, %esi
	movl $NELEM, %edi
petlja:
	movl $3, %eax
	movl $0, %ebx
	movl %esi, %ecx
	movl $MAX,%edx
	int $0x80
	addl $20,%esi
	decl %edi
	cmpl $0,%edi
	jne petlja
	movl $NELEM,%edi
	subl $20,%esi
ispis:
	movl $4,%eax
	movl $1,%ebx
	movl %esi, %ecx
	movl $MAX,%edx
	int $0x80
	decl %edi
	subl $20,%esi
	cmpl $0,%edi
	jne ispis
kraj:
	movl $1,%eax
	movl $0,%ebx
	int $0x80

