/*
Napisati potprogram koji ispituje neoznačene 16-bitne vrednosti u nizu A. Ukoliko član niza
ima paran broj binarnih jedinica, zameniti sadržaje njegova prva 3 i poslednja 3 bita. U suprotnom
zameniti sadržaje njegovog prvog i poslednjeg bita. Povratna vrednost potprograma je broj
elemenata niza koji imaju paran broj binarnih jedinica. Deklaracija potprograma je data sa:
int RazmeniBit(unsigned short *A, unsigned N);
gde je A pokazivač na niz 16-bitnih vrednosti, a N broj elemenata niza. Za testiranje je dat glavni
program zad4.c.
*/

#include <stdio.h>


	int RazmeniBit(unsigned short *A, unsigned N);


int main(){

int br;   //broj clanova niza koji imaju paran broj jedinica

	int i;
    int n=5;
    unsigned short niz[5]={20, 7, 5, 65532, 17};

	printf("Niz pre poziva RazmeniBit():\n");
	for(i=0;i<n;i++){
		printf(" %04x \n", niz[i]);

	}

    br=RazmeniBit(niz, n);


	printf("Niz posle poziva Razmeni Bit():\n");
	for(i=0;i<n;i++){
		printf(" %04x \n", niz[i]);

	}
	printf("Broj el. sa parnim br. jedinica = %d\n\n", br);






	return 0;
}




