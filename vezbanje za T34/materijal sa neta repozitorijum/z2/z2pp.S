#Napisati potprogram koji proverava da li se označene 64-bitne vrednosti u nizu A nalaze u otvorenom intervalu (-123456789000, 123456789000). Ukoliko dati član niza nije u intervalu, dodati mu 10000, u #suprotnom ga celobrojno pomnožiti sa 10. Povratna vrednost potprograma je broj elemenata niza koji se nalaze u intervalu. Deklaracija potprograma je data sa:
#int DodajMnozi(long long *A, unsigned N);
#gde je A pokazivač na niz 64-bitnih vrednosti, a N broj elemenata niza. U slučaju prekoračenja opsega vratiti -1.
.section .data
gornja: .quad  123456789000
donja:	.quad -123456789000
.section .text
.globl DodajMnozi
DodajMnozi:
	pushl %ebp
	movl %esp,%ebp
	pushl %ebx
	pushl %esi
	pushl %edi
	movl 8(%ebp),%esi #ovo mu dodje adresa prvog clana niza
	movl 12(%ebp),%ecx #brojac niza
	movl $0,%edi #brojac clanova koju su u intervalu
pocetak:
	movl (%esi),%ebx
	movl 4(%esi), %edx
proveraDonje:
	cmpl donja+4,%edx
	jl vanOpsega
	jg proveraGornja
	cmpl donja,%ebx
	jbe vanOpsega #kod perica stoji B umesto L videcemo sta treba
proveraGornja:
	cmpl gornja+4,%edx
	jg vanOpsega
	jl uOpsegu
	cmpl gornja,%ebx
	jae vanOpsega
uOpsegu:
	incl %edi
	movl $10,%eax
	imull 4(%esi),%eax #ova vrsta mnozenja ce strpati rezultat u %eax, tako da ce to sad postati visi deo proizvoda, ako dodje do prenosa, tjj overflow onda ce biti izlaz van opsega i trebalo bvi da prijavi gresku
	jo greska
	movl %eax,4(%esi)
	movl $10,%eax
	mull (%esi)
	movl %eax, (%esi)
	addl %edx, 4(%esi)
	jo greska
	jmp sledeci
	
vanOpsega:
	addl $10000,(%esi)
	adcl $0,4(%esi)
	jmp sledeci
sledeci:
	addl $8,%esi
	decl %ecx
	cmpl $0,%ecx
	jl rez
	jmp pocetak
greska:
	movl $-1,%eax
	jmp kraj
rez:
	movl %edi,%eax
kraj:
	popl %edi
	popl %esi
	popl %ebx
	movl %ebp,%esp
	popl %ebp
	ret


	
