//
//  TcpipSocket.c
//  tcpip
//
//  Created by fransiska on 2017/06/09.
//  Copyright © 2017年 fransiska. All rights reserved.
//

#include "TcpipSocket.h"
#include <stdio.h>

#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h> //inet_addr
#include <unistd.h> //read write close
#include <netdb.h> //hostent

void tcpipSocket_connect() {
    printf("Hello, I'm C\n");
}

