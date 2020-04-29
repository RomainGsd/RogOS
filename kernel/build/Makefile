##
## Author: RomainGsd
## Date: 10/04/2020
##

ASM 			= ../src/start.s

SRC 			= ../src/kernel.c

OBJ 			= $(SRC:.c=.o) ../src/start.o

HDRS 			= ../hdrs/

CC 				= i386-elf-gcc

CFLAGS 			= -std=gnu99 -ffreestanding -g -c

LD_FLAGS 		= -ffreestanding -nostdlib -g -T linker.ld

CFLAGS 			+= -I${HDRS}

NAME 			= kernel.elf

$(NAME):	$(OBJ)
	$(CC) $(LD_FLAGS) $(ASM_OBJ) $(OBJ) -o $(NAME) -lgcc

all:	$(NAME)

%.o : %.s
	$(CC) $(CFLAGS) $(ASM) -o ../src/start.o

clean:
	rm -f $(OBJ)

fclean: clean
	rm -f $(NAME)

re: fclean all

.PHONY: all clean fclean re
