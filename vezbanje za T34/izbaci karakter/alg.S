#int izbaci(char *str);
#!, #, $, %, &, /, *.
.section .text
.globl izbaci
izbaci:


	pushl %ebp
	movl %esp, %ebp
	pushl %esi
	pushl %edi

	movl $0, %esi					#esi i edi pokazivaci
	movl $0, %edi

	movl $0, -4(%ebp)				#ovde cu da cuvam broj izbacenih karaktera
	movl $0, %ecx					#da se ne nadju neki brojevi od pre
	movl 8(%ebp), %edx				#adresu stringa u edx i prvi karakter

opet:	movb (%edx,%esi,1), %cl			#u cl imam karaktere
		cmpb $0, %cl  					#$0 ~ \n
		je krajP						#ako dodjemo do onog \n to je kraj ceo string smo prosli

cmp:	cmpb $'!', %cl
		je alg
		cmpb $'#', %cl
		je alg
		cmpb $'$', %cl
		je alg
		cmpb $'%', %cl
		je alg
		cmpb $'&', %cl
		je alg
		cmpb $'/', %cl
		je alg
		cmpb $'*', %cl
		je alg

sl_k:	addl $1, %esi
		jmp opet



alg:	movl %esi, %edi					#alg za izbacivanje 
		addl $1, -4(%ebp)				#povecavam brojac za reci koje su izbacene
algW:	movb 1(%edx,%edi,1), %cl			
		movb %cl, (%edx,%edi,1)
		cmpb $0, %cl					#pomerili smo sve karaktre 
		je opet
		addl $1, %edi
		jmp algW





krajP:
movl -4(%ebp), %eax
popl %edi
popl %esi
movl %ebp, %esp
popl %ebp
ret

