.section .data

string1: .ascii "cbda\0"
duzinastringa= .-string1


.section .text
.global main

main:
	movl $string1, %eax
	movl $string1, %ebx

  movl $3, %eax
  movl $0, %ebx
  leal string1, %ecx
  movl $duzinastringa, %edx
  int $0x80

  movl $4, %eax
  movl $1, %ebx
  leal string1, %ecx
  movl $duzinastringa, %edx
  int $0x80

	
ciklus1:
    movl %eax, %ebx
povratak:
    incl %ebx
    cmpb $0, (%ebx)
    je ciklus2
    movb (%eax), %cl #sa zagradom = vrednost na adresi eax
    movb (%ebx), %ch
    cmpb %cl, %ch
    jb zameni
    jmp povratak
    
    
zameni:
    movb %cl, %dl
    movb %ch, %cl
    movb %dl, %ch
    jmp povratak
  
ciklus2:
    incl %eax
    cmpl $0, (%ebx)
    je kraj
    jmp ciklus1

kraj:
     movl $1, %eax
     movl $0, %ebx
     int $0x80
