

.include "/sdcard/Pavan/CS,4,2018/code//m328Pdef.inc"

.def A = r16
.def B = r17
.def P = r18
.def Q = r19
.def C = r20
.def R = r21

.org 0x0000
    rjmp main

.org 0x002A
main:
    ; Initialize variables
    ldi A, 0
    ldi B, 0
    ldi P, 0
    ldi Q, 0
    ldi C, 0
    ldi R, 0
    
    ; Configure DDRB and DDRD registers
    ldi r22, 0b11110000
    out DDRB, r22
    ldi r22, 0b00001100
    out DDRD, r22

loop:
    ; Read PINB0
    ldi r22, 0b00000001
    in r23, PINB
    and r23, r22
    tst r23
    brne pinb0_high
    clr A
    rjmp pinb0_done
pinb0_high:
    ldi A, 1
pinb0_done:
    
    ; Read PINB1
    ldi r22, 0b00000010
    in r23, PINB
    and r23, r22
    tst r23
    brne pinb1_high
    clr B
    rjmp pinb1_done
pinb1_high:
    ldi B, 1
pinb1_done:

    ; Read PINB2
    ldi r22, 0b00000100
    in r23, PINB
    and r23, r22
    tst r23
    brne pinb2_high
    clr P
    rjmp pinb2_done
pinb2_high:
    ldi P, 1
pinb2_done:

    ; Read PINB3
    ldi r22, 0b00001000
    in r23, PINB
    and r23, r22
    tst r23
    brne pinb3_high
    clr Q
    rjmp pinb3_done
pinb3_high:
    ldi Q, 1
pinb3_done:

    ; Calculate C and R
    eor r22, A
    mov C, r22
    eor r22, P
    com r22
    mov R, r22
    eor r22, Q
    com r22
    eor r22, Q
    com r22
    eor r22, P
    com r22
    com r22
    eor R, r22

    ; Set PORTD
    mov r22,C 
    lsl r22
    mov r23, PORTD
    andi r23, 0b11110011
    or r22, r23
    out PORTD, r22

    ; Set PORTD
    mov r22,R 
    lsl r22
    mov r23, PORTD
    andi r23, 0b11110111
    or r22, r23
    out PORTD, r22

    ; Infinite loop
    rjmp loop
    
