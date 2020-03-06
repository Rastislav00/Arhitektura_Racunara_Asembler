.section .data

izlazni_kod: .long 0

ispis1: .ascii "Unesite string: \0"
ispis1_len = . - ispis1

ispis2: .ascii "Zbir: \0"
ispis2_len = . - ispis2

ispis3: .ascii "Nema 32-bitnih hex brojeva.\n\0"
ispis3_len = . - ispis3

prazan: .ascii "Uneli ste prazan string!\n\0"
prazan_len = . - prazan

newlin: .ascii "\n\0"
newlin_len = . - newlin

zbir: .quad 0

unos_max = 101
unos: .fill 101, 1, 32

karaktera: .long 0 #predstavlja broj karaktera unetih u string

#promenljive funkcije
n: .long 0
SZ: .fill 20, 1, 32 #64 hex broj max bi bio FFFFFFFFFFFFFFFF

.section .text
.globl main

#==========================================

main:

unosi:
	#Unesite string:
	movl $4, %eax
	movl $1, %ebx
	movl $ispis1, %ecx
	movl $ispis1_len, %edx
	int $0x80

	#Unos
	movl $3, %eax
	movl $0, %ebx
	movl $unos, %ecx
	movl $100, %edx
	int $0x80

	#cuvanje broja unetih karaktera
	movl %eax, karaktera

#GRESKE U UNOSU:
	#Previse karaktera
	cmpl $100, %eax
	jge kraj
	
	#da li je string prazan?
	movl $unos, %ecx
	cmpl $10, (%ecx) #enter je 10 u ascii
	je greska_prazan
	
	#string je takodje prazan ako ima samo space i tab
	movl $0, %ebx #zbog bl

space_i_tab:
	movb (%ecx), %bl
		
	cmpb $10, %bl
	je greska_prazan #ako se pre entera nalaze space i tab, string je prazan
	
	cmpb $32, %bl #32 je u ascii tablici space
	je sledeci
	
	cmpb $9, %bl #9 je u ascii tablici tab
	je sledeci
	
	jmp dobar_unos #nema vise gresaka u unosu, idemo dalje
sledeci:	
	addl $1, %ecx
	jmp space_i_tab


greska_prazan:
	movl $4, %eax
	movl $1, %ebx
	movl $prazan, %ecx
	movl $prazan_len, %edx
	int $0x80
	
	jmp unosi
#ovo radim zbog previse labela u mainu
dobar_unos:

#posto ima dosta nealfanumerickih karaktera koji su separatori, bilo bi lakse da izmenimo string tako sto cemo sve separatore zameniti npr. space-om
#!%$!^%!#baba1234!!! nije hex deda5678?
		#u
#        baba1234    nije hex deda5678 
	movl $0, %ebx #anuliram ebx zbog nizeg bita bl
	movl $unos, %ecx #adresa unosa u ecx

izbaci_separator:
#IZBACIVANJE SEPARATORA:
	movb (%ecx), %bl
	
	cmpb $10, %bl
	je space_separator
	
	cmpb $'0', %bl
	jl separator

	cmpb $'9', %bl
	jle nije_separator
	
	cmpb $'A', %bl
	jl separator

	cmpb $'Z', %bl
	jle nije_separator

	cmpb $'a', %bl
	jl separator

	cmpb $'z', %bl
	jle nije_separator
	
	jmp separator

separator:
	movb $32, (%ecx) #space umesto separatora
	addl $1, %ecx #predji na sledeci karakter u stringu

	jmp izbaci_separator

nije_separator:
	addl $1, %ecx
	
	jmp izbaci_separator

#========================================================================
space_separator:
#sada su svi separatori prebaceni u space, sad treba pretvoriti string
#KONVERZIJA IZ STRINGA U INTERNI OBLIK

	movl $0, %ebx #zbog bl
	movl $0, %esi #esi i edi koristimo kao indekse i sa njima setamo po stringu
	movl $0, %edi
	movl $unos, %ecx #adresa stringa u ecx
	#esi koristim za ceo string
	#edi je fokusiran na brojeve
trazi:
	movb (%ecx, %esi, 1), %bl #ecx+esi*1
	cmpb $10, %bl #uporedjujemo sa enter jer on oznacava kraj
	je krajKonverzije
	
	cmpb $32, %bl #32 je space a ascii
	jne pot_cifra #potencijalna cifra
	addl $1, %esi
	jmp trazi

pot_cifra:
	movl %esi, %edi
	movl $0, %eax #anuliram eax jer ga koristim za konverziju
	
