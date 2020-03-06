#include <stdio.h>

  int fakt(int n);

int main(){
	
	int a;
	int n=2;	

	do {
	printf("Unesite broj: ");
	scanf("%d", &n);
	} while (n<0);
	
	a=fakt(n);

	printf("Fak(%d)=%d\n", n, a);	


}
