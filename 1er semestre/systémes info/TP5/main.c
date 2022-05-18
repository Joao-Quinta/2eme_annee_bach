#include <stdio.h>
#include <stdlib.h>
#include <sys/file.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include "LOCK.h"
#include "getPID.h"
//\


//fonction principale qui débute le lock en appelant lock_func, main retourne également le nombre de fois qu'on a testé le programme
int main(int argc, char* argv[]){
	int fin;
	int compteur=0;
	//boucle permettant de tester le programme plusieurs fois
	while (fin != 1997){
	int c;
	if (compteur==0){
	printf("press ENTER to start");
}
	//on vide le buffer à chaque fois que l'utilisateur veut réutiliser le programme pour éviter les erreurs dans les scanf()
	while ((c = getchar ()) != '\n' && c != EOF);
	//appelle lock_func avec notre fichier argv[1]
	fin = lock_func(argv[1],F_SETLK,fin);
	compteur=compteur+1;
	//printf("%d \n",fin);	
}
	printf("vous avez testez le programme: %d fois",compteur);
printf("\n");
	return 0;
}
