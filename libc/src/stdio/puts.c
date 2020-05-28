/**
 * Author: RomainGsd
 * Date: 28/05/2020
*/

#include "stdio.h"

int puts(const char *str)
{
	size_t len = strlen(str);

	for (size_t i = 0; i < len; i++)
	{
		putchar(str[i]);
	}

	return len;
}