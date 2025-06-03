; Counter Example
; Displays incrementing counter on port E

    ORG 0x0000

main:
    ; Initialize counter to 0
    LI 0x0              ; Start with 0
    LDZ 0x10            ; Set DP to RAM location 0x10
    S                   ; Store initial value in RAM
    
counter_loop:
    ; Load current counter value
    LDZ 0x10            ; Point to counter location
    LM 0                ; Load RAM[DP] to ACC
    
    ; Display counter on port E
    LDZ 0xE             ; Set DPL to port E
    OP                  ; Output current value
    
    ; Delay
    STM 0x80            ; Start timer with moderate delay
delay:
    TTM                 ; Test timer flag
    JCP delay           ; Loop until timer expires
    
    ; Increment counter
    LDZ 0x10            ; Point to counter location
    INM                 ; Increment RAM[DP], skip if zero
    JMP counter_loop    ; Continue counting
    
    ; Counter overflowed to 0, restart
    JMP counter_loop 