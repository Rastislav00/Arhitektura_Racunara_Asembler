#include <stdio.h>


   int fib(int n, int* rez);


int main(){

	int n, g;
	int f;
	printf("Unesite N: ");
	scanf("%d", &n);
	g = fib(n, &f);

	if (g){
		printf("greska!\n");
	}
	else {
		printf("fib(%d)=%d\n", n, f);
	}


}
































