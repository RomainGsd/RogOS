/**
 * Author: RomainGsd
 * Date: 10/04/2020
*/

#include "kernel.h"

//Check if my x86-elf cross compiler is used correctly
#if defined(__linux__)
	#error "This code must be compiled with a cross-compiler"
#elif !defined(__i386__)
	#error "This code must be compiled with an x86 compiler"
#endif

void kernel_main()
{
	term_init();

	term_write("Hello, World!\n");
	term_write("Welcome to RogOS's kernel.\n");
	detect_ansi("\x1b[031m");
}