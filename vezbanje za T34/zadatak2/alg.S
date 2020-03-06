#Void izmeniBit(int* broj, int vrednost, int pozicija, int *x);
.section .text
.globl izmeniBit
izmeniBit:

	pushl %ebp
	movl %esp, %ebp
	pushl %ebx

	movl $0, %ebx

	subl $8, %esp
	movl $0, -4(%ebp)			
	movl $0, -8(%ebp)			#brojac jedinica

	movl 8(%ebp), %edx			#u edx imam adresu broja
	movl 12(%ebp), %eax			#u eax imam vrednost
	movl 16(%ebp), %ecx			#pozicija

	movl $1, %ebx 				#maska u ebx

poza:	subl $1, %ecx			#brojac ima, tacno da ga pozicioniramo :D 		
		cmpl $0, %ecx
		je vrednost

		shll $1, %ebx			#siftovanje maske ebx za jedno mesto u levo
		jmp poza

vrednost:						#mi u ovom momentu imamo pozicionirano aj da vidimo vrednost kakva je
		cmpl $0, %eax			#u eax imamo ili 1 ili 0
		je nula
		jmp jedan				#od ovog momenta registri ecx i eax mogu da se koriste za druge stvari

nula:	#generalni algoritam za postavljanje nule na odgovarajuci bit
		movl (%edx), %eax		#u eax imam broj koji sam prosledio 
		notl %ebx 				#0->1 a 1->0 i 
		andl %ebx, %eax			#sada smo u eax izmenili tacno pozicioniran bit na vrednost 0
		movl %eax, (%edx)		#vracamo ga u adresu
		jmp prebroj

jedan:	#generalni algoritam za postavljanje jedinice na ogovarajui bit
		movl (%edx), %eax		#u eax imam broj prosledjen
		orl %ebx, %eax			#postavljena vrednost na trazenu poziciju
		movl %eax, (%edx)		#novodobijen broj stavljano na povratnu adresu
		jmp prebroj				


prebroj: #brojanje jedinica u ovom momentu ebx nam je slobodan za novu masku
		movl $1, %ebx 			#maska u ebx
		#u eax nam je ostao onaj broj nad kojim vrsimo algoritam
		opet:	movl %eax, -4(%ebp)		#ovde cemo da smestimo kako ne bi pokvarili broj u eax
				andl %ebx, -4(%ebp)		#endovanje konkretnog broja sa maskom
				
				cmpl $0, -4(%ebp)		#na -4(%ebp) imamo endovan broj znaci na njemu se moze naci 0 ili 1 na nekon poziciji
				je shift
				addl $1, -8(%ebp)		#na -8(%ebp) tu mi je brojac jedinica
				
		shift:	shll $1, %ebx			#siftovanje maske u levo
				cmpl $0, %ebx
				je alg
				jmp opet

alg:	movl 20(%ebp), %edx 			#adresa broja gde cu da smestim broj nakon alg

		#sada mi vec imamo prebrojan broj jedinica i stavljen je u -8(%ebp)
		shrl $1, -8(%ebp)		#siftovanjem brojaca u desno dobicemo 1 ili 0 u carry (1 neparan)(0 paran)
								#ako imamo neparan broj treba staviti odgovarajuci bit na najmanje znacajn bit da ovaj br bude paran
		jnc krajP				#jnc jump for no carry, ako nema prenosa znaci da je paran br jedinica i to je to kraj						
		xorl $1, %eax 			#invertovanje zadnjeg bita
		movl %eax, (%edx)

krajP:
popl %ebx
movl %ebp, %esp
popl %ebp
ret


