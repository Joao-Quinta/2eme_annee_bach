#include <stdio.h>
#include <stdlib.h>
#include <sys/file.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include "getPID.h"



//fonction qui lock/unlock/GETLK une partie du fichier en fonction de l'input de l'utilisateur
int lock_func(char* fichieralock, int cmd,int fin){
	int file;
	//on créer notre structure lock
	struct flock lock;
	printf("*****chose your locking options*****\n");
	char cmd1;
	char l_type1;
	int start;
	int length;
	char choix;
	char l_whence;
	//#############################################################################################################  INPUT START
	//#############################
	printf("choisis une commande ’g’ pour (F_GETLK), ’s’ pour (F_SETLK), or ’w’ pour (F_SETLKW) \n");
//1er input CMD	
	scanf("%s",&cmd1);
	printf("choisis un type de lock ’r’ pour (F_RDLCK), ’w’ pour (F_WRLCK), or ’u’ pour (F_UNLCK) \n");
//2eme  L_TYPE	
	scanf("%s",&l_type1);
	printf("choisis le starting offset\n");
//3eme start offset	
	scanf("%d",&start);
	printf("choisit la longueur de bit que tu veux lock\n");
//4eme input longueur byte de lock	
	scanf("%d",&length);
	printf("voulez vous donner un parametre whence (y/n) ? (si non, seek_set sera le defaut) \n");
	scanf("%s", &choix);
//5eme inpute l_whence
	if (choix=='y')
	{
		printf("choisis un l_whence ’s’ pour (SEEK_SET, default), ’c’ pour (SEEK_CUR), or ’e’ pour (SEEK_END) \n");
		scanf("%s", &l_whence);
			//#######################################################					L_WHENCE
	printf("%d \n", l_whence);
	switch (l_whence) {
	case 's':
		printf("SEEK_SET\n\n");
		lock.l_whence = SEEK_SET;
		break;
	case 'c':
		printf("SEEK_CUR\n\n");
		lock.l_whence = SEEK_CUR;
		break;
	case 'e':
		printf("SEEK_END\n\n");
		lock.l_whence = SEEK_END;
		break;
	default:
		printf("erreur, mauvais input ");
		exit(1);
	}
	} else {
	l_whence = SEEK_SET;
	printf("\n *on utilisera SEEK_SET* \n");
}
	//#############################################################################################################  INPUT END
	//#############################################################################################################  START DEF STRUC LOCK
	//#######################################################					 PARAMETRE CMD
	switch (cmd1){
		case 'g' :
		cmd = F_GETLK;
		break;
		case 's' :
		cmd = F_SETLK;
		break;
		case 'w' :
		cmd = F_SETLKW;
		break;
	default :
	printf("\n****%s n'est pas une option****\n",&cmd1);
	exit(1);
	}	
	//#######################################################					L_TYPE
	switch (l_type1){
		case 'r' :
		lock.l_type = F_RDLCK;
		break;
		case 'w' :
		lock.l_type = F_WRLCK;
		break;
		case 'u' :
		lock.l_type = F_UNLCK;
		break;
	default :
	printf("\n****%s n'est pas une option****\n",&l_type1);
	exit(1);
	}



	//#######################################################					START OFF SET
	lock.l_start = start;
printf("\n");
	//#######################################################					LONGUEUR
	lock.l_len = length;
//#############################################################################################################  END DEF STRUC LOCK

	lock.l_pid = getpid();
	//vérifie que le fichier est ouvrable
	if ((file = open(fichieralock, O_RDWR))==-1){
	perror("file non ouvrable");
	exit(1);
}
	//cas ou on a une erreur, fichier déjà lock par un autre processus
	if (fcntl(file,cmd,&lock) == -1){
		if (errno == EACCES || errno == EAGAIN){
		perror("le fichier est déjà locké par qqun d'autre");
		pid_t pid = getPID();		
		printf("file locked by PID : %d \n",pid);
		exit(1);
	//cas d'erreur ou un signal interrompt le processus
}	else if (errno == EINTR){
		printf("a signal was recieved, the program is interrupted");
		exit(1);
	}

	//cas ou on veut lock le fichier avec F_SETLK ou F_SETLKW
}	else if ((cmd == F_SETLK || cmd == F_SETLKW) && lock.l_type!=F_UNLCK){
		printf("\n");
			printf("*****on lock*****");
		printf("\n");
		//on obtient le pid du processus qui lock le fichier
		lock.l_pid = getpid();
		//si on lock en tant que reader on l'indique
		if (lock.l_type == F_RDLCK){
			printf("file has been locked by PID: %d as a READER \n",lock.l_pid);
		}
		//si on lock en tant de writer on l'indique
		else if (lock.l_type == F_WRLCK){
			printf("file has been locked by PID: %d as a WRITER\n",lock.l_pid);
		}
			printf("****file is locked****");
}	

		//cas ou un 2eme processus veut obtenir des infos sur le fichier 
		else if (cmd == F_GETLK){
			//cas ou le fichier est déjà lock par un autre processus, on obtient les infos du processus qui lock cette partie du fichier
			if ((fcntl(file,F_SETLK,&lock) == -1) || lock.l_type==F_RDLCK){
			printf("\n****another processus already locked this file****\n");
			printf("voici les information sur ce processus : \n");
			pid_t pid2 = getPID();
			printf("the PID is : %d \n",pid2);
			
			char commandeForMODE[40];
			char commandeForSTART[40];
			char commandeForEND[40];
			char commandeForCOMMAND[40];
			char resultForMODE[40];
			char resultForSTART[10];
			char resultForEND[10];
			char resultForCOMMAND[40];
			//on formatte d'abord la commande ce qui nous permet de lui donné la variable pid2 dans la commande, on utilise lslocks pour obtenir les infos nécessaire
			sprintf(commandeForMODE, "lslocks -p %d -o MODE -n", pid2);
			sprintf(commandeForSTART, "lslocks -p %d -o START -n -r", pid2);
			sprintf(commandeForEND, "lslocks -p %d -o END -n -r", pid2);
			sprintf(commandeForCOMMAND, "lslocks -p %d -o COMMAND -n", pid2);
			//on utilise notre commande pour chercher les différentes infos dont on a besoin grâce à popen qui nous permet d'invoquer le shell
			FILE *cmdForMODE = popen(commandeForMODE,"r");
			FILE *cmdForSTART = popen(commandeForSTART,"r");
			FILE *cmdForEND = popen(commandeForEND,"r");
			FILE *cmdForCOMMAND = popen(commandeForCOMMAND,"r");	
			//on prends les résultats qu'on stock dans des variable grâce à fgets
			fgets(resultForMODE, 40, cmdForMODE);
			fgets(resultForSTART, 10, cmdForSTART);
			fgets(resultForEND, 10, cmdForEND);
			fgets(resultForCOMMAND, 40, cmdForCOMMAND);
			//on convertit en long int non-négatif le starting offset et le ending
			int l_start2 = strtoul(resultForSTART, NULL, 10);
			int l_end2 = strtoul(resultForEND, NULL, 10);
			//on ferme les différents shell invoqués
			pclose(cmdForMODE);
			pclose(cmdForSTART);
			pclose(cmdForEND);
			pclose(cmdForCOMMAND);

			//on print les infos sur le processus qui lock une partie du fichier
			printf("voici le type de lock: %s",resultForMODE);
			printf("voici le start offset: %d\n",l_start2);
			printf("voici le end : %d\n",l_end2);
			printf("voici le processus qui lock une partie de ce fichier: %s",resultForCOMMAND);
			//cas ou le fichier n'est pas lock par un autre processus, on obtient les infos de la situation
}			else{
			printf("\n****on peut lock cette partie du fichier****\n");
			//on repasse le l_type en F_UNLCK
			lock.l_type = F_UNLCK;
			lock.l_pid = getpid();
			//printf les différentes informations
			printf("voici les informations sur la structure du verrou :\n");
			printf("le type du lock à été changé en F_UNLCK \n");
			printf("ce fichier peut être lock entre les 'bytes' %ld et %ld \n",lock.l_start,lock.l_len);
			printf("notre pid sera: %d",lock.l_pid);			
			if (choix == 'y'){
			char c= l_whence;
			printf("on commence avec un whence '%c' \n",c);
}
}

}
		//cas ou on unlock le fichier
		else if (lock.l_type == F_UNLCK){
		printf("****file has been unlocked****");
}
	//on laisse le choix à l'utilisateur d'arrêter le processus ou de continuer à lock/unlock des parties du fichier 
	printf("\n\n#### write any key then press ENTER to continue #### \n");
	printf("#### or write 1997 then press ENTER to end #### \n");
	scanf("%d",&fin);
	//on arrête le processus s'il écrit 1997
	if (fin == 1997){
	close(file);
	return fin;
}
}


