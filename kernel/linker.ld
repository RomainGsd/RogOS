/* Bootloader will start with designated entry symbol */
ENTRY(start)

SECTIONS
{
	/* Putting sections start at 1 Megabyte is a good pratice as below 1M is reserved to x86 stuff */
	. = 1M;

	/* Align all sections on a multiple of 4 Kilobytes */
	/* Multiboot header is only so it can go in a .rodata */
	.rodata BLOCK(4K) : ALIGN(4K)
	{
		*(.multiboot)
	}

	/* Executable code */
	.text BLOCK(4K) : ALIGN (4K)
	{
		*(.text)
	}

	/* Read-only data. */
	.rodata BLOCK(4K) : ALIGN(4K)
	{
		*(.rodata)
	}

	/* Read-write data (initialized) */
	.data BLOCK(4K) : ALIGN(4K)
	{
		*(.data)
	}

	/* Read-write data (uninitialized) and stack */
	.bss BLOCK(4K) : ALIGN(4K)
	{
		*(COMMON)
		*(.bss)
	}
}