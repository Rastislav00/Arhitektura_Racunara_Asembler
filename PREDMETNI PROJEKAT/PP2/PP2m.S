#Zadatak:
#Napisati asemblerski program koji od korisnika traži da se unese neoznačen 32­bitan broj u dekadnom brojnom
#sistemu (N) i jedan string, maksimalne dužine 80 znakova. Program zatim treba da analizira uneti string i da prvih
#N reči modifikuje tako da im je prvo slovo veliko, a sva ostala mala, dok preostale reči u rečenici treba
#modifikovati tako da su im sva slova mala. Ukupan broj reči koje su modifikovane tako da su im sva slova mala
#treba ispisati na ekranu u dekadnom brojnom sistemu. Smatra se da je reč niz znakova koju čine mala i velika slova
#engleske abecede, cifre i znak “_” (donja crta), dok su svi ostali znaci separatori (razdvajaju reči). Ukoliko
#prilikom unošenja broja ili stringa korisnik unese prazan string, treba ispisati poruku o tome i tražiti ponovno
#unošenje stringa. Ukoliko prilikom unošenja broja korisnik unese nešto što izaziva grešku u konverziji, treba
#ispisati poruku o tome i tražiti ponovno unošenje. Izlazni kod programa treba da bude 0.

.section .data

	msg1: .ascii "Unesite pozitivan celobrojni broj N: \0"
	str_len1 = . - msg1 

	msg2: .ascii "GRESKA, unesite opet N: \0"
	str_len2 = . - msg2

	msg3: .ascii "Unesite text:\n\0"
	str_len3 = . - msg3

	msg4: .ascii "GRESKA, niste uneli text, unesite opet:\n\0"
	str_len4 = . - msg4

	msg5: .ascii "EDITOVAN text:\n\0"
	str_len5 = . - msg5

	msg6: .ascii "Broj editovanih reci: \0"
	str_len6 = . - msg6




	Nstr: .fill 11,1,32 			#string unetog broja .fill kolicina,velicina, ascii ch

	N: .long 0 						#unet broj

	text: .fill 81,1,32 			#text koji posmatramo, 81 jer treba obezbediti i nul terminator

	z: .long 0 						#broj unetih karaktera u text

	br: .long 0 					#br editovanih reci tako da budu svi mali

	brstr: .fill 11,1,32 			#string da bi ispisali na ekran

.section .text
.globl main
main:


	#ispis
	movl $4, %eax
	movl $1, %ebx
	movl $msg1, %ecx 			
	movl $str_len1, %edx
	int $0x80 

unosN:		#unos ovde cemo da se vracamo sve dok ne bude unos kako treba za Nstr
	movl $3, %eax 				#u eax imamo broj unetih cifara
	movl $0, %ebx
	movl $Nstr, %ecx
	movl $11, %edx 				#stavio sam 11 jer "xxxxxxxxxx\n\0" 
	int $0x80					#11 da bi mogao uneti broj od 10 cifara jer se racuna i enter
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			movl $0, %ebx 					#zbog bl
			movl $Nstr, %ecx 				#adresa stringa sa brojem N
				movb (%ecx), %bl 				
				cmpb $10, %bl					#proverimo dal je string prazan, samo enter
				je greska_prazan_Nstr 		

	
			movb $0, (%ecx, %eax, 1) 		#stavice nulterminator na zadnje mesto "xxxxxxxxxx\n\0"
			#provera unetog N dal su cifre 

pro_cifre_N:	movb (%ecx), %bl
				cmpb $10, %bl
				je ispravne_cifre_Nstr

				cmpb $'0', %bl
				jl greska_cifre_Nstr

				cmpb $'9', %bl
				jg greska_cifre_Nstr

				addl $1, %ecx
				jmp pro_cifre_N

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ispravne_cifre_Nstr: 	#utvrdejno da je Nstr tacan treba nam konv string -> intern

		movl $N, %eax 			#stavlajenj na stek adresu promenljive N
		pushl %eax

		movl $Nstr, %eax		#stavlajenj na stek adresu stringa N
		pushl %eax

		call StoI 
		addl $8, %esp 			#brisanje sa steka

		jmp dalje
		#sada imamo N broj koji smo uneli 




#GRESKE== vezane za N ====
greska_prazan_Nstr:
greska_cifre_Nstr:
	movl $4, %eax
	movl $1, %ebx
	movl $msg2, %ecx 			
	movl $str_len2, %edx
	int $0x80 
	jmp unosN
#=========================



#sada treba omoguciti unos texta 
#ako smo dosli do ovde znaci da imamo unet Nstr i on je ispravan
#i takodje imamo konvertovan string u interni broj i smesten je u N
dalje: 

	#ispis unesite text
	movl $4, %eax
	movl $1, %ebx
	movl $msg3, %ecx 			
	movl $str_len3, %edx
	int $0x80 

unosT:
	movl $3, %eax 				#u eax imamo broj unetih karaktera
	movl $0, %ebx
	movl $text, %ecx
	movl $82, %edx 		  		#82 jer "abc...\n\0" zelimo 80 slova		
	int $0x80		

		movl $0, %ebx 				#zbog bl
		movl $text, %ecx 			#adresa stringa text u ecx
		movb (%ecx), %bl
		cmpb $10, %bl 				#proveravamo dal korisnik nije uneo samo enter
		je greska_prazan_text

			movl %eax, z  					#da sacuvam broj karaktera
										#setimo se da u eax imamo broj unetih karaktera
			movb $0, (%ecx,%eax,1) 		#stavljamo \0 na kraj texta "abc\n\0"
			jmp alg


#GRESKE=== vezane za text =======
greska_prazan_text:
	movl $4, %eax
	movl $1, %ebx
	movl $msg4, %ecx 			
	movl $str_len4, %edx
	int $0x80 
	jmp unosT
#================================


alg: #znaci da text nije prazan i da mozemo da radimo sa njime 

	#trebace nam
	#($text, N, $br)

	movl $br, %eax 			#adresa promneljive br (to je broj reci sa malim sl)
	pushl %eax 				#prenos po adresi

	movl N, %eax 			#prenos po vrednosti
	pushl %eax 				#ovo ce biti samo konstanta 

	movl $text, %eax
	pushl %eax 

	call glavni_algoritam
	addl $12, %esp 			#brisanje sa steka 

#ispis editovanog texta
	movl $4, %eax
	movl $1, %ebx
	movl $msg5, %ecx 			
	movl $str_len5, %edx
	int $0x80 

	movl $4, %eax
	movl $1, %ebx
	movl $text, %ecx 			
	movl z, %edx
	int $0x80 
#====================

	#($brstr, br)
	movl br, %eax
	pushl %eax 			#konstanta br na stek

	movl $brstr, %eax
	pushl %eax 			#adresa stringa na stek

	call ItoS
	addl $8, %esp 		#brisanje sa steka






#===================
	movl $4, %eax	#ispis broj editovanih reci
	movl $1, %ebx
	movl $msg6, %ecx 			
	movl $str_len6, %edx
	int $0x80 

# jos treba ispis bas stringa koji je broj
	
	movl $4, %eax	#ispis broj editovanih reci
	movl $1, %ebx
	movl $brstr, %ecx 			
	movl $11, %edx
	int $0x80 




kraj:
movl $1, %eax 
movl $0, %ebx
int $0x80

















