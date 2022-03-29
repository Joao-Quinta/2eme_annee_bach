#include <arpa/inet.h>
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <memory.h>
#include <unistd.h>

//fonction qui va envoyer l'intégralité du fichier par mail
void sendFichier(int sock,char *argv[]){
  FILE *fichier=NULL;
  //on teste si le fichier est ouvrable ou non
  fichier = fopen(argv[1],"r"); 
  //cas impossible de l'ouvrir
  if (fichier==NULL){
      printf("Impossible d'ouvrir le fichier\n");
  }
  //On initialise la ligne que l'on va lire
  char ligneLue[300];
  while (fgets(ligneLue,300,fichier) != NULL){
    char buf_prov[320];
    //Concaténation de la ligne
    strcpy(buf_prov,ligneLue);
    strcat(buf_prov,"\r\n");
    //Envoie de la ligne
    send(sock,buf_prov,strlen(buf_prov),0);
  }
  fclose(fichier);
}
