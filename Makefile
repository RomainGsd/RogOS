##
## Author: RomainGsd
## Date: 26/05/2020
##

## MACROS #############################

KERNEL_SRC_DIR = kernel/src

KERNEL_ASM_DIR = kernel/asm

LIBC_SRC_DIR = libc/src

LINKER_DIR = linker

KERNEL_HDRS = kernel/hdrs/

LIBC_HDRS = libc/hdrs/

CC = i386-elf-gcc

CFLAGS = -std=gnu99 -ffreestanding -g -c -I ${KERNEL_HDRS} -I ${LIBC_HDRS}

LD_FLAGS = -ffreestanding -nostdlib -g -T $(LINKER_DIR)/linker.ld

NAME = build/kernel.elf

RM = rm -rf

## SRC ################################

KERNEL_ASM = $(KERNEL_ASM_DIR)/start.s \
			$(KERNEL_ASM_DIR)/sleep.s

KERNEL_SRC = $(KERNEL_SRC_DIR)/kernel.c \
			$(KERNEL_SRC_DIR)/tty.c	\
			$(KERNEL_SRC_DIR)/ansi.c

LIBC_SRC = $(LIBC_SRC_DIR)/string/strlen.c

OBJ = $(KERNEL_SRC:.c=.o) \
	$(KERNEL_ASM:.s=.o) \
	$(LIBC_SRC:.c=.o)

## MAKE RULES #########################

$(NAME):	$(OBJ)
	$(CC) $(LD_FLAGS) $(OBJ) -o $(NAME) -lgcc

all:	$(NAME)

%.o : %.s
	$(CC) $(CFLAGS) $< -o $@

run: clean
	qemu-system-i386 -kernel $(NAME)

clean:
	$(RM) $(OBJ)

fclean: clean
	$(RM) $(NAME)

re: fclean all

.PHONY: all run clean fclean re
