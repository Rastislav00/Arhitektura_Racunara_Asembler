#izdvajanje prvih slova i uvecavanje npr uneses rastislav kukucka a treba da se ispise Rk
#========================================================================================
.section .data

	msg1: .ascii "Unesite ime i prezime: \0"
	str_len1 = . - msg1

	rec: .fill 50,1,42
	br: .long 0

	msg2: .ascii "Vas ID je:    \0"
	str_len2 = . - msg2


.section .text
.globl main
main:
#========================POCETAK=====================



	movl $4, %eax			#poruka unesite ime i prezime
	movl $1, %ebx
	movl $msg1, %ecx
	movl $str_len1, %edx
	int $0x80


	movl $3, %eax
	movl $0, %ebx
	movl $rec, %ecx
	movl $50, %edx
	int $0x80

	movl %eax, br


#sada treba da trazimo prva slova



	movl $rec, %eax
	movl $0, %esi
	movl $0, %ebx



opet:	movb (%eax,%esi,1), %bl			#u esi nam je ostao broj koji odgovara adresi prvog slova
	cmpb $' ', %bl
	jne dalje1				#jne nije jednako, znaci da prvi karakter nije spejs ok super
	addl $1, %esi
	jmp opet




dalje1:			#sada cemo taj karakter staviti na 11 mesto u string msg2
	
	cmpb $'a', %bl
	jge cmp3			#jge vece ili jednako
	jmp ubaci1


cmp3:	cmpb $'z', %bl
	jle alg1				#jle manje ili jednako
	jmp ubaci1


alg1:	addb $'A'-'a', %bl
	jmp ubaci1





ubaci1:	movl $msg2, %eax
	movl $11, %edi	
	movb %bl, (%eax,%edi,1)		#sada smo na 11najsto mesto smestili prvo slovo imena

dalje2: 		#sada treba da trazimo drugo pocetno slovo


	movl $rec, %eax
	movl %esi, %edi			#esi ima broj koji pokazuje na prvo slovo
	addl $1, %edi			#treba nam jedno mesto sledece

opet1:	cmpb $' ', (%eax,%esi,1)	#znaci trazimo spejs a kad ga nadjemo proverimo dali je sledeci karakter
	je cmp2
	addl $1, %esi
	addl $1, %edi
	jmp opet1

cmp2:
	cmpb $' ', (%eax,%edi,1)
	jne dalje3			#jne nije jednako, znaci ako posle spejsa nema spejs to je sledeci karakter
	addl $1, %edi
	jmp cmp2



dalje3:
	movb (%eax,%edi,1), %bl		#ovde eax ima adresu reci

	movl $msg2, %eax		#sada vec eax ima adresu msg2
	movl $12, %edi
	movb %bl, (%eax,%edi,1)


#stampanje


	movl $4, %eax
	movl $1, %ebx
	movl $msg2, %ecx
	movl $str_len2, %edx
	int $0x80







kraj:
movl $1, %eax
movl $0, %ebx
int $0x80
#=======================KRAJ===========================
#kako naci prvo slovo, pa ono je uvek na prvom mestu samo treba videti dal nije spejs ispred
#a za ono slovo kod prezimena treba traziti spejs pa prvo slovo posle spejsa je pocetak prezimena


#ovaj kod nije bas uredno pisan, vezbanje par sati pred kolokvijum :D 



































