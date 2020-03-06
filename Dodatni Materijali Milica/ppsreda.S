.section .data
maxStringLen=30
s1: .fill maxStringLen,1,0
unesiteStringIspis:.ascii "Unesite string: \0"
unesiteStringIspisLen=.-unesiteStringIspis
tempString: .fill 20,1,0 #pomocni string za smestanje cifara odnosno brojeva iz ulaznog stringa
ispisRez: .fill 20,1,0
baza: .long 10 #ovim smo vec smestili 10 u bazu i nema potrebe za npr. movl $10, %ebx
suma: .long 0
greska: .long 0
brojClanova: .long 0
brojKarakteraUStringu: .long 0
greska1Ispis: .ascii "Greska:prekoracenje pri sabiranju\0"
greska1IspisLen=.-greska1Ispis
greska2Ispis: .ascii "Greska:prekoracenje pri konverziji\0"
greska2IspisLen=.-greska2Ispis
rezultatIspis: .ascii "Rezultat:\0"
rezultatIspisLen=.-rezultatIspis

.section .text
.globl main
main:
	
	#ispis unesite string
	movl $4,%eax
	movl $1,%ebx
	leal unesiteStringIspis,%ecx
	movl $unesiteStringIspisLen,%edx
	int $0x80

	#ucitavanje stringa
	movl $3,%eax
	movl $0,%ebx
	leal s1,%ecx
	movl $maxStringLen,%edx
	int $0x80
	
	movl $s1,%esi #smestanje prvog karaktera unesenog stringa u registar %esi
	movl $tempString,%ecx  #prvi karakter stringa (u koji se smestaju brojevi iz ulaznog stringa) u registar %ecx

procitajStringPetlja:
	movb (%esi),%bl #smestamo trenutni znak i utvrdjujemo da li je cifra
	cmpb $'0',%bl
	jl nijeCifra #u jednom trenutku sledeca sigurno nece biti cifra i sigurno odlazi na nijeCifra
	cmpb $'9',%bl
	jg nijeCifra
	movb %bl,(%ecx) #utvrdili smo da je cifra, stoga je smestamo u pomocni string odnosno u registar %ecx
	incl %esi #povecavamo brojac kojim se pomeramo u ulaznom stringu
	incl %ecx #povecavamo brojac kojim se pomeramo u temp stringu gde se smestaju cifre (kako bi se formirao broj)
	jmp procitajStringPetlja

nijeCifra:
	movb $0,(%ecx) #kada dodjemo do karaktera koji nije cifra stavljamo null karakter na kraj temp stringa (gde se nalazi niz cifara koji efektivno formiraju broj)
	pushl $tempString
	call konvertujBroj #potprogram za KONVERZIJU iz ZNAKOVNOG u INTERNI oblik
	addl $4,%esp       #samo smo jedno push-ovali zato dodajemo 4, da je bilo dva push-a dodali bismo 8 itd.
	movl $tempString,%ecx #vracamo se na pocetak tempStringa
	addl %eax,suma #uvecamo sumu za vrednost (smestena u %eax zbog mull) konvertovanog broja 
	jc greskaP1 #ako ima prenosa prilikom dodavanja na sumu onda greska 1
	cmpl $-1,%eax #izlaz iz konverzije je napravljen tako da u slucaju prekoracenja u samoj konverziji vrati -1 (pogledati deo u potprogramu za konverziju)
	je greskaP2
	cmpl $0,%eax  # ako je rezultat konverzije bio nula to znaci da u tempu nije bilo nista. 0 nije mogla biti uneta u pocetnom stringu, to pise u tekstu zadatka, znaci na primer string "3sa sad 0 sad"  nije dozvoljen, odnosno nema potrebe baviti se ovakvim tipom stringova
	je proveriKrajStringa

povecajBrojClanova:
	incl brojClanova #povecavamo broj clanova (radi aritmeticke sredine)
