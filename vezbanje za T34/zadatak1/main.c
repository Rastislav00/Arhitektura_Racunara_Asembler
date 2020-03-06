/*
treba prebrojati jedinice u 64 bitnom broju
broj jedinica vratiti kao povratnu vrednost
i napraviti logicku operaciju ili (or) sa tim brojem jedinica
i delovima 64 bitnog broja i to po 16 bita
0-15
16-31
32-47
48-63
*/


#include <stdio.h>

	int broj(long long *A, long long *z);





	void printbin(unsigned long long x){
	unsigned long long m=0x8000000000000000, s=0;
	while (m) {
	printf("%s%s",m&x ? "1" : "0" ,++s%16 ? "" : "");
	m >>= 1;
	}
}




int main(){

	long long a=123456789123456789;
	long long z; 		
	int x;

	x=broj(&a, &z);

	printf("Uneti broj %lld sadrzi %d jedinica u sebi\n", a, x);
	printf("Radi provere binarni zapis je: ");
	printbin(a);
	printf("\n");
	printf("Zbir (or) nad 16bitnim registrima 64bitnog broja je: %lld\n", z);






return 0;
}