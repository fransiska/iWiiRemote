//
//  TcpipSocket.c
//  tcpip
//
//  Created by fransiska on 2017/06/09.
//  Copyright © 2017年 fransiska. All rights reserved.
//

#include "TcpipSocket.h"
#include <stdio.h>
#include <string.h>

#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h> //inet_addr
#include <unistd.h> //read write close
#include <netdb.h> //hostent

int tcpipSocket_connect(const char* serverName, int portno) {
  printf("Calling tcpipSocket connect\n");

  int sock;
  struct sockaddr_in serverAddress;

  //setup the sockaddr structure
  serverAddress.sin_family = AF_INET;
  serverAddress.sin_port = htons(portno);
  serverAddress.sin_addr.s_addr = inet_addr(serverName);

  //create a listening socket
  sock = socket(AF_INET, SOCK_STREAM, 0);
  if(sock < 0) {
    printf("error opening socket\n");
    return -1;
  }

  if(connect(sock, (struct sockaddr*) &serverAddress, sizeof(serverAddress)) < 0) {
    printf("error on connecting\n");
    return -1;
  }
  
  return sock;
}

void tcpipSocket_send(int sock, const char* message) {
  ssize_t n = write(sock, message, strlen(message));
  if(n < 0) {
    printf("error writing to socket\n");
    return;
  }
}

void tcpipSocket_close(int sock) {
  close(sock);
}

