namespace bresenham

circle:
    ; computes a full circle octant.
    ; ----------------
    ; $00 (2) -> radius, unsigned.
    ; ----------------
    ; $3700   <- octant data (ends with $00).
    ; X (2)   <- octant data size (excluding $00 at end).
    ; $02 (6) <- (garbage)
    ; ----------------
    !r = $00
    !x = $02
    !y = $04
    !m = $06
    
    php
    rep #$30
    
    ldy #$0000
    ldx #$0000
    lda !r
    beq .end
    sta !y
    asl #2
    eor #$ffff
    sec
    adc #$0005
    sta !m
    stz !x
    
    .loop:
        lda !x
        cmp !y
        bcs .end
        iny
        lda !m
        beq +
        bmi +
            tya
            sta $3700,x
            inx
            ldy #$0000
            dec !y
            lda !y
            asl #3
            eor #$ffff
            sec
            adc !m
            sta !m
        +
        inc !x
        lda !x
        asl #3
        clc
        adc #$0004
        clc
        adc !m
        sta !m
        bra .loop
    .end:
    
    ; plot last point,
    tya
    sta $3700,x
    ; then adjust x.
    beq +
    inx
    +
    
    plp
    rtl
    
    undef "r"
    undef "x"
    undef "y"
    undef "m"

namespace off