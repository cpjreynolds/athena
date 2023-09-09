; ======
; lcd.s
; ======
;
; LCD hardware routines

.PC02

.export _lcd_init
.export _lcd_cmd
.export _lcd_putc

.define VIA2_PORTB  $7400
.define VIA2_PORTA  $7401
.define VIA2_DDRB   $7402
.define VIA2_DDRA   $7403

.define LCD_E   %10000000
.define LCD_RW  %01000000
.define LCD_RS  %00100000

.segment    "CODE"

; void lcd_init(void)
.proc _lcd_init: near

    lda #$FF        ; Set all pins on port B_2 to output
    sta VIA2_DDRB
    lda #%11100000  ; Set top 3 pins on port A_2 to output
    sta VIA2_DDRA
    lda #%00111000  ; Set 8-bit mode; 2-line display; 5x8 font
    jsr _lcd_cmd
    lda #%00001110  ; Display on; cursor on; blink off
    jsr _lcd_cmd
    lda #%00000110  ; Increment and shift cursor; don't shift display
    jsr _lcd_cmd
    lda #$00000001  ; Clear display
    jsr _lcd_cmd
    rts

.endproc


; void lcd_cmd(char)
.proc _lcd_cmd: near

    jsr lcd_wait    ; Ensure not busy
    sta VIA2_PORTB  ; Set command on data lines
    stz VIA2_PORTA  ; RS=RW=E=0
    lda #LCD_E      ; RS=0 RW=0; E=1 to send instruction
    sta VIA2_PORTA
    stz VIA2_PORTA  ; RS=RW=E=0
    rts

.endproc


; void lcd_putc(char)
.proc _lcd_putc: near

    jsr lcd_wait
    sta VIA2_PORTB
    lda #LCD_RS
    sta VIA2_PORTA
    lda #(LCD_RS | LCD_E)
    sta VIA2_PORTA
    lda #LCD_RS
    sta VIA2_PORTA
    rts

.endproc


.proc lcd_wait: near

    pha
    stz VIA2_DDRB           ; Set port B to input
lcdbusy:
    lda #LCD_RW             ; RW=1 E=0
    sta VIA2_PORTA
    lda #(LCD_RW | LCD_E)   ; RW=1 E=1
    sta VIA2_PORTA
    lda VIA2_PORTB          ; Read D7-D0
    and #%10000000          ; Test for busy flag
    bne lcdbusy             ; Loop if busy flag set

    lda #LCD_RW             ; RW=1 E=0
    sta VIA2_PORTA
    lda #$FF                ; Restore Port B to output
    sta VIA2_DDRB
    pla
    rts

.endproc
