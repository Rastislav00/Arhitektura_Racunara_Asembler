#include <stdio.h>

int podstring(char** strs, char *s, int *niz, int n);


#define NUM 3     //ovo treba prilagoditi broju el nizova

int main(){

	int x,i;	//i je brojac
	int n=NUM;
	char *reci[NUM]={"abcd", "baba i deda", "abudabi"};
	char s[]="ab";	//trazeni podstring 
	int puta[NUM];	//niz od 4 elemenata

	x = podstring(reci, s, puta, n);

	printf("Podstring %s je pronadjen ukupno %d puta i to:\n", s, x);
	for(i=0;i<n; i++){
		printf("U stringu '%s', %d puta\n", reci[i], puta[i]);
	}




	return 0;
}
















