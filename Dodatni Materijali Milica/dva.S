.section .data

string1: .ascii "Unesite ime i prezime\0"
duzina1= .-string1
string2: .ascii "Vi ste\0"
maxduzina= 40

.section .text
.globl main

main:
     movl $4, %eax  #ispisivanje "Unesite..."
     movl $1, %ebx
     leal string1, %ecx
     movl $duzina1, %edx
     int $0x80 

     movl $3, %eax  #unosenje podataka u string 2
     movl $0, %ebx
     leal string2, %ecx
     movl $maxduzina, %edx
     int $0x80  
   
    movl $string2, %eax

 provera: cmpb $96, (%eax)
          ja promena
          incl %eax
          cmpb $0, (%eax)
          je nastavak
          jmp provera

promena:
       subb $32, (%eax)
       jmp provera

nastavak:
    movl $4, %eax  #ispisivanje u string 2
     movl $1, %ebx
     leal string2, %ecx
     movl $maxduzina, %edx
     int $0x80 


	
kraj: 
	movl $1,%eax
        movl $0, %ebx
	int $0x80 
