#include <sys/mman.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdlib.h>
#include <errno.h>
#include <unistd.h>
#include <stdio.h>
#include <semaphore.h>
#include "shm.h"

void main ()
{
  int fd, i;
  memoirePartager *shm;


    //Ouvrir une mémoire  partagée en lecture / écriture
    if( (fd = shm_open(FILE, O_RDWR, S_IRUSR | S_IWUSR)) == -1)
        perror("shm_open");

    //File mapping (Les parametres doivent correspondres au mode d'ouverture de l'objet POSIX)
    shm = mmap(NULL, sizeof(memoirePartager), PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
    if(shm == MAP_FAILED)
        perror("mmap");

    //On signal que l'on est prêt

    shm->isReady = READY;

    //on va chercher notre PID pour le partager avec le cuisinier
    shm->pidSERVEUR = getpid();

    //Ok on travail
    while(shm->totalPizzaServed < NOMBRE_DE_PIZZA_A_PREPARER) //Tant qu'on atteint pas le nombre de pizza max préparés par le cuisinier
    {
      //cas ou il y a des pizza sur l'étagere
      if (shm->pizzaOnShelf >0){
	printf("\npress ENTER to serve a pizza\n");
	getchar();
	//si on sert 1 pizza, on l'enlève de l'étagère
        shm->pizzaOnShelf --;
	//si on sert 1 pizza, on ajoute 1 pizza dans le nombre total de pizza servis
        shm->totalPizzaServed +=1;
        printf("Le serveur a prit 1 pizza, il y a %d pizza sur l'étagère\n",shm->pizzaOnShelf );
	printf("Le serveur a prit au total %d pizza\n",shm->totalPizzaServed);
	//condition if pour ne pas afficher le nombre de pizza sur l'étagère dans le terminal de cook lorsque celui-ci à terminé de travailler, on évite l'erreur qui nous dit que le processus n'existe plus 
	if (shm->totalPizzaMade != NOMBRE_DE_PIZZA_A_PREPARER){
	char commandePizzaOnShelf[60];
	char commandePressENTER[60];
	char justEnter[20];
	//on formatte d'abord notre commande pour pouvoir l'utiliser avec popen
	sprintf(justEnter, "echo > /proc/%d/fd/0", shm->pidCOOK);
	//on utilise popen pour envoyer notre commande au terminal avec nom tty qui a lancé le processus du cuisinier (donc terminal qui gere le PID du serveur)
	shm->Enter = popen(justEnter,"r");
	pclose(shm->Enter);
	sprintf(commandePizzaOnShelf, "echo il y a %d pizza sur etagere > /proc/%d/fd/0", shm->pizzaOnShelf,shm->pidCOOK);
	shm->affichePizzaOnShelfCOOK = popen(commandePizzaOnShelf,"r");
	pclose(shm->affichePizzaOnShelfCOOK);
	//condition if pour des questions de meilleur affichage
	if (shm->pizzaOnShelf <3){
	sprintf(commandePressENTER, "echo press ENTER to cook a pizza > /proc/%d/fd/0",shm->pidCOOK);
	shm->pressENTER = popen(commandePressENTER,"r");
	pclose(shm->pressENTER);
        }
	}
	//on attends
	usleep(rand()%SLEEP_TIME);
      }
      else
      {
	//on attends
        usleep(rand()%SLEEP_TIME);
      }
    }
    //nombre de pizza total servis
    printf("Nombre total de pizza servis: %d\n", shm->totalPizzaServed);

    //Unmap
    if(munmap(shm, sizeof(memoirePartager)) == -1)
        perror("munmclap");

    //Detacher l'objet POSIX
    shm_unlink(FILE);

}
