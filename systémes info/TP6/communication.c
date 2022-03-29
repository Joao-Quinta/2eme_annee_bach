#include <arpa/inet.h>
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <memory.h>
#include <unistd.h>
#include <time.h>
#include "sendMAIL.h"
#include "videBuffer.h"
#define BUF_SIZE 1024
//fonction qui va permettre une communication serveur client avec les différentes commande smtp
void smtpCMD(int sockets, char* senderORreceiver, void* commande, int code){
  char start[100],end[100];
  char *data="data\r\n";
//on copie la commande stmp dans start
  strcpy(start,commande);
//cas ou la commande n'est pas QUIT donc on concatene le mail du sender ou du reciever
if (code != 3){
  strcat(start,senderORreceiver);
}
//on copie start dans end
  strcpy(end,start);
//on a le message final
  strcat(end,"\r\n");
  printf("%s\n",end );
  char bufferCMD[BUF_SIZE];
//code = 1 est le cas du data
if (code == 1){
	//send pour data
	send(sockets,data,strlen(data),0);
}
  //send pour les autres commandes que data
  send(sockets,end,strlen(end),0);
//cas ehlo, MAIL FROM, RCPT TO, data, QUIT
if (code == 0 || code ==1 || code == 3){
  //on recoit ce que le serveur nous repond, on stock ca dans bufferCMD
  recv(sockets,bufferCMD,BUF_SIZE,0);
  //printf ce que nous repond le serveur
  printf(" %s \n", bufferCMD);
	//cas de QUIT
	if (code == 3){
	//print le message d'adieu
	printf("%s \n",senderORreceiver);
}
}
  //on vide les buffer pour éviter toutes confusions
  viderBuffer(bufferCMD);
  viderBuffer(start);
  viderBuffer(end);
}

