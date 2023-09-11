#include <6502.h>

#include "athena.h"
#include "lcd.h"
#include "acia.h"

int main() {
    char data = 0;

    lcd_init();

    acia_init();
    acia_tx('a');
    acia_tx('b');
    acia_tx('c');

    CLI();

    while (1) {
        data = acia_rx();
        lcd_putc(data);
    }

    return 0;
}

