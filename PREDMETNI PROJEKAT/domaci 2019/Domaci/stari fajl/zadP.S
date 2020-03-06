#Zadatak: DOMACI 2019
#Napisati asemblerski program koji od korisnika traži da unese string maksimalne dužine 100 znakova. Program potom
#analizira string i u njemu pronalazi sve neoznačene 32-bitne heksadecimalne brojeve. Heksadecimalnim brojem se smatra niz
#znakova koji čine heksadecimalne cifre, pri čemu se mogu koristiti i mala i velika slova. Svi heksadecimalni brojevi moraju
#biti razdvojeni separatorima od ostalih reči u stringu, pri čemu se separatorom smatra svaki znak koji nije slovo engleske
#abecede ili dekadna cifra.
#Program treba da izračuna 64-bitni zbir svih 32-bitnih heksadecmalnih brojeva (oni koji mogu da stanu u 32 bita) i da taj zbir
#ispiše na ekranu takođe u heksadecimalnom brojnom sistemu (koristeći velika slova). Ukoliko u stringu nema
#heksadecimalnih brojeva koji staju u 32 bita, ispisati odgovarajuću poruku.
#Ukoliko prilikom unošenja stringa korisnik unese prazan string, treba ispisati poruku o tome i tražiti ponovno unošenje
#stringa (praznim stringom se smatra i onaj koji se sastoji isključivo od razmaka i tabulacija). Izlazni kod programa treba da
#bude 0 ako je u stringu bilo 32-bitnih heksadecimalnih brojeva, a 1 ako ih nije bilo.
#=========================================================================
.section .data

	ispis1: .ascii "Unesite string: \0"
	str_len1 = . - ispis1 					#zbog izlaznog baffera sis poziva

	ispis2: .ascii "Zbir: \0"
	str_len2 = . - ispis2

	ispis3: .ascii "Nema 32-bitnih hex brojeva.\n\0"
	str_len3 = . - ispis3

	prazan: .ascii "Uneli ste prazan string!\n\0"
	str_len4 = . - prazan

	newlin: .ascii "\n\0"  			#cemu ovo sluzi?

	zbir: .quad 0 					#64 bitni zbir

	str: .fill 111,1,32 			#.fill kolicina, velicina, sadrzaj
	k: .long 0 						#broj unetih karaktera u string

	ispis4: .ascii "Zbir: \0"
	str_len5 = . - ispis4


	n: .long 0 						#bafer za stampanje SZ
	SZ: .fill 20,1,32 				#da bi imo string 20 karaktera velicine jedan pun spejsova
									#podrzavamo string do 64 bitnih brojeva 

.section .text
.globl main
main:
#=================MAIN===================================================

	#sistemski poziv za ispis stringova
unos:
	movl $4, %eax
	movl $1, %ebx
	movl $ispis1, %ecx
	movl $str_len1, %edx
	int $0x80

	#unos stringa
	movl $3, %eax
	movl $0, %ebx
	movl $str, %ecx
	movl $111, %edx 		#unos do 101 karakter jer smo uracunali i enter
	int $0x80 

	movl %eax, k 			#cuvamo broj unetih karaktera u string
	#ako korisnik unese vise karaktera nego sto moze treba da izbacimo gresku
	cmpl $110, %eax 
	jge kraj  

	#treba proveriti dal je prazan string

	movl $str, %ecx 		#adresa stringa u ecx
	cmpb $10, (%ecx) 		#provera dal je unet samo znak enter (prazan string)
	je greska_unos

	#string je prazan i ako ima samo spejsove i tabulatore
	movl $0, %ebx 			#zbog bl podregistra
	
prov1:	movb (%ecx), %bl
		
		cmpb $10, %bl
		je greska_unos

		cmpb $32, %bl  			#32(spejs), 9(tab)
		je sledeci

		cmpb $9, %bl 			# 9(tab)
		je sledeci 

		jmp ok_unos 			#vidi komentar[1] ispod skroz dole

		sledeci:
			addl $1, %ecx		#pristupi sl karakteru
			jmp prov1

#==================================
greska_unos:
	movl $4, %eax
	movl $1, %ebx
	movl $prazan, %ecx
	movl $str_len4, %edx
	int $0x80
	jmp unos 				#trazimo opet unos

#==================================


#Ako smo skocili ovde znaci da imamo unet string i on nije prazan...

ok_unos: 		
				
#posto ima mnogo separatora, bilo bi nam lakse da editujemo string
#na takav nacin da se svaki separator zameni spejsom
	movl $0, %ebx 			#da ga nuliramo zbog bl
	movl $str, %ecx 		#adresa stringa u ecx 
							#vidi komentar[3]
