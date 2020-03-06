#include <stdio.h>
//program koji ce da prebroji sve bite sa vrednolstima 1 iz nekog broja 


	int alg(int v);



int main()
{
	
	int v;
	int b;			//broj jedinica u broju v

	printf("Unesi vrednost: ");
	scanf("%d", &v);

	b = alg(v);

	printf("Broj jedinica je: %d\n", b);



	return 0;
}