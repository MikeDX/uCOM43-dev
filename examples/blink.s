; LED Blinker Example
; Toggles LEDs on port E with timer delays

    ORG 0x0000

main:
    ; Turn on LEDs (output 0xF to port E)
    LI 0xF              ; Load 15 (all bits set)
    LDZ 0xE             ; Set DPL to port E
    OP                  ; Output ACC to port[DPL]
    
    ; Delay using timer
    LI 0xFF             ; Load max delay value
    STM 0xFF            ; Start timer
delay_on:
    TTM                 ; Test timer flag
    JCP delay_on        ; Loop until timer expires
    
    ; Turn off LEDs (output 0x0 to port E)
    LI 0x0              ; Load 0 (all bits clear)
    LDZ 0xE             ; Set DPL to port E
    OP                  ; Output ACC to port[DPL]
    
    ; Delay using timer
    LI 0xFF             ; Load max delay value
    STM 0xFF            ; Start timer
delay_off:
    TTM                 ; Test timer flag
    JCP delay_off       ; Loop until timer expires
    
    ; Repeat forever
    JMP main 