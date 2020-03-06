.section .data
string1: .ascii " unesite ime i prezime   \0"
str1_len= .-string1
string2_max=40

string2: .fill string2_max,1,0
string3: .ascii "vi ste \0"
str3_len= .-string3

.section .text
.globl main

main:

	movl $4,%eax
	movl $1,%ebx
	leal string1,%ecx
	movl $str1_len,%edx
	int $0x80
	
	movl $3,%eax
	movl $0,%ebx
	leal string2,%ecx
	movl $string2_max,%edx
	int $0x80

	movl $4,%eax
	movl $1,%ebx
	leal string3,%ecx
	movl $str3_len,%edx
	int $0x80
	
	movl $4,%eax
	movl $1,%ebx
	leal string2,%ecx
	movl $string2_max,%edx
	int $0x80

kraj:
	movl $1,%eax
	movl $0,%ebx
	int $0x80
