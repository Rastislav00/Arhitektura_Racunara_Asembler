.section .data
.section .text
.global main
main:

        movl $5, %eax
	movl $25, %ebx

prov:   cmpl %eax, %ebx
	je exit
	ja vece
	subl %ebx, %eax
	jmp prov	

vece:   subl %eax, %ebx
	jmp prov






exit:
movl $1, %eax
movl $0, %ebx
int $0x80

