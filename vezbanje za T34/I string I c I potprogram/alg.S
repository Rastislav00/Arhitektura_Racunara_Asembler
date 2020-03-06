#int alg(char *str);
#ovaj kod je skoro beskorisan niko ziv nece razumeti sta se desava
#potrudio sam se ispod da napisem ideju algoritma
.section .text
.globl alg
alg:

	pushl %ebp
	movl %esp, %ebp
	pushl %ebx
	pushl %esi
	pushl %edi



	movl $0, -4(%ebp)	#da ima pocetnu vrednost 0
	movl $0, %esi		#edi i esi su brojaci
	movl $1, %edi
	movl $0, %ebx				#hocu dak oristim bl pa necu djubre da imam u ebx
	movl 8(%ebp), %edx			#u edx imam adresu stringa 
	movl $0, %ecx				#necu da mi se vamo nadje neko djubre ocu
								#da koristim %cl


prva:	movb (%edx,%esi,1), %bl		#u bl smestamo prvi karakter
		cmpb $0, %bl
		je krajP					#znaci ako esi pokaze na kraj
		cmpb $10, %bl
		je krajP

		cmpb $' ', %bl
		je up						#sve dok je spejs idemo dalje 
		jmp druga

up: 	addl $1, %esi
		jmp prva


druga:	movl %esi, %edi
drugaO:	movb (%edx,%edi,1), %cl

		cmpb $0, %cl
		je zadnji					#uslov da li smo dosli do onog \n
		cmpb $10, %cl
		je zadnji

		cmpb $' ', %cl
		je zadnji
		addl $1, %edi
		jmp drugaO

zadnji:
		subl $1, %edi			#posto nam edi doso do spejsa -1 je zadnji char
		movb (%edx,%edi,1), %cl
		jmp cmp


cmp:	cmpb %cl, %bl
		je isti
		jmp pok


isti:	addl $1, -4(%ebp)		# na -4(%ebp) cuvamo broj reci sa istim slovima	
		jmp	pok



pok:	movl %edi, %esi
		addl $1, %esi			#namerno +1 da bi se opet on nasao na spejsu
								#a onda mora da ide dalje
		jmp prva		




krajP:
movl -4(%ebp), %eax			#povratna vrednost
popl %edi
popl %esi
popl %ebx
movl %ebp, %esp
popl %ebp
ret


#znaci ideja je bila ovakva
#treba da imamo kao dve kutije u prvoj da bude prvo slovo reci 
#a u drugoj kutiji drugo slovo reci
# to postizemo tako sto koristimo indeksno adresiranje i esi i edi
#esi mi ima veze sa prvim slovom
#edi mi ima veze sa zaadnjim slovom
#prvo mi pocinjemo od brvog slova jednog stringa
#i logika je ovakva
#ako sadrzim spejs idem dalje
#idem dalje sve dok ne dodjem do nekog karaktera koji nije spejs
#kada dodjem d otog karaktera to je to, to je prvo slovo prve reci
#onda prebacujem brojac sa esi na edi, to jest hocu da nastavim od tog slova
#da idem napred sve do zadnjeg slova te reci, to postizem tako sto idem sve do
#spejsa a kad dodjem do prvog spejsa uradim -1 i super pokazujem na zadnje slovo 
#jedne reci. fino sada imamo dve kutije sa dva slova prvo i zadnje
#ako uporedim i ako su isti onda treba povecati brojac reci kod kojih su prvo i poslednje slovo isti
#nakon ovog treba da trazim prvo slovo druge reci
#to postizem tako sto prebacim edi na esi i uradim esi+1
#tu je poenta sto mi skacemo sa prvog slova prve reci na +1 poziciju zadnjeg slova prve reci
#setimo se da nam je algoritam takav da ako sadrzi spejs onda ide dalje
#mi to taman postizemo sa onim +1 jer posle zadnjeg slova sledi spejs
#i kad preskocimo spejs ili vise ako ih ima dolazimo na prvo slovo druge reci
#e sada prebacimo edi na esi
#i pocinjemo da trazimo zadnje slovo druge reci a pocinjemo od prvog slova druge reci
#ovo se sve ponavlja do kraja

