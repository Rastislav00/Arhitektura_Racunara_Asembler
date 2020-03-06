#Izmeniti uneti string tako da samoglasnici postanu tarabe i prebrojati samoglasnike
.section .data

str1: .ascii "Unesite string1: \0"
duz1= .-str1

str2: .ascii "Izmenjeni string je: \0"
duz2= .-str2

MAX=40

ime: .fill MAX,1,0

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

provera:
cmpb $10, (%eax)
je ispis

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

incl %eax
jmp provera

izmena:
 movb $'#',(%eax)
 incl %eax 
 incl R
 jmp provera

ispis:
 movl $4, %eax
 movl $1, %ebx
 leal str2, %ecx
 movl $duz2, %edx
 int $0x80

 movl $4, %eax
 movl $1, %ebx
 leal ime, %ecx
 movl duzina, %edx
 int $0x80

kraj:
 movl $1, %eax
 movl R, %ebx
 int $0x80

