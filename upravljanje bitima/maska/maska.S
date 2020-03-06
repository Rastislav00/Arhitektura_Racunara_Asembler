.section .text
.globl maska
maska:

	pushl %ebp
	movl %esp, %ebp


	movl 12(%ebp), %eax		#koja vrednost 0 ili 1
	movl 8(%ebp), %ecx		#na kom mestu treba da se nalazi n

	

	movl $1, -4(%ebp)		#inicijalizovao sam masku na sve nule i na najmanje znacajnom bitu imam 1

	#sada cemo da siftujemo masku u levo za n, pre toga moramo da proverimo koje su vrednosti za n
	#n sme da bude od 0 do 31

	cmpl $0, %ecx
	jl greska			#jl manje
	cmpl $31, %ecx
	jg greska			#jg vece

shift:	cmpl $0, %ecx
	jle krajS			#jle manje ili jednako, kraj siftovanja
	subl $1, %ecx

	shll $1, -4(%ebp)
	jmp shift


krajS:				#sada imamo podesenu poziciju maske samo treba da proverimo dal je vrednost 0 ili 1



	cmpl $1, %eax		#ako je bila vreednost 1 uneta onda je to to jer smo sa tom pretspotavkom radili
	je krajP

	cmpl $0, %eax		#ako je nula onda treba da uradimo not
	je not
	
greska:	movl $0, -4(%ebp)	#ovo ce se desiti ako vrednost nije ni 1 ni 0 znaci greska a u slucaju greske upisacemo sve nule u masku
	jmp krajP


not:
	notl -4(%ebp)




krajP:
	movl -4(%ebp), %eax		#povratna vrednost tj maska u eax
	movl %ebp, %esp
	popl %ebp
	ret





	
