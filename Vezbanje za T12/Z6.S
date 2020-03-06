#deljenje pomocu oduzimanja jednostruka preciznost
#=================================================
.section .data

 a: .long 15		
 b: .long 15
 k: .long 0		#kolicnik
 o: .long 0		#ostatak


.section .text
.globl main
main:
#=============================DELJENJE===============================

	#treba proveriti dal b nije nula mozda


	movl a, %eax
	movl b, %ebx
	cmpl $0, b
	je kraj			#ako je b=0 kraj nmg da delim sa nulom

	#deljenje tako sto se oduzima a-b i za svaki korak povecava k
	#treba videti da li je a>b onda ok ali ako ne onda kraj

opet:	cmpl %ebx, %eax
	jl kraj1			#jl manje

	subl %ebx, %eax
	addl $1, k
	jmp opet


kraj1:	movl %eax, o



kraj:
movl $1, %eax
movl $0, %ebx
int $0x80
#==================KRAJ============================================
