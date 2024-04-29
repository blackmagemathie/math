base_hex_dec_b_sa1:
    ; converts hex number (byte) to decimal number.
    ; uses sa1 arithmetic regs.
    ; ----------------
    ; A (1) -> hex number, unsigned.
    ; ----------------
    ; $00 (3) <- decimal number, little endian.
    ; ----------------
    php
    sep #$20
    
    sta $2251
    stz $2252
    lda #$01
    sta $2250
    lda.b #100
    sta $2253
    stz $2254
    nop #3
    lda $2306
    sta $02
    
    lda $2308
    sta $2251
    stz $2252
    lda #$01
    sta $2250
    lda.b #10
    sta $2253
    stz $2254
    nop #3
    lda $2306
    sta $01
    
    lda $2308
    sta $00
    
    plp
    rtl
    
base_hex_dec_w_sa1:
    ; converts hex number (word) to decimal number.
    ; uses sa1 arithmetic regs.
    ; ----------------
    ; A (2) -> hex number, unsigned.
    ; ----------------
    ; $00 (5) <- decimal number, little endian.
    ; ----------------
    phx
    phy
    php
    rep #$20
    sep #$10
    ldx #$01
    
    ror
    sta $2251
    stx $2250
    lda.w #5000
    sta $2253
    nop #3
    ldy $2306
    sty $04
    
    lda $2308
    rol
    sta $2251
    stx $2250
    lda.w #1000
    sta $2253
    nop #3
    ldy $2306
    sty $03
    
    lda $2308
    sta $2251
    stx $2250
    lda.w #100
    sta $2253
    nop #3
    ldy $2306
    sty $02
    
    lda $2308
    sta $2251
    stx $2250
    lda.w #10
    sta $2253
    nop #3
    ldy $2306
    sty $01
    
    ldy $2308
    sty $00
    
    plp
    ply
    plx
    rtl