izbaci_separator:

			movb (%ecx), %bl 
			
			cmpb $10, %bl 			#ovo moze da stoji na pocetku iz uslova da string nije prazan koji smo mi vec proverili
			je jednoznacni_spearatori

			cmpb $'0', %bl 
			jl separator 			#jl manje

			cmpb $'9', %bl
			jle nije_separator 		#jle manje ili jednako

			cmpb $'A', %bl
			jl separator

			cmpb $'Z', %bl
			jle nije_separator

			cmpb $'a', %bl 
			jl separator 

			cmpb $'z', %bl 
			jle nije_separator 		#za bolje razumevanje ovog koda pogledati 
									#ascii tabelu 
			jmp separator 



separator:	movb $32, (%ecx) 		#ubacivanje spejsa umesto separatora
			addl $1, %ecx 			#pristupi sl karakteru stringa
			jmp izbaci_separator

nije_separator:
			addl $1, %ecx
			jmp izbaci_separator



#===================================================================
jednoznacni_spearatori: #u ovom momentu nas string ima samo spejs separatore
#sada ce nas string umesto ovog:
#!%$!^%!#baba1234!!! nije hex deda5678?
#izgledati ovako:
#        baba1234    nije hex deda5678 


#sada treba izvaditi iz njega hexadecimalne brojeve

#====KONVERZIJA IZ STRINGA U INTERNI ================================

	movl $0, %ebx 			#zbog bl
	movl $0, %esi			#esi i edi sa njima cemo da se setamo
	movl $0, %edi 			
	movl $str, %ecx 		#adresa stringa u ecx

trazi:	movb (%ecx,%esi,1), %bl
		cmpb $10, %bl  		#uporedjujemo sa enterom jer je to kraj
		je krajK

		cmpb $32, %bl 		#32 je spejs ako je spejs ignorisi ga 
		jne pot_cif 		#potencionalna cifra, jne skoci ako nije jednako
		addl $1, %esi 		#pristupi sl karakteru stringa
		jmp trazi


pot_cif:	movl %esi, %edi 

			movl $0, %eax 		#nuliranje registra eax kojeg koristimo za konverziju
sl_pot_cifra:		
			movb (%ecx,%edi,1), %bl 
			cmpb $10, %bl  		#granicni slucaj kada je broj neposredno ispred entera on ne bi nikad iskocio iz
			je analiza 			#on ne bi otiso na analizu jer nema spejsa posle njega

			cmpb $32, %bl  		#ako je doso do spejsa treba videti sta smo to ulovili kakav broj
			je analiza 	


				cmpb $'G', %bl 
				jl cifra

				cmpb $'Z', %bl 
				jle nije_cifra

				cmpb $'g', %bl 
				jl cifra 

				cmpb $'z', %bl 
				jle nije_cifra


cifra:	#potencionalan konverzija (jer zavisi dal necemo doci do karaktera koji nije hexa cifra)
				movl $16, %esi  	#ovo mozemo da radimo jer vracamo edi na esi inace esi nam je element indeksnog adresiranja
				movl $0, %edx  		#zbog mnozenja tj konverzije
				mull %esi 			#eax*esi=edx:eax 

				cmpl $0, %edx 
				jne vise_od_32_bita #pogledaj komentar[4]

				#vidi komentar[5] moramo da razlikujemo brojke mala i velika slova 

				cmpb $'9', %bl 
				jle dec_cifra

				cmpb $'F', %bl
				jle hex_v_cifra

				cmpb $'f', %bl 
				jle hex_m_cifra

				jmp nije_cifra 	#ova linija nema smisla jer se ovo nikad nece desiti al ajde neka ga 

#KONVERZIJE 
dec_cifra: 	#0123456789 

				subb $'0', %bl   	#da bi dobio pravu brojku 
				addl %ebx, %eax 	#stavljanje vrednosti u rezultat
				jc vise_od_32_bita 	#npr 1111 + 0001 = (1)0000  jedinica ce biti u carry   

				addl $1, %edi  		#pristupanje sl karakteru u stringu
				jmp sl_pot_cifra   	

hex_v_cifra: #ABCDEF

				subb $'A', %bl 		#da bi dobili vrednosti 
				addb $10, %bl 		#moramo uvecati za 10 jer A ima vrednost 10
				addl %ebx, %eax  	#dodavanje u zbir
				jc vise_od_32_bita

				addl $1, %edi 		#pristupi sl karakteru
				jmp sl_pot_cifra


