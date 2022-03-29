#include <string.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/dir.h>
#include <fcntl.h>
#include <time.h>
#include "copieFichier.h"

//fonction qui vérifie si le fichier qu'on copie existe deja ou pas
//en retournant 0, on dit qu'on copie/remplace le fichier en question
//return 1 veut dire que le fichier existe, sa taille et date de modification est la meme

int testifFileExist(char* fichier_verifier, char* fichier_source)
{
  FILE* fichier = fopen(fichier_verifier,"r");
  if (fichier == NULL)
  {
	// si le fichier existe pas on retourne tout simplement 0, on pourra tout simplement le copier
    return 0; 
  }
  else
  {
	//s'il existe, on compare le fichier qui existe deja, et celui qu on veut copier, si taille differente, ou date de modification differente, on remplace
    struct stat file_verifier;
    struct stat file_source;
    if (stat(fichier_verifier, &file_verifier) == -1) 
	{
        perror("stat");
        exit(EXIT_SUCCESS);
    }
    if (stat(fichier_source, &file_source) == -1) 
	{
        perror("stat");
        exit(EXIT_SUCCESS);
    }
    if (file_verifier.st_size != file_source.st_size)
	//size des 2 est le meme, donc on return 0 pour remplacer le "vieux" avc le "nouveau"
    {
      return 0;
    }
    if(ctime(&file_verifier.st_mtime) != ctime(&file_source.st_mtime))
	//si la date de modification est differente, on return 0 pour remplacer le "vieux" avc le "nouveau"
    {
      return 0;
    }
  }
  return 1;
}
