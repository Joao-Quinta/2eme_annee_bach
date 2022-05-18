#include <arpa/inet.h>
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <memory.h>
#include <unistd.h>
#include <time.h>
#define BUF_SIZE 1024
//fonction qui va vider le buffer reçu
void viderBuffer(char* buffer)
{
  for (int i=0;i <= sizeof(buffer);i++)
  {
    //on vide le buffer 1 case par 1 case
    buffer[i]='\0';
  }
}

