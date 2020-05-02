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

	write("Hello, World!\n");
	write("Welcome to RogOS's kernel.\n");
	write("Test\nTest\nTest\nTest\nTest\nTest\nTest\nTest\nTest\nTest\nTest\nTest\n");
	write("Test2\nTest2\nTest2\nTest2\nTest2\nTest2\nTest2\nTest2\nTest2\nTest2\nTest2\nTest2\n");
	write("Test3\nTest3\nTest3\nTest3\nTest3\nTest3\n");
	write("Final word");
}