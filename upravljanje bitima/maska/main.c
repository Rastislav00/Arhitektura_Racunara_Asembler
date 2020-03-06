#include <stdio.h>

unsigned int maska(unsigned int n, unsigned int v);

void printbin(unsigned int x){
	unsigned int m=0x80000000, s=0;
	while (m) {
	printf("%s%s",m&x ? "1" : "0" ,++s%8 ? "" : "");
	m >>= 1;
	}
}

int main(){

	unsigned int r,n,v;

	printf("Unesi vrednost 0 ili 1: ");
	scanf("%d", &v);

	printf("Unesi poziciju: ");
	scanf("%d", &n);


	r=maska(n,v);
	printf("Maska za n=%d, v=%d je: ",n,v);
	printbin(r);
	printf("\n");
	





return 0;
}



























