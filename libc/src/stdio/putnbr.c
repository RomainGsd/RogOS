/**
 * Author: RomainGsd
 * Date: 28/05/2020
*/

#include "stdio.h"

int putnbr(int nb)
{
	int len = 0;

	if (nb < 0)
	{
		putchar('-');
		nb = -nb;
		len++;
	} else if (nb == 0) {
		putchar('0');
		len++;
		return len;
	}
	if (nb >= 10)
	{
		putnbr(nb / 10);
		putnbr(nb % 10);
	}
	else
		putchar(nb + '0');

	return len;
}