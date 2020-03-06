#IZAZOV OD FILIPA ZJALIC
#dobijena su 3 broja quad. trebanaci najmanji od ta tri i sabrati dva veca. upisati najmanji u promeljivu minimum
#a zbir ova dva u zbir max

.section .data

  a: .quad 0x110000001
  b: .quad 0x110000000
  c: .quad 0x120000001

  suma: .quad 0
  min: .quad 0

.section .text
.globl main
main:

#======================================================================

	#u pocetku mi ne znamo koji je najmanji pa cemo pretpostaviti

	movl a, %eax		#manje znacajne cifre
	movl a+4, %ebx		#vise znacajne cifre

	movl %eax, min		#manje znacajne cifre		ubacili smo brojke u min adresu
	movl %ebx, min+4	#vise znacajne cifre

	movl b, %eax
	movl b+4, %ebx

cmp1:	cmpl %ebx, min+4	#prvo uporedjujemo znacajne cifre
	je cmp2			#ako su isto velike znacajnije cifre onda treba videti za manje znacajne
	jl dalje1		#jl manje znaci ako je min manje idemo dalje
	movl %eax, min
	movl %ebx, min+4
	jmp dalje1

cmp2:	cmpl %eax, min
	jle dalje1		#jle manje ili jednako znaci ako je minimalni manji ili jedan dalje ako ne algoritam
	movl %eax, min
	movl %ebx, min+4

dalje1:					#ovde sada treba uporediti sa trecim brojem

	movl c, %eax
	movl c+4, %ebx

cmp3:	cmpl %ebx, min+4
	je cmp4
	jl dalje2		#jl manje znaci min nam je manji i to je to on je potpuno najmanji
	movl %eax, min
	movl %ebx, min+4
	jmp dalje2	
	
cmp4:	cmpl %eax, min		#uporedjujemo manje znacajne
	jle dalje2		#jle manje ili jednako znaci ako je min manji lili jednak ok idemo dalje
	movl %eax, min
	movl %ebx, min+4	#ovo ce se desiti samo ako je min veci od c
	jmp dalje2

dalje2:					#ovde vec imamo minimalni na adresi min
#================================================================================
#zbir dva veca

	movl a, %eax		#manje znacajno
	movl a+4, %ebx		#vise znacajne cifre
		
	movl %eax, suma		#u poectku nam je suma samo 0 pa moze muvl    	SADA imamo samo broj a u sumi
	movl %ebx, suma+4	#takodje moze muvl jer je 0 al sledeci put mora addl i adcl
	
	movl b, %eax
	movl b+4, %ebx

	addl %eax, suma
	adcl %ebx, suma+4	#sada u sumi imamo a+b

	movl c, %eax
	movl c+4, %ebx

	addl %eax, suma
	adcl %ebx, suma+4	#sada u sumi imamo a+b+c jedan od njih je sigurno min pa cemo oduzeti min od sume

	movl min, %eax
	movl min+4, %ebx

	subl %eax, suma
	sbbl %ebx, suma+4	#sada u sumi imamo a+b+c-min a to je zbir dva veca 




kraj:
movl $1, %eax
movl $0, %ebx
int $0x80
#========================KRAJ======================================================
#znaci prvo pretpostavimo o nekom broju tj potencijalno mozda najmanji
#uporedimo ga sa sledecim ako je manji treba da menjati
#ako ne idemo dalje
#cista logika nam kaze ako je A manje od B a B manje od C onda je i A menje od C


#postoji mala dosetka oko ovog zadatka posto su definisana tri broja i dve adrese jedna je suma a jedna je min
#nama se trazi zbir dva veca broja
#problem je sto ne znamo koja su to ta dva veca broja ali znamo da jedan od njih je smesten u min
#sabracemo ih sve a+b+c-min  posto a min ce biti jednak jednom od njih tj najmanjem i u sumi ce ostati zbir dva veca 















