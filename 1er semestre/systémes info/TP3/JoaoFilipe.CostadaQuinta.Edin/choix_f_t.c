#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>

//fonction qui verifie les input
void choixFT(int argc, char* argv[], int *pointeurSurF, int *pointeurSurT) {
	int choix;

	//boucle while qui parcourt les argumentsV 
	while ((choix = getopt( argc, argv, "ft:")) != -1 ){
		if (choix == 'f')
		{
			//s il existe une valeur f, alors varF devient 1
			*pointeurSurF = 1;
		}
		else if (choix == 't')
		{
			//s il existe une valeur t, alors varT devient 1
			*pointeurSurT = 1;
		}
		else
		{
			//cas pour mauvais input
			exit(EXIT_FAILURE);
		}
	}
}
