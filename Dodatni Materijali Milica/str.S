.section .data
string1: .ascii " abcd   \0"
.section .text
.globl main
main:

	movl $string1, %eax
kraj_s:
	cmpb $0, (%eax)
	je razmaci
	incl %eax
	jmp kraj_s
razmaci:
	cmpb $' ', -1(%eax)
	jne izbaci
	decl %eax
	jmp razmaci
izbaci:
	movb $0, (%eax)

	
kraj: 
	movl $1,%eax
	int $0x80 
