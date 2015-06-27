#include <WinSock2.h>
#include <Windows.h>
#include <stdio.h>

#pragma comment(lib, "WS2_32.lib")

int connect_socket(char* host, int port)
{
	hostent* endpoint = gethostbyname(host);
	if (!endpoint)
	{
		fprintf(stderr, "failed to lookup host %s\n", host);
		exit(-1);
	}

	SOCKADDR_IN addr;
	addr.sin_family = AF_INET;
	addr.sin_addr = *((in_addr*)*endpoint->h_addr_list);
	addr.sin_port = htons(port);

	int s = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
	if (s == -1)
	{
		fprintf(stderr, "failed to create socket\n");
		exit(-1);
	}

	const long zero = 0;
	setsockopt(s, SOL_SOCKET, SO_SNDBUF, (char*)&zero, 4);

	int err = connect(s, (sockaddr*)&addr, sizeof(addr));
	if (err == -1)
	{
		fprintf(stderr, "failed to connect to %s:%i\n", host, port);
		exit(-1);
	}
	return s;
}

int put(char* host, int port, unsigned long address, FILE* source)
{
	int s = connect_socket(host, port);

	if (send(s, (const char*)&address, 4, 0) != 4)
	{
		fprintf(stderr, "failed to send header");
		return -2;
	}

	while(!feof(source))
	{
		char buffer[4096];
		size_t len = fread(buffer, 1, sizeof(buffer), source);

		if (send(s, buffer, len, 0) != len)
		{
			fprintf(stderr, "send error");
			return 1;
		}
	}

	closesocket(s);
	return 0;
}

int main(int argc, char* argv[])
{
	WSADATA wsaData;
	WSAStartup(MAKEWORD(1, 1), &wsaData);

	if (argc < 4)
	{
		fprintf(stderr, "usage: iptap <host> <cmd> <address> [file]\n\tcmd - put | get\n");
		return -1;
	}

	char* host = argv[1];
	char* cmd = argv[2];
	
	unsigned long addr;
	sscanf(argv[3], "%x", &addr);

	FILE* stream = stdin;
	if (argc >= 5)
	{
		stream = fopen(argv[4], "rb");
		if (!stream)
		{
			fprintf(stderr, "failed to open file %s\n", argv[4]);
			return -1;
		}
	}

	if (strcmp(cmd, "put"))
	{
		fprintf(stderr, "cmd %s not supported\n", cmd);
		return -1;
	}

	return put(host, 81, addr, stream);
}
