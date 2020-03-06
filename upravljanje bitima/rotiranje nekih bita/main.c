/*
zadatak je da prosledjenom broju zamenimo prva 3 i zadnja 3 bita
npr:
pre alg:
	101...110
nakon alg:
	110...101
*/

#include <stdio.h>

	void alg(int *a);		//ovde cemo proslediti adresu broja



	void printbin(unsigned int x){			//fun za stampanje bita
	unsigned int m=0x80000000, s=0;
	while (m) {
	printf("%s%s",m&x ? "1" : "0" ,++s%8 ? "" : "");
	m >>= 1;
	}
}




int main(){

	int broj=57;

	printf("\nOriginal: ");
	printbin(broj);
	printf("\n");

	alg(&broj);

	printf("\nEditovan: ");
	printbin(broj);
	printf("\n");	
	printf("%d", broj);

return 0;
}