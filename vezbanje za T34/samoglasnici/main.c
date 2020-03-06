/*
filip zjalic
Ucitati string, u stringu prebrojati koliko reci ima paran broj
samoglasnika. Taj broj je povratna vrednost programa.
Separatorom se smatra razmak, zarez i tacka.
Int brojParnihSamoglasnika(char* str)
*/

#include <stdio.h>

int brojParnihSamoglasnika(char* str);

int main(){
        char str[100+1];
        printf("Unesite tekst: ");
        fgets(str, 100+1, stdin);
        
        int n=brojParnihSamoglasnika(str);
        printf("Ukupno ima %d reci koje imaju paran broj samoglasnika!\n", n);
        

        return 0;
}

