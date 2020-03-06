#Jedan niz, prebrojati parne i neparne i ispisati vise parni, vise neparnih ili jednako parnih-neparnih
#gratis prebrojati pozitivne negativne i naci minimalni i maximalni elemeant ali ovo se moze videti samo u ddd 

.section .data


  msg1: .ascii "I ISTI BROJ \0"
  str_len1 = . - msg1

  msg2: .ascii "P VISE PARNIH \0"
  str_len2 = . - msg2

  msg3: .ascii "N VISE NEPARNIH  \0"
  str_len3 = . - msg3


  NELEM = 10

  niz: .long 1, 2, -7, 6, -8, 10, 4, -8, 13, 16


	P: .long 0		#broj parnih
	
	N: .long 0		#broj neparnih




	poz: .long 0		#broj pozitivnih

	neg: .long 0		#broj negativnih



	min: .long 0		#najmanji broj

	max: .long 0		#najveci broj


.section .text
.globl main
main:

#=============== PARNI VS NEPARNI ===================

	movl $NELEM, %ebx
	movl $0, %esi				#ovo ce nam biti brojac

	movl niz(,%esi,4), %eax
	movl %eax, min
	movl %eax, max

	
	jmp opet1


opet:	addl $1, %esi
opet1:	cmpl %esi, %ebx
	je rezultat				#jl manje 	
	
	movl niz(,%esi,4), %eax			#pristupanje elementima niza

cmp_min: cmpl %eax, min			#ovaj deo koda proverava dal je taj minimalni ili maximalni
	 jle cmp_max				#jle manje ili jednako
	 movl %eax, min

cmp_max: cmpl %eax, max
	 jge cmp				#jge vece ili jednako
	 movl %eax, max			#ovde zavrsava provera za min i max

						
cmp:	cmpl $0, %eax
	je parni				#je isti
	jl negativan				#jl manje znaci eax je negativan
	jg pozitivan				#jg vece znaci eax je pozitivan
	jmp opet				#za svaki slucaj 




negativan:
	addl $1, neg
negb:	addl $2, %eax
	cmpl $1, %eax			#moze i minus jedan i jedan
	je neparni
	cmpl $0, %eax
	je parni
	jmp negb



pozitivan:
	addl $1, poz
pozb:	subl $2, %eax
	cmpl $1, %eax
	je neparni
	cmpl $0, %eax
	je parni
	jmp pozb



parni:	addl $1, P
	jmp opet


neparni:addl $1, N
	jmp opet


#===================================================
#ove petlje su krajnje preodrediste sta ce se ispisati na terminal

rezultat:
	movl P, %eax
	cmpl %eax, N		# P vs N
	je isti
	jg neparnih		#jg vece znaci vise N od P
	jl parnih		#jl manje N od P
	jmp kraj


isti:	
	movl $4, %eax
	movl $1, %ebx
	movl $msg1, %ecx
	movl $str_len1, %edx
	int $0x80
	jmp kraj

parnih:	
	movl $4, %eax
	movl $1, %ebx
	movl $msg2, %ecx
	movl $str_len2, %edx
	int $0x80
	jmp kraj

neparnih:
	movl $4, %eax
	movl $1, %ebx
	movl $msg3, %ecx
	movl $str_len3, %edx
	int $0x80
	jmp kraj



kraj:
movl $1, %eax
movl $0, %ebx
int $0x80

#================KRAJ==========

#ideja je da prvo proverimo da li je broj pozitivan ili negativan
#to cemo videti kad ga uporedimo sa nulom dal je manji ili veci od nule
#ako je veci od nule od njega cemo oduzimati broj dva
#ako dodjemo do nule onda je bio paran a ako dodjemo do jedinice onda neparan 
#ako je manji od nule tj negativan dodavacemo mu broj dva
#ista logika suprotnog pravca haha
#nula se racuna za parni broj 
























