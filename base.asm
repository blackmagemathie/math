base_hex_dec_b_sa1:
    ; converts hex number (1 byte) to decimal number (3 bytes).
    ; uses sa1 arithmetic regs.
    ; ----------------
    ; $00 (1) -> hex number.
    ; ----------------
    ; $01 (3) <- decimal number.
    ; ----------------
    lda #$01
    sta $2250
    lda $00
    sta $2251
    stz $2252
    lda #100
    sta $2253
    stz $2254
    nop #3
    lda $2306
    sta $01
    lda $2308
    sta $02
    lda #$01
    sta $2250
    lda $02
    sta $2251
    stz $2252
    lda #10
    sta $2253
    stz $2254
    nop #3
    lda $2306
    sta $02
    lda $2308
    sta $03
    rtl