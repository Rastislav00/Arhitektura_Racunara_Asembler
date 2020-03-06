.section .data

  rec: .ascii "kdcba\0"
  
  min: .long 0
  min_esi: .long 0

.section .text
.globl main
main:
	movl $0, %edi
	movl $0, %edx
	movl $0, %esi
	movl $rec, %eax
	movb (%eax), %bl
	movb %bl, min


opet:	addl $1, %esi
	movb (%eax,%esi,1), %bl
opet1:	cmpb $0, (%eax,%esi,1) 			#da li smo stigli do kraja stringa, ako jesmo skoci na algoritam
	je alg

	
	cmpb %bl, min
	jle opet				#jle manje ili jednako
	movb %bl, min
	movl %esi, min_esi
	jmp opet
	
alg:	
	addl $1, %edi
	movl $0, %esi

	movb (%eax, %esi, 1), %dl
	movb %bl, (%eax, %esi, 1)

	movl min_esi, %esi
	movb %dl, (%eax,%esi,1)


	


	addl $1, %eax
	movb (%eax), %bl
	addl $1, min
	jmp opet1








kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80





