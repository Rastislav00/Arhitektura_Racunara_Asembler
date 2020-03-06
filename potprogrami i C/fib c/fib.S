.section .text
.globl fib
#=================================START=======================================
fib:

	pushl %ebp			#cuvamo zatecen ebp (to je po pravilu)
	movl %esp, %ebp			#po pravilu
	pushl %ebx			#stavljamo na stek jer ebx ne smemo menjati a ovako sacuvamo pa na kraju programa vratimo vrednost
	
	movl 8(%ebp), %eax		#po pravilu na 8(%ebp) se uvek nalazi prvi parametar prosledjen potprogramu
					#mi sada imamo u eax broj koji smo prosledili taj broj je broj koliko fibonacijeviuih brojeva zelimo
	movl $1, %ebx			
	movl %ebx, %ecx

opet:	cmpl $2, %eax					
	jle kraj			#jle manje ili jednako
	subl $1, %eax			#na ovaj nacin mi smanjujemo broj 

	movl %ecx, %edx
	addl %ebx, %ecx
	jc greska			#ovo je ako imamo carry to jest van opsega to moze da se desi kad saberemo dva velika broja
	movl %edx, %ebx
	jmp opet

greska:	movl $1, %edx			#ovo se desi samo u slucaju izlaska iz opsega
	jmp krajP

kraj: 	movl $0, %edx
	movl 12(%ebp), %eax
	movl %ecx, (%eax)

krajP:	popl %ebx
	movl %ebp, %esp
	popl %ebp
	movl %edx, %eax		#povratna vrednost uvek mora da bude u eax pa zato je ovako
	ret
#==============================KRAJ==========================





























