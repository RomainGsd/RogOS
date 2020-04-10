#include <stddef.h>
#include <stdint.h>

//Check if my x86-elf cross compiler is used correctly
#if defined(__linux__)
	#error "This code must be compiled with a cross-compiler"
#elif !defined(__i386__)
	#error "This code must be compiled with an x86 compiler"
#endif

//x86's VGA textmode buffer. Displaying text goes by writing data in this memory location
volatile uint16_t   *vga_buffer = (uint16_t*)0xB8000;
//Default VGA textmode characters size is 80x25
const int           VGA_COLS = 80;
const int           VGA_ROWS = 25;

//Text is displayed in the screen's top-left (column = row = 0)
int                 term_col = 0;
int                 term_row = 0;
uint8_t             term_color = 0x0F; //black background & white foreground

//Initiate term by clearing it
void    term_init()
{
	//Clear textmode buffer
	for (int col = 0; col < VGA_COLS; col++) {
		for (int row = 0; row < VGA_ROWS; row++) {
			//VGA textmode buffer size is (VGA_COLS * VGA_ROWS)
			const size_t index = (VGA_COLS * row) + col;

			//Entries in VGA buffer are BBBBFFFFCCCCCCCC:
			//  -B: background color
			//  -F: foreground color
			//  -C: ASCII character
			vga_buffer[index] = ((uint16_t)term_col << 8) | ' '; //Set the character to blank
		}
	}
}

void    term_putc(char c)
{
	if (c == '\n') { //'\n' return a column 0 and increment the row
		term_col = 0;
		term_row++;
	} else { //Put char in buffer and increment column
		const size_t index = (VGA_COLS * term_row) + term_col;
		vga_buffer[index] = ((uint16_t)term_color << 8) | c;
		term_col++;
	}

	//If we go beyond the number of columns
	if (term_col >= VGA_COLS) {
		term_col = 0;
		term_row++;
	}
	//If we go beyond the number of rows
	if (term_row >= VGA_ROWS) {
		term_row = term_row = 0;
	}
}

void    term_print(const char *str)
{
	for (size_t i = 0; str[i] != '\0'; i++)
		term_putc(str[i]);
}

void kernel_main()
{
	term_init();

	term_print("Hello, World!\n");
	term_print("Welcome to RogOS's kernel.\n");
}