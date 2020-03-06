#sortiranje niza u dvostrukoj preciznosti

.section .data

	niz: .quad 0x74, 0xc5, 0x2d, 0x157b, 0xf, 0x1646df5f76, 0x237, 0x3
	n: .long 8					#n je broj elemenata

.section .text
.globl main
main:
#===================SORTIRANJE od manjeg ka vecem broju =========================
	
#niz su redom brojevi u dekadnom sistemu 116 197 45 5499 15 95678324598 567 3


	addl $4, n			#moramo da dodamo plus 4 na n jer tada zavrsavamo sa uporedjivanjem 
	movl $0, %esi			#esi i edi brojaci
	movl $1, %edi			#edi ce biti veci za jedan uvek kako bi pristupali sledecem
	jmp opet1
		
opet:	addl $2, %esi
	addl $2, %edi


opet1:	cmpl %esi, n
	jle kraj			#jle manje ili jednako


	movl niz(,%esi,4), %eax		#manje znacajne cifre elementa niza
	movl niz+4(,%esi,4), %ebx	#vise znacajne cifrre elementa niza

	movl niz+4(,%edi,4), %ecx	#manje znacajne cifre elementa niza sledeceg
	movl niz+8(,%edi,4), %edx	#vise znacajne cifrre elementa niza sledeceg

	
cmp1:	cmpl %ebx, %edx
	je cmp2
	jl alg1				#jl manje 	alg1 je algoritam za sortiranje
	jmp opet

cmp2:	cmpl %eax, %ecx
	jl alg1				#jl manje
	jmp opet


alg1:	movl %ecx, niz(,%esi,4)
	movl %edx, niz+4(,%esi,4)
	
	movl %eax, niz+4(,%edi,4)
	movl %ebx, niz+8(,%edi,4)

	movl $0, %esi
	movl $1, %edi
	jmp opet1	

#========================


kraj:
movl $1, %eax
movl $0, %ebx
int $0x80
