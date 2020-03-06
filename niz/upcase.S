.section .data

  rec: .ascii "RaStislav\0"

.section .text
.globl main
main:			

	#ovim kodom cemo pretvoriti mala slova u velika
	
	movl $rec, %eax


cmp:	
	cmpb $0, (%eax)
	je kraj


	cmpb $'a', (%eax)
	jge cmp1			#jge vece ili jednako
	addl $1, %eax
	jmp cmp

cmp1:	cmpb $'z', (%eax)
	jle alg				#jle manje ili jednako
	addl $1, %eax
	jmp cmp

alg:	addb $'A'-'a', (%eax)
	addl $1, %eax

	jmp cmp




kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80



