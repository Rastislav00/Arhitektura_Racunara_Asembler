#=======================igranje bitima ==========
.section .data

.section .text
.globl main
main:
#=======================START=====================



	movl $523, %eax		
	andl $0xfffffffe, %eax		#postavljanje zadnjeg bita na 0

	movl $522, %eax
	orl $1, %eax			#postavljanje zadnjeg bita na 1

	movl $525, %eax
	xorl $1, %eax			#invertovanje zadnjeg bita 

	movl $525, %eax
	notl %eax
	
	movl $525, %eax			#komplement dva predstava
	negl %eax

#=====================================================

	#siftovanje

	movl $1, %eax
	shll $1, %eax
	shll $5, %eax

	movl $0xfaaaaaaa, %eax
	shrl $1, %eax
	shrl $5, %eax
	
	movl $0xffffffff, %eax
	sarl $1, %eax
	sarl $5, %eax





















kraj:
movl $1, %eax
movl $0, %ebx
int $0x80