hex_m_cifra: #abcdef	

				subb $'a', %bl 		#da dobijemo vrednost
				addb $10, %bl 		#jer A ima vrednost 10
				addl %ebx, %eax 
				jc vise_od_32_bita

				addl $1, %edi 		#pristupi sl karakteru
				jmp sl_pot_cifra		


#======ovaj deo se aktivira prilikom gresaka nekih nulira rezultat i ide do spejsa===
vise_od_32_bita: #ovde skacemo ako je broj vise od 32 bita a to smo zakljucili jump for carry
nije_cifra:		#ako nije cifra treba prethodnu konverziju obrisati
				movl $0, %eax 
				#osim toga treba celi ovaj niz karaktera preskociti
				#sto znaci treba otici do prvog separatora ili u granicnom slucaju entera

					TS:	movb (%ecx,%edi,1), %bl 

						movl %edi, %esi 			#vracamo esi na mesto koje je i edi

						cmpb $32, %bl 
						je trazi 
						cmpb $10, %bl 
						je trazi 

						addl $1, %edi 
						jmp TS 				#skracenica od trazi separator





analiza: 	#tizvrsiti sumu pri tome znamo da nam je broj u %eax i %edx nam je prazan 0
			movl %edi, %esi 	#posle ove linije slobodno smemo koristii edi jer nam je esi bitan


				#treba suma 

				addl %eax, zbir 		#ubacivanje rezultat konverzije u manje znacajni deo sume 
				adcl $0, zbir+4			#ako ima nesto u carry ubaci na vise znacajne pozicije zbira

			jmp trazi 




krajK: 	#treba jos proveriti dal je suma 0 ako jeste znaci da nema 32 bitnih brojeva
		cmpl $0, zbir 
		jne dalje 

		cmpl $0, zbir+4
		jne dalje

		#ako smo pali vamo znaci da nema 32 bitnih brojeva treba opet unos
		movl $4, %eax
		movl $1, %ebx
		movl $ispis3, %ecx
		movl $str_len3, %edx
		int $0x80 
		jmp unos 





dalje:	#ako smo ovde dosli znaci da ima 32 bitnih brojeva
		#ako smo skocili ovamo nasa konverzija je izvrsena i mi imamo u promenljivoj
		#zbir svih hexadecimalnih 32 bitnih brojeva 
		#sada ih treba ispisati na terminal	

	#ipis poruke "zbir: "
	movl $4, %eax
	movl $1, %ebx
	movl $ispis4, %ecx
	movl $str_len5, %edx
	int $0x80 

	#sada nam je potrebna konverzija internog u string al hexa al 64bitni brojevi
	#napravicemo funkciju 

		movl $n, %eax 			#adresa promenljive n
		pushl %eax 				#stavi na stek

		movl $zbir, %eax 		#prosledjujemo adresu zbira 
		pushl %eax 				#stavljamo na stek

		movl $SZ, %eax 			#adresu stringa 
		pushl %eax 				#stavi na stek

		call ItoSH 				#inter to string hexa 
		addl $12, %esp 			#brisanje sa steka

	#ispis broja kao string na terminalu
	movl $4, %eax
	movl $1, %ebx
	movl $SZ, %ecx
	movl n, %edx 			#n je neki broj tj broj karaktera u stringu 
	int $0x80 

	#samo da istampamo jos novu liniju da bude citkije
	movl $4, %eax
	movl $1, %ebx
	movl $newlin, %ecx
	movl $2, %edx 		
	int $0x80 


kraj:
movl $1, %eax
movl $0, %ebx
int $0x80
#====================KRAJ===========================





#===KOMENTARI===

#komentar[1]: kod ide i proverava redom od prvog karaktera sve do kraja 
#to jesto do entera ($10) ako je neki karakter koji nije spejs ili tab
#string nije prazan, al ako takvog nema karaktera i svi karakteri su
#spejsovi i tabovi on ce na kraju da dodje do entera i shvatice da je 
#string prazan... opet unos

#komentar[3]: posto su separatori svi karakteri koji nisu decimalna cifra
#znaci (0-9) i cela engleska abeceda(ABECEDA) a sve ostalo jeste 
#bilo bi nam lakse ako bi sve separatore zamenili jednim na primer spejsom
#sada ce nas string umesto ovog:
#izgledati ovako:
#
#!%$!^%!#baba1234!!! nije hex deda5678?
#        baba1234    nije hex deda5678 



