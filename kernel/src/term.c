/**
 * Author: RomainGsd
 * Date: 29/04/2020
 */

#include "term.h"

//x86's VGA textmode buffer. Displaying text goes by writing data in this memory location
volatile uint16_t   *vga_buffer = (uint16_t*)0xB8000;
//Default VGA textmode characters size is 80x25
const int           VGA_COLS = 80;
const int           VGA_ROWS = 25;

//Text is displayed in the screen's top-left (column = row = 0)
int                 term_col = 0;
int                 term_row = 0;
uint8_t             term_color = WHITE;

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

void	term_set_color(uint8_t color)
{
	term_color = color;
}

void    putc(char c)
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

		for (int row = 0; row < VGA_ROWS - 1; row++) {
			for (int col = 0; col < VGA_COLS; col++){
				vga_buffer[col + (VGA_COLS * row)] = vga_buffer[col + (VGA_COLS * (row + 1))]; //col's char = col's char of next row
				vga_buffer[col + (VGA_COLS * (row + 1))] = ' '; //clean next row
			}
		}

		term_row--;
		term_col = 0;
	}
}

void    write_err(const char *str)
{
	term_set_color(RED);
	for (size_t i = 0; str[i] != '\0'; i++)
		putc(str[i]);
	term_set_color(WHITE);
}

void    write(const char *str)
{
	for (size_t i = 0; str[i] != '\0'; i++)
		putc(str[i]);
}