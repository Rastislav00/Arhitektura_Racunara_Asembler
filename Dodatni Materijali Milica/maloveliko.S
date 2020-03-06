.section .data

string1: .ascii "Unesite ime i prezime:\0"
duzina1= .-string1
string2: .ascii "Vi ste:\0"
duzina2= .-string2
maxduzina= 40
ulaz: .fill maxduzina
duzina: .long 0

.section .text
.globl main

main:
     movl $4, %eax  #ispisivanje "Unesite..."
     movl $1, %ebx
     leal string1, %ecx
     movl $duzina1, %edx
     int $0x80 

     movl $3, %eax  #unosenje podataka 
     movl $0, %ebx
     leal ulaz, %ecx
     movl $maxduzina, %edx
     int $0x80  

     movl %eax, duzina

     movl $ulaz, %eax
     
     
provera:
    cmpb $10, (%eax) #da li je dosao do kraja
    je ispis
    cmpb $96, (%eax)
    jg izmeni
    cmpb $32, (%eax)
    je preskoci

preskoci:
      incl %eax
      jmp provera
    
izmeni: 
       subb $32, (%eax)
       addl $2, %eax
       jmp provera

ispis:
     movl $4, %eax  
     movl $1, %ebx
     leal string2, %ecx
     movl $duzina2, %edx
     int $0x80 

     movl $4, %eax  
     movl $1, %ebx
     leal ulaz, %ecx
     movl duzina, %edx
     int $0x80 
      
	
kraj: 
	movl $1,%eax
        movl $0, %ebx
	int $0x80 

