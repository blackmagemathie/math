hypotenuse_b:
    ; returns hypotenuse of right triangle.
    ; ----------------
    ; $00 (2) -> segment 1 length, signed.
    ; $02 (2) ->         2
    ; ----------------
    ; $00 (4) <- (garbage)
    ; $04 (2) <- hypotenuse, clamped to $100.
    ; ----------------
    !mx = $00
    !my = $02
    !h  = $04
    
    php
    rep #$20
    .mx:
        lda !mx
        bpl +
        eor #$ffff
        +
        cmp #$0100
        bcs .exceed
        if !sa1
            stz $2250
            sta $2251
            sta $2253
            nop #3
            lda $2306
        else
            sep #$20
            sta $4202
            sta $4203
            nop #4
            rep #$20
            lda $4216
        endif
        sta !h
    .my:
        lda !my
        bpl +
        eor #$ffff
        +
        cmp #$0100
        bcs .exceed
        if !sa1
            stz $2250
            sta $2251
            sta $2253
            nop #3
            lda $2306
        else
            sep #$20
            sta $4202
            sta $4203
            nop #4
            rep #$20
            lda $4216
        endif
    .root:
        clc
        adc !h
        sta !mx
        jsl root_w
        lda !my
        bra .end
    .exceed:
        lda #$0100
    .end:
        sta !h
        plp
        rtl