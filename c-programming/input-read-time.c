#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <sys/types.h>
#include <unistd.h>
#include <string.h>

char *trl(int timeout){
  
  static char buf[512];/*create a char buffer to read and store the input*/
  fd_set rfds; /*create a file descriptor*/
  struct timeval tv; /*Create a timeinterval struct variable*/
  int ret; /*Return Value*/

  printf("Enter Name==>\n");

  /*Macros*/
  FD_ZERO(&rfds);
  FD_SET(0, &rfds);

  /*Initilize the time variable*/
  tv.tv_sec = timeout;
  tv.tv_usec = 0;

  ret = select(1,&rfds,0,0, &tv); /*How many file descriptor listening for, address*/
  
  /*Read the buffers*/
  if (ret && FD_ISSET(0,&rfds))
  {
    memset(buf,0,512);
    ret = read(0,buf,511);
    /*unable to select any data or might have end of file*/
    if (ret < 1){
      return 0;
    }
    /*else decrease the ret variable*/
    ret --;
    buf[ret] = 0;

    return buf;
  }

  /* else for time out*/
  else{
    return 0;
  }
}

int main(){

    char *name;
    name = trl(3);
    if (name){
      printf("Hello %s\n",name);
    }
    else{
      printf("TimeOut\n");
    }

    return 0;
}
