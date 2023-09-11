; ======[interrupt.s]======
;
; Interrupt handler
;
;   Stops execution on BRK
;
;   Handles ACIA receive on hardware interrupt

.export     _irq_int, _nmi_int

.import     _ACIA_RXBUF
.import     _ACIA_RX_RPTR
.import     _ACIA_RX_WPTR

.define     ACIA_DATA   $7800
.define     ACIA_STATUS $7801

.segment    "CODE"

; Force 65C02 assembly
.PC02

; ======
; NMI service routine
; ======
_nmi_int:
    rti         ; Return from all NMIs

; ======
; IRQ service routine
; ======
_irq_int:
    phx         ; push X to stack
    tsx         ; transfer stack pointer to X
    pha         ; push A to stack
    inx
    inx         ; inc X to point to status register on stack
    lda $100,x  ; load status register into A
    and #$10    ; test B status bit (bit 4)
    bne break   ; if B=1, interrupt is software BRK

; IRQ detected
irq:
    lda ACIA_STATUS
    and #%10001000      ; test interrupt and Rx bits
    beq endirq          ; end if bits not set
    lda ACIA_DATA       ; a = Rx data
    ldx _ACIA_RX_WPTR   ; x = wptr
    sta _ACIA_RXBUF,x   ; rxbuf[wptr] = a
    inc _ACIA_RX_WPTR   ; ++wptr

endirq:
    pla                 ; restore A
    plx                 ; restore X
    rti

; BRK detected
break:
    stp         ; something has gone wrong
