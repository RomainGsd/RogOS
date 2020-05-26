/**
 * Author: RomainGsd
 * Date: 29/04/2020
 */

#pragma once

#include "kernel.h"

void    term_init();
void	term_set_color(uint8_t color);
void    term_putc(char c);
void    term_write_err(const char *str);
void    term_write(const char *str);