.section .data
.section .text
.globl main
main:

 movl $3, %ebx
 movl $3, %ecx

 cmp %ecx, %ebx
 je jednako
 ja vece
 movl $2, %eax

jednako:
  movl $0, %eax
vece:
  movl $1, %eax


kraj:
   movl $1, %eax
   movl $0, %ebx
   int $0x80 
