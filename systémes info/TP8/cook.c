#include <sys/mman.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/stat.h>
#include <errno.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <semaphore.h>
#include "shm.h"


void main()
{
  // Initalisation

  printf("\n");
  int fd, i;
  memoirePartager *shm;
  //Créer une mémoire  partagée en lecture / écriture
  if( (fd = shm_open(FILE, O_RDWR | O_CREAT | O_EXCL, S_IRUSR | S_IWUSR)) == -1)
      perror("shm_open");

  //Taille de la mémoire = indicator + number
  if( ftruncate(fd, sizeof(memoirePartager)) == -1)
      perror("ftruncate");

  //File mapping (Les parametres doivent correspondres au mode d'ouverture de l'objet POSIX)
  shm =  mmap(NULL, sizeof(memoirePartager), PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);

  if(shm == MAP_FAILED)
      perror("mmap");

  // Initalistion des variables partagées

  shm->pizzaMade=0;
  shm->pizzaOnShelf=0;
  shm->totalPizzaMade=0;
  shm->totalPizzaServed=0;
  //on va chercher notre PID pour le partager avec le serveur
  shm->pidCOOK = getpid();

  //On attend l'autre processus pour travailler
  shm->isReady = !READY;
  while(!(shm->isReady == READY));

  printf(" \n");
  sem_init(&pizzaOnShelf,0,1); // Sémaphore qui va protéger le nombre de pizza prête
  sem_init(&pizzaMade,0,1); // Sémaphore qui va protéger le nombre de pizzas restante

  //Ok on travail
  while(shm->pizzaMade < NOMBRE_DE_PIZZA_A_PREPARER) // Tant qu'on atteint pas le nombre de pizza max à préparées
  {
      //cas ou on ne peut pas se reposer car < 3 pizza sur l'étagère
      if(shm->pizzaOnShelf <3){
        sem_wait(&pizzaOnShelf); // ON arrive dans une section critique pour les pizzas prêtes: On protège

	printf("\npress ENTER to cook a pizza\n");
	getchar();
	/*	
	le cuisinier peut prendre jusqu'à 7 seconde pour faire une pizza
	usleep(rand()%TIME_TO_COOK_A_PIZZA);
	*/
	//si on prépare 1 pizza, on ajoute 1 pizza sur l'étagère
        shm->pizzaOnShelf ++;
	//on unlock le sémaphore
        sem_post(&pizzaOnShelf);
	//on lock le sémaphore
        sem_wait(&pizzaMade);
        printf("Le cuisinier a fait 1 pizza, il y a %d pizza sur l'étagère\n", shm->pizzaOnShelf);
	//si on prépare 1 pizza, on ajoute 1 pizza au pizzaMade
        shm->pizzaMade ++;
	//on unlock les pizzaMade
        sem_post(&pizzaMade);
	//si on prépare 1 pizza, on ajoute 1 pizza au total de pizzaMade
        shm->totalPizzaMade ++;
	printf("Le cuisinier a fait au total %d pizza\n",shm->totalPizzaMade);
	char commandePizzaOnShelf[60];
	char commandePressENTER[60];
	char justEnter[20];
	//on formatte d'abord notre commande pour pouvoir l'utiliser avec popen
	sprintf(justEnter, "echo > /proc/%d/fd/0", shm->pidSERVEUR);
	//on utilise popen pour envoyer notre commande au terminal avec nom tty qui a lancé le processus du serveur (donc terminal qui gere le PID du serveur)
	shm->Enter = popen(justEnter,"r");
	pclose(shm->Enter);
	//permet d'afficher le nombre de pizza sur l'étagère sur le terminal du serveur
	sprintf(commandePizzaOnShelf, "echo il y a %d pizza sur etagere > /proc/%d/fd/0", shm->pizzaOnShelf,shm->pidSERVEUR);
	shm->affichePizzaOnShelfSERVEUR = popen(commandePizzaOnShelf,"r");
	pclose(shm->affichePizzaOnShelfSERVEUR);
	//condition if pour des questions de meilleur affichage
	if (shm->pizzaOnShelf >0){
	sprintf(commandePressENTER, "echo press ENTER to serve a pizza > /proc/%d/fd/0",shm->pidSERVEUR);
	shm->pressENTER = popen(commandePressENTER,"r");
	pclose(shm->pressENTER);
	}
        usleep(rand()%SLEEP_TIME);
      }
      else
      {
        usleep(rand()%SLEEP_TIME); // On se repose
      }
  }
  // destruction des sémaphore
  sem_destroy(&pizzaOnShelf);sem_destroy(&pizzaMade);
  printf("Nombre total de pizza préparées: %d\n", shm->totalPizzaMade);

  //Unmap
  if(munmap(shm, sizeof(memoirePartager)) == -1)
      perror("munmap");

  //Detacher l'objet POSIX

  shm_unlink(FILE);
}
