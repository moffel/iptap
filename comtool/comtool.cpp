#include <Windows.h>
#include <stdio.h>

void main()
{
	HANDLE hCom = CreateFileA("\\\\.\\COM4", GENERIC_READ | GENERIC_WRITE, 0, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);
	if (hCom == INVALID_HANDLE_VALUE)
	{
		printf("failed to open com port\n");
		return;
	}

	DCB state = { sizeof(DCB) };
	GetCommState(hCom, &state);
	state.BaudRate = 9600;
	state.ByteSize = 8;
	state.Parity = 0;
	state.StopBits = 1;
	SetCommState(hCom, &state);

	unsigned char data[16];
	DWORD read;
	while (ReadFile(hCom, data, 16, &read, NULL))
	{
		printf("got %2ib: ", read);
		for (DWORD i = 0; i < read; ++i)
		{
			printf("%X%X ", data[i] >> 4, data[i] & 0xf);
		}
		puts("");
	}
}

