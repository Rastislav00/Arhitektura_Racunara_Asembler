#long long racunaj(long long *A, long long *B, char *operacija, int *greska);
.section .text
.globl racunaj
racunaj:

	pushl %ebp
	movl %esp, %ebp
	pushl %ebx
	pushl %esi
	pushl %edi

	movl 8(%ebp), %esi			#A
	movl 12(%ebp), %edi			#B
	movl 16(%ebp), %ecx			#operacija
	movl 20(%ebp), %ebx			#adresa promenljive greska

	movl $0, (%ebx)				#pretpostaqvljamo da nema greske al videcemo 

	cmpb $'+', (%ecx)
	je zbir
	cmpb $'-', (%ecx)
	je razlika
	cmpb $'*', (%ecx)
	je proizvod
	#ako nista od navedenog greska pri operaciji
	movl $1, (%ebx)			#na adresu greska stavljamo 1
	jmp krajP

zbir:							 #A+B
		movl (%esi), %eax		#u eax manje znacajnih 4 bajta promenljive A
		addl (%edi), %eax		#na (%edi) imam manje znacajnih 4 bajta promenljive B
		movl 4(%esi), %edx		#4 visih bajta
		adcl 4(%edi), %edx		#addl i uracunat carry znaci adcl
		jo prekoracenje			#jo skoci za overflow o=1
		jmp krajP

razlika:
		movl (%esi), %eax
		subl (%edi), %eax
		movl 4(%esi), %edx
		sbbl 4(%edi), %edx
		jo prekoracenje
		jmp krajP

proizvod:
	imull 4(%edi), %eax
	jo   prekoracenje
	imull (%edi), %edx
	jo   prekoracenje
	addl  %eax, %edx
	jo   prekoracenje
	movl %edx, %ecx

	movl (%esi), %eax
	mull (%edi)
	cmpl $0, %edx
	js   prekoracenje
	addl %ecx, %edx
	jo   prekoracenje
	jmp  krajP





prekoracenje: 						#carry
		movl 20(%ebp), %ebx			#adresa promenljive greska
		movl $-1, (%ebx)
		jmp krajP


krajP:
popl %edi
popl %esi
popl %ebx
movl %ebp, %esp
popl %ebp
ret