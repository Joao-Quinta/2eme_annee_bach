#include <stdio.h>
#include <stdlib.h>
#include <sys/file.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>


//fonction pour obtenir le PID d'un processus tenant un lock sur une partie d'un fichier
int getPID(){

//permet d'obtenir le PID du processus le plus ancien s'appelant a.out, du coup le premier aillant lock le file
	char line[100];
	//on utilise pgrep -o pour chercher le file a.out le plus ancien, 'r' pour droit de lecture
	FILE *cmd = popen("pgrep -o lockFILES", "r");
	//obtient le résultat depuis cmd
	fgets(line, 100, cmd);
	//transforne résultat en long int non négatif
	pid_t pid = strtoul(line, NULL, 10);
	//on ferme le cmd et on return le PID du processus le plus ancien qui tient le lock 
	pclose(cmd);
	return pid;
}

