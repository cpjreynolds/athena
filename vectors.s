; ======[vectors.s]======
;
; Defines the interrupt vector table
;
;   FFFA-B = NMI
;   FFFC-D = RESET
;   FFFE-F = IRQ/BRK

.import     _init
.import     _nmi_int, _irq_int

.segment    "VECTORS"

.addr       _nmi_int
.addr       _init
.addr       _irq_int
