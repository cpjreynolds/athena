; ======[crt0.s]======
;
; Startup code for cc65 (athena version)

.export     _init, _exit
.import     _main

.export     __STARTUP__ : absolute = 1      ; mark as startup
.import     __RAM_START__, __RAM_SIZE__     ; linker generated

.import     copydata, zerobss, initlib, donelib

.include    "zeropage.inc"

; Place startup code in its segment
.segment    "STARTUP"

; 6502 cpu setup
_init:
    ldx #$ff
    txs
    cld

    lda #<(__RAM_START__ + __RAM_SIZE__)
    sta sp
    lda #>(__RAM_START__ + __RAM_SIZE__)
    sta sp+1

    jsr zerobss
    jsr copydata
    jsr initlib

    jsr _main

_exit:
    jsr donelib
    brk
