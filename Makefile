TARGET = code

SRC = code.c

MSPDEBUG = mspdebug
MSPPROGRAMMER = rf2500

CC = msp430-gcc
AS = msp430-as
LD = msp430-ld

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

as: asm
	$(AS) -mcpu=430 -mmcu=msp430g2553 -o $(TARGET).o $(TARGET).s

ld: as
	$(LD) -m msp430 $(TARGET).o /usr/local/Cellar/msp430/lib/gcc/msp430/4.6.3/crt0ivtbl16.o -L /usr/local/Cellar/msp430/lib/gcc/msp430/4.6.3 -lcrt0 -L /usr/local/Cellar/msp430/msp430/lib/ldscripts/msp430g2553/ -o $(TARGET).out --verbose

custom:	ld
	$(MSPDEBUG) $(MSPPROGRAMMER) "erase"
	$(MSPDEBUG) $(MSPPROGRAMMER) "prog $(TARGET).out"	

clean:
	rm $(TARGET).elf $(TARGET).s $(TARGET).o $(TARGET).out
