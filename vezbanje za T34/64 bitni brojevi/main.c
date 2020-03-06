/*
Napisati potprogram koji vraća rezultat računske operacije između dve 64-bitne označene
promenljive A i B, u zavisnosti od parametra operacija . Ukoliko operacija ima vrednost:
‘+’, vratiti zbir A+B,
‘-’, vratiti razliku A-B,
‘*’, vratiti proizvod A*B
U slučaju da operacija ima neku drugu vrednost, promenljivu greška postaviti na 1.
U slučaju da dođe do prekoračenja opsega, promenljivu greška postaviti na -1.
U svim ostalim slučajevima, promenljivu greška postaviti na 0.
Deklaracija potprograma je data sa:
long long Racunaj(long long *A, long long *B, char *operacija, int
*greska);
gde su A, B, operacija i greška pokazivači na odgovarajuće parametre. Za testiranje je dat glavni
program zad1.c.
*/

#include <stdio.h>


	long long racunaj(long long *A, long long *B, char *operacija, int *greska);


int main(){

	int greska=5;
    long long rac=0;
    long long A=123456789000LL;
    long long B=10000LL;
    char op='+';

    rac=racunaj(&A, &B, &op, &greska);

    printf("%lld %c %lld = %lld    greska=%d\n", A, op, B, rac, greska);

return 0;
}



