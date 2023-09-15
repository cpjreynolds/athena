.PC02

.import     _ACIA_RXBUF
.import     _ACIA_RX_RPTR
.import     _ACIA_RX_WPTR

.export     _acia_rx
.export     _acia_tx

.define     ACIA_DATA   $7800
.define     ACIA_STATUS $7801

.segment    "CODE"

; char acia_rx (void)
;
;   recieve a byte from the Rx buffer, block for a byte if empty
.proc _acia_rx: near

    bra condtest        ; hop over the wait the first time
waitloop:
    wai                 ; wait for interrupt
condtest:
    lda _ACIA_RX_WPTR   ; a = wptr
    cmp _ACIA_RX_RPTR
    beq waitloop        ; if (rptr == wptr): wait and try again

    ldy _ACIA_RX_RPTR   ; y = rptr
    lda _ACIA_RXBUF,y   ; a = rxbuf[rptr]
    inc _ACIA_RX_RPTR   ; ++rptr

    ldx #$00            ; load high byte of return value
    rts

.endproc

.segment    "CODE"

; void acia_tx (char)
;
; Send character as soon as ready
.proc _acia_tx: near

    tax             ; x = a
waitloop:           ; wait for Tx buffer to empty
    lda ACIA_STATUS
    and #$10        ; Tx register empty?
    beq waitloop    ; loop if !empty

    stx ACIA_DATA   ; Send data
    rts

.endproc