dalje_pot_cifra: #ova labela je tu zato što hoću samo jednom da prebacim esi u edi
	movb (%ecx,%edi,1), %bl #ecx+edi*1 u bl
	cmpb $10, %bl #granicni slucaj, desava se samo jednom
	je analiza
	cmpb $32, %bl 
	je analiza
#kad skacem u analizu, broj je ispravan i odvojen je ispravnim separatorima
#ako imam potencijalnu cifru, pre nje mora biti separator i posle nje treba biti separator

	cmpb $'G', %bl
	jl cifra
	
	cmpb $'Z', %bl
	jle nije_cifra

	cmpb $'g', %bl
	jl cifra
	
	cmpb $'z', %bl
	jle nije_cifra

cifra:
	#prebacujemo u hex
	movl $16, %esi #baza sistema, vrednost u esi je u edi, pa esi koristim
	movl $0, %edx #zbog mnozenja, rez stavlja u edx-u visi, u eax nizi brojevi
	mull %esi #eax*esi=par registara edx eax (64bit)
	
	cmpl $0, %edx #broj nije stao u 32bit nizi registar eax, greska
	jne vise_od_32_bita
	
	#razlikujemo mala i velika slova
	cmpb $'9', %bl
	jle dec_cifra #sve sto je ispod 9 je 8-0, cifra je decimalna
	
	cmpb $'F', %bl
	jle hex_velika_cifra
	
	cmpb $'f', %bl
	jle hex_mala_cifra
	
	jmp nije_cifra #nema smisla jer se nikad nece desiti, al da ne ostane dorečeno
	
#KONVERZIJE
dec_cifra:
	#0123456789
	subb $'0', %bl #da bi dobio pravu vrednost
 	addl %ebx, %eax #stavljanje vrednosti u rezultat
	jc vise_od_32_bita #npr 1111+0001 = (1)0000 odnosno jedinica u carry

	addl $1, %edi #pristupanje sledecem karakteru u stringu
	jmp dalje_pot_cifra

hex_velika_cifra:
	#ABCDEF
	
	subb $'A', %bl #da bi dobili vrednost
	addb $10, %bl #moramo uvecati za 10 jer A ima vrednost 10

	addl %ebx, %eax #dodavanje u zbir
	jc vise_od_32_bita

	addl $1, %edi #pristupi sledecem karakteru
	jmp dalje_pot_cifra

hex_mala_cifra:
	#abcdef
	
	subb $'a', %bl #da bi dobili vrednost
	addb $10, %bl #jer A ima vrednost 10
	jc vise_od_32_bita
	
	addl $1, %edi #sledeci karakter
	jmp dalje_pot_cifra

#ovaj deo prilikom gresaka nekih anulira rezultat i ide do space-a
vise_od_32_bita:
	#skok ovde ako je broj veci od 32 bita, zakljucili smo to skokom sa prenosom

nije_cifra:
	#ako nije cifra, treba prethodnu konverziju ponistiti
	movl $0, %eax
	#pored ovoga, treba ceo niz karaktera preskociti ili u granicnom slucaju entera		
trazi_separator:
	movb (%ecx,%edi,1), %bl
	
	movl %edi, %esi #vracamo esi na mesto na kom je i edi
	
	cmpb $32, %bl
	je trazi
	cmpb $10, %bl
	je trazi
	
	addl $1, %edi
	jmp trazi_separator

analiza:
	#izvrsiti sumu, znamo da nam je broj u %eax, a %edx nam je prazan (0)
	movl %edi, %esi #slobodno sad mozemo koristiti edi jer nam je esi bitan
	
	#treba suma
	addl %eax, zbir #ubacivanje rezultata konverzije u manje bitan deo sume
	adcl $0, zbir+4 #ako ima nesto u carry ubaci na vise pozicije zbira

	jmp trazi

krajKonverzije:
	#treba jos proveriti da li je suma 0, ako jeste znaci da nema 32bit brojeva
	cmpl $0, zbir
	jne dalje
	
	cmpl $0, zbir+4
	jne dalje
	
	#ako nismo skocili dalje, znaci da nema 32bit brojeva pa treba ponovo uneti
	movl $4, %eax
	movl $1, %ebx
	movl $ispis3, %ecx
	movl $ispis3_len, %edx
	int $0x80
	movl $1, izlazni_kod
	
	jmp kraj

