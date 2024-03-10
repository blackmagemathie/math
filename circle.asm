circle_y:
; returns radius*sin(angle).
; ----------------
; $04 (2) -> angle. (functionally $0000 to $01ff; 7 highest bits are ignored)
; $06 (1) -> radius. ($00 to $ff)
; ----------------
; $09 (2) -> y displacement.
; ----------------
    phx
    lda $05
    lsr
    ldx $04
    lda.l table_sincos,x
    stz $2250
    sta $2251
    stz $2252
    lda $06
    sta $2253
    stz $2254
    rep #$20
    lda $2307
    bcc +
    eor #$ffff
    inc
    +
    sta $09
    sep #$20
    plx
    rtl
    
circle_x:
; returns radius*cos(angle).
; ----------------
; $04 (2) -> angle. (functionally $0000 to $01ff; 7 highest bits are ignored
; $06 (1) -> radius. ($00 to $ff)
; ----------------
; $07 (2) -> x displacement.
; ----------------
    phx
    lda $04
    clc
    adc #$80
    tax
    lda $05
    adc #$00
    lsr
    lda.l table_sincos,x
    stz $2250
    sta $2251
    stz $2252
    lda $06
    sta $2253
    stz $2254
    rep #$20
    lda $2307
    bcc +
    eor #$ffff
    inc
    +
    sta $07
    sep #$20
    plx
    rtl