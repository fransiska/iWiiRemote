//
//  TcpipSocket.h
//  tcpip
//
//  Created by fransiska on 2017/06/09.
//  Copyright © 2017年 fransiska. All rights reserved.
//

#ifndef TcpipSocket_h
#define TcpipSocket_h

#ifdef __cplusplus
extern "C" {
#endif
  int tcpipSocket_connect(const char* serverName, int portno);
  void tcpipSocket_send(int sock, const char* message);
  void tcpipSocket_close(int sock);
#ifdef __cplusplus
}
#endif

#endif /* TcpipSocket_h */
