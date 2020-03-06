.section .data

str1: .ascii "Unesite string1: \0"
duz1= .-str1

str2: .ascii "Izmenjeni string je: \0"
duz2= .-str2

MAX=40

ime: .fill MAX,1,0
e: .fill MAX,1,0

duzina: .long 0
R: .long 0

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
leal ime, %ecx
movl $MAX, %edx
int $0x80

movl %eax, duzina

movl $ime, %eax
movl $0, %esi
movl $e,%ecx
movl $0, %edx

poredi:
cmpb $10, (%eax)
je kraj1

cmpb $'A',(%eax)
je izmena

cmpb $'E',(%eax)
je izmena

cmpb $'I',(%eax)
je izmena

cmpb $'O',(%eax)
je izmena

cmpb $'U',(%eax)
je izmena

cmpb $'a',(%eax)
je izmena

cmpb $'e',(%eax)
je izmena

cmpb $'i',(%eax)
je izmena

cmpb $'o',(%eax)
je izmena

cmpb $'u',(%eax)
je izmena

jmp dodaj

dodaj:
movb (%eax),%dl
movb %dl,(%ecx)
incl %ecx
jmp nastavi

izmena:
movb $'#',(%ecx)
incl %ecx 
incl R
jmp nastavi

nastavi:
incl %eax
jmp poredi

kraj1:

movl %ecx, ime

movl $4, %eax
movl $1, %ebx
leal str2, %ecx
movl $duz2, %edx
int $0x80

movl $4, %eax
movl $1, %ebx
leal e, %ecx
movl duzina, %edx
int $0x80

kraj:
movl $1, %eax
movl R, %ebx
int $0x80



