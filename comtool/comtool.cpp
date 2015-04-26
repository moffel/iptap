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

	unsigned char data[64] = {};
	DWORD read;

#if 1

	while (ReadFile(hCom, data, 1, &read, NULL))
	{
		putchar(*data);
	}

#else

	unsigned counter = 0;
	while (ReadFile(hCom, data, sizeof(data), &read, NULL))
	{
		printf("%4i:\t", counter++);
		for (DWORD i = 0; i < read; ++i)
		{
			printf("%x%x ", data[i] >> 4, data[i] & 0xf);
			if (i % 16 == 15)
				printf("\n\t");
			data[i] = 0;
		}
		puts("");
	}

#endif
}