dalje:
	#ako smo ovde dosli, znaci da ima 32bit brojeva	
	#ovde smo, dakle nasa konverzija je izvrsena i imamo u nasoj promenljivoj eax zbir svih 32bit hexa brojeva
	#sada treba da pretvorimo interni u string i to 64bit hexadecimalni broj

	#ispis poruke "Zbir: "
	movl $4, %eax
	movl $1, %ebx
	movl $ispis2, %ecx
	movl $ispis2_len, %edx
	int $0x80

	#pravimo fju koja konvertuje interni u 64bit hexa string
	movl $n, %eax #adresa promenljive n na stek
	pushl %eax	
	
	movl $zbir, %eax #adresa zbira na stek
	pushl %eax
	
	movl $SZ, %eax #adresa stringa zbira na stek
	pushl %eax
	
	call IntToSH #poziv fje
	addl $12, %esp #brisanje sa steka (3*4=12)
	
	#ispis broja kao string na terminalu
	movl $4, %eax
	movl $1, %ebx
	movl $SZ, %ecx
	movl n, %edx #n je broj karaktera u stringu
	int $0x80
	
	#new line zbog citkosti a i da je iskoristimo
	movl $4, %eax
	movl $1, %ebx
	movl $newlin, %ecx
	movl $newlin_len, %edx
	int $0x80
				
kraj:
		
	movl $1, %eax
	movl izlazni_kod, %ebx
	int $0x80

#=================================================================
#FUNKCIJA
.globl IntToSH

IntToSH:
	#($SZ, $zbir, $n)
	
	pushl %ebp
	movl %esp, %ebp
	
	subl $4, %esp  #zbog lokalne promenljive
	movl $0, -4(%ebp) #lokalna promenljiva stanja kao indikator da li smo vec uradili i visi i nizi deo
	
	pushl %ebx
	pushl %esi
	pushl %edi
	#brojac puta ubacivanja u string
	
	movl $0, %ebx
	movl $16, %esi #baza stringa
	movl $0, %edx #zbog deljenja
	movl $0, %edi #brojac
	
	movl 8(%ebp), %ecx #adresa stringa u ecx
	movl 12(%ebp), %ebx #adresa zbira, to je onaj broj koji konv. u string
	
#Posto je u pitanju 64bit broj, mi cemo konvertovati prvo manje znacajan deo
#znaci prvo konverujemo zbir pa zbir+4
#movl (%ebx), %eax - manje znacajni deo
#movl 4(%ebx), %eax - vise znacajni deo

	movl (%ebx), %eax #u eax ubacili manje bitne brojeve zbira
deli:
	cmpl $0, %eax
	je zamena #zamena u prvom slucaju, kraj u drugom
	
	divl %esi #eax/esi = eax, edx (edx je ostatak)
	addl $1, %edi #brojac ubacivanja
	
	cmpb $10, %dl
	#treba da vidimo da li je manje od 10 ili ne, ako je 10 ili bece treba 		zameniti sa A hexa ciframa	
	jge hex_cifra

deci_cifra:
	addb $'0', %dl #da bi dobio ascii broj
	movb %dl, (%ecx) #smestanje na odgovarajucu poziciju u stringu
	
	addl $1, %ecx #uvecati brojac
	movl $0, %edx #anuliranje ostatka
	jmp deli
	
hex_cifra:
	subb $10, %dl 
	addb $'A', %dl #da bi dobili ascii karakter
	movb %dl, (%ecx) #smestanje na odg mesto u stringu
	
	addl $1, %ecx #sledeci karakter
	movl $0, %edx #anuliranje ostatka
	jmp deli

zamena:
	#zamena donjeg dela gornjim delom 64bit zbira
	cmpl $0, -4(%ebp)
	#lokalnu promenljivu -4(%ebp) koristimo kao indikator da li smo vec jednom uradili prelazak na vise znacajne cifre
	jne krajK
	
	movl $1, -4(%ebp)
	movl 4(%ebp), %eax #vise znacajni brojevi u eax
	
	jmp deli
krajK:
	#treba jos obrnuti string
	
	#prvo sacuvamo broj ubacenih karaktera
	subl $1, %ecx #da bi se vratili na poslednje ubacen karakter
	
	movl 16(%ebp), %edx #adresa n
	movl %edi, (%edx) #sacuvali smo broj pojavljivanja, nakon ovog slobodni su i edx i edi
	movl $0, %edx #anuliranje zbog dl
	movl $0, %ebx #anuliranje zbog bl
	
	movl 8(%ebp), %eax #adresa pocetka stringa

obrniString:
	movb (%eax), %bl
	movb (%ecx), %dl
	movb %bl, (%ecx)
	movb %dl, (%eax)
	
	addl $1, %eax #pokazivacu
	subl $1, %ecx #pokazivaci za pristupanje elem stringa
	
	cmpl %eax, %ecx #kad se oni dohvate, tada je kraj obrtanja
	jle krajP
	
	jmp obrniString
	
krajP:
	popl %edi
	popl %esi
	popl %ebx
	movl %ebp, %esp
	popl %ebp
	ret
	
	
