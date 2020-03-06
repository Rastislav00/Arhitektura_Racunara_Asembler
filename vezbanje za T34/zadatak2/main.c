/*
Void izmeniBit(int* broj, int vrednost, int pozicija)
Za prosledjeni broj(32-bitni), postaviti na n-tu poziciju,
vrednost bita.
Zatim prebrojati koliko broj ima jedinica. Ukoliko ima neparan
broj jedinica izmeniti najnizi bit tako da nakon te promene broj
ima paran broj jedinica.
Sacuvati novodobijeni broj na adresu koja je prosledjena preko
parametra funkcije broj.
Najnizi bit ima poziciju 0.
primer:
broj=10010101101
vrednost=0
pozicija=5
posle izmene--> 10010001101 ->imamo 5 jedinica
-->najnizi bit posto je 1, menjamo nulu
Resenje: 10010001100
*/

#include <stdio.h>


	void izmeniBit(int* broj, int vrednost, int pozicija, int *x);



	void printbin(unsigned int x){
	unsigned int m=0x80000000, s=0;
	while (m) {
	printf("%s%s",m&x ? "1" : "0" ,++s%8 ? "" : "");
	m >>= 1;
	}
}



int main(){

	int v=1;	//vrednost 0 ili 1
	int p=5;	//pozicija od 1 do 32
	int broj=2593;	
	int x;		//broj nakon svih algoritma

	printf("\nBroj pre izmene: %d\n", broj);
	printf("Binarni zapis br pre izmene: ");
	printbin(broj);
	printf("\n\n");

	izmeniBit(&broj, v, p, &x);

	printf("Na %d mesto stavi vrednost %d\n", p, v);
	printf("Novodobijeni broj: %d\n", broj);
	printf("Binarni zapis je: ");
	printbin(broj);
	printf("\n\n");

	printf("Preradnjen broj je: %d\n", x);
	printf("Binaran zapis preradjeng broja je: ");
	printbin(x);
	printf("\n\n");




return 0;
}








