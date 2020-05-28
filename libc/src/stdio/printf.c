/**
 * Author: RomainGsd
 * Date: 28/05/2020
*/

#include "stdio.h"

int printf(const char *fmt, ...)
{
	va_list args;
	int written = 0;

	va_start(args, fmt);
	while (*fmt != '\0')
	{
		if (*fmt == '%') {
			switch (*++fmt) {
				case 's':
					written += puts(va_arg(args, char*));
					break;
				case 'c':
					putchar(va_arg(args, int));
					written++;
					break;
				case 'd':
					written += putnbr(va_arg(args, int));
					break;
				default:
					putchar('%');
					putchar(*fmt);
					written += 2;
					break;
			}
		} else {
			putchar(*fmt);
			written++;
		}
		fmt++;
	}
	va_end(args);

	return written;
}