#include <WinSock2.h>
#include <Windows.h>
#include <stdio.h>

#pragma comment(lib, "WS2_32.lib")

void main()
{
	WSADATA wsaData;
	WSAStartup(MAKEWORD(1, 1), &wsaData);


	SOCKADDR_IN addr;
	addr.sin_family = AF_INET;
	addr.sin_addr.s_addr = inet_addr("10.0.0.2");
	addr.sin_port = htons(80);

	for (int i = 0; i < 1; i++)
	{
		char a = 0xa;
		char buffer[] = { 0x00, 0x00, 0x00, 0x10, a };

		SOCKET s = socket(AF_INET, SOCK_STREAM, IPPROTO_IP);
		connect(s, (sockaddr*)&addr, sizeof(addr));
		send(s, buffer, sizeof(buffer), 0);
		closesocket(s);

		printf("send %i\n", i);

	}





}
