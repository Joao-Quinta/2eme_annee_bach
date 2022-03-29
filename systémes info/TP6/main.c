#include <arpa/inet.h>
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <memory.h>
#include <unistd.h>
#include <time.h>
#include "sendMAIL.h"
#include "videBuffer.h"
#include "communication.h"
#define HOST_IP "10.194.9.231"
#define PORT_NUM 25
#define BUF_SIZE 1024


//fonction principale qui va demander les adresses mail, appeller la fonction qui créer la communication client/serveur, appeller la fonction qui envoie le mail, terminer la communication client/serveur et s'arrète si l'user ne veut pas renvoyer de mail
int main(int argc, char *argv[]){
    //on vérifie qu'il n'y a que 2 arguments, l'appel au programme et le fichier qu'on souhaite utiliser comme contenu du mail
    if (argc !=2){
      printf("Arguments error\n" );
      exit(EXIT_FAILURE);
    }
    //Demande des adresses mail
    char sender[100],receiver[100];
    printf("Rentrez l'adresse de l'expéditeur \n");
    scanf( "%s",sender);
    printf("Rentrez l'addresse de destination \n");
    scanf("%s",receiver );
    //Initialisation du socket
    struct sockaddr_in adresse;
    memset(&adresse, 0, sizeof(adresse));
    adresse.sin_family = AF_INET;
    adresse.sin_port = htons(PORT_NUM);

//on demande a l'utilisateur s'il veut utiliser une adresse IP à lui
char adresseIP[100],choix;
printf("voulez vous donner une adresse IP (y/n)?");
scanf("%s",&choix);
	//si oui on lui laisse donner son adresse IP
	if (choix == 'y'){
		printf("donnez une adresse IP valide: ");
		scanf("%s",adresseIP);
		adresse.sin_addr.s_addr = inet_addr(adresseIP);
	}else{
	//si non on impose une adresse IP par défaut
		printf("choix par défaut :%s ",HOST_IP);
		adresse.sin_addr.s_addr = inet_addr(HOST_IP);
	}
    //si adresse non valide, on termine le programme
    if (adresse.sin_addr.s_addr == INADDR_NONE){
        printf("adresse non valide \n");
        return -1;
    }
    //Création du socket
    int canal = socket(AF_INET, SOCK_STREAM, 0);
    //cas on arrive pas à créer le socket
    if(canal < 0){
        perror("socket");
        return -1;
    }
    //cas socket créer
    else{
      printf("Socket Done, now connecting....\n");
    }
    //on essaie de se connecter avec l'IP et le port donné
    char bufferRcpt[BUF_SIZE];
    if(connect(canal, (struct sockaddr *) &adresse, sizeof(adresse)) < 0){   
	//cas ou on arrive pas a se connecter
        perror("connect");
        close(canal);
        return -1;
    }
    else{
      //Lecture du serveur
      read(canal,bufferRcpt,BUF_SIZE);
    }
    printf("%s\n", bufferRcpt);
    //Vidage du buffer
    viderBuffer(bufferRcpt); 
    //communication entre client et serveur
    smtpCMD(canal,adresseIP,"ehlo ",0);
    smtpCMD(canal,sender,"MAIL FROM:",0);
    smtpCMD(canal,receiver,"RCPT TO:",0);
    smtpCMD(canal,receiver,"pour Data",1);
    smtpCMD(canal,sender,"From:",2);
    smtpCMD(canal,receiver,"To:",2);
    smtpCMD(canal,"TP6 de SI","Subject:",2);
    //on envoie la totalité du message grâce à sendFichier
    sendFichier(canal,argv);
    //envoie du point final au serveur
    char *point=" \r\n.\r\n";
    send(canal,point,strlen(point),0);
    recv(canal,bufferRcpt,BUF_SIZE,0);
    printf(" %s \n", bufferRcpt);
    viderBuffer(bufferRcpt);
    //envoie du signal QUIT pour terminer la communication 
    smtpCMD(canal,"goobye","QUIT",3);
	//on demande a l'utilisateur s'il veut continuer à envoyer ce fichier à d'autres mails (ou les mêmes selon son input)
	char contiuer;
	printf("voulez vous à nouveau envoyer un mail avec: %s ,comme contenu (y/n)?",argv[1]);
	scanf("%s", &contiuer);
	if (contiuer == 'y'){
		printf("\nvous pouvez à nouveau envoyer le mail %s à qui vous voulez \n\n\n",argv[1]);
		main(argc, argv);
	}
	else{
		exit(EXIT_SUCCESS);
	}
    exit(EXIT_SUCCESS);
}
