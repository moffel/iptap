#include <WinSock2.h>
#include <Windows.h>
#include <stdio.h>

#pragma comment(lib, "WS2_32.lib")

struct NetHeader
{
	char			operation;
	char			padding;
	unsigned short	size;
	unsigned long	offset;
};

void main()
{
	WSADATA wsaData;
	WSAStartup(MAKEWORD(1, 1), &wsaData);


	SOCKADDR_IN addr;
	addr.sin_family = AF_INET;
	addr.sin_addr.s_addr = inet_addr("10.0.0.2");
	addr.sin_port = htons(80);

	for (int i = 0;; i++)
	{
		char buffer[sizeof(NetHeader) + 256] = {};
		NetHeader* head = (NetHeader*)buffer;
		head->offset = 0;
		head->size = 256;

		for (int j = 0; j < 256; ++j)
		{
			buffer[sizeof(NetHeader) + j] = i + j;
		}

		head->offset = htonl(head->offset);
		head->size = htons(head->size);

		SOCKET s = socket(AF_INET, SOCK_STREAM, IPPROTO_IP);
		connect(s, (sockaddr*)&addr, sizeof(addr));
		send(s, buffer, sizeof(buffer), 0);
		closesocket(s);

		printf("send %i\n", i);
		Sleep(5000);

	}





}
