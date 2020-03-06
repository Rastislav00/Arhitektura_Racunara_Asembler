.section .data
.section .text
.globl main
main:


 movl $0, %eax
 movl $10, %ecx

uporedi:
 cmp $0, %ecx
 je kraj
 ja dodaj

dodaj:
   addl %ecx, %eax
   decl %ecx
   jmp uporedi

kraj:
   movl $1, %eax
   movl $0, %ebx
   int $0x80 
