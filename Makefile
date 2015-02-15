TARGET = code

SRC = code.c

MSPDEBUG = mspdebug
MSPPROGRAMMER = rf2500

CC = msp430-gcc

# Compiler flag to set the C Standard level.
#     gnu89 = c89 plus GCC extensions
#     gnu99 = c99 plus GCC extensions
COPTS = -std=gnu99 -mmcu=msp430g2553

all: build
	
install: build
	$(MSPDEBUG) $(MSPPROGRAMMER) "erase"
	$(MSPDEBUG) $(MSPPROGRAMMER) "prog $(TARGET).elf"

build:
	$(CC) $(COPTS) -o $(TARGET).elf $(SRC)

asm:
	$(CC) $(COPTS) -S -o $(TARGET).s $(SRC)

clean:
	rm $(TARGET).elf $(TARGET).s
