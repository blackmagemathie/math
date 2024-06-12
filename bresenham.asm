namespace bresenham

circle:
    ; computes a full circle octant.
    ; ----------------
    ; $00 (2) -> radius, unsigned.
    ; $08 (3) -> octant data pointer.
    ; ----------------
    ; $02 (2) <- diagonal size.
    ; $04 (2) <- octant data size (excluding diagonal).
    ; $06 (2) <- (garbage)
    ; [$08]   <- octant data.
    ; ----------------
    !r = $00
    !x = $02
    !y = $04
    !m = $06
    !p = $08
    
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
        inx
        lda !m
        beq +
        bmi +
            txa
            sta [$08],y
            iny
            ldx #$0000
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
    txa
    sta [$08],y
    beq +
    iny
    +
    tya
    clc
    adc !x
    sec
    sbc !r
    beq +
    dey 
    lda [$08],y
    and #$00ff
    +
    sta !x
    sty !y
    plp
    rtl
    
namespace off