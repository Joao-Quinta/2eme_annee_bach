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

void retourSignal(int signo){
	if (signo==SIGINT){
	signal(signo, SIG_DFL);
}
}
/*
void ignoreSignal(int signo){
	if (signo == SIGINT){
	signal(signo, SIG_IGN);
}
}
*/

void fdJob(int argc,char* argv[])
{
  pid_t son=fork(),k,g;
  if (son < 0) {
    perror("Fork failed");
        }
  int wstatus;
  int child_state;

  if (son==0)
    {
      char *cmd =argv[0];
      argv[argc]=NULL;
      if (execvp(cmd,argv) <0){
	perror(cmd);
	kill(son,SIGINT);
            }
    }
    else if(son>0)
    {
        do
        {
		struct sigaction sa;
		sa.sa_handler = &retourSignal;
		sigaction(SIGINT,&sa,NULL);
		sa.sa_flags = SA_RESTART;
		if (getppid() == 1){
	printf("c'est moi wesh");
            k=waitpid(son,&wstatus,WUNTRACED | WCONTINUED);
if (errno == EINTR){
perror("EINTR");
}
		
}
	    if (getppid() != 1){
		signal(SIGINT,SIG_IGN);
		g = waitpid(son,&wstatus,WUNTRACED | WCONTINUED);
		
		
}
            if (k == -1)
            {

              perror("waitpid");
              //exit(EXIT_FAILURE);
            }
            if (WIFEXITED(wstatus))
              printf("Foreground job exited with code %d \n",WEXITSTATUS(wstatus) );

            else
              printf("Foreground job exited\n" );

		
        }while(!WIFEXITED(wstatus) && !WIFSIGNALED(wstatus));
    }   /*struct sigaction ignore;
	ignore.sa_handler =&ignoreSignal;
	sigaction(SIGINT,&ignore,NULL);
	ignore.sa_flags = SA_RESTART;*/
  }

