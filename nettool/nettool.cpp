#include <WinSock2.h>
#include <Windows.h>
#include <stdio.h>

#pragma comment(lib, "WS2_32.lib")

struct get_header
{
	unsigned long	offset;
	unsigned short	size;
};

void main()
{
	WSADATA wsaData;
	WSAStartup(MAKEWORD(1, 1), &wsaData);


	SOCKADDR_IN addr;
	addr.sin_family = AF_INET;
	addr.sin_addr.s_addr = inet_addr("10.0.0.2");
	addr.sin_port = htons(82);

	SOCKET s = socket(AF_INET, SOCK_STREAM, IPPROTO_IP);

	long zero = 0;
	int err = setsockopt(s, SOL_SOCKET, SO_SNDBUF, (char*)&zero, 4);

	err = connect(s, (sockaddr*)&addr, sizeof(addr));

#if 1
	get_header	header;
	header.offset = htonl(1 << 31);
	header.size	= htons(1024);
	err = send(s, (char*)&header, 6, 0);

	char buffer[1024];
	err = recv(s, buffer, 1024, 0);

#else

	long offset = htonl(1 << 31);
	err = send(s, (const char*)&offset, sizeof(offset), 0);

	char* largebuffer = new char[1024 * 1024];
	for (int i = 0; i < 1024 * 1024; ++i)
		largebuffer[i] = 'a' + (rand() % 26);


//	while (1)
	{
		err = send(s, largebuffer, 1024, 0);
	}


//	for (int i = 0; ; i++)
//	{
//		char a = 0xa;
//		char buffer[] = { i };
//
//		send(s, buffer, sizeof(buffer), 0);
//
//		printf("send %i\n", i);
//	//	Sleep(10);
//	}
#endif
	err = closesocket(s);




}
