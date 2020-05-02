/**
 * Author: RomainGsd
 * Date: 29/04/2020
 */

#pragma once

#include "kernel.h"

void    term_init();
void	term_set_color(uint8_t color);
void    putc(char c);
void    write_err(const char *str);
void    write(const char *str);