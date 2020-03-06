.section .data

NELEM=3

niz1: .quad 232,345,655
niz2: .quad 54,878,655
c: .quad 0,0,0



.section .text
.globl main
main:





subl $1,NELEM
movl $0, %esi
movl $0, %edi
movl $0, %eax
petlja:

cmpl $0,NELEM
je kraj

 movl niz1(,%esi,8), %ecx
 movl niz1+4(,%esi,8), %edx

petlja1:

cmpl %edi,$3
je petlja

cmpl %ecx, niz2(,%edi,8)
ja dodaj
jb dodaj
cmpl %edx, niz2+4(,%edi,8)
ja dodaj
jb dodaj

incl %edi
jmp petlja1



dodaj:

movl %ecx, c(,%eax,8)
movl %edx, c+4(,%eax,8)

incl %eax
jmp petlja



kraj:
movl $1, %eax
movl %eax, %ebx
int $0x80
