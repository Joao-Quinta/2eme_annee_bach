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

void handler(int signum)
{
  pid_t k;
  int wstatus;
  if(signum==SIGCHLD)
  {
    do{
        k=waitpid(0,&wstatus,WNOHANG | WCONTINUED);
	signal(SIGINT,SIG_DFL);
        if (k == -1)
        {
          perror("waitpid");
        }
        if (WIFEXITED(wstatus)) // Si le fils s'est terminé normalement
        {
          printf("Background job exited with code %d \n",WEXITSTATUS(wstatus) );
          return;
        }
    }while(!WIFEXITED(wstatus)&& !WIFSIGNALED(wstatus));
  } 
}
void bkJob(int argc,char* argv[])
{
  pid_t son= fork();
  if (son == 0)
  {
      //On est dans le fils
      char *cmd =argv[0];
      argv[argc-1]=NULL; // On supprime & et on le remplace par NULL
      freopen("/dev/null","w",stdin);
      if (execvp(cmd,argv) == -1)
      {
        printf("%s\n", strerror(errno));
      }
    }
    struct sigaction sa;
    sa.sa_handler=&handler;
    sigaction(SIGCHLD,&sa,NULL);

}
