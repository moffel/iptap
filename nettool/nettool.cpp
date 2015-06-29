#include <WinSock2.h>
#include <Windows.h>
#include <stdio.h>

#pragma comment(lib, "WS2_32.lib")

struct get_header
{
	unsigned long	offset;
	unsigned short	size;
};

SOCKADDR_IN addr;

void put(unsigned long address, const void* data, unsigned long size)
{
	SOCKET s = socket(AF_INET, SOCK_STREAM, IPPROTO_IP);
	const long zero = 0;
	int err = setsockopt(s, SOL_SOCKET, SO_SNDBUF, (char*)&zero, 4);
	addr.sin_port = htons(81);
	err = connect(s, (sockaddr*)&addr, sizeof(addr));

	address = htonl(address);
	err = send(s, (const char*)&address, 4, 0);
	err = send(s, (const char*)data, size, 0);
	err = closesocket(s);
}

void get(unsigned long address, void* data, unsigned long size)
{
	SOCKET s = socket(AF_INET, SOCK_STREAM, IPPROTO_IP);
	const long zero = 0;
	int err = setsockopt(s, SOL_SOCKET, SO_SNDBUF, (char*)&zero, 4);
	addr.sin_port = htons(82);
	err = connect(s, (sockaddr*)&addr, sizeof(addr));

	const get_header header = { htonl(address), htons(size) };
	err = send(s, (const char*)&header, 6, 0);
	err = recv(s, (char*)data, size, 0);
	err = closesocket(s);
}

void main()
{
	WSADATA wsaData;
	WSAStartup(MAKEWORD(1, 1), &wsaData);

	addr.sin_family = AF_INET;
	addr.sin_addr.s_addr = inet_addr("10.0.0.2");

	char testdata[1024];
	for (int i = 0; i < 1024; ++i)
		testdata[i] = 'a' + rand() % 26;

	const unsigned addr_led = 0;
	const unsigned addr_uart = 0x80000000u;
	const unsigned addr_mem = 0xC0000000u;

	put(addr_mem, testdata, 4);

	char getdata[1024];
	get(addr_mem, getdata, 4);




}
