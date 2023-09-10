#include "lcd.h"

void lcd_puts(char* s) {
    while (*s != 0) {
        lcd_putc(*s);
        ++s;
    }
}
