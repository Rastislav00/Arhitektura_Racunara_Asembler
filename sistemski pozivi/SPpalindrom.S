.section .data

poruka: .ascii "Unesite String: \0"
str_len1 = . - poruka

nijep: .ascii "String nije palindrom.\n\0"
str_len2 = . - nijep

jestep: .ascii "String jeste palindrom.\n\0"
str_len3 = . - jestep

unos: .fill 50,1,42

duzina_palindroma: .long 0

.section .text
.globl main
main:

#====================== PALINDROM ==========================


	#ispisi Unesite string

	movl $4, %eax
	movl $1, %ebx
	movl $poruka, %ecx
	movl $str_len1, %edx
	int $0x80

	#unesite string prvo

	movl $3, %eax				#po pravilu        u eax ce biti broj karaktera
	movl $0, %ebx				#po pravilu
	movl $unos, %ecx			#adresa stringa stavljamo u ecx
	movl $50, %edx				#mogucnost do 50 karaktera za unos
	int $0x80

	movl %eax, duzina_palindroma		#eax sadrzi broj karaktera naseg stringa hocu da ga cuvam

#========================================================


	movl $unos, %eax			#stavili smo adresu stringa u eax

	movl duzina_palindroma, %esi		#smestili smo broj karaktera u esi
	subl $2, %esi				#oduzeli smo dva jer zadnji karakter nam je enter a prvi karakter pocinje od nule
						

	movl $0, %edi				#edi i esi koristim kao brojace

	movl $0, %ecx				#stavili smo nulu kako se ne bi desilo da ima u sebi neki bzvz broj

#=======================================================

						#gledamo skroz levi karakter

opet:	cmpb $' ', (%eax,%edi,1)		#uporedjivacemo da li je razmak ako jeste preskocicemo tj gurnimo se dalje
	je pomeri
	jmp dalje

pomeri:	addl $1, %edi				#ovim pomeranjem mi smo povecali brojac i sada gledamo na sledecu adresu
	jmp opet

dalje:	cmpb $'a', (%eax,%edi,1)		#pogledacmo da li nase slovo spada u opseg od a do z 
	jge cmp1				#jge vece ili jednako
	jmp zadnji				#logicno ako ne idemo na cmp1 znaci da imamo karakter sa manjim asci kodom od slova a
						#i ako je to tako onda ne treba da ga diramo 
cmp1:	cmpb $'z', (%eax,%edi,1)
	jle alg1				#jle manje ili jednako
	jmp zadnji				#jmp bezuslovni skok

alg1: 	addl $'A'-'a', (%eax,%edi,1)		#ocigledno ce se ovaj algoritam izvrsiti ako je nase slovo u opsegu od a do z
	jmp zadnji


#======================================================

zadnji:						#sada radimo isto sto smo i malo pre ali za skroz desni karakter naseg stringa

opet1:	cmpb $' ', (%eax,%esi,1)		#icicemo uvek dalje sve dok sadrzimo spejs
	je pomeri1
	jmp dalje3

pomeri1:subl $1, %esi				#ovde oduzimamo od brojaca jer se pomeramo sa desna u levo
	jmp opet1

dalje3:	cmpb $'a', (%eax,%esi,1)
	jge cmp_1
	jmp dalje1				#npr ako karakter ima asci kod manji od koda a znaci ne treba da ga diramo 

cmp_1:	cmpb $'z', (%eax,%esi,1)
	jle alg2
	jmp dalje1

alg2:	addl $'A'-'a', (%eax,%esi,1)		#ovo ce se desiti samo ako nam je karakter u opsegu od a do z
	jmp dalje1

#==================================================


dalje1:	movb (%eax,%edi,1), %cl			#moramo staviti u cl registar tj podregistar ecx kako bi uporedjivali
	cmpb %cl, (%eax,%esi,1)			#ovo radimo jer ne mozemo uporedjivati dve memorijske lokacije
	jne nije				#jne nije jednako

	addl $1, %edi				#edi nam ide sa leva na desno pa treba da dodjaemo
	subl $1, %esi				#esi nam ide sa desne na levo pa treba da oduzimamo

	cmpl %esi, %edi				#potrebno je uporediti kada se esi i edi ukrste zavrsili smo ispitivanje celog stringa
	jge jeste				#jge vece ili jednako     posto smo zavrsili bez problema mozemo tvrditi da string je pali 
	jmp opet				


#===============================================

						#ovo su algoritmi za pisanje
jeste:	movl $4, %eax				#po pravilu
	movl $1, %ebx				#po pravilu
	movl $jestep, %ecx			#stavi adresu stringa u registar ecx
	movl $str_len3, %edx			#duzinu stringa smo na pocetku odredili
	int $0x80
	jmp kraj				#kraj programa



nije: 	movl $4, %eax
	movl $1, %ebx
	movl $nijep, %ecx
	movl $str_len2, %edx
	int $0x80
	jmp kraj





kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80

#============KRAJ====================================

























