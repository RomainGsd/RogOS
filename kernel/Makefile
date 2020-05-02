##
## Author: RomainGsd
## Date: 10/04/2020
##

ASM 			= 	src/start.s \
					src/sleep.s

SRC 			= 	src/kernel.c \
					src/term.c

OBJ 			= $(SRC:.c=.o) $(ASM:.s=.o)

HDRS 			= hdrs/

CC 				= i386-elf-gcc

CFLAGS 			= -std=gnu99 -ffreestanding -g -c

LD_FLAGS 		= -ffreestanding -nostdlib -g -T linker/linker.ld

CFLAGS 			+= -I${HDRS}

NAME 			= build/kernel.elf

$(NAME):	$(OBJ)
	$(CC) $(LD_FLAGS) $(ASM_OBJ) $(OBJ) -o $(NAME) -lgcc

all:	$(NAME)

%.o : %.s
	$(CC) $(CFLAGS) $< -o $@

run: clean
	qemu-system-i386 -kernel $(NAME)

clean:
	rm -f $(OBJ)

fclean: clean
	rm -f $(NAME)

re: fclean all

.PHONY: all run clean fclean re
