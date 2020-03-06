#Sa standardnog ulaza uneti 2 stringa. Izbrojati koliko puta se u prvom stringu pojavljuje znak '+', i koliko puta se u drugom stringu pojavljuje znak '-'. Ako se '+' pojavljuje veci broj puta nego '-', u 8-bitnu promenljivu R smestiti vrednost 1. Ako ima vise znakova '-', smestiti 2, a ako ih je jednak broj / smestiti vrednost 3. R vratiti kao izlazni kod programa.
.section .data
str1: .ascii "Unesite prvi string:\0"
duz1=.-str1
str2: .ascii "Unesite drugi string:\0"
duz2=.-str2
max=50
prvi:.fill max
drugi:.fill max

brojpluseva: .long 0
brojminuseva:.long 0
R:.byte 0

.section .text
.globl main

main:

 movl $4, %eax
 movl $1, %ebx
 leal str1, %ecx
 movl $duz1, %edx
 int $0x80

 movl $3, %eax
 movl $0, %ebx
 leal prvi, %ecx
 movl $max, %edx
 int $0x80
 
 movl $4, %eax
 movl $1, %ebx
 leal str2, %ecx
 movl $duz2, %edx
 int $0x80

 movl $3, %eax
 movl $0, %ebx
 leal drugi, %ecx
 movl $max, %edx
 int $0x80

 movl $prvi, %eax
 movl $drugi, %ebx
 
provera1:
 cmpb $10, (%eax)
 je provera2
 cmpb $'+', (%eax)
 je povecaj1
 incl %eax
 jmp provera1

povecaj1:
   incl brojpluseva
   incl %eax
   jmp provera1

provera2:
 cmpb $10, (%ebx)
 je poredi
 cmpb $'-', (%ebx)
 je povecaj2
 incl %ebx
 jmp provera2

povecaj2:
  incl brojminuseva
  incl %ebx
  jmp provera2

 poredi:
 movb brojpluseva, %cl
 movb brojminuseva, %dl
 cmpb %cl, %dl
 je trojka
 jg dvojka
 movb $1, R
 jmp kraj

trojka:
 movb $3, R
 jmp kraj

dvojka:
 movb $2, R

kraj:
    movl $1, %eax
    movl $0, %ebx
    movb R, %bl
    int $0x80


























 















