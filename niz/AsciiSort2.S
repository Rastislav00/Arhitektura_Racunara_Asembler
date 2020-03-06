.section .data

  rec: .ascii "hgfeddhdguvhgrhcoztdjvgoeridvhgioxrgvjdcba\0"

.section .text
.globl main
main:
	#sortiranje po ascii tabeli
	#ovaj alg radi po principu idi proveravaj dal je manji susedni sa desne strane ili trenutni ako je manji onda alg ako ne dalje
	#esi i edi su mi brojaci edi je uvek za jedan veci od esi i to mi omogucava pristup sledecem karakteru
	

	movl $rec, %eax			#stavljam adresu na eax
	movl $0, %edx			#edx stavljam na nulu ovo radim jed on mozda ima neinicializovanu vrednost bezveze brojke
					#ako ima bzvz brojke onda ja kad pristupim dl podregistru registra edx onaj gorinji deo edx
					#ce mi smetati taj dobicu neke glupe brojeve	
	movl $0, %esi			#esi i edi koristim kao brojace
	movl $1, %edi
	movl $0, %ebx			#isti razlog kao i kod edx mada primetio sam da je ebx uvek na nuli tako da nisam morao al ajde
	jmp opet1			

opet:	addl $1,%esi
	addl $1, %edi

opet2:	cmpb $0, (%eax,%edi,1)		#posto ovaj kod ide redom i uvek se vrati na kraj cim dodje do jednog manjeg
	je kraj				#zbog toga ovaj text je sortiran tek kada dodjemo do backslesa


opet1:	movb (%eax,%esi,1), %bl
	cmpb %bl, (%eax,%edi,1)		#posto je edi za jedan veci od esi mi proveravamo bukvalno susedne adrese al koristim posrednik bl
	jl alg				#jl manje   znaci ako je na sledecoj adresi manji mi ga trebamo staviti ispred pa skacemo na alg
	jmp opet			#ako nije sledeci manji znaci da je veci ili isti pa nista ne diramo nego idemo opet

alg:	movb (%eax,%edi,1), %dl		#ovde koristim dl i bl registar za zamenu mesta dl mi je kao posrednik 
	movb %dl, (%eax,%esi,1)
	movb %bl, (%eax,%edi,1)
	movl $0, %esi			#i esi i edi vracam na pocetno stanje kako bi mogao opet da ispoetka pristupam prvoj adresi stringa
	movl $1, %edi

	jmp opet2			#zasto bas jmp2 pa zato sto zelim da idem uvek od pocetka ono da sam stavio opet
					#dodai bi jedan na esi i edi pa oni ne bi isli od nule i jedinice nego od jedinice i dvojke
	







kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80





