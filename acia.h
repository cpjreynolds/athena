#ifndef ACIA_H
#define ACIA_H

/*
 * defined in acia.c
 */
extern char ACIA_RXBUF[];
extern char ACIA_RX_RPTR;
extern char ACIA_RX_WPTR;

void acia_init(void);

/*
 * defined in acia_s.s
 */
void acia_tx(char);
char acia_rx(void);

#endif
