#include <stdio.h>


int alg(int a, int b, int c, int d, int e);



void printbin(unsigned int x){
	unsigned int m=0x80000000, s=0;
	while (m) {
	printf("%s%s",m&x ? "1" : "0" ,++s%8 ? "" : "");
	m >>= 1;
	}
}

int main(){

	unsigned int r;
	int a,b,c,d,e;

	printf("Unesite redom brojeve za a,b,c,d,e vrednosti: \n");
	scanf("%d%d%d%d%d",&a,&b,&c,&d,&e);

	printbin(a);
	printf("\n");

	printbin(b);
	printf("\n");

	printbin(c);
	printf("\n");

	printbin(d);
	printf("\n");

	printbin(e);
	printf("\n");
	printf("\n");


	r = alg(a,b,c,d,e);
	printbin(r);
	printf("\n");



return 0;
}

/*
ovaj main poziva asemblerski potprogram gde je napravljen algoritam
mi sada radimo vertikalni paritet

*/
