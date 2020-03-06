/*
VAZNO OBAVESTENJE NA KOLOKVIJUMU JE BIO ZADAT NIZ U 8BITA AL JA TO U C SAD NMG DA SE SETIM KAKO DA 
INICIJALIZUJEM 8BITNI NIZ PA SAM URADIO SA 16BITNIM NIZOM TO ZNACI DA CU PRI PRISTUPANJU ELEMENTIMA
MORATI DA POKAZIVAC POVECAVAM ZA 2
*/



/*
Dat je niz sa 8 elemenata neoznaceni brojevi
Niz je velicine bajt znaci 8bita

Treba prebrojati broj jedinica na glavnoj i sporednoj diagonali niza

Ako je broj jedinica paran kao povratnu vrednost funkcije vratiti 0
Ako je broj jedinica neparan vratiti kao povratnu vrednost funkcije 1

Broj jedinica upisati na prosledjen parametar
Funkcija je ovako otprilie izgledala

int alg(short short int *niz, int *parametar);

10000001
01000010
00100100
00011000
00011000
00100100
01000010
10000001
*/

#include <stdio.h>

	int alg(short int *niz, int *n);



	void printbin(unsigned short int x){
	unsigned short int m=0x80, s=0;
	while (m) {
	printf("%s%s",m&x ? "1" : "0" ,++s%8 ? "" : "");
	m >>= 1;
	}
}




int main(){

	short int niz[8]={234, 222, 128, 94, 122, 71, 45, 210};
	int n;		//broj jedinica na glavnooj diagonali
	int i;
	int x;

	printf("Pocetne vrednosti:\n");
	for (i = 0; i < 8; ++i)
	{
		printbin(niz[i]);
		printf("  ->  %d",niz[i]);
		printf("\n");
	}

	x = alg(niz, &n);

	printf("\nBroj jedinica na diagonalama je: %d\n",n);	
	//posto je ocigledno kad se bude video broj dal je paran ili ne 
	//necu da stampam i povratnu vrednost
	// ona ce biti u x posredstvom registra eax

return 0;
}