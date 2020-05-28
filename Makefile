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

CC = i686-elf-gcc

CFLAGS = -std=gnu99 -ffreestanding -g -c -I ${KERNEL_HDRS} -I ${LIBC_HDRS} -W -Wall -Wextra -Werror

LD_FLAGS = -ffreestanding -nostdlib -g -T $(LINKER_DIR)/linker.ld

OUT_DIR = build

NAME = $(OUT_DIR)/kernel.elf

RM = rm -rf

MKDIR_P = mkdir -p

## SRC ################################

KERNEL_ASM = $(KERNEL_ASM_DIR)/start.s \
			$(KERNEL_ASM_DIR)/sleep.s

KERNEL_SRC = $(KERNEL_SRC_DIR)/kernel.c \
			$(KERNEL_SRC_DIR)/tty.c	\
			$(KERNEL_SRC_DIR)/ansi.c

LIBC_SRC = $(LIBC_SRC_DIR)/string/strlen.c \
			$(LIBC_SRC_DIR)/stdio/printf.c \
			$(LIBC_SRC_DIR)/stdio/putchar.c \
			$(LIBC_SRC_DIR)/stdio/puts.c \
			$(LIBC_SRC_DIR)/stdio/putnbr.c

OBJ = $(KERNEL_SRC:.c=.o) \
	$(KERNEL_ASM:.s=.o) \
	$(LIBC_SRC:.c=.o)

## MAKE RULES #########################

all:	build_dir $(NAME)

$(NAME):	$(OBJ)
	$(CC) $(LD_FLAGS) $(OBJ) -o $(NAME) -lgcc

%.o : %.s
	$(CC) $(CFLAGS) $< -o $@

run: clean
	qemu-system-i386 -kernel $(NAME)

clean:
	$(RM) $(OBJ)

fclean: clean
	$(RM) $(NAME)

re: fclean all

build_dir:
	$(MKDIR_P) $(OUT_DIR)

.PHONY: all run clean fclean re
