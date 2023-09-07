# disable built-in rules
.SUFFIXES:

CC=cc65
AS=ca65
AR=ar65
LD=ld65

CFLAGS=-t none --cpu 65c02
ASFLAGS=--cpu 65c02
LDFLAGS=-C athena.cfg

TARGET=a.out

TARGET_SRC=main.c
TARGET_OBJ=$(patsubst %.c,%.o,$(TARGET_SRC))

PLATFORM_ASM=interrupt.s vectors.s
PLATFORM_OBJ=$(patsubst %.s,%.o,$(PLATFORM_ASM))

LIBC=athena.lib

$(TARGET): $(PLATFORM_OBJ) $(TARGET_OBJ) $(LIBC)
	$(LD) $(LDFLAGS) $^

%.o: %.s
	ca65 $(ASFLAGS) $<

%.s: %.c
	$(CC) $(CFLAGS) $<

$(LIBC): crt0.o
	$(AR) a athena.lib crt0.o

crt0.o: crt0.s
	ca65 crt0.s

.PHONY: clean
clean:
	rm -f crt0.o $(TARGET) $(PLATFORM_OBJ) $(TARGET_OBJ)

.PHONY: upload
upload:
	minipro -p AT28C256 -uP $(TARGET)
