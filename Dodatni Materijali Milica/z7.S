#Dati su nizovi 64-bitnih označenih brojeva A i B sa jednakim brojem elemenata. Formirati niz C na sledeći način:
#•ako jeA[i]>B[i], onda je C[i]=A[i]-B[i]
#u suprotnom je C[i]=A[i]+B[i]
#U slučaju prekoračenja opsega prilikom računanja, postaviti 32-bitnu promenljivu greska na 1 i prekinuti izvršavanje programa. Ako se program uspešno izvršio, promenljivu greska postaviti na 0.Promenljivu greska vratiti kao izlazni kod programa.
.section .data
NELEM = 4
A:
	.quad 5000000001, 5, 3, 6000000005
B:
	.quad 5000000000, 4, 7, 32000
C:
	.quad 0, 0, 0, 0
greska:
	.long 0
.section .text
.globl main
main:
	movl $0,%esi #indeks
	movl $0,%edi #greska
petlja:
	movl A+4(,%esi,8),%eax
	cmpl B+4(,%esi,8),%eax
	jl saberi
	jg oduzmi
	movl A(,%esi,8),%eax
	cmpl B(,%esi,8),%eax
	jg oduzmi
saberi:
	movl A+4(,%esi,8),%eax
	movl A(,%esi,8),%ebx
	addl B(,%esi,8),%ebx
	adcl B+4(,%esi,8),%eax #upisace u c 1 ako dodje do prenosa
	adcl $0,greska #sabrace 0 sa nulom koja je u greski na pocetku zadata ali sada ce imate i iz prenosa od malo pre jedinicu ako dodje do izlaska van opsega i ako nije 0 onda ide na kraj
	jnz kraj
	jmp smestiuc
oduzmi:
	movl A+4(,%esi,8), %eax
	movl A(,%esi,8),%ebx
	subl B(,%esi,8), %ebx
	sbbl B+4(,%esi,8),%eax
	adcl $0,greska
	jnz kraj
smestiuc:
	movl %eax, C+4(,%esi,8)
	movl %ebx, C(,%esi,8)
	incl %esi
	cmpl $NELEM, %esi
	jl petlja
kraj:	
	movl $1 , %eax
	movl greska, %ebx #nzm kako da postavim da mi to bude izlazni kod?????????
	int $0x80










