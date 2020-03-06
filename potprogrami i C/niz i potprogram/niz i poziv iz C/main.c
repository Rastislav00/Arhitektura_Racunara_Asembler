#include <stdio.h>
#include <stdlib.h>

int alg(int *niz);



int main(){

int i;
int z;	//zbir
int niz[5];

printf("Unesite elemente niza: \n");

for (i=0; i<5; i++){
	scanf("%d", &niz[i]);
}



z = alg(niz);
printf("zbir je =%d\n",z);


	return 0;
}