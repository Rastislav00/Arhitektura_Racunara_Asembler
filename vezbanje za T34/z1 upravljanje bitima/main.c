/* ukoliko imamo uredjeni par od 3 bita koji izgleda kao 101,
 ako je 0 okruzena sa dve jedinice onda ona postaje 1 iz oblika 101 ->> 111
*/


#include <stdio.h>


	int alg(int *niz, int n);			//pokazivac na niz i n broj elementa niza


	void printbin(unsigned int x){
	unsigned int m=0x80000000, s=0;
	while (m) {
	printf("%s%s",m&x ? "1" : "0" ,++s%8 ? "" : "");
	m >>= 1;
	}
}


int main(){

	int i = 0;
	int niz[5]={235354,634674,85569,23464,52454};
	int n=5;
	int r;


	for (i = 0; i < n; i++)
	{
		printf("%d", niz[i]);
		printf("\n");
	}
	printf("\nPrvobitni brojevi predstvljeni binarno\n");
	for (i = 0; i < n; i++)
	{
		printbin(niz[i]);
		printf("\n");
	}


	r = alg(niz, n);

		printf("\nIzmenjeni brojevi predstavljeni binarno\n");
	for (i = 0; i < n; i++)
	{
		printbin(niz[i]);
		printf("\n");
	}



return 0;
}

