#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <errno.h>
#include <signal.h>
#include <stdbool.h>
#include <fcntl.h>
#include "bkJob.h"
#include "fdJob.h"
#include <setjmp.h>
#include <sys/ptrace.h>


#define ANSI_COLOR_GREEN   "\x1b[32m"
#define ANSI_COLOR_RED     "\x1b[31m"
#define ANSI_COLOR_RESET   "\x1b[0m"

//simple fonction qui print le path actuel dans le shell
void affiche(char*chemin)
{
  printf(ANSI_COLOR_GREEN">: %s $: " ANSI_COLOR_RESET,chemin);
}

//fonction qui handle les singnaux
void handlerSignal(int signo){
	if ((signo == SIGTERM) || (signo == SIGQUIT) || (signo == SIGINT)){	
	signal(signo,SIG_IGN);
	if (signo == SIGINT){
	printf("\r\n");
 	char current_path[300];
 	getcwd(current_path,300);
	affiche(current_path);
}
	}
	if (signo == SIGHUP) {
		pid_t currentPID = getpid();
		pid_t groupPID = getpgid(currentPID);
		signal(SIGHUP, SIG_DFL);
		//pid_t parentPID = getppid();
		killpg(groupPID, SIGHUP);
	}
}



int main()
{
	printf("\n");
	printf(ANSI_COLOR_RED   "*****************************************************************"   ANSI_COLOR_RESET "\n");
	printf(ANSI_COLOR_RED   "**************************PETITE SHELL***************************"   ANSI_COLOR_RESET "\n");
	printf(ANSI_COLOR_RED   "**************************EDIN ET JOAO***************************"   ANSI_COLOR_RESET "\n");
	printf(ANSI_COLOR_RED   "*****************************************************************"   ANSI_COLOR_RESET "\n");
	printf("\n");


	//appel print path
  char current_path[300];
  getcwd(current_path,300);
  affiche(current_path);



	pid_t pidSHELL = getpid();

  while(1)
  {
    struct sigaction s, sa, old_SIGTERM,old_SIGQUIT,new_SIGINT,old_SIGINT;
    sa.sa_handler = &handlerSignal;
    sigaction(SIGTERM,&sa,&old_SIGTERM);
    sigaction(SIGQUIT,&sa,&old_SIGQUIT);
    sigaction(SIGINT,&sa,&old_SIGINT);

    sigaction(SIGHUP,&sa,NULL);

    

    char vide [500];
    char entree[500];
//cas où ce f.. de CTRL+C et utilisé par l'utilisateur donc l'input sera NULL
    if (fgets(entree,500, stdin)==NULL){
	//alors on vide l'entree en copiant un tableau vide dedans
	strcpy(entree,vide);
	//on évite de faire un job avec CTRL+C
	continue;
}



    //############################################################## PARTIE ANALYSE DE L ENTREE 3.1 ##############################################################\\


	
    char *cond=" \t";
    // On ajoute l'espace et la tablusation comme délimiteur
    int argc=0;
    //char *argv[20];

     // On crée un tableau où il y aura nos arguments
    char *p;
    p = strtok(entree,cond);
char **argv = malloc(sizeof(p));
    while (p != NULL)
     {
      argv[argc] = p;
      p = strtok(NULL,cond);
      argc++;
    }
	argv[argc-1][strlen(argv[argc-1])-1]='\0';
	//Il faut remplacer le dernier caractère du dernier argument de la liste par \0




	//############################################################## PARTIE ANALYSE DE L ENTREE 3.2 ##############################################################\\

    // Commaned exit


//si l'utilisateur appuie enter sans argument alors on retourne true et rien ne se passe
if (strcmp(argv[0],"")==0){
	true;
}

//si l'utilisateur écrit exit, le programme avec pid principal se termine (si on a un shell dans notre shell c'est le shell en foreground qui se terminera)
    else if(strcmp(argv[0],"exit")==0)
    {
	//exit(EXIT_SUCCESS);
	signal(SIGINT,SIG_DFL);
        kill(pidSHELL,SIGINT); // Kill all process
	//kill(pidSHELL,SIGINT);
	//return 0;
    }

    // Commande  cd
    else if(strcmp(argv[0],"cd")==0)
    {
	 if (argv[1] == NULL) {
    fprintf(stderr, "shell: expected argument to \"cd\"\n");
}
      else if (chdir(argv[1]) != 0) // changement de dossier
      {
        printf("%s\n", strerror(errno));
      }
      getcwd(current_path,300);
    }



//############################################################## PARTIE ANALYSE DE L ENTREE 3.3 ##############################################################\\


    /// on detect si c est background ou foreground

    // Commande en arrière plan (voir bkJob.c)

//cas job en background demandé par l'utilisateur grâce à '&'
    else if(strcmp(argv[argc-1],"&")==0)
    {
	//on ignore le signal CTRL+C car ce signal ne doit pas terminer un programme en background
	signal(SIGINT,SIG_IGN);
      //notre fonction qui va executer la tâche en background
      bkJob(argc,argv);
    }

    // 3.3 Commande au premier plan (voir fdJob.c )

    //cas ou c'est une tâche en foreground demander par l'utilisateur
    else if (strcmp(argv[argc-1],"&")!=0)
    {
      //on veut pouvoir interrompre la tâche donc remet SIGINT à sa valeur de base 
      signal(SIGINT,SIG_DFL);
      //fonction qui va executer la tâche en foreground
      fdJob(argc,argv);
    }
else {
    //on affiche le chemin quand on appuie sur CTRL+C
    getcwd(current_path,300);
    affiche(current_path);
}
    //on affiche le chemin apres avoir exécuter n'importe qu'elle tâche
    getcwd(current_path,300);
    affiche(current_path);
	free(argv);
  }
  return 0;
}
