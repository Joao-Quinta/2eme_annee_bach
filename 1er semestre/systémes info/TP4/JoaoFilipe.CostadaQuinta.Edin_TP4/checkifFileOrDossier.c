#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include "listingFichier.h"
#include "listedossier.h"
#include <sys/types.h>
#include <sys/stat.h>
#include "copieFichier.h"
#include "rechercheFichier.h"

void checkifFileOrDossier(char *fichierDeDepart,char* fichierDarriver){
  struct stat myStat;
  if (stat(fichierDeDepart, &myStat) == -1) {
      perror("stat");
      exit(EXIT_SUCCESS);
  }
//on considère que les bits qui détermine le type du file
  if (myStat.st_mode & S_IFMT){
//si c'est un dossier, on va appeller la fonction pour copier le dossier et son contenu dans le répertoire destination
  if (S_IFDIR) {
        rechercheFichierAcopier(fichierDeDepart,fichierDarriver);
  }
//Si c'est un fichier on va juste le copier
  else if (S_IFREG){
        copieVersDestination(fichierDeDepart,fichierDarriver,myStat.st_mode);
  }
//cas autres
  else {
  printf("Ce n'est ni un fichier ni un dossier");
  }
  }
}

