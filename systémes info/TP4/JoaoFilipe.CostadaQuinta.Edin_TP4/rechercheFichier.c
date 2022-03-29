#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <sys/dir.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <limits.h>
#include <errno.h>
#include "copieFichier.h"

void rechercheFichierAcopier(char* folder_debut,char* destination_file)
{
  //on cree le dossier
  struct stat perm;
  if (stat(folder_debut, &perm) == -1) {
      perror("stat");
      exit(EXIT_SUCCESS);
  }
  //comme pour copieVersDestination
  char source[100], destination[100];
  strcpy(source, "/");
  strcpy(destination,destination_file);
  strcat(destination, source);
  strcpy(source,folder_debut);
  strcat(destination, source);
  mkdir(destination,perm.st_mode);
 /////////////////////////////////////////////////////////////////// _CODE_DU_COURS_  /////////////////////////////////////////////////////////
  DIR *d = opendir(folder_debut);
  struct dirent *entry;
  const char *d_name;   //nom d'une entrée
  //En cas d'erreur d'ouverture
  if (! d)
  {
      fprintf(stderr, "Cannot open directory '%s': %s\n",folder_debut, strerror(errno));
  }
  //Boucle sur chaque entrée
  while( (entry = readdir(d)) != NULL )
 {
        // Obtient le nom de l'entrée et affiche
        d_name = entry->d_name;
        //Est-ce que 'entry' est un sous-répertoire
        if (entry->d_type & DT_DIR)
         {
        //Est-ce que 'entry' n'est pas '..' ou '.'
              if (strcmp(d_name, "..") != 0 && strcmp(d_name, ".") != 0)
              {
                   char path[PATH_MAX];

                    //forme le nom du sous-répertoire et affiche
                     int path_length = snprintf (path, PATH_MAX,"%s/%s", folder_debut , d_name);
                     printf("%s\n", path);

                   //Vérifie que le nom du sous-répertoire n'est pas trop long
                    if (path_length >= PATH_MAX)
                    {
                           fprintf(stderr, "Path length has got too long.\n");
                           exit(EXIT_FAILURE);
                    }

                   //Appel récursif
                   rechercheFichierAcopier(path,destination_file);
                }
          }
          if (entry->d_type & DT_REG)
          {
          // si c'est un fichier, on le copie
          char path[PATH_MAX];
          int path_length = snprintf (path, PATH_MAX,"%s/%s", folder_debut, d_name);
          int permission_rwx=perm.st_mode;
          copieVersDestination(path,destination_file,permission_rwx);
          }
}

  if( closedir(d) ) {
    fprintf(stderr, "Could not close '%s': %s\n",
    folder_debut, strerror (errno));
    exit (EXIT_FAILURE);
    }
}