#komentar[4]: pa pre mnozenja smestili smo nulu u edx a posle mnozenja u edx ce se
#nalaziti znacajnije cifre ako udju u njega znaci bice tamo nesto razlicito od nule
#znaci da nije 32 bitni broj nego neki veci tipa 33 ...

#komentar[5]: posto nam se mogu naci mala i velika slova i brojke moramo to regulisati








#=================KONVERZIJA=====================================
#iz internog 64 bitnog broja u string al hexa decimalni string :D 
#cifre koje mogu koristiti su 0123456789ABCDEF
.globl ItoSH
ItoSH:
#($SZ, $zbir, $n)

	pushl %ebp
	movl %esp, %ebp

	subl $4, %esp 			#zbog lokalne promenljive
	movl $0, -4(%ebp) 		#lokalna promenljiva stanja kao indikator dal smo vec uradili i visi i nizi deo

	pushl %ebx 			
	pushl %esi  			
	pushl %edi 				#brojac puta ubacivanja u string 

	movl $0, %ebx
	movl $16, %esi  		#baza hexa cifrara
	movl $0, %edx 			#zbog deljenja
	movl $0, %edi 			#brojac

	movl 8(%ebp), %ecx 		#adresa stringa u ecx
	movl 12(%ebp), %ebx 	#adresa zbira to je onaj broj koji konvertujemo u string

	#pogledaj komentar[6] ispod ovog koda

	movl (%ebx), %eax 		#ubacili u eax manje znajacne brojeve zbira


deli:	cmpl $0, %eax
		je zamena 				#zamena u prvom slucaju, kraj u drugom slucaju

		divl %esi 				#eax/esi = eax,edx (edx je ostatak)

		addl $1, %edi 			#brojac ubacivanja 

		cmpb $10, %dl 			#vidi komentar[7]
		jge hexi_cifra 			#jge veci ili jednaki


	deci_cifra:
		
			addb $'0', %dl  		#da bi dobio ascii broj
			movb %dl, (%ecx) 		#smestanje na odgovarajucu poziciju u stringu
			addl $1, %ecx 			#uvecati brojac
			movl $0, %edx 			#nuliranje ostatka
			jmp deli 

	hexi_cifra:
		
			subb $10, %dl  			
			addb $'A', %dl 			#da bi dobili ascii karakter
			movb %dl, (%ecx) 		#smestanje na odg mesto u karakteru
			addl $1, %ecx 			#pristupi sl karakteru
			movl $0, %edx 			#nuliranje ostatka
			jmp deli 


zamena: #zamena donjeg gornjim delom 64bitnog zbira
		cmpl $0, -4(%ebp) 		#vidi komentar[8]
		jne krajKonverzije

		movl $1, -4(%ebp)

		movl 4(%ebx), %eax 		#stavljanje vise znacajnih brojeva u eax
		jmp deli 


krajKonverzije:#treba jos samo da obrnemo string ==========================
		
		#samo da sacuvamo broj ubacenih karaktera
		subl $1, %ecx 			#da bi se vratili na zadnje ubacen karakter

		movl 16(%ebp), %edx 	#adresa n
		movl %edi, (%edx) 		#ok sacuvali smo broj pojavljivanja nakon ovog slobodni su mi i edx i edi

		movl $0, %edx 			#nuliranje zbog dl
		movl $0, %ebx 			#nuliranje zbog bl

		movl 8(%ebp), %eax 		#adressa pocetka stringa 


obrniS:		movb (%eax), %bl 
			movb (%ecx), %dl 

			movb %bl, (%ecx)
			movb %dl, (%eax)

			addl $1, %eax		#pokazivacu
			subl $1, %ecx  		#pokazivaci za pristupanje el stringa

			cmpl %eax, %ecx 
			jle krajP 			#kad se oni dohvate tada je kraj obrtanja

			jmp obrniS



krajP: 
popl %edi 
popl %esi 
popl %ebx
movl %ebp, %esp
popl %ebp 
ret 
#=======================================================
#komentar[6]: posto je 64bitni broj mi cemo konvertovati prvo deo manje znacajan
#znaci samo zbir a onda posle cemo konvertovati zbir+4
#koristicemo neki od registara
#movl (%ebx), %eax    manje znacajne
#movl 4(%ebx), %eax   vise znacajne



#komentar[7]: treba da vidimo dal je manje od 10 ili ne 
#jer mi treba ako je 10 ili vece zameniti sa A hexa ciframa 


#komentar[8]: lokalnu promenljivu -4(%ebp) koristim samo kao indikator
#da li sam vec jednom uradio prelazak na vise znacajne cifre







