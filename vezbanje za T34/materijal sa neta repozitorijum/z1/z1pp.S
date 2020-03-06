#Napisati potprogram koji vraća rezultat računske operacije između dve 64-bitne označene promenljive A i B, u zavisnosti od parametra operacija. Ukoliko operacija ima vrednost:
#‘+’, vratiti zbir A+B,
#‘-’, vratiti razliku A-B,
#‘’, vratiti proizvod AB
#U slučaju da operacija ima neku drugu vrednost, promenljivu greška postaviti na 1.
#U slučaju da dođe do prekoračenja opsega, promenljivu greška postaviti na -1.
#U svim ostalim slučajevima, promenljivu greška postaviti na 0.
#Deklaracija potprograma je data sa: long long Racunaj(long long *A, long long *B, char *operacija, int *greska);
#gde su A, B, operacija i greška pokazivači na odgovarajuće parametre. 
.section .text
.globl Racunaj
Racunaj:
	pushl %ebp
	movl %esp,%ebp
	pushl %ebx
	pushl %esi
	pushl %edi

	movl 8(%ebp),%esi #niz A
	movl 12(%ebp),%edi #niz B
	movl 16(%ebp),%ecx #operacija
pretprog:
	cmpb $'+',(%ecx)
	je zbir
	cmpb $'-',(%ecx)
	je razlika
	cmpb $'*',(%ecx)
	je proizvod
	jmp greska1
zbir:
	movl (%esi),%eax
	movl 4(%esi),%edx
	addl (%edi),%eax
	adcl 4(%edi),%edx
	jo greska2
	jmp rezultat
razlika:
	movl (%esi),%eax
	movl 4(%esi),%edx
	subl (%edi),%eax
	sbbl 4(%edi),%edx
	jo greska2
	jmp rezultat
proizvod:
	movl (%esi),%eax
	movl 4(%esi),%edx
	cmpl $0,%edx
	je mnozi
	cmpl $0,4(%edi)
	jne greska2
mnozi:
	imull 4(%edi),%eax
	jo greska2
	imull (%edi),%edx
	jo greska2
	addl %eax,%edx #zasto ide bez kerija?
	jo greska2
	movl %edx,%ecx

	movl (%esi),%eax
	mull (%edi)
	addl %ecx,%edx #zasto ide bez kerija?
	jo greska2
	jmp rezultat
greska1:
	movl $1,(%ebx)
	jmp kraj
greska2:
	movl 20(%ebp),%ecx	
	movl $-1,(%ecx)
rezultat:
	movl 20(%ebp),%ecx	
	movl $0,(%ecx)
kraj:
	popl %edi
	popl %esi
	popl %ebx
	movl %ebp, %esp
	popl %ebp
	ret
