/**
 * Author: RomainGsd
 * Date: 27/05/2020
*/

#include "ansi.h"

int get_hex_escape(char *str)
{
	char esc = '\x1b';
	size_t len = strlen(str);

	for (size_t i = 0; i < len; i++) {
		if (str[i] == esc) {
			printf("escape code");
		}
	}

	return 0;
}