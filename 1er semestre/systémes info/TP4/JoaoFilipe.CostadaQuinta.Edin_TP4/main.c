#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include "listingFichier.h"
#include "listedossier.h"
#include <sys/types.h>
#include <sys/stat.h>
#include "copieFichier.h"
#include "rechercheFichier.h"
#include "checkifFileOrDossier.h"


//fonction qui va vérifier dans quel cas on se trouve pour initer le programme
int main(int argc, char *argv[]){
  int i;
//Soit 2 arguments, on est dans le cas ou on veut simplement lister les attributs du fichier
  if (argc < 3){
    listerDIR(argv[1]);
  }
//Soit > 2 arguments, on veut faire un backup
  else
  {
    int DIRacces;
    DIRacces = access(argv[argc-1],0);
    if (DIRacces == -1)
    {
      mkdir(argv[argc-1], ACCESSPERMS);
    }
// on va vérfier tous les arguments sauf le dernier qui est la destination afin de déterminer leur type
    for (i=1; i< (argc-1); i++){
      checkifFileOrDossier(argv[i],argv[argc-1]);
    }
  }

}
