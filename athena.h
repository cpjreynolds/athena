#ifndef ATHENA_H
#define ATHENA_H

#define VIA1_PORTA  (*(unsigned char*) 0x7000)
#define VIA1_PORTB  (*(unsigned char*) 0x7001)
#define VIA1_DDRB   (*(unsigned char*) 0x7002)
#define VIA1_DDRA   (*(unsigned char*) 0x7003)

#define VIA2_PORTA  (*(unsigned char*) 0x7400)
#define VIA2_PORTB  (*(unsigned char*) 0x7401)
#define VIA2_DDRB   (*(unsigned char*) 0x7402)
#define VIA2_DDRA   (*(unsigned char*) 0x7403)

#define ACIA_DATA   (*(unsigned char*) 0x7800)
#define ACIA_STATUS (*(unsigned char*) 0x7801)
#define ACIA_CMD    (*(unsigned char*) 0x7802)
#define ACIA_CTRL   (*(unsigned char*) 0x7803)

#endif
