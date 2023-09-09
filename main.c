#define ACIA_DATA   (*(unsigned char*) 0x7800)
#define ACIA_STATUS (*(unsigned char*) 0x7801)
#define ACIA_CMD    (*(unsigned char*) 0x7802)
#define ACIA_CTRL   (*(unsigned char*) 0x7803)

void acia_init(void);
void acia_tx(char);
char acia_rx(void);

int main() {
    acia_init();
    acia_tx('a');
    acia_tx('b');
    acia_tx('c');
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