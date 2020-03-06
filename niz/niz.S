.section .data

 niz: .long 5, 6, 2, 9, -3, -8, 4, 7, 1, 14

 PO = 0
 DO = 10

 min: .long 0
 max: .long 0

.section .text
.globl main
main:			#odredjivanje min i max iz niza ovaj fajl otvoriti na fullhd zbog komenata
	movl $0, %esi                 #ovo ce nam biti brojac koji ce da se povecava i pristupacemo clanovima niza
	movl niz, %eax
	movl %eax, min
	movl %eax, max		      #za pocetak ne znamo koji brojevi su najveci a koji najmanji pa stavimo za pocetak prve brojeve

	
ponovo:	movl niz(,%esi,4), %eax       #stavljamo prvi clan niza u registar eax i naravno sve ostale kasnije
	
	cmpl %eax, min		      #uporedimo min i registar ako je min manji od registra ok ali ako ne onda zameni mesta
	jle next1
	movl %eax, min		      #izvrseno premestanje

next1:  cmpl %eax, max		      #uporedi da li je veci broj na eax ili na max ako je veci na max onda ok ali ako je broj veci na eax
	jge next2		      #onda treba da zamenimo mesta
	movl %eax, max

next2:  addl $1, %esi 		      #ovo je brojac i stalno ga povecamao za jedan
	cmpl $DO, %esi                #povecavamo ga sve dok esi ne dodje do do vrednosti u ovom slucaju deset
	je kraj			      #ako je isto onda kraj znaci prosli smo kroz sve clanove niza	
	jmp ponovo




kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80