proveriKrajStringa:
	#naravno mogao se koristiti i broj ukupno unetih karaktera dobijen kroz sistemski poziv umesto ove provere ( bilo bi u eax)
	cmpb $10,%bl #proveravamo da li smo dosli do entera, tj do kraja stringa
	je krajStringa
	incl %esi #pomeramo se dalje u ulaznom stringu kako bi se pomerili na sledeci karakter i uzimali potencijalno naredni broj(sekvencu cifara)
	jmp procitajStringPetlja

konvertujBroj:
	pushl %ebp
	movl %esp,%ebp
	pushl %ebx
	movl 8(%ebp),%ebx #broj
	movl $0,%eax
	movl $0,%ecx
	movl $0,%edx

petljaKonverzija:
	movb (%ebx),%cl
	cmpb $0,%cl
	je krajKonverzije
	subb $'0',%cl
	mull baza
	jc greskaPp
	addl %ecx,%eax
	jc greskaPp
	incl %ebx
	jmp petljaKonverzija
	

greskaPp: #u slucaju da je doslo do greske (prenosa) vracamo -1
	movl $-1, %eax #mora u %eax jer je tu povratna vrednost programa

krajKonverzije:
	popl %ebx
	movl %ebp,%esp
	popl %ebp
	ret

krajStringa:
	movl suma,%eax 
	movl brojClanova,%ebx
	cmpl $0,%ebx #zbog deljenja sa 0, ovaj slucaj se izdvaja
	je stampajIspis
	divl %ebx #delimo sumu brojem clanova 
	jmp stampajIspis


konverzijaUString:
	pushl %ebp
	movl %esp,%ebp
	pushl %edi
	pushl %esi
	pushl %ebx
	movl 8(%ebp),%ebx #broj 
	movl 12(%ebp),%esi #adresa stringa
	movl 16(%ebp),%eax
	movl %esi,%edi
	movl $0,(%ebx)
	cmpl $0,%eax #u slucaju da je prosledjen string bez brojeva prakticno
	jne petljaKonverzijaUString
	movb $'0',(%esi)
	incl (%ebx)
	jmp zavrsiKonverzijuUString

	
petljaKonverzijaUString:
	movl $0,%edx
	cmpl $0,%eax
	je obrniString
	divl baza
	addb $'0',%dl
	movb %dl,(%edi)
	incl %edi
	incl (%ebx)
	jmp petljaKonverzijaUString
	

obrniString:
	cmpl %esi,%edi #proveravamo da li su se dva pokazivaca susrela
	jle zavrsiKonverzijuUString
	movb (%edi),%cl
	movb (%esi),%dl
	movb %cl,(%esi)
	movb %dl,(%edi)
	incl %esi
	decl %edi
	jmp obrniString
	
zavrsiKonverzijuUString:
	incl (%ebx) # za null karakter ( povecavamo broj karaktera koje bi trebalo ispisati za 1)
	popl %ebx
	popl %esi
	popl %edi
	movl %ebp,%esp
	popl %ebp
	ret

stampajIspis:
	pushl %eax
	pushl $ispisRez
	pushl $brojKarakteraUStringu #brojac karaktera za stampu
	call konverzijaUString
	addl $12,%esp

#ispis teksta rezultat

	movl $4,%eax
	movl $1,%ebx
	leal rezultatIspis,%ecx
	movl $rezultatIspisLen,%edx
	int $0x80

ispisiRezultat:
	movl $4,%eax
	movl $1,%ebx
	movl $ispisRez,%ecx
	movl brojKarakteraUStringu,%edx
	int $0x80
	jmp kraj


greskaP1: #ispis greske1
	movl $1,greska
	movl $4,%eax
	movl $1,%ebx
	leal greska1Ispis,%ecx
	movl $greska1IspisLen,%edx
	int $0x80
	jmp kraj

greskaP2: #ispis greske2
	movl $2,greska
	movl $4,%eax
	movl $1,%ebx
	leal greska2Ispis,%ecx
	movl $greska2IspisLen,%edx
	int $0x80
kraj:
	movl $1,%eax
	movl $0,%ebx
	int $0x80
