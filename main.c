#include <6502.h>

#include "athena.h"
#include "lcd.h"
#include "acia.h"

int main() {
    char data = 0;

    lcd_init();
    acia_init();
    acia_tx('i');
    acia_tx('n');
    acia_tx('i');
    acia_tx('t');

    CLI();

    while (1) {
        data = acia_rx();
        lcd_putc(data);
        acia_tx(data);
    }

    return 0;
}

