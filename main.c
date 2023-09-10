#include "athena.h"
#include "lcd.h"
#include "acia.h"

int main() {
    acia_init();
    acia_tx('a');
    acia_tx('b');
    acia_tx('c');

    lcd_init();
    lcd_puts("merpmerp");

    return 0;
}

