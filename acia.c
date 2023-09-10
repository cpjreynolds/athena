#include "athena.h"
#include "acia.h"

void acia_init() {
    ACIA_STATUS = 0;            // soft reset chip
    ACIA_CTRL = 0b00010000;     // N-8-1 @ 115.2K baud
    ACIA_CMD = 0b00001011;      // no parity, no echo, no interrupts
}

// Blocking transmit
void acia_tx(char data) {
    char delay = 100;
    ACIA_DATA = data;
    while (delay != 0) {
        asm volatile ("nop");
        --delay;
    }
}

// Blocking receive
char acia_rx() {
    // loop while Rx buffer not full
    while (ACIA_STATUS & 0x08) {
        asm volatile ("nop");
    }
    return ACIA_DATA;
}
