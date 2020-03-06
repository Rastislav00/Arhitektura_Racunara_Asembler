.section .text
.globl alg
alg:

	pushl %ebp
	movl %esp, %ebp

	pushl %ebx					#registar koji cu mozda da koristim
	pushl %esi					#brojac koji ce da skace po redovima

	movl $1, %eax				#maska u eax, 000...001 
	movl $0, -8(%ebp)			#da mi se ne nadje neko djubre
	movl $0, -4(%ebp)

opet:	movl $2, %esi				#zasto bas 2 pa zto sto je na 8(%ebp) prvi parametar
								#(pogledaj ispod potprograma text [1])

ver_p:	movl (%ebp,%esi,4),%edx		#sada u edx imamo prvi broj tj br a
		andl %eax, %edx				#ovo ce da proveri dal je na odg poziciji 1 ili 0
		cmpl $0, %edx
		je sl_b
		addl $1, -4(%ebp)			#na -4(%ebp) brojac za jednu vertikalu

sl_b:	addl $1, %esi
		cmpl $7, %esi
		je analiza
		jmp ver_p


analiza:				#treba provariti dal ih ima paran broj ili neparan
		shrl -4(%ebp)			#siftujem desno i sada u carry imam 1 ili 0
								#u Carry imamo 1 ako je br bio neparan
								#u carry imamo br 0 ako je broj bio paran
		rcrl -8(%ebp)			#iz carrya cecmo polako da punimo ovaj broj
								#u njemu se nalazi paritet			

		movl $0, -4(%ebp)		#uvek treba da anuliramo kad siftujemo


shift:					#shift treba da pomeri masku tojest eax
		shll $1, %eax
		cmpl $0, %eax		#u eax mi je maska, kraj programa je kad maska dodje do nule
		je krajP
		jmp opet



krajP:
movl -8(%ebp), %eax
popl %esi
popl %ebx
movl %ebp, %esp
popl %ebp
ret


#[1] nama je parametar a na 8(%ebp), b na 12(%ebp), c na 16(%ebp), d na 20(%ebp),..
#zato cu koristiti brojac esi koji ce da ide od 8 a povecavacu ga za +4