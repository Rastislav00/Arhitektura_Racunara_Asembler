
#ovaj program ne radi segmentated fault al je jako zanimlliv

#int podstring(char** strs, char *s, int *niz, int n);
.section .text
.globl podstring

#================dodatni potprogram=================
# int alg(char *str1, char *str2);
alg:
	pushl %ebp
	movl %esp, %ebp
	pushl %edx
	pushl %ecx
	pushl %esi
	pushl %edi
	pushl %ebx

	movl $0, %ebx				#registri koje cu da koristim za bajte 
	movl $0, %eax				
	movl $0, -4(%ebp)			#brojac pojavljivanja podstringa
	movl $0, %edi				#brojaci esi i edi
	movl $0, %esi
	movl 8(%ebp), %edx			#ovo je adresa stringa 
	movl 12(%ebp), %ecx			#adresa trazenog podstringa


dalje:	movb (%edx,%esi,1), %bl
		cmpb $0, %bl
		je krajA

		cmpb %bl, (%ecx, %edi,1)
		je pot_sl
		addl $1, %esi
		jmp dalje

pot_sl:	movl %esi, -8(%ebp)				#cuvanje starog esi

pot_sl1:addl $1, %esi
		addl $1, %edi	


		cmpb $0, (%ecx, %edi, 1)		#kraj trazenog stringa	
		je jeste

		

		movb (%edx, %esi, 1), %bl
		cmpb %bl, (%ecx,%edi,1)
		je pot_sl1
		#ako nije
		movl -8(%ebp), %esi				#vracanje starog esija
		addl $1, %esi       			#da bi odma isli dalje
		movl $0, %edi					#sl put pocecemo od nule da proveravmo podstring
		jmp dalje

jeste:	addl $1, -4(%ebp)
		movl $0, %edi					#nuliranje pokazivaca na podstring
		movl -8(%ebp), %esi     		#vracanje na staro esi
		addl $1, %esi    				#sl karakter stringa
		jmp dalje





krajA:
movl -4(%ebp), %eax
popl %ebx
popl %edi
popl %esi
popl %ecx
popl %edx
movl %ebp, %esp
popl %ebp
ret









#=================START=================
#int podstring(char** strs, char *s, int *niz, int n);
podstring:

	pushl %ebp
	movl %esp, %ebp
	pushl %ebx
	pushl %esi
	pushl %edi

	movl $0, -4(%ebp)			#pocinjemo od nule da brojimo
	movl $0, %esi				#esi brojac koji ce da seta po nizu stringova
o:	movl 8(%ebp), %edx			#pokazivac na niz stringova
	movl 12(%ebp), %ecx			#podstring trazeni
	movl 16(%ebp), %ebx			#niz brojaca

opet:	movl (%edx, %esi, 4), %edi
		
		pushl %ecx				#stavljamo podstring
		pushl %edi				#odgovarajuci string niza stringova		
		call alg				#po povratku mi u eax cemo imati broj pojavljivanja podstringa u datom stringu
		addl $8, %esp	
		
		movl %eax, (%ebx, %esi, 4)	
		addl %eax, -4(%ebp)		#brojac ukupnog pojavljivanja podstringa u svim stringovima	
		addl $1, %esi			#esi nam sluzi da pokazujemo na tacno el koji trebaju
		cmpl %esi, 20(%ebp)		#na 20(%ebp), imamo broj stringova niza strignvoa
		je krajP
		jmp o



krajP:
movl -4(%ebp), %eax				#povratna vrednost glavnog potprograma
popl %edi
popl %esi
popl %ebx
movl %ebp, %esp
popl %ebp
ret
#====================KRAJ=======================