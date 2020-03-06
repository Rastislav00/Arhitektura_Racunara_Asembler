.section .data

  rec: .ascii "rastislavvalsitsar\0"
  palindrom: .long 0

.section .text
.globl main
main:			


	movl $0, %esi
	movl $0, %edi

	movl $rec, %eax			


zad_adresa:
	cmpb $0, (%eax,%esi,1)		#ovaj algoitam izvrsavam samo jednom jer mi treba zadnja adresa ovonecu ovde se vracati vise
	je alga
	addl $1, %esi
	jmp zad_adresa

alga:	subl $1, %esi 			#oduzimam jedinicu od esija jer esi je do sada uticao da pokaze na beckles
	
alg:	movb (%eax,%esi,1), %bl
	cmpb %bl, (%eax,%edi,1)
	jne kraj0			#jne nije jednako znaci nije palindrom
	
	addl $1, %edi
	subl $1, %esi

	cmpb $0, (%eax,%edi,1)
	je kraj1
	jmp alg




kraj0:  movl $0, palindrom
	jmp kraj

kraj1:  movl $1, palindrom
	jmp kraj






kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80



