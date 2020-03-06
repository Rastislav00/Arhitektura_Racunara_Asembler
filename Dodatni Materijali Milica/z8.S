#Dat je niz niz2, koji je niz označenih 64-bitnih brojeva (dvostruka preciznost). Naći koliko se elemenata niza nalazi van opsega [-5000000000 (minus 5 milijardi), 6000000000 (6 milijardi)].Dobijen broj postaviti u 8-bitnu promenljivu van_opsega i vratiti ga kao izlazni kod programa
.section .data
NELEM = 4
niz:
	.quad -5000000001, 20, 34, 6000000005
donja:
	.quad -5000000000
gornja:
	.quad 6000000000
van_opsega:
	.long 0
.section .text
.globl main
main:
	movl $0,%esi
	movl niz(,%esi,8),%eax
	movl niz+4(,%esi,8),%ebx
uporedi:
	cmpl donja+4,%ebx
	jl uvecaj
	jg proveri2
	cmpl donja,%eax
	jl uvecaj
proveri2:
	cmpl gornja+4, %ebx
	jg uvecaj
	jl sledeci
	cmpl gornja,%eax
	jg uvecaj
sledeci:	
	incl %esi
uvecaj:
	incl van_opsega
	incl %esi
	cmpl $NELEM, %esi
	jl   uporedi
kraj:
	movl $1, %eax
	movl van_opsega,%ebx
	int $0x80
