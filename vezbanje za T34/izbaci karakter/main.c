/*
Napisati potprogram koji proverava da li u prosleđenom 
ASCII stringu postoje neki od znakova
!, #, $, %, &, /, *. Ukoliko postoje izbaciti ih iz stringa 
i kao povratnu vrednost vratiti broj izbacenih karaktera . U
suprotnom vratiti 0. Deklaracija potprograma je data sa:
int Izbaci(char *str);
gde je str pokazivač na string kojeg treba proveriti. 
Za testiranje je dat glavni program zad3.c.
*/

#include <stdio.h>

	int izbaci(char *str);

int main(){

	int br;
	char rec[]="pozdrav $ sta ima * ka!ko si /";

	printf("\nString pre izbacivanja\n");
	puts(rec);

	br = izbaci(rec);

	printf("\n\nString posle izbacivanja\n");
	puts(rec);
	printf("\n\nBroj izbacenih karaktera je: %d\n", br);







	return 0;

}