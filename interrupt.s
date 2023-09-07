; ======[interrupt.s]======
;
; Interrupt handler
;
;   Checks for BRK and returns from all other interrupts

.import     _stop
.export     _irq_int, _nmi_int

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
    pla         ; restore A
    plx         ; restore X
    rti

; BRK detected
break:
    stp         ; something has gone wrong
