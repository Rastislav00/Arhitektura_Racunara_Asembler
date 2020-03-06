#void alg(int *a);
.section .text
.globl alg
alg:

	pushl %ebp
	movl %esp, %ebp

		subl $12, %esp				#jer koristim 3 lokalne promenljive

		movl 8(%ebp), %edx			#u edx imamo adresu tog prosledjenog broja
		movl (%edx), %eax			#u eax imamo konkretan broj koji smo prosledili

		movl $0xe0000000, %ecx 		#prva maska u ecx e0000000 == 111000....000000
		andl %ecx, %eax 			#ovim sam pobrisao sve brojke osim 3 najznacajnije koje sam samo kopirao	
		movl %eax, -4(%ebp)

		movl (%edx), %eax			#u eax imamo konkretan broj koji smo prosledili
		movl $0x7, %ecx 			#sada u ecx imam masku 000...111 jer hexa 7 je 111 u binarnom
		andl %ecx, %eax 			#sada u eax imam samo 3 najmanjeznacajna bita broja 
		movl %eax, -8(%ebp)

		#do ovde mi sada imamo izolovano u lokalnim promnljivima 3 vise i 3 manje znacajna bita

		movl (%edx), %eax 			#opet u eax imamo konkretan broj

		movl $0x1ffffff8, %ecx		#maska u ecx tipa 000111...111000
		andl %ecx, %eax 			#sada u eax i to na 3 vise i manje znacajna bita smo stavili nule

		movl %eax, -12(%ebp)		#treba da sacuvam broj koji je tipa 000.....000 izedju tackiza random brojke

		roll $3, -4(%ebp)			#rotiranje tako da se namesti kako treba
		rorl $3, -8(%ebp)			#ovo je razlog zasto se javlja greska da su isti brojive nakon alg

		orl -4(%ebp), %eax			#pogledaj objasnjenje OBJ[1] ispod koda
		orl -8(%ebp), %eax			#TREBA ROTIRATI MASKE

		movl %eax, (%edx)			#vracanje dobijenog broja


krajP:
movl %ebp, %esp
popl %ebp
ret



#OBJ[1] znaci poenta je u tome sto orl tamo gde maska ima 0 nece poremeniti operand a tamo gde 1 stavice 1