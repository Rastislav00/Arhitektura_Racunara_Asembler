.section .data 
str1: .ascii "Unesite string:"
duz1= .-str1
str2: .ascii "Unesite pravilo:"
duz2= .-str2
max1=51
str3: .fill max1
max2=4
str4: .fill max2
duzina: .long 0
str5: .ascii "Izmenjeni string je:"
duz5= .-str5

.section .text
.globl main
main: 

 movl %eax, duzina

 movl $4, %eax
 movl $1, %ebx
 leal str1, %ecx
 movl $duz1, %edx
 int $0x80

 movl $3, %eax
 movl $0, %ebx
 leal str3, %ecx
 movl $max1, %edx
 int $0x80

 movl $4, %eax
 movl $1, %ebx
 leal str2, %ecx
 movl $duz2, %edx
 int $0x80

 movl $3, %eax
 movl $0, %ebx
 leal str4, %ecx
 movl $max2, %edx
 int $0x80

 movl $str3, %eax
 movl $str4, %ecx

poredi:
 cmpb $10, (%eax)
 je ispis
 movb (%eax), %bl
 cmpb %bl, (%ecx)
 je zameni
 incl %eax
 jmp poredi

zameni:
   addl $2, %ecx
   movb (%ecx), %dl
   movb %dl, (%eax)
   incl %eax
   subl $2, %ecx
   jmp poredi

ispis: 

 movl $4, %eax
 movl $1, %ebx
 leal str5, %ecx
 movl $duz5, %edx
 int $0x80

  movl $4, %eax
  movl $1, %ebx
  leal str3, %ecx
  movl $duzina, %edx
  int $0x80

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
