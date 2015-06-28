#include <WinSock2.h>
#include <Windows.h>
#include <stdio.h>

#pragma comment(lib, "WS2_32.lib")

int connect_socket(char* host, int port)
{
	int err;
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
	err = setsockopt(s, SOL_SOCKET, SO_SNDBUF, (const char*)&zero, 4);

	const linger linger_setup = { 1, 10 };
	err = setsockopt(s, SOL_SOCKET, SO_LINGER, (const char*)&linger_setup, sizeof(linger_setup));

	err = connect(s, (sockaddr*)&addr, sizeof(addr));
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
		fprintf(stderr, "failed to send header\n");
		return -2;
	}

	while(!feof(source))
	{
		char buffer[4096];
		size_t len = fread(buffer, 1, sizeof(buffer), source);

		if (send(s, buffer, len, 0) != len)
		{
			fprintf(stderr, "send error\n");
			return 1;
		}
	}

	closesocket(s);
	return 0;
}

int get(char* host, int port, unsigned long address, unsigned short size, FILE* destination)
{
	struct
	{
		unsigned long offset;
		unsigned short size;
	}	header;

	header.offset = htonl(address);
	header.size = htons(size);

	int s = connect_socket(host, port);

	if (send(s, (char*)&header, 6, 0) != 6)
	{
		fprintf(stderr, "failed to send header\n");
		return -2;
	}

	char buffer[2048];
	int len = recv(s, buffer, size, 0);
	if (len != size)
	{
		fprintf(stderr, "recv failed\n");
		return -2;
	}

	if (fwrite(buffer, size, 1, destination) != 1)
	{
		fprintf(stderr, "write to file failed\n");
		return -1;
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
		fprintf(stderr, "usage:\tiptap <host> put <hex address> [input file]\n"
						"\tiptap <host> get <hex address> <size> [output file]\n");
		return -1;
	}

	char* host = argv[1];
	
	unsigned long addr;
	sscanf(argv[3], "%x", &addr);

	FILE* stream = 0;
	int cmd;
	if (!strcmp(argv[2], "put"))
	{
		cmd = 0;

		stream = stdin;
		if (argc >= 5)
			stream = fopen(argv[4], "rb");
	}
	else if (!strcmp(argv[2], "get"))
	{
		cmd = 1;

		stream = stdout;
		if (argc >= 6)
			stream = fopen(argv[5], "wb");
	}
	else
	{
		fprintf(stderr, "invalid command %s\n", argv[2]);
		return -1;
	}

	if (!stream)
	{
		fprintf(stderr, "failed to open file\n");
		return -1;
	}

	if (cmd == 0)
		return put(host, 81, addr, stream);

	unsigned long size = atoi(argv[4]);
	while (size)
	{
		const unsigned short chunk = size > 1280 ? 1280 : (unsigned short)size;
		int err = get(host, 82, addr, chunk, stream);
		if (err != 0)
			return err;

		addr += chunk;
		size -= chunk;
	}
	return 0;
}
