#include "athena.h"
#include "lcd.h"

void acia_init(void);
void acia_tx(char);
char acia_rx(void);

int main() {
    acia_init();
    acia_tx('a');
    acia_tx('b');
    acia_tx('c');

    lcd_init();
    lcd_putc('a');
    lcd_putc('b');
    lcd_putc('c');

    return 0;
}

void acia_init() {
    ACIA_STATUS = 0;
    ACIA_CTRL = 0b00010000;
    ACIA_CMD = 0b00001011;
}

void acia_tx(char data) {
    char delay = 100;
    ACIA_DATA = data;
    for (; delay > 0; --delay) {
        asm volatile ("nop");
    }
}

char acia_rx() {
    while (ACIA_STATUS & 0x08) {
        asm volatile ("nop");
    }
    return ACIA_DATA;
}
