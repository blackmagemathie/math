root_w:
    ; returns square root.
    ; ----------------
    ; $00 (2) -> number, unsigned.
    ; ----------------
    ; $02 (2) <- square root, unsigned.
    ; ----------------
    ; $04 (2) <- (garbage)
    ; ----------------
    !n = $00
    !r = $02
    !b = $04
    
    php
    rep #$20
    stz !r
    
    .test_zero:
        lda !n
        beq .end
    .find_b:
        lda #$4000
        bra +
        -
        lsr #2
        +
        cmp !n
        bcs -
    .loop:
        sta !b
        -
        beq .end
        clc
        adc !r
        cmp !n
        beq .opt2
        bcc .opt2
    .opt1:
        lsr !r
        bra .common
    .opt2:
        eor #$ffff
        sec
        adc !n
        sta !n
        lda !r
        lsr
        clc
        adc !b
        sta !r
    .common:
        lda !b
        lsr #2
        sta !b
        bra .loop
    .end:
        plp
        rtl
    