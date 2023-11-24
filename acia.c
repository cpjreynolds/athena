#include "athena.h"
#include "acia.h"

char ACIA_RXBUF[256];

char ACIA_RX_RPTR = 0;
char ACIA_RX_WPTR = 0;

void acia_init()
{
    ACIA_STATUS = 0;        // soft reset chip
    ACIA_CTRL = 0b00011111; // N-8-1 @ 115.2K baud
    ACIA_CMD = 0b00001001;  // no parity, no echo, interrupt on Rx
}
