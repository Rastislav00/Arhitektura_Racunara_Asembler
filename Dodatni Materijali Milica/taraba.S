.section .data

string1: .ascii "Unesite string:\0"
duzina1=.-string1
string2: .ascii "Izmenjeni string je:\0"
duzina2=.-string2
maxduzina=50
unesi: .fill maxduzina
uneto:.long 0

.section .text
.global main

 main:

 movl $4, %eax
 movl $1, %ebx
 leal string1, %ecx
 movl $duzina1, %edx
 int $0x80

 movl $3, %eax
 movl $0, %ebx
 leal unesi, %ecx
 movl $maxduzina, %edx
 int $0x80

 movl %eax, uneto
  
 movl $unesi, %eax

provera:
 cmpb $10, (%eax)
 je ispis
 cmpb $32 , (%eax)
 je izmeni
 cmpb $'a', (%eax)
 je izmeni
 cmpb $'e', (%eax)
 je izmeni
 cmpb $'i', (%eax)
 je izmeni
 cmpb $'o', (%eax)
 je izmeni
 cmpb $'u', (%eax)
 je izmeni

dodaj:
  incl %eax
  jmp provera

 izmeni:
  movb $'#', (%eax)
  incl %eax
  jmp provera

ispis:
 movl $4, %eax
 movl $1, %ebx
 leal string2, %ecx
 movl $duzina2, %edx
 int $0x80

 movl $4, %eax
 movl $1, %ebx
 leal unesi, %ecx
 movl $uneto, %edx
 int $0x80

kraj:
    movl $1, %eax
    movl $0, %ebx
    int $0x80
