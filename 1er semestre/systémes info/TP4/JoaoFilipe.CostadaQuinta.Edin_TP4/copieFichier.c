#include <string.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/dir.h>
#include <fcntl.h>
#include <time.h>
#include "testifFileExist.h"

void copieVersDestination(char* fichier_source, char* fichier_destination,int permission_rwx )
{
  //on utilise la fonction si dessous pour verifier si le fichier existe ou pas (deja)
if (testifFileExist(fichier_source, fichier_destination) == 0)
{
	printf("copie....\n");
	char source[50], destination[50];
	char ligne_memoire[200];
	//on cree le nouveau nom du dossier
	strcpy(source, "/");
	strcpy(destination, fichier_destination);
	strcat(destination, source);
	strcpy(source, fichier_source);
	strcat(destination, source);

	FILE* old_fichier = fopen(fichier_source, "r"); // on ouvre le fichier qu'on veut lire
	FILE* new_fichier = fopen(destination, "w"); // et on cree le nouveau fichier sur lequel on va copier old fichier
	while (fgets(ligne_memoire, 300, old_fichier) != NULL)//on prend 300 lettres/chars de old_fichiers, et on met dans new_fichier
		//tant que les 300 chars sont pas nuls, on le fait
	{
		fputs(ligne_memoire, new_fichier);
	}
	fclose(new_fichier);
	fclose(old_fichier);//on ferme les deux
	chmod(fichier_destination, permission_rwx);//on donne les droits
}
else if (testifFileExist(fichier_source, fichier_destination) == 1)
{

	printf("asd\n");

}
else
{
    printf("Error: Cannot existing file\n");
}

}
