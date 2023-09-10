#ifndef LCD_H
#define LCD_H

// Defined in lcd.c
void lcd_puts(char* s);

// Defined in lcd_s.s
void lcd_putc(char c);
void lcd_init(void);
void lcd_cmd(char cmd);

#endif
