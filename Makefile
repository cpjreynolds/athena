# disable built-in rules
.SUFFIXES:

CC=cc65
AS=ca65
AR=ar65
LD=ld65

CFLAGS=-O -t none --cpu 65c02 --create-dep $(<:.c=.d)
ASFLAGS=--cpu 65c02
LDFLAGS=-C athena.cfg

TARGET=a.out

TARGET_SRC=main.c lcd.c
TARGET_OBJ=$(TARGET_SRC:.c=.o)

PLATFORM_ASM=interrupt.s vectors.s lcd_s.s
PLATFORM_OBJ=$(PLATFORM_ASM:.s=.o)

LIBC=athena.lib

.PHONY: all clean

all: $(TARGET)

ifneq ($(MAKECMDGOALS),clean)
-include $(TARGET_SRC:.c=.d)
endif

$(TARGET): $(PLATFORM_OBJ) $(TARGET_OBJ) $(LIBC)
	$(LD) $(LDFLAGS) $^

%.o: %.s
	$(AS) $(ASFLAGS) $<

%.s: %.c
	$(CC) $(CFLAGS) $<

$(LIBC): crt0.o
	$(AR) a athena.lib crt0.o

crt0.o: crt0.s
	$(AS) $(ASFLAGS) crt0.s

clean:
	rm -f \
		main.s				\
		crt0.o				\
		$(TARGET)			\
		$(PLATFORM_OBJ) 	\
		$(TARGET_OBJ) 		\
		$(TARGET_SRC:.c=.d)

.PHONY: upload
upload:
	minipro -p AT28C256 -uP -w $(TARGET)
