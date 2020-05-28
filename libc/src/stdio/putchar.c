/**
 * Author: RomainGsd
 * Date: 28/05/2020
*/

#include "stdio.h"

int putchar(const int ic)
{
    char c = (char)ic;

    term_putc(c);

    return ic;
}