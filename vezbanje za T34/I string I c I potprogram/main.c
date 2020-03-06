#include <stdio.h>
#include <stdlib.h>
#include <string.h>

	int alg(char *str);



int main(){

	int br;

	char rec[51];
	printf("Unesi string: \n");
	fgets(rec, 101, stdin);

	br = alg(rec);
	printf("Ukupno ima %d reci koje pocinju i zavrsvaju na isto slovo\n", br);



return 0;
}