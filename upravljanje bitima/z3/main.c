/*
Potprogram koji kao argumente prima pokazivac na niz
elemenata tipa short int i broj elemenata tog niza, zatim
proverava za svaki clan niza da li u njegovom binarnom
zapisu ima vise nula ili jedinica. Ako ima vise nula, treba
invertovati sve bitove, ako ima vise jedinica, treba
invertovati samo prvi bit. Kao povratnu vrednost program
treba da prosledi broj elemenata niza kojima je u
binarnom zapisu broj jedinica jednak broju nula
(neizmenjeni clanovi niza)
*/

#include <stdio.h>


int alg(int *niz, int br);



int main(){

int f;
int n=5;
int niz[5]={65535,2863311530,965,23,335};





f = alg(niz, n);
printf("Broj neizmenjenih clanova je =%d\n", f);



	return 0;
}