.section .text
.globl alg
alg:

	pushl %ebp
	movl %esp, %ebp

	movl $0, -4(%ebp)			#stavio nulu na prvu lokalnu promenljivu
						#ovde cu da cuvam broj jedinica
	movl $1, %eax			#maska mi je 000...0001 pomeracu 1 u levo					

petlja:	movl 8(%ebp), %edx		#sada u edx imam vrednost v

		
		andl %eax, %edx			#ovako proveravam dal je na odg mestu 1

		cmpl $0, %edx
		je shift
		addl $1, -4(%ebp)			#ako edxx nije 0 znaci da je 1 a ako je jedan
							#treba povecati brojac koji je meni -4(%ebp)

shift:						#pomeranje u levo
	shll $1, %eax
	cmpl $0, %eax				#posto u eaxx imam masku i pomeram je u levo			
	je krajP					#alg je zavrsio kada maska bude 0		
	jmp petlja




krajP:
movl -4(%ebp), %eax
movl %ebp, %esp
popl %ebp
ret 