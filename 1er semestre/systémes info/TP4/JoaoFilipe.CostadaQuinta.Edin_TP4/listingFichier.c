#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <time.h>

void listerFILE(char *fichierAlister){
  struct stat myStat;
  if (stat(fichierAlister, &myStat) == -1) {
      perror("stat");
      exit(EXIT_SUCCESS);
  }
//on détermine le type du file, dossier? true affiche "d" false affiche "-"
  printf( (S_ISDIR(myStat.st_mode)) ? "d" : "-");
//on teste les droits pour différents flags d'abord pour l'owner
//test read
  printf( (myStat.st_mode & S_IRUSR) ? "r" : "-");
//test write
  printf( (myStat.st_mode & S_IWUSR) ? "w" : "-");
//test execute
  printf( (myStat.st_mode & S_IXUSR) ? "x" : "-");
//les droits pour les groupes
//test read
  printf( (myStat.st_mode & S_IRGRP) ? "r" : "-");
//test write
  printf( (myStat.st_mode & S_IWGRP) ? "w" : "-");
//test execute
  printf( (myStat.st_mode & S_IXGRP) ? "x" : "-");
//les droites pour les "autres"
//test read
  printf( (myStat.st_mode & S_IROTH) ? "r" : "-");
//test write
  printf( (myStat.st_mode & S_IWOTH) ? "w" : "-");
//test execute
  printf( (myStat.st_mode & S_IXOTH) ? "x" : "-");
  printf(" ");
//on affiche la taille du fichier grâce à st_size
  printf("%lld  ", (long long) myStat.st_size);
//on considère que les bits qui détermine le type du file
  if (myStat.st_mode & S_IFMT) {
//cas si c'est un dossier
  if (S_IFDIR){
        printf("d ");
  }
//cas si c'est un lien
  else if (S_IFLNK){
        printf("l");
  }
//cas si c'est un fichier
  else if (S_IFREG){
        printf("-");
  }
//cas autre
  else{
  printf("Ce n'est ni un lien ni un fichier ni un repertoire");
  }
  }
     printf(" %s",fichierAlister);
//affiche le temps de la dernière modification
     printf(" Dernière modification: %s", ctime(&myStat.st_mtime));

}
