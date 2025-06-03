; Round-trip test disassembly
; Original ROM: astrowars.rom
; Test range: 0x0000 - 0x0801
; Size: 2049 bytes

    ORG 0x0000

; === LI INSTRUCTION ANALYSIS ===
; Found 22 LI instructions that skip following LI instructions
;   0x0006: skips 2 LI instructions, resumes at 0x0009
;   0x0007: skips 1 LI instructions, resumes at 0x0009
;   0x0017: skips 1 LI instructions, resumes at 0x0019
;   0x0027: skips 2 LI instructions, resumes at 0x002A
;   0x0028: skips 1 LI instructions, resumes at 0x002A
;   0x00DE: skips 1 LI instructions, resumes at 0x00E0
;   0x021C: skips 1 LI instructions, resumes at 0x021E
;   0x0235: skips 1 LI instructions, resumes at 0x0237
;   0x026F: skips 1 LI instructions, resumes at 0x0271
;   0x027E: skips 1 LI instructions, resumes at 0x0280
;   0x0293: skips 1 LI instructions, resumes at 0x0295
;   0x0347: skips 1 LI instructions, resumes at 0x0349
;   0x0386: skips 1 LI instructions, resumes at 0x0388
;   0x03AF: skips 1 LI instructions, resumes at 0x03B1
;   0x051D: skips 1 LI instructions, resumes at 0x051F
;   0x053F: skips 1 LI instructions, resumes at 0x0541
;   0x0574: skips 1 LI instructions, resumes at 0x0576
;   0x064B: skips 2 LI instructions, resumes at 0x064E
;   0x064C: skips 1 LI instructions, resumes at 0x064E
;   0x0650: skips 1 LI instructions, resumes at 0x0652
;   0x06BD: skips 1 LI instructions, resumes at 0x06BF
;   0x070A: skips 1 LI instructions, resumes at 0x070C

; JPA jump table at 0x0513 (page 0x0500):
;   Jump targets based on ACC value (ACC << 2 | page):
;   ACC=0→0x0500  ACC=1→0x0504  ACC=2→0x0508  ACC=3→0x050C  
;   ACC=4→0x0510  ACC=5→0x0514  ACC=6→0x0518  ACC=7→0x051C  
;   ACC=8→0x0520  ACC=9→0x0524  ACC=A→0x0528  ACC=B→0x052C  
;   ACC=C→0x0530  ACC=D→0x0534  ACC=E→0x0538  ACC=F→0x053C  
;   Targets within ROM: 16 of 16
; JPA jump table at 0x05F5 (page 0x05C0):
;   Jump targets based on ACC value (ACC << 2 | page):
;   ACC=0→0x05C0  ACC=1→0x05C4  ACC=2→0x05C8  ACC=3→0x05CC  
;   ACC=4→0x05D0  ACC=5→0x05D4  ACC=6→0x05D8  ACC=7→0x05DC  
;   ACC=8→0x05E0  ACC=9→0x05E4  ACC=A→0x05E8  ACC=B→0x05EC  
;   ACC=C→0x05F0  ACC=D→0x05F4  ACC=E→0x05F8  ACC=F→0x05FC  
;   Targets within ROM: 16 of 16
; JPA jump table at 0x05F7 (page 0x05C0):
;   Jump targets based on ACC value (ACC << 2 | page):
;   ACC=0→0x05C0  ACC=1→0x05C4  ACC=2→0x05C8  ACC=3→0x05CC  
;   ACC=4→0x05D0  ACC=5→0x05D4  ACC=6→0x05D8  ACC=7→0x05DC  
;   ACC=8→0x05E0  ACC=9→0x05E4  ACC=A→0x05E8  ACC=B→0x05EC  
;   ACC=C→0x05F0  ACC=D→0x05F4  ACC=E→0x05F8  ACC=F→0x05FC  
;   Targets within ROM: 16 of 16
; JPA jump table at 0x068B (page 0x0680):
;   Jump targets based on ACC value (ACC << 2 | page):
;   ACC=0→0x0680  ACC=1→0x0684  ACC=2→0x0688  ACC=3→0x068C  
;   ACC=4→0x0690  ACC=5→0x0694  ACC=6→0x0698  ACC=7→0x069C  
;   ACC=8→0x06A0  ACC=9→0x06A4  ACC=A→0x06A8  ACC=B→0x06AC  
;   ACC=C→0x06B0  ACC=D→0x06B4  ACC=E→0x06B8  ACC=F→0x06BC  
;   Targets within ROM: 16 of 16
; JPA jump table at 0x07ED (page 0x07C0):
;   Jump targets based on ACC value (ACC << 2 | page):
;   ACC=0→0x07C0  ACC=1→0x07C4  ACC=2→0x07C8  ACC=3→0x07CC  
;   ACC=4→0x07D0  ACC=5→0x07D4  ACC=6→0x07D8  ACC=7→0x07DC  
;   ACC=8→0x07E0  ACC=9→0x07E4  ACC=A→0x07E8  ACC=B→0x07EC  
;   ACC=C→0x07F0  ACC=D→0x07F4  ACC=E→0x07F8  ACC=F→0x07FC  
;   Targets within ROM: 16 of 16

L0000:
    STM 0x00             ; 0000: 14 80 ; Reset Timer F/F, Start Timer with 0x00 (63 ticks)
    JMP L0040            ; 0002: A0 40 ; Jump to absolute address 0x0040
L0004:
    STM 0x10             ; 0004: 14 90 ; Reset Timer F/F, Start Timer with 0x10 (1071 ticks)
    LI 0                 ; 0006: 90 ; Load ACC with 0x0, skip next 2 LI instructions, resume at 0x0009
L0007:
    LI 13                ; 0007: 9D ; Load ACC with 0xD, skip next LI instruction, resume at 0x0009
L0008:
    LI 1                 ; 0008: 91 ; Load ACC with 0x1
    JMP sub_01DA         ; 0009: A1 DA ; Jump to absolute address 0x01DA
    NOP                  ; 000B: 00 ; No Operation
L000C:
    LI 3                 ; 000C: 93 ; Load ACC with 0x3
    JMP sub_01DA         ; 000D: A1 DA ; Jump to absolute address 0x01DA
    NOP                  ; 000F: 00 ; No Operation
L0010:
    LI 7                 ; 0010: 97 ; Load ACC with 0x7
    JMP sub_01DA         ; 0011: A1 DA ; Jump to absolute address 0x01DA
    NOP                  ; 0013: 00 ; No Operation
L0014:
    JCP L0007            ; 0014: C7 ; Jump to address 0x0007 in current page (page 0x0000 + offset 0x07)
L0015:
    STM 0x10             ; 0015: 14 90 ; Reset Timer F/F, Start Timer with 0x10 (1071 ticks)
    LI 0                 ; 0017: 90 ; Load ACC with 0x0, skip next LI instruction, resume at 0x0019
L0018:
    LI 7                 ; 0018: 97 ; Load ACC with 0x7
    JCP L002A            ; 0019: EA ; Jump to address 0x002A in current page (page 0x0000 + offset 0x2A)
    NOP                  ; 001A: 00 ; No Operation
    NOP                  ; 001B: 00 ; No Operation
L001C:
    LDZ 0xF              ; 001C: 8F ; Load DP with 0x0F (DPH = 0, DPL = 0xF)
    LI 9                 ; 001D: 99 ; Load ACC with 0x9
    JMP sub_0700         ; 001E: A7 00 ; Jump to absolute address 0x0700
L0020:
    LI 0                 ; 0020: 90 ; Load ACC with 0x0
    XMD 0                ; 0021: 2C ; Exchange ACC with RAM[DP], decrement DPL, skip next if DPL underflows to 15 ;  [CONDITIONAL: skip next on carry (DPl==0xF) after decrement]
    JCP L0020            ; 0022: E0 ; Jump to address 0x0020 in current page (page 0x0000 + offset 0x20)
    RT                   ; 0023: 48 ; Return from subroutine
L0024:
    LDI 0x78             ; 0024: 15 78 ; Load DP with 0x78 (DPH = 0x7, DPL = 0x8)
    JCP L0020            ; 0026: E0 ; Jump to address 0x0020 in current page (page 0x0000 + offset 0x20)
L0027:
    LI 13                ; 0027: 9D ; Load ACC with 0xD, skip next 2 LI instructions, resume at 0x002A
L0028:
    LI 3                 ; 0028: 93 ; Load ACC with 0x3, skip next LI instruction, resume at 0x002A
    LI 1                 ; 0029: 91 ; Load ACC with 0x1
L002A:
    JMP sub_05BB         ; 002A: A5 BB ; Jump to absolute address 0x05BB
L002C:
    LM 0                 ; 002C: 38 ; Load ACC with RAM[DP] (ACC = RAM[DP])
    DEC                  ; 002D: 0F ; Decrement ACC (ACC = ACC - 1), skip next instruction if ACC underflows to 15 ;  [CONDITIONAL: skip next on carry (ACC==0xF)]
    S                    ; 002E: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
    RT                   ; 002F: 48 ; Return from subroutine
L0030:
    LI 0                 ; 0030: 90 ; Load ACC with 0x0
    XM 1                 ; 0031: 29 ; Exchange ACC with RAM[DP], XOR DPH with 0x1 (temp = ACC; ACC = RAM[DP]; RAM[DP] = temp; DPH ^= 0x1)
    LI 0                 ; 0032: 90 ; Load ACC with 0x0
    JCP L0035            ; 0033: F5 ; Jump to address 0x0035 in current page (page 0x0000 + offset 0x35)
L0034:
    JCP L003D            ; 0034: FD ; Jump to address 0x003D in current page (page 0x0000 + offset 0x3D)
L0035:
    XMD 1                ; 0035: 2D ; Exchange ACC with RAM[DP], XOR DPH with 0x1, decrement DPL, skip next if DPL underflows to 15 ;  [CONDITIONAL: skip next on carry (DPl==0xF) after decrement]
    JCP L0030            ; 0036: F0 ; Jump to address 0x0030 in current page (page 0x0000 + offset 0x30)
    RT                   ; 0037: 48 ; Return from subroutine
L0038:
    LDZ 0x5              ; 0038: 85 ; Load DP with 0x05 (DPH = 0, DPL = 0x5)
    JCP L003D            ; 0039: FD ; Jump to address 0x003D in current page (page 0x0000 + offset 0x3D)
    NOP                  ; 003A: 00 ; No Operation
    NOP                  ; 003B: 00 ; No Operation
L003C:
    LDZ 0x4              ; 003C: 84 ; Load DP with 0x04 (DPH = 0, DPL = 0x4)
L003D:
    CMA                  ; 003D: 10 ; Complement ACC
    JMP sub_0562         ; 003E: A5 62 ; Jump to absolute address 0x0562
L0040:
    LDI 0x7F             ; 0040: 15 7F ; Load DP with 0x7F (DPH = 0x7, DPL = 0xF)
    CAL L00FA            ; 0042: A8 FA ; Call subroutine at absolute address 0x00FA (push return address to stack)
    LDZ 0xF              ; 0044: 8F ; Load DP with 0x0F (DPH = 0, DPL = 0xF)
    CZP L0030            ; 0045: BC ; Call subroutine at zero page address 0x0030 (page 12 << 2)
    LM 2                 ; 0046: 3A ; Load ACC with RAM[DP], XOR DPH with 0x2 (ACC = RAM[DP]; DPH ^= 0x2)
    CZP L0030            ; 0047: BC ; Call subroutine at zero page address 0x0030 (page 12 << 2)
    CAL sub_061C         ; 0048: AE 1C ; Call subroutine at absolute address 0x061C (push return address to stack)
    CAL sub_061C         ; 004A: AE 1C ; Call subroutine at absolute address 0x061C (push return address to stack)
    NOP                  ; 004C: 00 ; No Operation
    NOP                  ; 004D: 00 ; No Operation
L004E:
    LDZ 0x3              ; 004E: 83 ; Load DP with 0x03 (DPH = 0, DPL = 0x3)
L004F:
    LI 14                ; 004F: 9E ; Load ACC with 0xE
    XMD 0                ; 0050: 2C ; Exchange ACC with RAM[DP], decrement DPL, skip next if DPL underflows to 15 ;  [CONDITIONAL: skip next on carry (DPl==0xF) after decrement]
    JCP L004F            ; 0051: CF ; Jump to address 0x004F in current page (page 0x0040 + offset 0x0F)
    LDZ 0xD              ; 0052: 8D ; Load DP with 0x0D (DPH = 0, DPL = 0xD)
    LM 0                 ; 0053: 38 ; Load ACC with RAM[DP] (ACC = RAM[DP])
    LDZ 0x2              ; 0054: 82 ; Load DP with 0x02 (DPH = 0, DPL = 0x2)
    S                    ; 0055: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
    INM                  ; 0056: 1D ; Increment RAM[DP] (RAM[DP] = RAM[DP] + 1), skip next if RAM[DP] overflows to 0 ;  [CONDITIONAL: skip next on carry (RAM==0)]
L0057:
    LDZ 0xA              ; 0057: 8A ; Load DP with 0x0A (DPH = 0, DPL = 0xA)
    LI 0                 ; 0058: 90 ; Load ACC with 0x0
    CM                   ; 0059: 0C ; Compare ACC with RAM[DP], skip next instruction if ACC == RAM[DP] ;  [CONDITIONAL: skip next on ACC equals RAM]
    JMP sub_04AC         ; 005A: A4 AC ; Jump to absolute address 0x04AC
    LDZ 0xF              ; 005C: 8F ; Load DP with 0x0F (DPH = 0, DPL = 0xF)
    CM                   ; 005D: 0C ; Compare ACC with RAM[DP], skip next instruction if ACC == RAM[DP] ;  [CONDITIONAL: skip next on ACC equals RAM]
    JMP L00A4            ; 005E: A0 A4 ; Jump to absolute address 0x00A4
    RFB 1                ; 0060: 6D ; Reset bit 1 of FLAG register (FLAG &= ~0x2)
    LDI 0x13             ; 0061: 15 13 ; Load DP with 0x13 (DPH = 0x1, DPL = 0x3)
    CZP L0020            ; 0063: B8 ; Call subroutine at zero page address 0x0020 (page 8 << 2)
    LDI 0x39             ; 0064: 15 39 ; Load DP with 0x39 (DPH = 0x3, DPL = 0x9)
    TMB 0                ; 0066: 58 ; Skip next instruction if RAM[DP] bit 0 is set (RAM[DP] & 0x1 != 0) ;  [CONDITIONAL: skip next on bit 0 of RAM]
    JCP L007D            ; 0067: FD ; Jump to address 0x007D in current page (page 0x0040 + offset 0x3D)
    LDI 0x2E             ; 0068: 15 2E ; Load DP with 0x2E (DPH = 0x2, DPL = 0xE)
    CM                   ; 006A: 0C ; Compare ACC with RAM[DP], skip next instruction if ACC == RAM[DP] ;  [CONDITIONAL: skip next on ACC equals RAM]
    JCP L0079            ; 006B: F9 ; Jump to address 0x0079 in current page (page 0x0040 + offset 0x39)
    LI 7                 ; 006C: 97 ; Load ACC with 0x7
    XM 3                 ; 006D: 2B ; Exchange ACC with RAM[DP], XOR DPH with 0x3 (temp = ACC; ACC = RAM[DP]; RAM[DP] = temp; DPH ^= 0x3)
    LI 4                 ; 006E: 94 ; Load ACC with 0x4
    S                    ; 006F: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
    LDI 0x40             ; 0070: 15 40 ; Load DP with 0x40 (DPH = 0x4, DPL = 0x0)
    LM 0                 ; 0072: 38 ; Load ACC with RAM[DP] (ACC = RAM[DP])
    AD                   ; 0073: 08 ; Add RAM[DP] to ACC, skip next instruction if carry (ACC + RAM[DP] > 15) ;  [CONDITIONAL: skip next on carry]
    NOP                  ; 0074: 00 ; No Operation
    S                    ; 0075: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
    DEC                  ; 0076: 0F ; Decrement ACC (ACC = ACC - 1), skip next instruction if ACC underflows to 15 ;  [CONDITIONAL: skip next on carry (ACC==0xF)]
    JCP L0079            ; 0077: F9 ; Jump to address 0x0079 in current page (page 0x0040 + offset 0x39)
    SMB 0                ; 0078: 78 ; Set bit 0 of RAM[DP] (RAM[DP] |= 0x1)
L0079:
    LDI 0x2A             ; 0079: 15 2A ; Load DP with 0x2A (DPH = 0x2, DPL = 0xA)
    LI 14                ; 007B: 9E ; Load ACC with 0xE
    S                    ; 007C: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
L007D:
    LDZ 0x1              ; 007D: 81 ; Load DP with 0x01 (DPH = 0, DPL = 0x1)
    CAL sub_056C         ; 007E: AD 6C ; Call subroutine at absolute address 0x056C (push return address to stack)
    TMB 3                ; 0080: 5B ; Skip next instruction if RAM[DP] bit 3 is set (RAM[DP] & 0x8 != 0) ;  [CONDITIONAL: skip next on bit 3 of RAM]
    JCP L008A            ; 0081: CA ; Jump to address 0x008A in current page (page 0x0080 + offset 0x0A)
    RMB 3                ; 0082: 6B ; Reset bit 3 of RAM[DP] (RAM[DP] &= ~0x8)
    LDZ 0xD              ; 0083: 8D ; Load DP with 0x0D (DPH = 0, DPL = 0xD)
    INM                  ; 0084: 1D ; Increment RAM[DP] (RAM[DP] = RAM[DP] + 1), skip next if RAM[DP] overflows to 0 ;  [CONDITIONAL: skip next on carry (RAM==0)]
    RMB 2                ; 0085: 6A ; Reset bit 2 of RAM[DP] (RAM[DP] &= ~0x4)
    LDZ 0x5              ; 0086: 85 ; Load DP with 0x05 (DPH = 0, DPL = 0x5)
    CZP L000C            ; 0087: B3 ; Call subroutine at zero page address 0x000C (page 3 << 2)
    JMP L004E            ; 0088: A0 4E ; Jump to absolute address 0x004E
L008A:
    LDZ 0x1              ; 008A: 81 ; Load DP with 0x01 (DPH = 0, DPL = 0x1)
    TPB 1                ; 008B: 51 ; Skip next instruction if input port[DPl] bit 1 is set (port[DPl] & 0x2 != 0) ;  [CONDITIONAL: skip next on bit 1 of input port (DPl)]
    JMP sub_020C         ; 008C: A2 0C ; Jump to absolute address 0x020C
    LDZ 0x2              ; 008E: 82 ; Load DP with 0x02 (DPH = 0, DPL = 0x2)
    CZP L0008            ; 008F: B2 ; Call subroutine at zero page address 0x0008 (page 2 << 2)
    LI 4                 ; 0090: 94 ; Load ACC with 0x4
    LDI 0x1B             ; 0091: 15 1B ; Load DP with 0x1B (DPH = 0x1, DPL = 0xB)
    S                    ; 0093: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
    LM 3                 ; 0094: 3B ; Load ACC with RAM[DP], XOR DPH with 0x3 (ACC = RAM[DP]; DPH ^= 0x3)
    CZP L0030            ; 0095: BC ; Call subroutine at zero page address 0x0030 (page 12 << 2)
L0096:
    CZP L0018            ; 0096: B6 ; Call subroutine at zero page address 0x0018 (page 6 << 2)
    RFB 1                ; 0097: 6D ; Reset bit 1 of FLAG register (FLAG &= ~0x2)
    CAL sub_0723         ; 0098: AF 23 ; Call subroutine at absolute address 0x0723 (push return address to stack)
    LDZ 0xB              ; 009A: 8B ; Load DP with 0x0B (DPH = 0, DPL = 0xB)
    LI 15                ; 009B: 9F ; Load ACC with 0xF
    XMI 2                ; 009C: 3E ; Exchange ACC with RAM[DP], XOR DPH with 0x2, increment DPL, skip next if DPL overflows to 0 ;  [CONDITIONAL: skip next on carry (DPl==0) after increment]
    LI 1                 ; 009D: 91 ; Load ACC with 0x1
    XM 3                 ; 009E: 2B ; Exchange ACC with RAM[DP], XOR DPH with 0x3 (temp = ACC; ACC = RAM[DP]; RAM[DP] = temp; DPH ^= 0x3)
    LI 4                 ; 009F: 94 ; Load ACC with 0x4
    S                    ; 00A0: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
    LDZ 0xF              ; 00A1: 8F ; Load DP with 0x0F (DPH = 0, DPL = 0xF)
    LI 1                 ; 00A2: 91 ; Load ACC with 0x1
    S                    ; 00A3: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
L00A4:
    LI 1                 ; 00A4: 91 ; Load ACC with 0x1
    CM                   ; 00A5: 0C ; Compare ACC with RAM[DP], skip next instruction if ACC == RAM[DP] ;  [CONDITIONAL: skip next on ACC equals RAM]
    JMP L00C3            ; 00A6: A0 C3 ; Jump to absolute address 0x00C3
    LDI 0x1B             ; 00A8: 15 1B ; Load DP with 0x1B (DPH = 0x1, DPL = 0xB)
    LM 0                 ; 00AA: 38 ; Load ACC with RAM[DP] (ACC = RAM[DP])
    INC                  ; 00AB: 0D ; Increment ACC (ACC = ACC + 1), skip next instruction if ACC overflows to 0 ;  [CONDITIONAL: skip next on carry (ACC==0)]
    LDZ 0x3              ; 00AC: 83 ; Load DP with 0x03 (DPH = 0, DPL = 0x3)
    XMD 0                ; 00AD: 2C ; Exchange ACC with RAM[DP], decrement DPL, skip next if DPL underflows to 15 ;  [CONDITIONAL: skip next on carry (DPl==0xF) after decrement]
L00AE:
    LI 14                ; 00AE: 9E ; Load ACC with 0xE
    XMD 0                ; 00AF: 2C ; Exchange ACC with RAM[DP], decrement DPL, skip next if DPL underflows to 15 ;  [CONDITIONAL: skip next on carry (DPl==0xF) after decrement]
    JCP L00AE            ; 00B0: EE ; Jump to address 0x00AE in current page (page 0x0080 + offset 0x2E)
    LDZ 0xB              ; 00B1: 8B ; Load DP with 0x0B (DPH = 0, DPL = 0xB)
    LI 0                 ; 00B2: 90 ; Load ACC with 0x0
    CM                   ; 00B3: 0C ; Compare ACC with RAM[DP], skip next instruction if ACC == RAM[DP] ;  [CONDITIONAL: skip next on ACC equals RAM]
    JMP sub_03B5         ; 00B4: A3 B5 ; Jump to absolute address 0x03B5
    LDZ 0x8              ; 00B6: 88 ; Load DP with 0x08 (DPH = 0, DPL = 0x8)
    LI 10                ; 00B7: 9A ; Load ACC with 0xA
    S                    ; 00B8: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
    LDZ 0xF              ; 00B9: 8F ; Load DP with 0x0F (DPH = 0, DPL = 0xF)
    INM                  ; 00BA: 1D ; Increment RAM[DP] (RAM[DP] = RAM[DP] + 1), skip next if RAM[DP] overflows to 0 ;  [CONDITIONAL: skip next on carry (RAM==0)]
L00BB:
    CAL sub_061C         ; 00BB: AE 1C ; Call subroutine at absolute address 0x061C (push return address to stack)
    CAL sub_01FA         ; 00BD: A9 FA ; Call subroutine at absolute address 0x01FA (push return address to stack)
    CAL sub_0723         ; 00BF: AF 23 ; Call subroutine at absolute address 0x0723 (push return address to stack)
    JMP L0057            ; 00C1: A0 57 ; Jump to absolute address 0x0057
L00C3:
    LDZ 0x0              ; 00C3: 80 ; Load DP with 0x00 (DPH = 0, DPL = 0x0)
    CAL sub_056C         ; 00C4: AD 6C ; Call subroutine at absolute address 0x056C (push return address to stack)
    LDZ 0xF              ; 00C6: 8F ; Load DP with 0x0F (DPH = 0, DPL = 0xF)
    LI 2                 ; 00C7: 92 ; Load ACC with 0x2
    CM                   ; 00C8: 0C ; Compare ACC with RAM[DP], skip next instruction if ACC == RAM[DP] ;  [CONDITIONAL: skip next on ACC equals RAM]
    JCP L00F0            ; 00C9: F0 ; Jump to address 0x00F0 in current page (page 0x00C0 + offset 0x30)
    LDI 0x39             ; 00CA: 15 39 ; Load DP with 0x39 (DPH = 0x3, DPL = 0x9)
    TMB 0                ; 00CC: 58 ; Skip next instruction if RAM[DP] bit 0 is set (RAM[DP] & 0x1 != 0) ;  [CONDITIONAL: skip next on bit 0 of RAM]
    JMP sub_0225         ; 00CD: A2 25 ; Jump to absolute address 0x0225
    LDI 0x2A             ; 00CF: 15 2A ; Load DP with 0x2A (DPH = 0x2, DPL = 0xA)
    LI 14                ; 00D1: 9E ; Load ACC with 0xE
    S                    ; 00D2: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
    LDZ 0xF              ; 00D3: 8F ; Load DP with 0x0F (DPH = 0, DPL = 0xF)
    INM                  ; 00D4: 1D ; Increment RAM[DP] (RAM[DP] = RAM[DP] + 1), skip next if RAM[DP] overflows to 0 ;  [CONDITIONAL: skip next on carry (RAM==0)]
    INM                  ; 00D5: 1D ; Increment RAM[DP] (RAM[DP] = RAM[DP] + 1), skip next if RAM[DP] overflows to 0 ;  [CONDITIONAL: skip next on carry (RAM==0)]
L00D6:
    LDI 0x4B             ; 00D6: 15 4B ; Load DP with 0x4B (DPH = 0x4, DPL = 0xB)
    LI 0                 ; 00D8: 90 ; Load ACC with 0x0
    CM                   ; 00D9: 0C ; Compare ACC with RAM[DP], skip next instruction if ACC == RAM[DP] ;  [CONDITIONAL: skip next on ACC equals RAM]
    JCP L00EE            ; 00DA: EE ; Jump to address 0x00EE in current page (page 0x00C0 + offset 0x2E)
    LDI 0x14             ; 00DB: 15 14 ; Load DP with 0x14 (DPH = 0x1, DPL = 0x4)
    TMB 1                ; 00DD: 59 ; Skip next instruction if RAM[DP] bit 1 is set (RAM[DP] & 0x2 != 0) ;  [CONDITIONAL: skip next on bit 1 of RAM]
    LI 1                 ; 00DE: 91 ; Load ACC with 0x1, skip next LI instruction, resume at 0x00E0
    LI 2                 ; 00DF: 92 ; Load ACC with 0x2
    LDZ 0xF              ; 00E0: 8F ; Load DP with 0x0F (DPH = 0, DPL = 0xF)
    TMB 0                ; 00E1: 58 ; Skip next instruction if RAM[DP] bit 0 is set (RAM[DP] & 0x1 != 0) ;  [CONDITIONAL: skip next on bit 0 of RAM]
    JCP L00E4            ; 00E2: E4 ; Jump to address 0x00E4 in current page (page 0x00C0 + offset 0x24)
    LI 4                 ; 00E3: 94 ; Load ACC with 0x4
L00E4:
    TAW                  ; 00E4: 43 ; Transfer ACC to W
    SFB 0                ; 00E5: 7C ; Set bit 0 of FLAG register (FLAG |= 0x1)
    CAL sub_0584         ; 00E6: AD 84 ; Call subroutine at absolute address 0x0584 (push return address to stack)
    RFB 0                ; 00E8: 6C ; Reset bit 0 of FLAG register (FLAG &= ~0x1)
    LDZ 0xD              ; 00E9: 8D ; Load DP with 0x0D (DPH = 0, DPL = 0xD)
    TMB 1                ; 00EA: 59 ; Skip next instruction if RAM[DP] bit 1 is set (RAM[DP] & 0x2 != 0) ;  [CONDITIONAL: skip next on bit 1 of RAM]
    JCP L00EE            ; 00EB: EE ; Jump to address 0x00EE in current page (page 0x00C0 + offset 0x2E)
    CAL sub_0584         ; 00EC: AD 84 ; Call subroutine at absolute address 0x0584 (push return address to stack)
L00EE:
    JMP sub_020C         ; 00EE: A2 0C ; Jump to absolute address 0x020C
L00F0:
    LDZ 0x8              ; 00F0: 88 ; Load DP with 0x08 (DPH = 0, DPL = 0x8)
    LI 2                 ; 00F1: 92 ; Load ACC with 0x2
    CM                   ; 00F2: 0C ; Compare ACC with RAM[DP], skip next instruction if ACC == RAM[DP] ;  [CONDITIONAL: skip next on ACC equals RAM]
    JCP L00F5            ; 00F3: F5 ; Jump to address 0x00F5 in current page (page 0x00C0 + offset 0x35)
    SFB 1                ; 00F4: 7D ; Set bit 1 of FLAG register (FLAG |= 0x2)
L00F5:
    LI 0                 ; 00F5: 90 ; Load ACC with 0x0
    CM                   ; 00F6: 0C ; Compare ACC with RAM[DP], skip next instruction if ACC == RAM[DP] ;  [CONDITIONAL: skip next on ACC equals RAM]
    JCP L00D6            ; 00F7: D6 ; Jump to address 0x00D6 in current page (page 0x00C0 + offset 0x16)
    JMP sub_0100         ; 00F8: A1 00 ; Jump to absolute address 0x0100
L00FA:
    LI 0                 ; 00FA: 90 ; Load ACC with 0x0
    XM 3                 ; 00FB: 2B ; Exchange ACC with RAM[DP], XOR DPH with 0x3 (temp = ACC; ACC = RAM[DP]; RAM[DP] = temp; DPH ^= 0x3)
    LI 0                 ; 00FC: 90 ; Load ACC with 0x0
    XMD 3                ; 00FD: 2F ; Exchange ACC with RAM[DP], XOR DPH with 0x3, decrement DPL, skip next if DPL underflows to 15 ;  [CONDITIONAL: skip next on carry (DPl==0xF) after decrement]
    JCP L00FA            ; 00FE: FA ; Jump to address 0x00FA in current page (page 0x00C0 + offset 0x3A)
    RT                   ; 00FF: 48 ; Return from subroutine
sub_0100:
    LDZ 0xF              ; 0100: 8F ; Load DP with 0x0F (DPH = 0, DPL = 0xF)
    LI 4                 ; 0101: 94 ; Load ACC with 0x4
    CM                   ; 0102: 0C ; Compare ACC with RAM[DP], skip next instruction if ACC == RAM[DP] ;  [CONDITIONAL: skip next on ACC equals RAM]
    JCP sub_0108         ; 0103: C8 ; Jump to address 0x0108 in current page (page 0x0100 + offset 0x08)
    LDZ 0x8              ; 0104: 88 ; Load DP with 0x08 (DPH = 0, DPL = 0x8)
    LI 10                ; 0105: 9A ; Load ACC with 0xA
    S                    ; 0106: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
    JCP sub_010B         ; 0107: CB ; Jump to address 0x010B in current page (page 0x0100 + offset 0x0B)
sub_0108:
    LI 5                 ; 0108: 95 ; Load ACC with 0x5
    CM                   ; 0109: 0C ; Compare ACC with RAM[DP], skip next instruction if ACC == RAM[DP] ;  [CONDITIONAL: skip next on ACC equals RAM]
    JCP sub_0113         ; 010A: D3 ; Jump to address 0x0113 in current page (page 0x0100 + offset 0x13)
sub_010B:
    CAL sub_0768         ; 010B: AF 68 ; Call subroutine at absolute address 0x0768 (push return address to stack)
    LDZ 0xF              ; 010D: 8F ; Load DP with 0x0F (DPH = 0, DPL = 0xF)
    INM                  ; 010E: 1D ; Increment RAM[DP] (RAM[DP] = RAM[DP] + 1), skip next if RAM[DP] overflows to 0 ;  [CONDITIONAL: skip next on carry (RAM==0)]
    CAL sub_0723         ; 010F: AF 23 ; Call subroutine at absolute address 0x0723 (push return address to stack)
    JMP sub_020C         ; 0111: A2 0C ; Jump to absolute address 0x020C
sub_0113:
    LI 6                 ; 0113: 96 ; Load ACC with 0x6
    CM                   ; 0114: 0C ; Compare ACC with RAM[DP], skip next instruction if ACC == RAM[DP] ;  [CONDITIONAL: skip next on ACC equals RAM]
    JCP sub_013F         ; 0115: FF ; Jump to address 0x013F in current page (page 0x0100 + offset 0x3F)
    LDI 0x2A             ; 0116: 15 2A ; Load DP with 0x2A (DPH = 0x2, DPL = 0xA)
    LM 1                 ; 0118: 39 ; Load ACC with RAM[DP], XOR DPH with 0x1 (ACC = RAM[DP]; DPH ^= 0x1)
    AD                   ; 0119: 08 ; Add RAM[DP] to ACC, skip next instruction if carry (ACC + RAM[DP] > 15) ;  [CONDITIONAL: skip next on carry]
    DEC                  ; 011A: 0F ; Decrement ACC (ACC = ACC - 1), skip next instruction if ACC underflows to 15 ;  [CONDITIONAL: skip next on carry (ACC==0xF)]
    JMP sub_0225         ; 011B: A2 25 ; Jump to absolute address 0x0225
    CZP L0018            ; 011D: B6 ; Call subroutine at zero page address 0x0018 (page 6 << 2)
    LDZ 0x7              ; 011E: 87 ; Load DP with 0x07 (DPH = 0, DPL = 0x7)
    CZP L000C            ; 011F: B3 ; Call subroutine at zero page address 0x000C (page 3 << 2)
    LDZ 0xA              ; 0120: 8A ; Load DP with 0x0A (DPH = 0, DPL = 0xA)
    CZP L000C            ; 0121: B3 ; Call subroutine at zero page address 0x000C (page 3 << 2)
    LDZ 0xF              ; 0122: 8F ; Load DP with 0x0F (DPH = 0, DPL = 0xF)
    CZP L000C            ; 0123: B3 ; Call subroutine at zero page address 0x000C (page 3 << 2)
    CAL L0015            ; 0124: A8 15 ; Call subroutine at absolute address 0x0015 (push return address to stack)
    CZP L0010            ; 0126: B4 ; Call subroutine at zero page address 0x0010 (page 4 << 2)
    LDZ 0xA              ; 0127: 8A ; Load DP with 0x0A (DPH = 0, DPL = 0xA)
    CZP L000C            ; 0128: B3 ; Call subroutine at zero page address 0x000C (page 3 << 2)
    LDZ 0x7              ; 0129: 87 ; Load DP with 0x07 (DPH = 0, DPL = 0x7)
    CZP L000C            ; 012A: B3 ; Call subroutine at zero page address 0x000C (page 3 << 2)
    LDZ 0xA              ; 012B: 8A ; Load DP with 0x0A (DPH = 0, DPL = 0xA)
    CZP L000C            ; 012C: B3 ; Call subroutine at zero page address 0x000C (page 3 << 2)
    LDZ 0x5              ; 012D: 85 ; Load DP with 0x05 (DPH = 0, DPL = 0x5)
    CZP L000C            ; 012E: B3 ; Call subroutine at zero page address 0x000C (page 3 << 2)
    LDZ 0x9              ; 012F: 89 ; Load DP with 0x09 (DPH = 0, DPL = 0x9)
    CZP L000C            ; 0130: B3 ; Call subroutine at zero page address 0x000C (page 3 << 2)
    CAL sub_07B9         ; 0131: AF B9 ; Call subroutine at absolute address 0x07B9 (push return address to stack)
    CZP L0018            ; 0133: B6 ; Call subroutine at zero page address 0x0018 (page 6 << 2)
    NOP                  ; 0134: 00 ; No Operation
    NOP                  ; 0135: 00 ; No Operation
    NOP                  ; 0136: 00 ; No Operation
    NOP                  ; 0137: 00 ; No Operation
    CAL sub_01FA         ; 0138: A9 FA ; Call subroutine at absolute address 0x01FA (push return address to stack)
    CAL sub_0579         ; 013A: AD 79 ; Call subroutine at absolute address 0x0579 (push return address to stack)
    CZP L0030            ; 013C: BC ; Call subroutine at zero page address 0x0030 (page 12 << 2)
    LDZ 0xF              ; 013D: 8F ; Load DP with 0x0F (DPH = 0, DPL = 0xF)
    INM                  ; 013E: 1D ; Increment RAM[DP] (RAM[DP] = RAM[DP] + 1), skip next if RAM[DP] overflows to 0 ;  [CONDITIONAL: skip next on carry (RAM==0)]
sub_013F:
    LI 7                 ; 013F: 97 ; Load ACC with 0x7
    CM                   ; 0140: 0C ; Compare ACC with RAM[DP], skip next instruction if ACC == RAM[DP] ;  [CONDITIONAL: skip next on ACC equals RAM]
    JCP sub_016B         ; 0141: EB ; Jump to address 0x016B in current page (page 0x0140 + offset 0x2B)
    CAL sub_0730         ; 0142: AF 30 ; Call subroutine at absolute address 0x0730 (push return address to stack)
    CAL sub_06DF         ; 0144: AE DF ; Call subroutine at absolute address 0x06DF (push return address to stack)
    JCP sub_0168         ; 0146: E8 ; Jump to address 0x0168 in current page (page 0x0140 + offset 0x28)
    LI 7                 ; 0147: 97 ; Load ACC with 0x7
    S                    ; 0148: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
    CAL sub_01FA         ; 0149: A9 FA ; Call subroutine at absolute address 0x01FA (push return address to stack)
    LDI 0x2C             ; 014B: 15 2C ; Load DP with 0x2C (DPH = 0x2, DPL = 0xC)
    LI 6                 ; 014D: 96 ; Load ACC with 0x6
    CM                   ; 014E: 0C ; Compare ACC with RAM[DP], skip next instruction if ACC == RAM[DP] ;  [CONDITIONAL: skip next on ACC equals RAM]
    JCP sub_0165         ; 014F: E5 ; Jump to address 0x0165 in current page (page 0x0140 + offset 0x25)
    DED                  ; 0150: 13 ; Decrement DPL (DPL = DPL - 1), skip next instruction if DPL underflows to 15 ;  [CONDITIONAL: skip next on carry (DPl==0xF)]
    LI 15                ; 0151: 9F ; Load ACC with 0xF
    XMI 3                ; 0152: 3F ; Exchange ACC with RAM[DP], XOR DPH with 0x3, increment DPL, skip next if DPL overflows to 0 ;  [CONDITIONAL: skip next on carry (DPl==0) after increment]
    LM 0                 ; 0153: 38 ; Load ACC with RAM[DP] (ACC = RAM[DP])
    LDI 0x44             ; 0154: 15 44 ; Load DP with 0x44 (DPH = 0x4, DPL = 0x4)
    S                    ; 0156: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
    LDI 0x14             ; 0157: 15 14 ; Load DP with 0x14 (DPH = 0x1, DPL = 0x4)
    LM 0                 ; 0159: 38 ; Load ACC with RAM[DP] (ACC = RAM[DP])
    LDI 0x4F             ; 015A: 15 4F ; Load DP with 0x4F (DPH = 0x4, DPL = 0xF)
    S                    ; 015C: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
    CAL sub_01FA         ; 015D: A9 FA ; Call subroutine at absolute address 0x01FA (push return address to stack)
    LDZ 0x3              ; 015F: 83 ; Load DP with 0x03 (DPH = 0, DPL = 0x3)
    CZP L0020            ; 0160: B8 ; Call subroutine at zero page address 0x0020 (page 8 << 2)
    LDZ 0x0              ; 0161: 80 ; Load DP with 0x00 (DPH = 0, DPL = 0x0)
    SMB 0                ; 0162: 78 ; Set bit 0 of RAM[DP] (RAM[DP] |= 0x1)
    RFB 3                ; 0163: 6F ; Reset bit 3 of FLAG register (FLAG &= ~0x8)
    LDZ 0xF              ; 0164: 8F ; Load DP with 0x0F (DPH = 0, DPL = 0xF)
sub_0165:
    INM                  ; 0165: 1D ; Increment RAM[DP] (RAM[DP] = RAM[DP] + 1), skip next if RAM[DP] overflows to 0 ;  [CONDITIONAL: skip next on carry (RAM==0)]
sub_0166:
    JMP sub_03B5         ; 0166: A3 B5 ; Jump to absolute address 0x03B5
sub_0168:
    TMB 3                ; 0168: 5B ; Skip next instruction if RAM[DP] bit 3 is set (RAM[DP] & 0x8 != 0) ;  [CONDITIONAL: skip next on bit 3 of RAM]
    SFB 3                ; 0169: 7F ; Set bit 3 of FLAG register (FLAG |= 0x8)
    JCP sub_0166         ; 016A: E6 ; Jump to address 0x0166 in current page (page 0x0140 + offset 0x26)
sub_016B:
    LI 8                 ; 016B: 98 ; Load ACC with 0x8
    CM                   ; 016C: 0C ; Compare ACC with RAM[DP], skip next instruction if ACC == RAM[DP] ;  [CONDITIONAL: skip next on ACC equals RAM]
    JMP sub_0200         ; 016D: A2 00 ; Jump to absolute address 0x0200
    LDZ 0x3              ; 016F: 83 ; Load DP with 0x03 (DPH = 0, DPL = 0x3)
sub_0170:
    LM 0                 ; 0170: 38 ; Load ACC with RAM[DP] (ACC = RAM[DP])
    DEC                  ; 0171: 0F ; Decrement ACC (ACC = ACC - 1), skip next instruction if ACC underflows to 15 ;  [CONDITIONAL: skip next on carry (ACC==0xF)]
    JCP sub_017E         ; 0172: FE ; Jump to address 0x017E in current page (page 0x0140 + offset 0x3E)
    LI 9                 ; 0173: 99 ; Load ACC with 0x9
    XMD 0                ; 0174: 2C ; Exchange ACC with RAM[DP], decrement DPL, skip next if DPL underflows to 15 ;  [CONDITIONAL: skip next on carry (DPl==0xF) after decrement]
    JCP sub_0170         ; 0175: F0 ; Jump to address 0x0170 in current page (page 0x0140 + offset 0x30)
sub_0176:
    LDZ 0xE              ; 0176: 8E ; Load DP with 0x0E (DPH = 0, DPL = 0xE)
    CZP L0014            ; 0177: B5 ; Call subroutine at zero page address 0x0014 (page 5 << 2)
    CZP L0028            ; 0178: BA ; Call subroutine at zero page address 0x0028 (page 10 << 2)
    CZP L0014            ; 0179: B5 ; Call subroutine at zero page address 0x0014 (page 5 << 2)
    LDZ 0x3              ; 017A: 83 ; Load DP with 0x03 (DPH = 0, DPL = 0x3)
    CZP L0020            ; 017B: B8 ; Call subroutine at zero page address 0x0020 (page 8 << 2)
    JMP sub_01C5         ; 017C: A1 C5 ; Jump to absolute address 0x01C5
sub_017E:
    S                    ; 017E: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
    LDZ 0xE              ; 017F: 8E ; Load DP with 0x0E (DPH = 0, DPL = 0xE)
    TMB 3                ; 0180: 5B ; Skip next instruction if RAM[DP] bit 3 is set (RAM[DP] & 0x8 != 0) ;  [CONDITIONAL: skip next on bit 3 of RAM]
    JCP sub_019B         ; 0181: DB ; Jump to address 0x019B in current page (page 0x0180 + offset 0x1B)
    CAL sub_0730         ; 0182: AF 30 ; Call subroutine at absolute address 0x0730 (push return address to stack)
    LDZ 0xB              ; 0184: 8B ; Load DP with 0x0B (DPH = 0, DPL = 0xB)
    LI 0                 ; 0185: 90 ; Load ACC with 0x0
    CM                   ; 0186: 0C ; Compare ACC with RAM[DP], skip next instruction if ACC == RAM[DP] ;  [CONDITIONAL: skip next on ACC equals RAM]
    JCP sub_01A2         ; 0187: E2 ; Jump to address 0x01A2 in current page (page 0x0180 + offset 0x22)
    FBT 3                ; 0188: 5F ; Skip next instruction if FLAG bit 3 is set (FLAG & 0x8 != 0) ;  [CONDITIONAL: skip next on bit 3 of FLAG]
    JCP sub_0194         ; 0189: D4 ; Jump to address 0x0194 in current page (page 0x0180 + offset 0x14)
    CAL sub_06DF         ; 018A: AE DF ; Call subroutine at absolute address 0x06DF (push return address to stack)
    JCP sub_0199         ; 018C: D9 ; Jump to address 0x0199 in current page (page 0x0180 + offset 0x19)
    LI 12                ; 018D: 9C ; Load ACC with 0xC
    S                    ; 018E: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
    LDI 0x2C             ; 018F: 15 2C ; Load DP with 0x2C (DPH = 0x2, DPL = 0xC)
    LI 6                 ; 0191: 96 ; Load ACC with 0x6
    CM                   ; 0192: 0C ; Compare ACC with RAM[DP], skip next instruction if ACC == RAM[DP] ;  [CONDITIONAL: skip next on ACC equals RAM]
    INM                  ; 0193: 1D ; Increment RAM[DP] (RAM[DP] = RAM[DP] + 1), skip next if RAM[DP] overflows to 0 ;  [CONDITIONAL: skip next on carry (RAM==0)]
sub_0194:
    CAL sub_0719         ; 0194: AF 19 ; Call subroutine at absolute address 0x0719 (push return address to stack)
    LI 12                ; 0196: 9C ; Load ACC with 0xC
    S                    ; 0197: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
    SFB 3                ; 0198: 7F ; Set bit 3 of FLAG register (FLAG |= 0x8)
sub_0199:
    JMP sub_01CB         ; 0199: A1 CB ; Jump to absolute address 0x01CB
sub_019B:
    FBF 3                ; 019B: 23 ; Skip next instruction if FLAG bit 3 is NOT set (FLAG & 0x8 == 0) ;  [CONDITIONAL: skip next on NOT bit 3 of FLAG]
    CAL sub_0719         ; 019C: AF 19 ; Call subroutine at absolute address 0x0719 (push return address to stack)
    LDZ 0xB              ; 019E: 8B ; Load DP with 0x0B (DPH = 0, DPL = 0xB)
    LI 3                 ; 019F: 93 ; Load ACC with 0x3
    XMD 2                ; 01A0: 2E ; Exchange ACC with RAM[DP], XOR DPH with 0x2, decrement DPL, skip next if DPL underflows to 15 ;  [CONDITIONAL: skip next on carry (DPl==0xF) after decrement]
    CZP L0030            ; 01A1: BC ; Call subroutine at zero page address 0x0030 (page 12 << 2)
sub_01A2:
    RFB 3                ; 01A2: 6F ; Reset bit 3 of FLAG register (FLAG &= ~0x8)
    CAL sub_06DF         ; 01A3: AE DF ; Call subroutine at absolute address 0x06DF (push return address to stack)
    JCP sub_0199         ; 01A5: D9 ; Jump to address 0x0199 in current page (page 0x0180 + offset 0x19)
    LI 12                ; 01A6: 9C ; Load ACC with 0xC
    S                    ; 01A7: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
    LDI 0x2C             ; 01A8: 15 2C ; Load DP with 0x2C (DPH = 0x2, DPL = 0xC)
    DEM                  ; 01AA: 1F ; Decrement RAM[DP] (RAM[DP] = RAM[DP] - 1), skip next if RAM[DP] underflows to 15 ;  [CONDITIONAL: skip next on carry (RAM==0xF)]
    LM 3                 ; 01AB: 3B ; Load ACC with RAM[DP], XOR DPH with 0x3 (ACC = RAM[DP]; DPH ^= 0x3)
    CI 0xC1              ; 01AC: 17 C1 ; Compare ACC with 0xC1, skip next instruction if ACC == 0xC1 ;  [CONDITIONAL: skip next on ACC equals X]
    JCP sub_01B4         ; 01AE: F4 ; Jump to address 0x01B4 in current page (page 0x0180 + offset 0x34)
    LDI 0x4E             ; 01AF: 15 4E ; Load DP with 0x4E (DPH = 0x4, DPL = 0xE)
    LI 2                 ; 01B1: 92 ; Load ACC with 0x2
    S                    ; 01B2: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
    JCP sub_0199         ; 01B3: D9 ; Jump to address 0x0199 in current page (page 0x0180 + offset 0x19)
sub_01B4:
    CI 0xC0              ; 01B4: 17 C0 ; Compare ACC with 0xC0, skip next instruction if ACC == 0xC0 ;  [CONDITIONAL: skip next on ACC equals X]
    JCP sub_0199         ; 01B6: D9 ; Jump to address 0x0199 in current page (page 0x0180 + offset 0x19)
    LM 3                 ; 01B7: 3B ; Load ACC with RAM[DP], XOR DPH with 0x3 (ACC = RAM[DP]; DPH ^= 0x3)
    INM                  ; 01B8: 1D ; Increment RAM[DP] (RAM[DP] = RAM[DP] + 1), skip next if RAM[DP] overflows to 0 ;  [CONDITIONAL: skip next on carry (RAM==0)]
    LDI 0x44             ; 01B9: 15 44 ; Load DP with 0x44 (DPH = 0x4, DPL = 0x4)
    CM                   ; 01BB: 0C ; Compare ACC with RAM[DP], skip next instruction if ACC == RAM[DP] ;  [CONDITIONAL: skip next on ACC equals RAM]
    JMP sub_0176         ; 01BC: A1 76 ; Jump to absolute address 0x0176
    LDZ 0x2              ; 01BE: 82 ; Load DP with 0x02 (DPH = 0, DPL = 0x2)
    CZP L0008            ; 01BF: B2 ; Call subroutine at zero page address 0x0008 (page 2 << 2)
    CZP L0018            ; 01C0: B6 ; Call subroutine at zero page address 0x0018 (page 6 << 2)
    CAL sub_07B9         ; 01C1: AF B9 ; Call subroutine at absolute address 0x07B9 (push return address to stack)
    CAL sub_07B9         ; 01C3: AF B9 ; Call subroutine at absolute address 0x07B9 (push return address to stack)
sub_01C5:
    LDZ 0xF              ; 01C5: 8F ; Load DP with 0x0F (DPH = 0, DPL = 0xF)
    INM                  ; 01C6: 1D ; Increment RAM[DP] (RAM[DP] = RAM[DP] + 1), skip next if RAM[DP] overflows to 0 ;  [CONDITIONAL: skip next on carry (RAM==0)]
    LDI 0x4E             ; 01C7: 15 4E ; Load DP with 0x4E (DPH = 0x4, DPL = 0xE)
    JMP sub_07B5         ; 01C9: A7 B5 ; Jump to absolute address 0x07B5
sub_01CB:
    CAL sub_06E2         ; 01CB: AE E2 ; Call subroutine at absolute address 0x06E2 (push return address to stack)
    JCP sub_01D8         ; 01CD: D8 ; Jump to address 0x01D8 in current page (page 0x01C0 + offset 0x18)
    SMB 2                ; 01CE: 7A ; Set bit 2 of RAM[DP] (RAM[DP] |= 0x4)
    LDI 0x44             ; 01CF: 15 44 ; Load DP with 0x44 (DPH = 0x4, DPL = 0x4)
    STC                  ; 01D1: 1B ; Set Carry F/F
    LM 0                 ; 01D2: 38 ; Load ACC with RAM[DP] (ACC = RAM[DP])
    CI 0xC0              ; 01D3: 17 C0 ; Compare ACC with 0xC0, skip next instruction if ACC == 0xC0 ;  [CONDITIONAL: skip next on ACC equals X]
    CLC                  ; 01D5: 0B ; Reset Carry F/F
    RAR                  ; 01D6: 30 ; Rotate ACC Right through Carry F/F
    S                    ; 01D7: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
sub_01D8:
    JMP sub_0360         ; 01D8: A3 60 ; Jump to absolute address 0x0360
sub_01DA:
    TLY                  ; 01DA: 46 ; Transfer DPl to Y
    REB 0                ; 01DB: 64 ; Reset bit 0 of output port E (portE &= ~0x1)
    REB 1                ; 01DC: 65 ; Reset bit 1 of output port E (portE &= ~0x2)
    OCD 0x00             ; 01DD: 1E 00 ; Output 0x0 to port D, 0x0 to port C
sub_01DF:
    XLY                  ; 01DF: 4E ; Exchange DPl with Y
    XLY                  ; 01E0: 4E ; Exchange DPl with Y
sub_01E1:
    LDZ 0x8              ; 01E1: 88 ; Load DP with 0x08 (DPH = 0, DPL = 0x8)
sub_01E2:
    DED                  ; 01E2: 13 ; Decrement DPL (DPL = DPL - 1), skip next instruction if DPL underflows to 15 ;  [CONDITIONAL: skip next on carry (DPl==0xF)]
    JCP sub_01E2         ; 01E3: E2 ; Jump to address 0x01E2 in current page (page 0x01C0 + offset 0x22)
    XLY                  ; 01E4: 4E ; Exchange DPl with Y
    TLY                  ; 01E5: 46 ; Transfer DPl to Y
sub_01E6:
    DED                  ; 01E6: 13 ; Decrement DPL (DPL = DPL - 1), skip next instruction if DPL underflows to 15 ;  [CONDITIONAL: skip next on carry (DPl==0xF)]
    JCP sub_01F8         ; 01E7: F8 ; Jump to address 0x01F8 in current page (page 0x01C0 + offset 0x38)
    TC                   ; 01E8: 04 ; skip next on Carry F/F ;  [CONDITIONAL: skip next on Carry F/F]
    JCP sub_01EE         ; 01E9: EE ; Jump to address 0x01EE in current page (page 0x01C0 + offset 0x2E)
    SEB 3                ; 01EA: 77 ; Set bit 3 of output port E (portE |= 0x8)
    CLC                  ; 01EB: 0B ; Reset Carry F/F
    NOP                  ; 01EC: 00 ; No Operation
    JCP sub_01DF         ; 01ED: DF ; Jump to address 0x01DF in current page (page 0x01C0 + offset 0x1F)
sub_01EE:
    REB 3                ; 01EE: 67 ; Reset bit 3 of output port E (portE &= ~0x8)
    STC                  ; 01EF: 1B ; Set Carry F/F
    TTM                  ; 01F0: 05 ; skip next on Timer F/F ;  [CONDITIONAL: skip next on Timer F/F]
    JCP sub_01DF         ; 01F1: DF ; Jump to address 0x01DF in current page (page 0x01C0 + offset 0x1F)
    STM 0x32             ; 01F2: 14 B2 ; Reset Timer F/F, Start Timer with 0x32 (3213 ticks)
    DEC                  ; 01F4: 0F ; Decrement ACC (ACC = ACC - 1), skip next instruction if ACC underflows to 15 ;  [CONDITIONAL: skip next on carry (ACC==0xF)]
    JCP sub_01E1         ; 01F5: E1 ; Jump to address 0x01E1 in current page (page 0x01C0 + offset 0x21)
    XLY                  ; 01F6: 4E ; Exchange DPl with Y
    RT                   ; 01F7: 48 ; Return from subroutine
sub_01F8:
    NOP                  ; 01F8: 00 ; No Operation
    JCP sub_01E6         ; 01F9: E6 ; Jump to address 0x01E6 in current page (page 0x01C0 + offset 0x26)
sub_01FA:
    LDZ 0x3              ; 01FA: 83 ; Load DP with 0x03 (DPH = 0, DPL = 0x3)
sub_01FB:
    LM 1                 ; 01FB: 39 ; Load ACC with RAM[DP], XOR DPH with 0x1 (ACC = RAM[DP]; DPH ^= 0x1)
sub_01FC:
    XM 1                 ; 01FC: 29 ; Exchange ACC with RAM[DP], XOR DPH with 0x1 (temp = ACC; ACC = RAM[DP]; RAM[DP] = temp; DPH ^= 0x1)
    XMD 0                ; 01FD: 2C ; Exchange ACC with RAM[DP], decrement DPL, skip next if DPL underflows to 15 ;  [CONDITIONAL: skip next on carry (DPl==0xF) after decrement]
    JCP sub_01FB         ; 01FE: FB ; Jump to address 0x01FB in current page (page 0x01C0 + offset 0x3B)
    RT                   ; 01FF: 48 ; Return from subroutine
sub_0200:
    CAL sub_06DF         ; 0200: AE DF ; Call subroutine at absolute address 0x06DF (push return address to stack)
    JMP sub_03B5         ; 0202: A3 B5 ; Jump to absolute address 0x03B5
    CAL sub_074E         ; 0204: AF 4E ; Call subroutine at absolute address 0x074E (push return address to stack)
    CAL sub_07A2         ; 0206: AF A2 ; Call subroutine at absolute address 0x07A2 (push return address to stack)
    JMP L0096            ; 0208: A0 96 ; Jump to absolute address 0x0096
    JMP sub_04DF         ; 020A: A4 DF ; Jump to absolute address 0x04DF
sub_020C:
    LDZ 0xD              ; 020C: 8D ; Load DP with 0x0D (DPH = 0, DPL = 0xD)
    STC                  ; 020D: 1B ; Set Carry F/F
    TMB 0                ; 020E: 58 ; Skip next instruction if RAM[DP] bit 0 is set (RAM[DP] & 0x1 != 0) ;  [CONDITIONAL: skip next on bit 0 of RAM]
    CLC                  ; 020F: 0B ; Reset Carry F/F
    LDI 0x4B             ; 0210: 15 4B ; Load DP with 0x4B (DPH = 0x4, DPL = 0xB)
    LI 0                 ; 0212: 90 ; Load ACC with 0x0
    CM                   ; 0213: 0C ; Compare ACC with RAM[DP], skip next instruction if ACC == RAM[DP] ;  [CONDITIONAL: skip next on ACC equals RAM]
    JCP sub_0225         ; 0214: E5 ; Jump to address 0x0225 in current page (page 0x0200 + offset 0x25)
    TAL                  ; 0215: 07 ; Transfer ACC to DPL (lower 4 bits of data pointer)
    TMB 2                ; 0216: 5A ; Skip next instruction if RAM[DP] bit 2 is set (RAM[DP] & 0x4 != 0) ;  [CONDITIONAL: skip next on bit 2 of RAM]
    LI 1                 ; 0217: 91 ; Load ACC with 0x1
    LDI 0x4B             ; 0218: 15 4B ; Load DP with 0x4B (DPH = 0x4, DPL = 0xB)
    S                    ; 021A: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
    TC                   ; 021B: 04 ; skip next on Carry F/F ;  [CONDITIONAL: skip next on Carry F/F]
    LI 4                 ; 021C: 94 ; Load ACC with 0x4, skip next LI instruction, resume at 0x021E
    LI 2                 ; 021D: 92 ; Load ACC with 0x2
    AD                   ; 021E: 08 ; Add RAM[DP] to ACC, skip next instruction if carry (ACC + RAM[DP] > 15) ;  [CONDITIONAL: skip next on carry]
    S                    ; 021F: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
    SFB 0                ; 0220: 7C ; Set bit 0 of FLAG register (FLAG |= 0x1)
    CAL sub_0629         ; 0221: AE 29 ; Call subroutine at absolute address 0x0629 (push return address to stack)
    CAL sub_0629         ; 0223: AE 29 ; Call subroutine at absolute address 0x0629 (push return address to stack)
sub_0225:
    LDZ 0xF              ; 0225: 8F ; Load DP with 0x0F (DPH = 0, DPL = 0xF)
    LI 6                 ; 0226: 96 ; Load ACC with 0x6
    CM                   ; 0227: 0C ; Compare ACC with RAM[DP], skip next instruction if ACC == RAM[DP] ;  [CONDITIONAL: skip next on ACC equals RAM]
    JMP sub_025C         ; 0228: A2 5C ; Jump to absolute address 0x025C
    LDZ 0xD              ; 022A: 8D ; Load DP with 0x0D (DPH = 0, DPL = 0xD)
    STC                  ; 022B: 1B ; Set Carry F/F
    TMB 0                ; 022C: 58 ; Skip next instruction if RAM[DP] bit 0 is set (RAM[DP] & 0x1 != 0) ;  [CONDITIONAL: skip next on bit 0 of RAM]
    CLC                  ; 022D: 0B ; Reset Carry F/F
    LDI 0x1A             ; 022E: 15 1A ; Load DP with 0x1A (DPH = 0x1, DPL = 0xA)
    LI 0                 ; 0230: 90 ; Load ACC with 0x0
    CM                   ; 0231: 0C ; Compare ACC with RAM[DP], skip next instruction if ACC == RAM[DP] ;  [CONDITIONAL: skip next on ACC equals RAM]
    JMP sub_0287         ; 0232: A2 87 ; Jump to absolute address 0x0287
    TC                   ; 0234: 04 ; skip next on Carry F/F ;  [CONDITIONAL: skip next on Carry F/F]
    LI 4                 ; 0235: 94 ; Load ACC with 0x4, skip next LI instruction, resume at 0x0237
    LI 2                 ; 0236: 92 ; Load ACC with 0x2
    XM 3                 ; 0237: 2B ; Exchange ACC with RAM[DP], XOR DPH with 0x3 (temp = ACC; ACC = RAM[DP]; RAM[DP] = temp; DPH ^= 0x3)
    LM 1                 ; 0238: 39 ; Load ACC with RAM[DP], XOR DPH with 0x1 (ACC = RAM[DP]; DPH ^= 0x1)
    TAZ                  ; 0239: 42 ; Transfer ACC to Z
    CLC                  ; 023A: 0B ; Reset Carry F/F
    TMB 0                ; 023B: 58 ; Skip next instruction if RAM[DP] bit 0 is set (RAM[DP] & 0x1 != 0) ;  [CONDITIONAL: skip next on bit 0 of RAM]
    STC                  ; 023C: 1B ; Set Carry F/F
    LDI 0x15             ; 023D: 15 15 ; Load DP with 0x15 (DPH = 0x1, DPL = 0x5)
    LM 0                 ; 023F: 38 ; Load ACC with RAM[DP] (ACC = RAM[DP])
    TAW                  ; 0240: 43 ; Transfer ACC to W
    LI 9                 ; 0241: 99 ; Load ACC with 0x9
    AD                   ; 0242: 08 ; Add RAM[DP] to ACC, skip next instruction if carry (ACC + RAM[DP] > 15) ;  [CONDITIONAL: skip next on carry]
    JCP sub_0254         ; 0243: D4 ; Jump to address 0x0254 in current page (page 0x0240 + offset 0x14)
    LDI 0x20             ; 0244: 15 20 ; Load DP with 0x20 (DPH = 0x2, DPL = 0x0)
    XAZ                  ; 0246: 4A ; Exchange ACC with Z
    S                    ; 0247: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
    XAW                  ; 0248: 4B ; Exchange ACC with W
    TAB 1                ; 0249: 25 ; Skip next instruction if ACC bit 1 is set (ACC & 0x2 != 0) ;  [CONDITIONAL: skip next on bit 1 of ACC]
    JCP sub_024E         ; 024A: CE ; Jump to address 0x024E in current page (page 0x0240 + offset 0x0E)
    RMB 0                ; 024B: 68 ; Reset bit 0 of RAM[DP] (RAM[DP] &= ~0x1)
    RMB 2                ; 024C: 6A ; Reset bit 2 of RAM[DP] (RAM[DP] &= ~0x4)
    JCP sub_0254         ; 024D: D4 ; Jump to address 0x0254 in current page (page 0x0240 + offset 0x14)
sub_024E:
    RMB 1                ; 024E: 69 ; Reset bit 1 of RAM[DP] (RAM[DP] &= ~0x2)
    RMB 3                ; 024F: 6B ; Reset bit 3 of RAM[DP] (RAM[DP] &= ~0x8)
    LDI 0x30             ; 0250: 15 30 ; Load DP with 0x30 (DPH = 0x3, DPL = 0x0)
    TC                   ; 0252: 04 ; skip next on Carry F/F ;  [CONDITIONAL: skip next on Carry F/F]
    SMB 0                ; 0253: 78 ; Set bit 0 of RAM[DP] (RAM[DP] |= 0x1)
sub_0254:
    LDI 0x3A             ; 0254: 15 3A ; Load DP with 0x3A (DPH = 0x3, DPL = 0xA)
    LM 1                 ; 0256: 39 ; Load ACC with RAM[DP], XOR DPH with 0x1 (ACC = RAM[DP]; DPH ^= 0x1)
    RAR                  ; 0257: 30 ; Rotate ACC Right through Carry F/F
    LM 0                 ; 0258: 38 ; Load ACC with RAM[DP] (ACC = RAM[DP])
    RAR                  ; 0259: 30 ; Rotate ACC Right through Carry F/F
    RAR                  ; 025A: 30 ; Rotate ACC Right through Carry F/F
    JCP sub_026D         ; 025B: ED ; Jump to address 0x026D in current page (page 0x0240 + offset 0x2D)
sub_025C:
    LDI 0x19             ; 025C: 15 19 ; Load DP with 0x19 (DPH = 0x1, DPL = 0x9)
    LI 0                 ; 025E: 90 ; Load ACC with 0x0
    CM                   ; 025F: 0C ; Compare ACC with RAM[DP], skip next instruction if ACC == RAM[DP] ;  [CONDITIONAL: skip next on ACC equals RAM]
    JCP sub_0273         ; 0260: F3 ; Jump to address 0x0273 in current page (page 0x0240 + offset 0x33)
    LI 3                 ; 0261: 93 ; Load ACC with 0x3
    XM 3                 ; 0262: 2B ; Exchange ACC with RAM[DP], XOR DPH with 0x3 (temp = ACC; ACC = RAM[DP]; RAM[DP] = temp; DPH ^= 0x3)
    CLC                  ; 0263: 0B ; Reset Carry F/F
    TMB 0                ; 0264: 58 ; Skip next instruction if RAM[DP] bit 0 is set (RAM[DP] & 0x1 != 0) ;  [CONDITIONAL: skip next on bit 0 of RAM]
    JCP sub_0267         ; 0265: E7 ; Jump to address 0x0267 in current page (page 0x0240 + offset 0x27)
    JCP sub_0269         ; 0266: E9 ; Jump to address 0x0269 in current page (page 0x0240 + offset 0x29)
sub_0267:
    TMB 1                ; 0267: 59 ; Skip next instruction if RAM[DP] bit 1 is set (RAM[DP] & 0x2 != 0) ;  [CONDITIONAL: skip next on bit 1 of RAM]
    STC                  ; 0268: 1B ; Set Carry F/F
sub_0269:
    FBF 1                ; 0269: 21 ; Skip next instruction if FLAG bit 1 is NOT set (FLAG & 0x2 == 0) ;  [CONDITIONAL: skip next on NOT bit 1 of FLAG]
    CLC                  ; 026A: 0B ; Reset Carry F/F
    LM 0                 ; 026B: 38 ; Load ACC with RAM[DP] (ACC = RAM[DP])
    ADC                  ; 026C: 19 ; Add RAM[DP] and carry to ACC, store carry flag (ACC = ACC + RAM[DP] + carry)
sub_026D:
    XM 1                 ; 026D: 29 ; Exchange ACC with RAM[DP], XOR DPH with 0x1 (temp = ACC; ACC = RAM[DP]; RAM[DP] = temp; DPH ^= 0x1)
    TC                   ; 026E: 04 ; skip next on Carry F/F ;  [CONDITIONAL: skip next on Carry F/F]
    LI 0                 ; 026F: 90 ; Load ACC with 0x0, skip next LI instruction, resume at 0x0271
    LI 1                 ; 0270: 91 ; Load ACC with 0x1
    S                    ; 0271: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
    JCP sub_0275         ; 0272: F5 ; Jump to address 0x0275 in current page (page 0x0240 + offset 0x35)
sub_0273:
    DED                  ; 0273: 13 ; Decrement DPL (DPL = DPL - 1), skip next instruction if DPL underflows to 15 ;  [CONDITIONAL: skip next on carry (DPl==0xF)]
    CM                   ; 0274: 0C ; Compare ACC with RAM[DP], skip next instruction if ACC == RAM[DP] ;  [CONDITIONAL: skip next on ACC equals RAM]
sub_0275:
    JMP sub_0287         ; 0275: A2 87 ; Jump to absolute address 0x0287
    LI 5                 ; 0277: 95 ; Load ACC with 0x5
    XM 3                 ; 0278: 2B ; Exchange ACC with RAM[DP], XOR DPH with 0x3 (temp = ACC; ACC = RAM[DP]; RAM[DP] = temp; DPH ^= 0x3)
    LM 1                 ; 0279: 39 ; Load ACC with RAM[DP], XOR DPH with 0x1 (ACC = RAM[DP]; DPH ^= 0x1)
    TAB 3                ; 027A: 27 ; Skip next instruction if ACC bit 3 is set (ACC & 0x8 != 0) ;  [CONDITIONAL: skip next on bit 3 of ACC]
    JCP sub_027D         ; 027B: FD ; Jump to address 0x027D in current page (page 0x0240 + offset 0x3D)
    JCP sub_027F         ; 027C: FF ; Jump to address 0x027F in current page (page 0x0240 + offset 0x3F)
sub_027D:
    TMB 0                ; 027D: 58 ; Skip next instruction if RAM[DP] bit 0 is set (RAM[DP] & 0x1 != 0) ;  [CONDITIONAL: skip next on bit 0 of RAM]
    LI 1                 ; 027E: 91 ; Load ACC with 0x1, skip next LI instruction, resume at 0x0280
sub_027F:
    LI 0                 ; 027F: 90 ; Load ACC with 0x0
    FBF 1                ; 0280: 21 ; Skip next instruction if FLAG bit 1 is NOT set (FLAG & 0x2 == 0) ;  [CONDITIONAL: skip next on NOT bit 1 of FLAG]
    LI 0                 ; 0281: 90 ; Load ACC with 0x0
    XM 1                 ; 0282: 29 ; Exchange ACC with RAM[DP], XOR DPH with 0x1 (temp = ACC; ACC = RAM[DP]; RAM[DP] = temp; DPH ^= 0x1)
    RAR                  ; 0283: 30 ; Rotate ACC Right through Carry F/F
    LM 0                 ; 0284: 38 ; Load ACC with RAM[DP] (ACC = RAM[DP])
    RAR                  ; 0285: 30 ; Rotate ACC Right through Carry F/F
    S                    ; 0286: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
sub_0287:
    CZP L0024            ; 0287: B9 ; Call subroutine at zero page address 0x0024 (page 9 << 2)
    LDZ 0xD              ; 0288: 8D ; Load DP with 0x0D (DPH = 0, DPL = 0xD)
    STC                  ; 0289: 1B ; Set Carry F/F
    TMB 0                ; 028A: 58 ; Skip next instruction if RAM[DP] bit 0 is set (RAM[DP] & 0x1 != 0) ;  [CONDITIONAL: skip next on bit 0 of RAM]
    CLC                  ; 028B: 0B ; Reset Carry F/F
    LDI 0x4A             ; 028C: 15 4A ; Load DP with 0x4A (DPH = 0x4, DPL = 0xA)
    LI 0                 ; 028E: 90 ; Load ACC with 0x0
    CM                   ; 028F: 0C ; Compare ACC with RAM[DP], skip next instruction if ACC == RAM[DP] ;  [CONDITIONAL: skip next on ACC equals RAM]
    JMP sub_02D2         ; 0290: A2 D2 ; Jump to absolute address 0x02D2
    TC                   ; 0292: 04 ; skip next on Carry F/F ;  [CONDITIONAL: skip next on Carry F/F]
    LI 3                 ; 0293: 93 ; Load ACC with 0x3, skip next LI instruction, resume at 0x0295
    LI 2                 ; 0294: 92 ; Load ACC with 0x2
    S                    ; 0295: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
    LDI 0x1C             ; 0296: 15 1C ; Load DP with 0x1C (DPH = 0x1, DPL = 0xC)
    LM 0                 ; 0298: 38 ; Load ACC with RAM[DP] (ACC = RAM[DP])
    LDI 0x74             ; 0299: 15 74 ; Load DP with 0x74 (DPH = 0x7, DPL = 0x4)
sub_029B:
    S                    ; 029B: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
    IND                  ; 029C: 33 ; Increment DPL (DPL = DPL + 1), skip next instruction if DPL overflows to 0 ;  [CONDITIONAL: skip next on carry (DPl==0)]
    CLI 7                ; 029D: 16 E7 ; Compare DPL with 7, skip next instruction if DPL == 7 ;  [CONDITIONAL: skip next on DPl equals X]
    JCP sub_029B         ; 029F: DB ; Jump to address 0x029B in current page (page 0x0280 + offset 0x1B)
    IND                  ; 02A0: 33 ; Increment DPL (DPL = DPL + 1), skip next instruction if DPL overflows to 0 ;  [CONDITIONAL: skip next on carry (DPl==0)]
    INM                  ; 02A1: 1D ; Increment RAM[DP] (RAM[DP] = RAM[DP] + 1), skip next if RAM[DP] overflows to 0 ;  [CONDITIONAL: skip next on carry (RAM==0)]
    LDI 0x27             ; 02A2: 15 27 ; Load DP with 0x27 (DPH = 0x2, DPL = 0x7)
    CI 0xC0              ; 02A4: 17 C0 ; Compare ACC with 0xC0, skip next instruction if ACC == 0xC0 ;  [CONDITIONAL: skip next on ACC equals X]
    JCP sub_02B8         ; 02A6: F8 ; Jump to address 0x02B8 in current page (page 0x0280 + offset 0x38)
    LM 1                 ; 02A7: 39 ; Load ACC with RAM[DP], XOR DPH with 0x1 (ACC = RAM[DP]; DPH ^= 0x1)
    TMB 0                ; 02A8: 58 ; Skip next instruction if RAM[DP] bit 0 is set (RAM[DP] & 0x1 != 0) ;  [CONDITIONAL: skip next on bit 0 of RAM]
sub_02A9:
    JMP sub_02C2         ; 02A9: A2 C2 ; Jump to absolute address 0x02C2
    LI 7                 ; 02AB: 97 ; Load ACC with 0x7
    LDI 0x77             ; 02AC: 15 77 ; Load DP with 0x77 (DPH = 0x7, DPL = 0x7)
    XMD 0                ; 02AE: 2C ; Exchange ACC with RAM[DP], decrement DPL, skip next if DPL underflows to 15 ;  [CONDITIONAL: skip next on carry (DPl==0xF) after decrement]
    CZP L0020            ; 02AF: B8 ; Call subroutine at zero page address 0x0020 (page 8 << 2)
sub_02B0:
    LDZ 0xF              ; 02B0: 8F ; Load DP with 0x0F (DPH = 0, DPL = 0xF)
    LI 15                ; 02B1: 9F ; Load ACC with 0xF
    AD                   ; 02B2: 08 ; Add RAM[DP] to ACC, skip next instruction if carry (ACC + RAM[DP] > 15) ;  [CONDITIONAL: skip next on carry]
    JCP sub_02A9         ; 02B3: E9 ; Jump to address 0x02A9 in current page (page 0x0280 + offset 0x29)
    LDZ 0xA              ; 02B4: 8A ; Load DP with 0x0A (DPH = 0, DPL = 0xA)
    SMB 0                ; 02B5: 78 ; Set bit 0 of RAM[DP] (RAM[DP] |= 0x1)
    SFB 2                ; 02B6: 7E ; Set bit 2 of FLAG register (FLAG |= 0x4)
    JCP sub_02A9         ; 02B7: E9 ; Jump to address 0x02A9 in current page (page 0x0280 + offset 0x29)
sub_02B8:
    TAZ                  ; 02B8: 42 ; Transfer ACC to Z
    AD                   ; 02B9: 08 ; Add RAM[DP] to ACC, skip next instruction if carry (ACC + RAM[DP] > 15) ;  [CONDITIONAL: skip next on carry]
    JCP sub_02BC         ; 02BA: FC ; Jump to address 0x02BC in current page (page 0x0280 + offset 0x3C)
    JCP sub_02B0         ; 02BB: F0 ; Jump to address 0x02B0 in current page (page 0x0280 + offset 0x30)
sub_02BC:
    EXL                  ; 02BC: 18 ; XOR ACC with RAM[DP] (ACC = ACC ^ RAM[DP])
    LDI 0x7A             ; 02BD: 15 7A ; Load DP with 0x7A (DPH = 0x7, DPL = 0xA)
    CM                   ; 02BF: 0C ; Compare ACC with RAM[DP], skip next instruction if ACC == RAM[DP] ;  [CONDITIONAL: skip next on ACC equals RAM]
    JMP sub_02B0         ; 02C0: A2 B0 ; Jump to absolute address 0x02B0
sub_02C2:
    LDI 0x20             ; 02C2: 15 20 ; Load DP with 0x20 (DPH = 0x2, DPL = 0x0)
    LI 0                 ; 02C4: 90 ; Load ACC with 0x0
    TAW                  ; 02C5: 43 ; Transfer ACC to W
sub_02C6:
    XM 1                 ; 02C6: 29 ; Exchange ACC with RAM[DP], XOR DPH with 0x1 (temp = ACC; ACC = RAM[DP]; RAM[DP] = temp; DPH ^= 0x1)
    TAZ                  ; 02C7: 42 ; Transfer ACC to Z
    XAW                  ; 02C8: 4B ; Exchange ACC with W
    XMI 1                ; 02C9: 3D ; Exchange ACC with RAM[DP], XOR DPH with 0x1, increment DPL, skip next if DPL overflows to 0 ;  [CONDITIONAL: skip next on carry (DPl==0) after increment]
    TAW                  ; 02CA: 43 ; Transfer ACC to W
    XAZ                  ; 02CB: 4A ; Exchange ACC with Z
    CLI 8                ; 02CC: 16 E8 ; Compare DPL with 8, skip next instruction if DPL == 8 ;  [CONDITIONAL: skip next on DPl equals X]
    JCP sub_02C6         ; 02CE: C6 ; Jump to address 0x02C6 in current page (page 0x02C0 + offset 0x06)
    FBF 2                ; 02CF: 22 ; Skip next instruction if FLAG bit 2 is NOT set (FLAG & 0x4 == 0) ;  [CONDITIONAL: skip next on NOT bit 2 of FLAG]
sub_02D0:
    JMP sub_03B5         ; 02D0: A3 B5 ; Jump to absolute address 0x03B5
sub_02D2:
    LDZ 0xF              ; 02D2: 8F ; Load DP with 0x0F (DPH = 0, DPL = 0xF)
    LI 15                ; 02D3: 9F ; Load ACC with 0xF
    AD                   ; 02D4: 08 ; Add RAM[DP] to ACC, skip next instruction if carry (ACC + RAM[DP] > 15) ;  [CONDITIONAL: skip next on carry]
    JCP sub_02D0         ; 02D5: D0 ; Jump to address 0x02D0 in current page (page 0x02C0 + offset 0x10)
    LDI 0x2D             ; 02D6: 15 2D ; Load DP with 0x2D (DPH = 0x2, DPL = 0xD)
    LI 0                 ; 02D8: 90 ; Load ACC with 0x0
    CM                   ; 02D9: 0C ; Compare ACC with RAM[DP], skip next instruction if ACC == RAM[DP] ;  [CONDITIONAL: skip next on ACC equals RAM]
    JCP sub_02E7         ; 02DA: E7 ; Jump to address 0x02E7 in current page (page 0x02C0 + offset 0x27)
    LDZ 0xE              ; 02DB: 8E ; Load DP with 0x0E (DPH = 0, DPL = 0xE)
    TMB 3                ; 02DC: 5B ; Skip next instruction if RAM[DP] bit 3 is set (RAM[DP] & 0x8 != 0) ;  [CONDITIONAL: skip next on bit 3 of RAM]
    JCP sub_02EA         ; 02DD: EA ; Jump to address 0x02EA in current page (page 0x02C0 + offset 0x2A)
    RMB 3                ; 02DE: 6B ; Reset bit 3 of RAM[DP] (RAM[DP] &= ~0x8)
    LDI 0x1C             ; 02DF: 15 1C ; Load DP with 0x1C (DPH = 0x1, DPL = 0xC)
    LM 0                 ; 02E1: 38 ; Load ACC with RAM[DP] (ACC = RAM[DP])
    IND                  ; 02E2: 33 ; Increment DPL (DPL = DPL + 1), skip next instruction if DPL overflows to 0 ;  [CONDITIONAL: skip next on carry (DPl==0)]
    XM 3                 ; 02E3: 2B ; Exchange ACC with RAM[DP], XOR DPH with 0x3 (temp = ACC; ACC = RAM[DP]; RAM[DP] = temp; DPH ^= 0x3)
    SMB 1                ; 02E4: 79 ; Set bit 1 of RAM[DP] (RAM[DP] |= 0x2)
    LDZ 0x1              ; 02E5: 81 ; Load DP with 0x01 (DPH = 0, DPL = 0x1)
    CZP L0008            ; 02E6: B2 ; Call subroutine at zero page address 0x0008 (page 2 << 2)
sub_02E7:
    LDI 0x4C             ; 02E7: 15 4C ; Load DP with 0x4C (DPH = 0x4, DPL = 0xC)
    CM                   ; 02E9: 0C ; Compare ACC with RAM[DP], skip next instruction if ACC == RAM[DP] ;  [CONDITIONAL: skip next on ACC equals RAM]
sub_02EA:
    JMP sub_035E         ; 02EA: A3 5E ; Jump to absolute address 0x035E
    LI 1                 ; 02EC: 91 ; Load ACC with 0x1
    S                    ; 02ED: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
    LI 8                 ; 02EE: 98 ; Load ACC with 0x8
    LDI 0x78             ; 02EF: 15 78 ; Load DP with 0x78 (DPH = 0x7, DPL = 0x8)
    XMD 0                ; 02F1: 2C ; Exchange ACC with RAM[DP], decrement DPL, skip next if DPL underflows to 15 ;  [CONDITIONAL: skip next on carry (DPl==0xF) after decrement]
    CZP L0020            ; 02F2: B8 ; Call subroutine at zero page address 0x0020 (page 8 << 2)
    LDI 0x1D             ; 02F3: 15 1D ; Load DP with 0x1D (DPH = 0x1, DPL = 0xD)
    LI 0                 ; 02F5: 90 ; Load ACC with 0x0
    CM                   ; 02F6: 0C ; Compare ACC with RAM[DP], skip next instruction if ACC == RAM[DP] ;  [CONDITIONAL: skip next on ACC equals RAM]
    JCP sub_02FE         ; 02F7: FE ; Jump to address 0x02FE in current page (page 0x02C0 + offset 0x3E)
    LI 4                 ; 02F8: 94 ; Load ACC with 0x4
    LDI 0x77             ; 02F9: 15 77 ; Load DP with 0x77 (DPH = 0x7, DPL = 0x7)
    S                    ; 02FB: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
    JMP sub_0304         ; 02FC: A3 04 ; Jump to absolute address 0x0304
sub_02FE:
    JMP sub_0300         ; 02FE: A3 00 ; Jump to absolute address 0x0300
sub_0300:
    LM 0                 ; 0300: 38 ; Load ACC with RAM[DP] (ACC = RAM[DP])
    LDI 0x74             ; 0301: 15 74 ; Load DP with 0x74 (DPH = 0x7, DPL = 0x4)
    S                    ; 0303: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
sub_0304:
    LDI 0x1D             ; 0304: 15 1D ; Load DP with 0x1D (DPH = 0x1, DPL = 0xD)
    LM 3                 ; 0306: 3B ; Load ACC with RAM[DP], XOR DPH with 0x3 (ACC = RAM[DP]; DPH ^= 0x3)
    TAW                  ; 0307: 43 ; Transfer ACC to W
    LI 9                 ; 0308: 99 ; Load ACC with 0x9
    CM                   ; 0309: 0C ; Compare ACC with RAM[DP], skip next instruction if ACC == RAM[DP] ;  [CONDITIONAL: skip next on ACC equals RAM]
    JCP sub_0312         ; 030A: D2 ; Jump to address 0x0312 in current page (page 0x0300 + offset 0x12)
    LDZ 0xF              ; 030B: 8F ; Load DP with 0x0F (DPH = 0, DPL = 0xF)
    LI 6                 ; 030C: 96 ; Load ACC with 0x6
    CM                   ; 030D: 0C ; Compare ACC with RAM[DP], skip next instruction if ACC == RAM[DP] ;  [CONDITIONAL: skip next on ACC equals RAM]
    JCP sub_0328         ; 030E: E8 ; Jump to address 0x0328 in current page (page 0x0300 + offset 0x28)
    LDI 0x2A             ; 030F: 15 2A ; Load DP with 0x2A (DPH = 0x2, DPL = 0xA)
    JCP sub_031F         ; 0311: DF ; Jump to address 0x031F in current page (page 0x0300 + offset 0x1F)
sub_0312:
    LI 8                 ; 0312: 98 ; Load ACC with 0x8
    CM                   ; 0313: 0C ; Compare ACC with RAM[DP], skip next instruction if ACC == RAM[DP] ;  [CONDITIONAL: skip next on ACC equals RAM]
    JCP sub_0319         ; 0314: D9 ; Jump to address 0x0319 in current page (page 0x0300 + offset 0x19)
    LI 4                 ; 0315: 94 ; Load ACC with 0x4
    LDI 0x29             ; 0316: 15 29 ; Load DP with 0x29 (DPH = 0x2, DPL = 0x9)
    JCP sub_031F         ; 0318: DF ; Jump to address 0x031F in current page (page 0x0300 + offset 0x1F)
sub_0319:
    LI 7                 ; 0319: 97 ; Load ACC with 0x7
    CM                   ; 031A: 0C ; Compare ACC with RAM[DP], skip next instruction if ACC == RAM[DP] ;  [CONDITIONAL: skip next on ACC equals RAM]
    JCP sub_033B         ; 031B: FB ; Jump to address 0x033B in current page (page 0x0300 + offset 0x3B)
    LI 2                 ; 031C: 92 ; Load ACC with 0x2
    LDI 0x28             ; 031D: 15 28 ; Load DP with 0x28 (DPH = 0x2, DPL = 0x8)
sub_031F:
    TAZ                  ; 031F: 42 ; Transfer ACC to Z
    XAW                  ; 0320: 4B ; Exchange ACC with W
    TAW                  ; 0321: 43 ; Transfer ACC to W
    CI 0xC0              ; 0322: 17 C0 ; Compare ACC with 0xC0, skip next instruction if ACC == 0xC0 ;  [CONDITIONAL: skip next on ACC equals X]
    JCP sub_032A         ; 0324: EA ; Jump to address 0x032A in current page (page 0x0300 + offset 0x2A)
    LM 0                 ; 0325: 38 ; Load ACC with RAM[DP] (ACC = RAM[DP])
    XM 1                 ; 0326: 29 ; Exchange ACC with RAM[DP], XOR DPH with 0x1 (temp = ACC; ACC = RAM[DP]; RAM[DP] = temp; DPH ^= 0x1)
    TMB 0                ; 0327: 58 ; Skip next instruction if RAM[DP] bit 0 is set (RAM[DP] & 0x1 != 0) ;  [CONDITIONAL: skip next on bit 0 of RAM]
sub_0328:
    JCP sub_033B         ; 0328: FB ; Jump to address 0x033B in current page (page 0x0300 + offset 0x3B)
    JCP sub_0335         ; 0329: F5 ; Jump to address 0x0335 in current page (page 0x0300 + offset 0x35)
sub_032A:
    AD                   ; 032A: 08 ; Add RAM[DP] to ACC, skip next instruction if carry (ACC + RAM[DP] > 15) ;  [CONDITIONAL: skip next on carry]
    JCP sub_032D         ; 032B: ED ; Jump to address 0x032D in current page (page 0x0300 + offset 0x2D)
    JCP sub_0335         ; 032C: F5 ; Jump to address 0x0335 in current page (page 0x0300 + offset 0x35)
sub_032D:
    EXL                  ; 032D: 18 ; XOR ACC with RAM[DP] (ACC = ACC ^ RAM[DP])
    LDZ 0x9              ; 032E: 89 ; Load DP with 0x09 (DPH = 0, DPL = 0x9)
    S                    ; 032F: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
    XAW                  ; 0330: 4B ; Exchange ACC with W
    TAW                  ; 0331: 43 ; Transfer ACC to W
    CM                   ; 0332: 0C ; Compare ACC with RAM[DP], skip next instruction if ACC == RAM[DP] ;  [CONDITIONAL: skip next on ACC equals RAM]
    JCP sub_0335         ; 0333: F5 ; Jump to address 0x0335 in current page (page 0x0300 + offset 0x35)
    JCP sub_033B         ; 0334: FB ; Jump to address 0x033B in current page (page 0x0300 + offset 0x3B)
sub_0335:
    LDZ 0x9              ; 0335: 89 ; Load DP with 0x09 (DPH = 0, DPL = 0x9)
    XAW                  ; 0336: 4B ; Exchange ACC with W
    SFB 2                ; 0337: 7E ; Set bit 2 of FLAG register (FLAG |= 0x4)
    XMI 0                ; 0338: 3C ; Exchange ACC with RAM[DP], increment DPL, skip next if DPL overflows to 0 ;  [CONDITIONAL: skip next on carry (DPl==0) after increment]
    JMP sub_034E         ; 0339: A3 4E ; Jump to absolute address 0x034E
sub_033B:
    LDI 0x2D             ; 033B: 15 2D ; Load DP with 0x2D (DPH = 0x2, DPL = 0xD)
    LM 0                 ; 033D: 38 ; Load ACC with RAM[DP] (ACC = RAM[DP])
    TAZ                  ; 033E: 42 ; Transfer ACC to Z
    IND                  ; 033F: 33 ; Increment DPL (DPL = DPL + 1), skip next instruction if DPL overflows to 0 ;  [CONDITIONAL: skip next on carry (DPl==0)]
    CAL sub_0670         ; 0340: AE 70 ; Call subroutine at absolute address 0x0670 (push return address to stack)
    JCP sub_0347         ; 0342: C7 ; Jump to address 0x0347 in current page (page 0x0340 + offset 0x07)
    CAL sub_0670         ; 0343: AE 70 ; Call subroutine at absolute address 0x0670 (push return address to stack)
    JCP sub_0348         ; 0345: C8 ; Jump to address 0x0348 in current page (page 0x0340 + offset 0x08)
    JCP sub_0351         ; 0346: D1 ; Jump to address 0x0351 in current page (page 0x0340 + offset 0x11)
sub_0347:
    LI 8                 ; 0347: 98 ; Load ACC with 0x8, skip next LI instruction, resume at 0x0349
sub_0348:
    LI 10                ; 0348: 9A ; Load ACC with 0xA
    LDZ 0xA              ; 0349: 8A ; Load DP with 0x0A (DPH = 0, DPL = 0xA)
    S                    ; 034A: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
    SFB 2                ; 034B: 7E ; Set bit 2 of FLAG register (FLAG |= 0x4)
    LDI 0x78             ; 034C: 15 78 ; Load DP with 0x78 (DPH = 0x7, DPL = 0x8)
sub_034E:
    XAZ                  ; 034E: 4A ; Exchange ACC with Z
    S                    ; 034F: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
    JCP sub_0357         ; 0350: D7 ; Jump to address 0x0357 in current page (page 0x0340 + offset 0x17)
sub_0351:
    LDI 0x2D             ; 0351: 15 2D ; Load DP with 0x2D (DPH = 0x2, DPL = 0xD)
    INM                  ; 0353: 1D ; Increment RAM[DP] (RAM[DP] = RAM[DP] + 1), skip next if RAM[DP] overflows to 0 ;  [CONDITIONAL: skip next on carry (RAM==0)]
    LI 10                ; 0354: 9A ; Load ACC with 0xA
    CM                   ; 0355: 0C ; Compare ACC with RAM[DP], skip next instruction if ACC == RAM[DP] ;  [CONDITIONAL: skip next on ACC equals RAM]
    JCP sub_035E         ; 0356: DE ; Jump to address 0x035E in current page (page 0x0340 + offset 0x1E)
sub_0357:
    LDI 0x2D             ; 0357: 15 2D ; Load DP with 0x2D (DPH = 0x2, DPL = 0xD)
    LI 0                 ; 0359: 90 ; Load ACC with 0x0
    S                    ; 035A: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
    FBF 2                ; 035B: 22 ; Skip next instruction if FLAG bit 2 is NOT set (FLAG & 0x4 == 0) ;  [CONDITIONAL: skip next on NOT bit 2 of FLAG]
    JMP sub_04FD         ; 035C: A4 FD ; Jump to absolute address 0x04FD
sub_035E:
    STC                  ; 035E: 1B ; Set Carry F/F
    JCP sub_0366         ; 035F: E6 ; Jump to address 0x0366 in current page (page 0x0340 + offset 0x26)
sub_0360:
    LDI 0x2C             ; 0360: 15 2C ; Load DP with 0x2C (DPH = 0x2, DPL = 0xC)
    LI 14                ; 0362: 9E ; Load ACC with 0xE
    AD                   ; 0363: 08 ; Add RAM[DP] to ACC, skip next instruction if carry (ACC + RAM[DP] > 15) ;  [CONDITIONAL: skip next on carry]
    JCP sub_036A         ; 0364: EA ; Jump to address 0x036A in current page (page 0x0340 + offset 0x2A)
    CLC                  ; 0365: 0B ; Reset Carry F/F
sub_0366:
    LDI 0x4D             ; 0366: 15 4D ; Load DP with 0x4D (DPH = 0x4, DPL = 0xD)
    TMB 0                ; 0368: 58 ; Skip next instruction if RAM[DP] bit 0 is set (RAM[DP] & 0x1 != 0) ;  [CONDITIONAL: skip next on bit 0 of RAM]
    JCP sub_036C         ; 0369: EC ; Jump to address 0x036C in current page (page 0x0340 + offset 0x2C)
sub_036A:
    JMP sub_038D         ; 036A: A3 8D ; Jump to absolute address 0x038D
sub_036C:
    LDI 0x2B             ; 036C: 15 2B ; Load DP with 0x2B (DPH = 0x2, DPL = 0xB)
    LI 0                 ; 036E: 90 ; Load ACC with 0x0
    CM                   ; 036F: 0C ; Compare ACC with RAM[DP], skip next instruction if ACC == RAM[DP] ;  [CONDITIONAL: skip next on ACC equals RAM]
    JCP sub_036A         ; 0370: EA ; Jump to address 0x036A in current page (page 0x0340 + offset 0x2A)
    XC                   ; 0371: 1A ; Exchange Carry F/F with Carry Save F/F
    XMI 3                ; 0372: 3F ; Exchange ACC with RAM[DP], XOR DPH with 0x3, increment DPL, skip next if DPL overflows to 0 ;  [CONDITIONAL: skip next on carry (DPl==0) after increment]
    STC                  ; 0373: 1B ; Set Carry F/F
    CM                   ; 0374: 0C ; Compare ACC with RAM[DP], skip next instruction if ACC == RAM[DP] ;  [CONDITIONAL: skip next on ACC equals RAM]
    CLC                  ; 0375: 0B ; Reset Carry F/F
    LM 0                 ; 0376: 38 ; Load ACC with RAM[DP] (ACC = RAM[DP])
    TPA 2                ; 0377: 56 ; Skip next instruction if input port A bit 2 is set (portA & 0x4 != 0) ;  [CONDITIONAL: skip next on bit 2 of input port A]
    JCP sub_037D         ; 0378: FD ; Jump to address 0x037D in current page (page 0x0340 + offset 0x3D)
    TMB 0                ; 0379: 58 ; Skip next instruction if RAM[DP] bit 0 is set (RAM[DP] & 0x1 != 0) ;  [CONDITIONAL: skip next on bit 0 of RAM]
    RAR                  ; 037A: 30 ; Rotate ACC Right through Carry F/F
    JMP sub_0383         ; 037B: A3 83 ; Jump to absolute address 0x0383
sub_037D:
    TPA 1                ; 037D: 55 ; Skip next instruction if input port A bit 1 is set (portA & 0x2 != 0) ;  [CONDITIONAL: skip next on bit 1 of input port A]
    JMP sub_038A         ; 037E: A3 8A ; Jump to absolute address 0x038A
    TC                   ; 0380: 04 ; skip next on Carry F/F ;  [CONDITIONAL: skip next on Carry F/F]
    AD                   ; 0381: 08 ; Add RAM[DP] to ACC, skip next instruction if carry (ACC + RAM[DP] > 15) ;  [CONDITIONAL: skip next on carry]
    NOP                  ; 0382: 00 ; No Operation
sub_0383:
    XC                   ; 0383: 1A ; Exchange Carry F/F with Carry Save F/F
sub_0384:
    XMD 3                ; 0384: 2F ; Exchange ACC with RAM[DP], XOR DPH with 0x3, decrement DPL, skip next if DPL underflows to 15 ;  [CONDITIONAL: skip next on carry (DPl==0xF) after decrement]
    TC                   ; 0385: 04 ; skip next on Carry F/F ;  [CONDITIONAL: skip next on Carry F/F]
    LI 15                ; 0386: 9F ; Load ACC with 0xF, skip next LI instruction, resume at 0x0388
    LI 3                 ; 0387: 93 ; Load ACC with 0x3
    S                    ; 0388: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
    JCP sub_038D         ; 0389: CD ; Jump to address 0x038D in current page (page 0x0380 + offset 0x0D)
sub_038A:
    XC                   ; 038A: 1A ; Exchange Carry F/F with Carry Save F/F
    TC                   ; 038B: 04 ; skip next on Carry F/F ;  [CONDITIONAL: skip next on Carry F/F]
    JCP sub_0384         ; 038C: C4 ; Jump to address 0x0384 in current page (page 0x0380 + offset 0x04)
sub_038D:
    CZP L0024            ; 038D: B9 ; Call subroutine at zero page address 0x0024 (page 9 << 2)
    LDI 0x1C             ; 038E: 15 1C ; Load DP with 0x1C (DPH = 0x1, DPL = 0xC)
    LM 3                 ; 0390: 3B ; Load ACC with RAM[DP], XOR DPH with 0x3 (ACC = RAM[DP]; DPH ^= 0x3)
    TAW                  ; 0391: 43 ; Transfer ACC to W
    LM 0                 ; 0392: 38 ; Load ACC with RAM[DP] (ACC = RAM[DP])
    TAZ                  ; 0393: 42 ; Transfer ACC to Z
    LDI 0x78             ; 0394: 15 78 ; Load DP with 0x78 (DPH = 0x7, DPL = 0x8)
    XMD 0                ; 0396: 2C ; Exchange ACC with RAM[DP], decrement DPL, skip next if DPL underflows to 15 ;  [CONDITIONAL: skip next on carry (DPl==0xF) after decrement]
    XAW                  ; 0397: 4B ; Exchange ACC with W
    TAW                  ; 0398: 43 ; Transfer ACC to W
    CI 0xC0              ; 0399: 17 C0 ; Compare ACC with 0xC0, skip next instruction if ACC == 0xC0 ;  [CONDITIONAL: skip next on ACC equals X]
    JCP sub_039F         ; 039B: DF ; Jump to address 0x039F in current page (page 0x0380 + offset 0x1F)
    LI 7                 ; 039C: 97 ; Load ACC with 0x7
    S                    ; 039D: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
    JCP sub_03A5         ; 039E: E5 ; Jump to address 0x03A5 in current page (page 0x0380 + offset 0x25)
sub_039F:
    DED                  ; 039F: 13 ; Decrement DPL (DPL = DPL - 1), skip next instruction if DPL underflows to 15 ;  [CONDITIONAL: skip next on carry (DPl==0xF)]
sub_03A0:
    S                    ; 03A0: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
    DED                  ; 03A1: 13 ; Decrement DPL (DPL = DPL - 1), skip next instruction if DPL underflows to 15 ;  [CONDITIONAL: skip next on carry (DPl==0xF)]
    CLI 3                ; 03A2: 16 E3 ; Compare DPL with 3, skip next instruction if DPL == 3 ;  [CONDITIONAL: skip next on DPl equals X]
    JCP sub_03A0         ; 03A4: E0 ; Jump to address 0x03A0 in current page (page 0x0380 + offset 0x20)
sub_03A5:
    XAZ                  ; 03A5: 4A ; Exchange ACC with Z
    LDI 0x2E             ; 03A6: 15 2E ; Load DP with 0x2E (DPH = 0x2, DPL = 0xE)
    CAL sub_0670         ; 03A8: AE 70 ; Call subroutine at absolute address 0x0670 (push return address to stack)
    JCP sub_03AF         ; 03AA: EF ; Jump to address 0x03AF in current page (page 0x0380 + offset 0x2F)
    CAL sub_0670         ; 03AB: AE 70 ; Call subroutine at absolute address 0x0670 (push return address to stack)
    JCP sub_03B0         ; 03AD: F0 ; Jump to address 0x03B0 in current page (page 0x0380 + offset 0x30)
    JCP sub_03B5         ; 03AE: F5 ; Jump to address 0x03B5 in current page (page 0x0380 + offset 0x35)
sub_03AF:
    LI 9                 ; 03AF: 99 ; Load ACC with 0x9, skip next LI instruction, resume at 0x03B1
sub_03B0:
    LI 11                ; 03B0: 9B ; Load ACC with 0xB
    LDZ 0xA              ; 03B1: 8A ; Load DP with 0x0A (DPH = 0, DPL = 0xA)
    S                    ; 03B2: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
    JMP sub_0502         ; 03B3: A5 02 ; Jump to absolute address 0x0502
sub_03B5:
    CZP L001C            ; 03B5: B7 ; Call subroutine at zero page address 0x001C (page 7 << 2)
    OCD 0x01             ; 03B6: 1E 01 ; Output 0x0 to port D, 0x1 to port C
    LM 2                 ; 03B8: 3A ; Load ACC with RAM[DP], XOR DPH with 0x2 (ACC = RAM[DP]; DPH ^= 0x2)
sub_03B9:
    EXL                  ; 03B9: 18 ; XOR ACC with RAM[DP] (ACC = ACC ^ RAM[DP])
    IND                  ; 03BA: 33 ; Increment DPL (DPL = DPL + 1), skip next instruction if DPL overflows to 0 ;  [CONDITIONAL: skip next on carry (DPl==0)]
    JCP sub_03B9         ; 03BB: F9 ; Jump to address 0x03B9 in current page (page 0x0380 + offset 0x39)
    LDI 0x14             ; 03BC: 15 14 ; Load DP with 0x14 (DPH = 0x1, DPL = 0x4)
    ADC                  ; 03BE: 19 ; Add RAM[DP] and carry to ACC, store carry flag (ACC = ACC + RAM[DP] + carry)
    XMI 0                ; 03BF: 3C ; Exchange ACC with RAM[DP], increment DPL, skip next if DPL overflows to 0 ;  [CONDITIONAL: skip next on carry (DPl==0) after increment]
    ADC                  ; 03C0: 19 ; Add RAM[DP] and carry to ACC, store carry flag (ACC = ACC + RAM[DP] + carry)
    S                    ; 03C1: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
    CAL sub_05C2         ; 03C2: AD C2 ; Call subroutine at absolute address 0x05C2 (push return address to stack)
    CAL sub_05C6         ; 03C4: AD C6 ; Call subroutine at absolute address 0x05C6 (push return address to stack)
    CZP L001C            ; 03C6: B7 ; Call subroutine at zero page address 0x001C (page 7 << 2)
    SEB 0                ; 03C7: 74 ; Set bit 0 of output port E (portE |= 0x1)
    CAL sub_05CE         ; 03C8: AD CE ; Call subroutine at absolute address 0x05CE (push return address to stack)
    STM 0x01             ; 03CA: 14 81 ; Reset Timer F/F, Start Timer with 0x01 (126 ticks)
    CAL sub_05D6         ; 03CC: AD D6 ; Call subroutine at absolute address 0x05D6 (push return address to stack)
    LDI 0x49             ; 03CE: 15 49 ; Load DP with 0x49 (DPH = 0x4, DPL = 0x9)
    DEM                  ; 03D0: 1F ; Decrement RAM[DP] (RAM[DP] = RAM[DP] - 1), skip next if RAM[DP] underflows to 15 ;  [CONDITIONAL: skip next on carry (RAM==0xF)]
    JCP sub_03EB         ; 03D1: EB ; Jump to address 0x03EB in current page (page 0x03C0 + offset 0x2B)
    LI 3                 ; 03D2: 93 ; Load ACC with 0x3
    XMI 0                ; 03D3: 3C ; Exchange ACC with RAM[DP], increment DPL, skip next if DPL overflows to 0 ;  [CONDITIONAL: skip next on carry (DPl==0) after increment]
sub_03D4:
    CZP L002C            ; 03D4: BB ; Call subroutine at zero page address 0x002C (page 11 << 2)
    IND                  ; 03D5: 33 ; Increment DPL (DPL = DPL + 1), skip next instruction if DPL overflows to 0 ;  [CONDITIONAL: skip next on carry (DPl==0)]
    CLI 13               ; 03D6: 16 ED ; Compare DPL with 13, skip next instruction if DPL == 13 ;  [CONDITIONAL: skip next on DPl equals X]
    JCP sub_03D4         ; 03D8: D4 ; Jump to address 0x03D4 in current page (page 0x03C0 + offset 0x14)
    INM                  ; 03D9: 1D ; Increment RAM[DP] (RAM[DP] = RAM[DP] + 1), skip next if RAM[DP] overflows to 0 ;  [CONDITIONAL: skip next on carry (RAM==0)]
    JCP sub_03E0         ; 03DA: E0 ; Jump to address 0x03E0 in current page (page 0x03C0 + offset 0x20)
    LI 14                ; 03DB: 9E ; Load ACC with 0xE
    XMI 0                ; 03DC: 3C ; Exchange ACC with RAM[DP], increment DPL, skip next if DPL overflows to 0 ;  [CONDITIONAL: skip next on carry (DPl==0) after increment]
sub_03DD:
    CZP L002C            ; 03DD: BB ; Call subroutine at zero page address 0x002C (page 11 << 2)
    IND                  ; 03DE: 33 ; Increment DPL (DPL = DPL + 1), skip next instruction if DPL overflows to 0 ;  [CONDITIONAL: skip next on carry (DPl==0)]
    JCP sub_03DD         ; 03DF: DD ; Jump to address 0x03DD in current page (page 0x03C0 + offset 0x1D)
sub_03E0:
    LDZ 0xB              ; 03E0: 8B ; Load DP with 0x0B (DPH = 0, DPL = 0xB)
    CZP L002C            ; 03E1: BB ; Call subroutine at zero page address 0x002C (page 11 << 2)
    LM 2                 ; 03E2: 3A ; Load ACC with RAM[DP], XOR DPH with 0x2 (ACC = RAM[DP]; DPH ^= 0x2)
    CZP L002C            ; 03E3: BB ; Call subroutine at zero page address 0x002C (page 11 << 2)
    LDI 0x18             ; 03E4: 15 18 ; Load DP with 0x18 (DPH = 0x1, DPL = 0x8)
sub_03E6:
    CZP L002C            ; 03E6: BB ; Call subroutine at zero page address 0x002C (page 11 << 2)
    IND                  ; 03E7: 33 ; Increment DPL (DPL = DPL + 1), skip next instruction if DPL overflows to 0 ;  [CONDITIONAL: skip next on carry (DPl==0)]
    CLI 11               ; 03E8: 16 EB ; Compare DPL with 11, skip next instruction if DPL == 11 ;  [CONDITIONAL: skip next on DPl equals X]
    JCP sub_03E6         ; 03EA: E6 ; Jump to address 0x03E6 in current page (page 0x03C0 + offset 0x26)
sub_03EB:
    CZP L001C            ; 03EB: B7 ; Call subroutine at zero page address 0x001C (page 7 << 2)
    SEB 1                ; 03EC: 75 ; Set bit 1 of output port E (portE |= 0x2)
    LDI 0x43             ; 03ED: 15 43 ; Load DP with 0x43 (DPH = 0x4, DPL = 0x3)
    SMB 3                ; 03EF: 7B ; Set bit 3 of RAM[DP] (RAM[DP] |= 0x8)
    LM 3                 ; 03F0: 3B ; Load ACC with RAM[DP], XOR DPH with 0x3 (ACC = RAM[DP]; DPH ^= 0x3)
    S                    ; 03F1: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
    JMP sub_040D         ; 03F2: A4 0D ; Jump to absolute address 0x040D
sub_03F4:
    XAW                  ; 03F4: 4B ; Exchange ACC with W
    TAW                  ; 03F5: 43 ; Transfer ACC to W
sub_03F6:
    CM                   ; 03F6: 0C ; Compare ACC with RAM[DP], skip next instruction if ACC == RAM[DP] ;  [CONDITIONAL: skip next on ACC equals RAM]
    RT                   ; 03F7: 48 ; Return from subroutine
    LM 3                 ; 03F8: 3B ; Load ACC with RAM[DP], XOR DPH with 0x3 (ACC = RAM[DP]; DPH ^= 0x3)
    LM 0                 ; 03F9: 38 ; Load ACC with RAM[DP] (ACC = RAM[DP])
    CZP L003C            ; 03FA: BF ; Call subroutine at zero page address 0x003C (page 15 << 2)
    CI 0xCF              ; 03FB: 17 CF ; Compare ACC with 0xCF, skip next instruction if ACC == 0xCF ;  [CONDITIONAL: skip next on ACC equals X]
    RT                   ; 03FD: 48 ; Return from subroutine
    SMB 2                ; 03FE: 7A ; Set bit 2 of RAM[DP] (RAM[DP] |= 0x4)
    RT                   ; 03FF: 48 ; Return from subroutine
sub_0400:
    CZP L001C            ; 0400: B7 ; Call subroutine at zero page address 0x001C (page 7 << 2)
    LDI 0x43             ; 0401: 15 43 ; Load DP with 0x43 (DPH = 0x4, DPL = 0x3)
    CLC                  ; 0403: 0B ; Reset Carry F/F
    LM 0                 ; 0404: 38 ; Load ACC with RAM[DP] (ACC = RAM[DP])
    OP                   ; 0405: 0E ; Output ACC to port specified by DPL (port[DPL] = ACC)
    RAR                  ; 0406: 30 ; Rotate ACC Right through Carry F/F
    XMD 0                ; 0407: 2C ; Exchange ACC with RAM[DP], decrement DPL, skip next if DPL underflows to 15 ;  [CONDITIONAL: skip next on carry (DPl==0xF) after decrement]
    LM 0                 ; 0408: 38 ; Load ACC with RAM[DP] (ACC = RAM[DP])
    OP                   ; 0409: 0E ; Output ACC to port specified by DPL (port[DPL] = ACC)
    RAR                  ; 040A: 30 ; Rotate ACC Right through Carry F/F
    XMI 3                ; 040B: 3F ; Exchange ACC with RAM[DP], XOR DPH with 0x3, increment DPL, skip next if DPL overflows to 0 ;  [CONDITIONAL: skip next on carry (DPl==0) after increment]
    DEM                  ; 040C: 1F ; Decrement RAM[DP] (RAM[DP] = RAM[DP] - 1), skip next if RAM[DP] underflows to 15 ;  [CONDITIONAL: skip next on carry (RAM==0xF)]
sub_040D:
    SFB 0                ; 040D: 7C ; Set bit 0 of FLAG register (FLAG |= 0x1)
    CAL sub_05A7         ; 040E: AD A7 ; Call subroutine at absolute address 0x05A7 (push return address to stack)
    RFB 0                ; 0410: 6C ; Reset bit 0 of FLAG register (FLAG &= ~0x1)
    CAL sub_05A7         ; 0411: AD A7 ; Call subroutine at absolute address 0x05A7 (push return address to stack)
    LDI 0x42             ; 0413: 15 42 ; Load DP with 0x42 (DPH = 0x4, DPL = 0x2)
    TMB 0                ; 0415: 58 ; Skip next instruction if RAM[DP] bit 0 is set (RAM[DP] & 0x1 != 0) ;  [CONDITIONAL: skip next on bit 0 of RAM]
    JCP sub_0419         ; 0416: D9 ; Jump to address 0x0419 in current page (page 0x0400 + offset 0x19)
    JMP sub_0470         ; 0417: A4 70 ; Jump to absolute address 0x0470
sub_0419:
    IND                  ; 0419: 33 ; Increment DPL (DPL = DPL + 1), skip next instruction if DPL overflows to 0 ;  [CONDITIONAL: skip next on carry (DPl==0)]
    TMB 3                ; 041A: 5B ; Skip next instruction if RAM[DP] bit 3 is set (RAM[DP] & 0x8 != 0) ;  [CONDITIONAL: skip next on bit 3 of RAM]
    JCP sub_043D         ; 041B: FD ; Jump to address 0x043D in current page (page 0x0400 + offset 0x3D)
    LDI 0x20             ; 041C: 15 20 ; Load DP with 0x20 (DPH = 0x2, DPL = 0x0)
    LM 1                 ; 041E: 39 ; Load ACC with RAM[DP], XOR DPH with 0x1 (ACC = RAM[DP]; DPH ^= 0x1)
    CLC                  ; 041F: 0B ; Reset Carry F/F
    TMB 0                ; 0420: 58 ; Skip next instruction if RAM[DP] bit 0 is set (RAM[DP] & 0x1 != 0) ;  [CONDITIONAL: skip next on bit 0 of RAM]
    STC                  ; 0421: 1B ; Set Carry F/F
    LDZ 0x6              ; 0422: 86 ; Load DP with 0x06 (DPH = 0, DPL = 0x6)
    CZP L0034            ; 0423: BD ; Call subroutine at zero page address 0x0034 (page 13 << 2)
    TC                   ; 0424: 04 ; skip next on Carry F/F ;  [CONDITIONAL: skip next on Carry F/F]
    SMB 0                ; 0425: 78 ; Set bit 0 of RAM[DP] (RAM[DP] |= 0x1)
    LI 9                 ; 0426: 99 ; Load ACC with 0x9
    CAL sub_06E8         ; 0427: AE E8 ; Call subroutine at absolute address 0x06E8 (push return address to stack)
    LDI 0x29             ; 0429: 15 29 ; Load DP with 0x29 (DPH = 0x2, DPL = 0x9)
    LM 1                 ; 042B: 39 ; Load ACC with RAM[DP], XOR DPH with 0x1 (ACC = RAM[DP]; DPH ^= 0x1)
    CLC                  ; 042C: 0B ; Reset Carry F/F
    TMB 0                ; 042D: 58 ; Skip next instruction if RAM[DP] bit 0 is set (RAM[DP] & 0x1 != 0) ;  [CONDITIONAL: skip next on bit 0 of RAM]
    STC                  ; 042E: 1B ; Set Carry F/F
    CZP L0038            ; 042F: BE ; Call subroutine at zero page address 0x0038 (page 14 << 2)
    TC                   ; 0430: 04 ; skip next on Carry F/F ;  [CONDITIONAL: skip next on Carry F/F]
    SMB 1                ; 0431: 79 ; Set bit 1 of RAM[DP] (RAM[DP] |= 0x2)
    LDI 0x2A             ; 0432: 15 2A ; Load DP with 0x2A (DPH = 0x2, DPL = 0xA)
    LM 1                 ; 0434: 39 ; Load ACC with RAM[DP], XOR DPH with 0x1 (ACC = RAM[DP]; DPH ^= 0x1)
    CLC                  ; 0435: 0B ; Reset Carry F/F
    TMB 0                ; 0436: 58 ; Skip next instruction if RAM[DP] bit 0 is set (RAM[DP] & 0x1 != 0) ;  [CONDITIONAL: skip next on bit 0 of RAM]
    STC                  ; 0437: 1B ; Set Carry F/F
    CZP L003C            ; 0438: BF ; Call subroutine at zero page address 0x003C (page 15 << 2)
    TC                   ; 0439: 04 ; skip next on Carry F/F ;  [CONDITIONAL: skip next on Carry F/F]
    SMB 2                ; 043A: 7A ; Set bit 2 of RAM[DP] (RAM[DP] |= 0x4)
    JMP sub_0489         ; 043B: A4 89 ; Jump to absolute address 0x0489
sub_043D:
    LDI 0x73             ; 043D: 15 73 ; Load DP with 0x73 (DPH = 0x7, DPL = 0x3)
    LI 6                 ; 043F: 96 ; Load ACC with 0x6
    AD                   ; 0440: 08 ; Add RAM[DP] to ACC, skip next instruction if carry (ACC + RAM[DP] > 15) ;  [CONDITIONAL: skip next on carry]
    CMA                  ; 0441: 10 ; Complement ACC
    LDI 0x27             ; 0442: 15 27 ; Load DP with 0x27 (DPH = 0x2, DPL = 0x7)
    TAL                  ; 0444: 07 ; Transfer ACC to DPL (lower 4 bits of data pointer)
    LM 1                 ; 0445: 39 ; Load ACC with RAM[DP], XOR DPH with 0x1 (ACC = RAM[DP]; DPH ^= 0x1)
    CLC                  ; 0446: 0B ; Reset Carry F/F
    TMB 0                ; 0447: 58 ; Skip next instruction if RAM[DP] bit 0 is set (RAM[DP] & 0x1 != 0) ;  [CONDITIONAL: skip next on bit 0 of RAM]
    STC                  ; 0448: 1B ; Set Carry F/F
    LDZ 0x6              ; 0449: 86 ; Load DP with 0x06 (DPH = 0, DPL = 0x6)
    CZP L0034            ; 044A: BD ; Call subroutine at zero page address 0x0034 (page 13 << 2)
    TC                   ; 044B: 04 ; skip next on Carry F/F ;  [CONDITIONAL: skip next on Carry F/F]
    SMB 0                ; 044C: 78 ; Set bit 0 of RAM[DP] (RAM[DP] |= 0x1)
    XAW                  ; 044D: 4B ; Exchange ACC with W
    TAW                  ; 044E: 43 ; Transfer ACC to W
    CAL sub_06E8         ; 044F: AE E8 ; Call subroutine at absolute address 0x06E8 (push return address to stack)
    LDI 0x73             ; 0451: 15 73 ; Load DP with 0x73 (DPH = 0x7, DPL = 0x3)
    LI 7                 ; 0453: 97 ; Load ACC with 0x7
    CM                   ; 0454: 0C ; Compare ACC with RAM[DP], skip next instruction if ACC == RAM[DP] ;  [CONDITIONAL: skip next on ACC equals RAM]
    JCP sub_047C         ; 0455: FC ; Jump to address 0x047C in current page (page 0x0440 + offset 0x3C)
    LDI 0x2D             ; 0456: 15 2D ; Load DP with 0x2D (DPH = 0x2, DPL = 0xD)
    LI 8                 ; 0458: 98 ; Load ACC with 0x8
    CAL sub_03F6         ; 0459: AB F6 ; Call subroutine at absolute address 0x03F6 (push return address to stack)
    RFB 0                ; 045B: 6C ; Reset bit 0 of FLAG register (FLAG &= ~0x1)
    LDI 0x21             ; 045C: 15 21 ; Load DP with 0x21 (DPH = 0x2, DPL = 0x1)
    LM 1                 ; 045E: 39 ; Load ACC with RAM[DP], XOR DPH with 0x1 (ACC = RAM[DP]; DPH ^= 0x1)
    CLC                  ; 045F: 0B ; Reset Carry F/F
    TMB 0                ; 0460: 58 ; Skip next instruction if RAM[DP] bit 0 is set (RAM[DP] & 0x1 != 0) ;  [CONDITIONAL: skip next on bit 0 of RAM]
    STC                  ; 0461: 1B ; Set Carry F/F
    CZP L003C            ; 0462: BF ; Call subroutine at zero page address 0x003C (page 15 << 2)
    TC                   ; 0463: 04 ; skip next on Carry F/F ;  [CONDITIONAL: skip next on Carry F/F]
    SMB 2                ; 0464: 7A ; Set bit 2 of RAM[DP] (RAM[DP] |= 0x4)
    LDI 0x28             ; 0465: 15 28 ; Load DP with 0x28 (DPH = 0x2, DPL = 0x8)
    LM 1                 ; 0467: 39 ; Load ACC with RAM[DP], XOR DPH with 0x1 (ACC = RAM[DP]; DPH ^= 0x1)
    CLC                  ; 0468: 0B ; Reset Carry F/F
    TMB 0                ; 0469: 58 ; Skip next instruction if RAM[DP] bit 0 is set (RAM[DP] & 0x1 != 0) ;  [CONDITIONAL: skip next on bit 0 of RAM]
    STC                  ; 046A: 1B ; Set Carry F/F
    CZP L0038            ; 046B: BE ; Call subroutine at zero page address 0x0038 (page 14 << 2)
    TC                   ; 046C: 04 ; skip next on Carry F/F ;  [CONDITIONAL: skip next on Carry F/F]
    SMB 1                ; 046D: 79 ; Set bit 1 of RAM[DP] (RAM[DP] |= 0x2)
    JMP sub_0489         ; 046E: A4 89 ; Jump to absolute address 0x0489
sub_0470:
    LDZ 0xF              ; 0470: 8F ; Load DP with 0x0F (DPH = 0, DPL = 0xF)
    LI 15                ; 0471: 9F ; Load ACC with 0xF
    AD                   ; 0472: 08 ; Add RAM[DP] to ACC, skip next instruction if carry (ACC + RAM[DP] > 15) ;  [CONDITIONAL: skip next on carry]
    JCP sub_047C         ; 0473: FC ; Jump to address 0x047C in current page (page 0x0440 + offset 0x3C)
    LM 0                 ; 0474: 38 ; Load ACC with RAM[DP] (ACC = RAM[DP])
    LDI 0x44             ; 0475: 15 44 ; Load DP with 0x44 (DPH = 0x4, DPL = 0x4)
    TAB 3                ; 0477: 27 ; Skip next instruction if ACC bit 3 is set (ACC & 0x8 != 0) ;  [CONDITIONAL: skip next on bit 3 of ACC]
    LDI 0x1C             ; 0478: 15 1C ; Load DP with 0x1C (DPH = 0x1, DPL = 0xC)
    CAL sub_06ED         ; 047A: AE ED ; Call subroutine at absolute address 0x06ED (push return address to stack)
sub_047C:
    LDI 0x2E             ; 047C: 15 2E ; Load DP with 0x2E (DPH = 0x2, DPL = 0xE)
    CAL sub_03F4         ; 047E: AB F4 ; Call subroutine at absolute address 0x03F4 (push return address to stack)
    LDI 0x2F             ; 0480: 15 2F ; Load DP with 0x2F (DPH = 0x2, DPL = 0xF)
    CAL sub_03F4         ; 0482: AB F4 ; Call subroutine at absolute address 0x03F4 (push return address to stack)
    XAW                  ; 0484: 4B ; Exchange ACC with W
    LDI 0x2C             ; 0485: 15 2C ; Load DP with 0x2C (DPH = 0x2, DPL = 0xC)
    CAL sub_05AF         ; 0487: AD AF ; Call subroutine at absolute address 0x05AF (push return address to stack)
sub_0489:
    FBT 2                ; 0489: 5E ; Skip next instruction if FLAG bit 2 is set (FLAG & 0x4 != 0) ;  [CONDITIONAL: skip next on bit 2 of FLAG]
    JCP sub_04A0         ; 048A: E0 ; Jump to address 0x04A0 in current page (page 0x0480 + offset 0x20)
    LDZ 0x4              ; 048B: 84 ; Load DP with 0x04 (DPH = 0, DPL = 0x4)
    THX                  ; 048C: 47 ; Transfer DPh to X
    LDI 0x78             ; 048D: 15 78 ; Load DP with 0x78 (DPH = 0x7, DPL = 0x8)
    LM 0                 ; 048F: 38 ; Load ACC with RAM[DP] (ACC = RAM[DP])
    LDI 0x73             ; 0490: 15 73 ; Load DP with 0x73 (DPH = 0x7, DPL = 0x3)
    CM                   ; 0492: 0C ; Compare ACC with RAM[DP], skip next instruction if ACC == RAM[DP] ;  [CONDITIONAL: skip next on ACC equals RAM]
    JCP sub_04A0         ; 0493: E0 ; Jump to address 0x04A0 in current page (page 0x0480 + offset 0x20)
sub_0494:
    REB 1                ; 0494: 65 ; Reset bit 1 of output port E (portE &= ~0x2)
    OCD 0x00             ; 0495: 1E 00 ; Output 0x0 to port D, 0x0 to port C
    IND                  ; 0497: 33 ; Increment DPL (DPL = DPL + 1), skip next instruction if DPL overflows to 0 ;  [CONDITIONAL: skip next on carry (DPl==0)]
    LM 0                 ; 0498: 38 ; Load ACC with RAM[DP] (ACC = RAM[DP])
    XHX                  ; 0499: 4F ; Exchange DPh with X
    EXL                  ; 049A: 18 ; XOR ACC with RAM[DP] (ACC = ACC ^ RAM[DP])
    S                    ; 049B: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
    XHX                  ; 049C: 4F ; Exchange DPh with X
    CLI 7                ; 049D: 16 E7 ; Compare DPL with 7, skip next instruction if DPL == 7 ;  [CONDITIONAL: skip next on DPl equals X]
    JCP sub_0494         ; 049F: D4 ; Jump to address 0x0494 in current page (page 0x0480 + offset 0x14)
sub_04A0:
    LDI 0x42             ; 04A0: 15 42 ; Load DP with 0x42 (DPH = 0x4, DPL = 0x2)
    TMB 0                ; 04A2: 58 ; Skip next instruction if RAM[DP] bit 0 is set (RAM[DP] & 0x1 != 0) ;  [CONDITIONAL: skip next on bit 0 of RAM]
    JMP sub_0400         ; 04A3: A4 00 ; Jump to absolute address 0x0400
    RMB 0                ; 04A5: 68 ; Reset bit 0 of RAM[DP] (RAM[DP] &= ~0x1)
sub_04A6:
    TTM                  ; 04A6: 05 ; skip next on Timer F/F ;  [CONDITIONAL: skip next on Timer F/F]
    JCP sub_04A6         ; 04A7: E6 ; Jump to address 0x04A6 in current page (page 0x0480 + offset 0x26)
    OCD 0x00             ; 04A8: 1E 00 ; Output 0x0 to port D, 0x0 to port C
    JMP L0057            ; 04AA: A0 57 ; Jump to absolute address 0x0057
sub_04AC:
    LDZ 0x9              ; 04AC: 89 ; Load DP with 0x09 (DPH = 0, DPL = 0x9)
    LM 0                 ; 04AD: 38 ; Load ACC with RAM[DP] (ACC = RAM[DP])
    TAW                  ; 04AE: 43 ; Transfer ACC to W
    LDZ 0xA              ; 04AF: 8A ; Load DP with 0x0A (DPH = 0, DPL = 0xA)
    LI 2                 ; 04B0: 92 ; Load ACC with 0x2
    CM                   ; 04B1: 0C ; Compare ACC with RAM[DP], skip next instruction if ACC == RAM[DP] ;  [CONDITIONAL: skip next on ACC equals RAM]
    LI 4                 ; 04B2: 94 ; Load ACC with 0x4
    CM                   ; 04B3: 0C ; Compare ACC with RAM[DP], skip next instruction if ACC == RAM[DP] ;  [CONDITIONAL: skip next on ACC equals RAM]
    JCP sub_04B7         ; 04B4: F7 ; Jump to address 0x04B7 in current page (page 0x0480 + offset 0x37)
    JMP sub_04CF         ; 04B5: A4 CF ; Jump to absolute address 0x04CF
sub_04B7:
    LDZ 0xB              ; 04B7: 8B ; Load DP with 0x0B (DPH = 0, DPL = 0xB)
    LI 0                 ; 04B8: 90 ; Load ACC with 0x0
    CM                   ; 04B9: 0C ; Compare ACC with RAM[DP], skip next instruction if ACC == RAM[DP] ;  [CONDITIONAL: skip next on ACC equals RAM]
    JMP sub_0560         ; 04BA: A5 60 ; Jump to absolute address 0x0560
    LI 1                 ; 04BC: 91 ; Load ACC with 0x1
    XMI 0                ; 04BD: 3C ; Exchange ACC with RAM[DP], increment DPL, skip next if DPL overflows to 0 ;  [CONDITIONAL: skip next on carry (DPl==0) after increment]
    LI 1                 ; 04BE: 91 ; Load ACC with 0x1
    CM                   ; 04BF: 0C ; Compare ACC with RAM[DP], skip next instruction if ACC == RAM[DP] ;  [CONDITIONAL: skip next on ACC equals RAM]
    JCP sub_04C7         ; 04C0: C7 ; Jump to address 0x04C7 in current page (page 0x04C0 + offset 0x07)
    DEM                  ; 04C1: 1F ; Decrement RAM[DP] (RAM[DP] = RAM[DP] - 1), skip next if RAM[DP] underflows to 15 ;  [CONDITIONAL: skip next on carry (RAM==0xF)]
    LI 0                 ; 04C2: 90 ; Load ACC with 0x0
    LDZ 0xA              ; 04C3: 8A ; Load DP with 0x0A (DPH = 0, DPL = 0xA)
    S                    ; 04C4: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
    JMP L00BB            ; 04C5: A0 BB ; Jump to absolute address 0x00BB
sub_04C7:
    LI 0                 ; 04C7: 90 ; Load ACC with 0x0
    CM                   ; 04C8: 0C ; Compare ACC with RAM[DP], skip next instruction if ACC == RAM[DP] ;  [CONDITIONAL: skip next on ACC equals RAM]
    JCP sub_04CC         ; 04C9: CC ; Jump to address 0x04CC in current page (page 0x04C0 + offset 0x0C)
    LI 9                 ; 04CA: 99 ; Load ACC with 0x9
    S                    ; 04CB: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
sub_04CC:
    INM                  ; 04CC: 1D ; Increment RAM[DP] (RAM[DP] = RAM[DP] + 1), skip next if RAM[DP] overflows to 0 ;  [CONDITIONAL: skip next on carry (RAM==0)]
    JMP sub_0547         ; 04CD: A5 47 ; Jump to absolute address 0x0547
sub_04CF:
    CAL sub_074E         ; 04CF: AF 4E ; Call subroutine at absolute address 0x074E (push return address to stack)
    RFB 2                ; 04D1: 6E ; Reset bit 2 of FLAG register (FLAG &= ~0x4)
    LDZ 0xA              ; 04D2: 8A ; Load DP with 0x0A (DPH = 0, DPL = 0xA)
    LI 1                 ; 04D3: 91 ; Load ACC with 0x1
    CM                   ; 04D4: 0C ; Compare ACC with RAM[DP], skip next instruction if ACC == RAM[DP] ;  [CONDITIONAL: skip next on ACC equals RAM]
    JMP sub_0500         ; 04D5: A5 00 ; Jump to absolute address 0x0500
    CAL sub_0755         ; 04D7: AF 55 ; Call subroutine at absolute address 0x0755 (push return address to stack)
    LDI 0x1B             ; 04D9: 15 1B ; Load DP with 0x1B (DPH = 0x1, DPL = 0xB)
    DEM                  ; 04DB: 1F ; Decrement RAM[DP] (RAM[DP] = RAM[DP] - 1), skip next if RAM[DP] underflows to 15 ;  [CONDITIONAL: skip next on carry (RAM==0xF)]
    JCP sub_04E8         ; 04DC: E8 ; Jump to address 0x04E8 in current page (page 0x04C0 + offset 0x28)
    CAL sub_077D         ; 04DD: AF 7D ; Call subroutine at absolute address 0x077D (push return address to stack)
sub_04DF:
    LDZ 0xF              ; 04DF: 8F ; Load DP with 0x0F (DPH = 0, DPL = 0xF)
    LI 0                 ; 04E0: 90 ; Load ACC with 0x0
    S                    ; 04E1: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
    LDZ 0xA              ; 04E2: 8A ; Load DP with 0x0A (DPH = 0, DPL = 0xA)
    S                    ; 04E3: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
    LDI 0x2F             ; 04E4: 15 2F ; Load DP with 0x2F (DPH = 0x2, DPL = 0xF)
    CZP L0030            ; 04E6: BC ; Call subroutine at zero page address 0x0030 (page 12 << 2)
    JCP sub_04FB         ; 04E7: FB ; Jump to address 0x04FB in current page (page 0x04C0 + offset 0x3B)
sub_04E8:
    LM 1                 ; 04E8: 39 ; Load ACC with RAM[DP], XOR DPH with 0x1 (ACC = RAM[DP]; DPH ^= 0x1)
    INC                  ; 04E9: 0D ; Increment ACC (ACC = ACC + 1), skip next instruction if ACC overflows to 0 ;  [CONDITIONAL: skip next on carry (ACC==0)]
    S                    ; 04EA: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
    LI 15                ; 04EB: 9F ; Load ACC with 0xF
    XM 0                 ; 04EC: 28 ; Exchange ACC with RAM[DP] (temp = ACC; ACC = RAM[DP]; RAM[DP] = temp)
    LDZ 0x3              ; 04ED: 83 ; Load DP with 0x03 (DPH = 0, DPL = 0x3)
    CAL sub_01FC         ; 04EE: A9 FC ; Call subroutine at absolute address 0x01FC (push return address to stack)
    LDZ 0x2              ; 04F0: 82 ; Load DP with 0x02 (DPH = 0, DPL = 0x2)
sub_04F1:
    LI 14                ; 04F1: 9E ; Load ACC with 0xE
    XMD 0                ; 04F2: 2C ; Exchange ACC with RAM[DP], decrement DPL, skip next if DPL underflows to 15 ;  [CONDITIONAL: skip next on carry (DPl==0xF) after decrement]
    JCP sub_04F1         ; 04F3: F1 ; Jump to address 0x04F1 in current page (page 0x04C0 + offset 0x31)
    CAL sub_0723         ; 04F4: AF 23 ; Call subroutine at absolute address 0x0723 (push return address to stack)
    LDZ 0xC              ; 04F6: 8C ; Load DP with 0x0C (DPH = 0, DPL = 0xC)
    INM                  ; 04F7: 1D ; Increment RAM[DP] (RAM[DP] = RAM[DP] + 1), skip next if RAM[DP] overflows to 0 ;  [CONDITIONAL: skip next on carry (RAM==0)]
    LM 1                 ; 04F8: 39 ; Load ACC with RAM[DP], XOR DPH with 0x1 (ACC = RAM[DP]; DPH ^= 0x1)
    LI 4                 ; 04F9: 94 ; Load ACC with 0x4
    S                    ; 04FA: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
sub_04FB:
    JMP sub_0560         ; 04FB: A5 60 ; Jump to absolute address 0x0560
sub_04FD:
    RFB 2                ; 04FD: 6E ; Reset bit 2 of FLAG register (FLAG &= ~0x4)
    JMP sub_0550         ; 04FE: A5 50 ; Jump to absolute address 0x0550
sub_0500:
    CAL sub_06F5         ; 0500: AE F5 ; Call subroutine at absolute address 0x06F5 (push return address to stack)
sub_0502:
    LDI 0x13             ; 0502: 15 13 ; Load DP with 0x13 (DPH = 0x1, DPL = 0x3)
sub_0504:
    CZP L0020            ; 0504: B8 ; Call subroutine at zero page address 0x0020 (page 8 << 2)
    LDZ 0xA              ; 0505: 8A ; Load DP with 0x0A (DPH = 0, DPL = 0xA)
    LI 8                 ; 0506: 98 ; Load ACC with 0x8
    AD                   ; 0507: 08 ; Add RAM[DP] to ACC, skip next instruction if carry (ACC + RAM[DP] > 15) ;  [CONDITIONAL: skip next on carry]
sub_0508:
    JCP sub_051B         ; 0508: DB ; Jump to address 0x051B in current page (page 0x0500 + offset 0x1B)
    LM 0                 ; 0509: 38 ; Load ACC with RAM[DP] (ACC = RAM[DP])
    TAW                  ; 050A: 43 ; Transfer ACC to W
    LDI 0x2F             ; 050B: 15 2F ; Load DP with 0x2F (DPH = 0x2, DPL = 0xF)
    TAB 1                ; 050D: 25 ; Skip next instruction if ACC bit 1 is set (ACC & 0x2 != 0) ;  [CONDITIONAL: skip next on bit 1 of ACC]
    DED                  ; 050E: 13 ; Decrement DPL (DPL = DPL - 1), skip next instruction if DPL underflows to 15 ;  [CONDITIONAL: skip next on carry (DPl==0xF)]
    LI 0                 ; 050F: 90 ; Load ACC with 0x0
sub_0510:
    S                    ; 0510: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
    XAW                  ; 0511: 4B ; Exchange ACC with W
    LDI 0x41             ; 0512: 15 41 ; Load DP with 0x41 (DPH = 0x4, DPL = 0x1)
sub_0514:
    TAB 1                ; 0514: 25 ; Skip next instruction if ACC bit 1 is set (ACC & 0x2 != 0) ;  [CONDITIONAL: skip next on bit 1 of ACC]
    DED                  ; 0515: 13 ; Decrement DPL (DPL = DPL - 1), skip next instruction if DPL underflows to 15 ;  [CONDITIONAL: skip next on carry (DPl==0xF)]
    LI 3                 ; 0516: 93 ; Load ACC with 0x3
    AD                   ; 0517: 08 ; Add RAM[DP] to ACC, skip next instruction if carry (ACC + RAM[DP] > 15) ;  [CONDITIONAL: skip next on carry]
sub_0518:
    LDZ 0x8              ; 0518: 88 ; Load DP with 0x08 (DPH = 0, DPL = 0x8)
    DEM                  ; 0519: 1F ; Decrement RAM[DP] (RAM[DP] = RAM[DP] - 1), skip next if RAM[DP] underflows to 15 ;  [CONDITIONAL: skip next on carry (RAM==0xF)]
    JCP sub_053A         ; 051A: FA ; Jump to address 0x053A in current page (page 0x0500 + offset 0x3A)
sub_051B:
    CLC                  ; 051B: 0B ; Reset Carry F/F
sub_051C:
    TMB 2                ; 051C: 5A ; Skip next instruction if RAM[DP] bit 2 is set (RAM[DP] & 0x4 != 0) ;  [CONDITIONAL: skip next on bit 2 of RAM]
    LI 1                 ; 051D: 91 ; Load ACC with 0x1, skip next LI instruction, resume at 0x051F
    LI 2                 ; 051E: 92 ; Load ACC with 0x2
    TMB 1                ; 051F: 59 ; Skip next instruction if RAM[DP] bit 1 is set (RAM[DP] & 0x2 != 0) ;  [CONDITIONAL: skip next on bit 1 of RAM]
sub_0520:
    TMB 2                ; 0520: 5A ; Skip next instruction if RAM[DP] bit 2 is set (RAM[DP] & 0x4 != 0) ;  [CONDITIONAL: skip next on bit 2 of RAM]
    TMB 2                ; 0521: 5A ; Skip next instruction if RAM[DP] bit 2 is set (RAM[DP] & 0x4 != 0) ;  [CONDITIONAL: skip next on bit 2 of RAM]
    STC                  ; 0522: 1B ; Set Carry F/F
    TAZ                  ; 0523: 42 ; Transfer ACC to Z
sub_0524:
    LDI 0x29             ; 0524: 15 29 ; Load DP with 0x29 (DPH = 0x2, DPL = 0x9)
    TAB 1                ; 0526: 25 ; Skip next instruction if ACC bit 1 is set (ACC & 0x2 != 0) ;  [CONDITIONAL: skip next on bit 1 of ACC]
    DED                  ; 0527: 13 ; Decrement DPL (DPL = DPL - 1), skip next instruction if DPL underflows to 15 ;  [CONDITIONAL: skip next on carry (DPl==0xF)]
sub_0528:
    TC                   ; 0528: 04 ; skip next on Carry F/F ;  [CONDITIONAL: skip next on Carry F/F]
    IND                  ; 0529: 33 ; Increment DPL (DPL = DPL + 1), skip next instruction if DPL overflows to 0 ;  [CONDITIONAL: skip next on carry (DPl==0)]
    XAW                  ; 052A: 4B ; Exchange ACC with W
    TAW                  ; 052B: 43 ; Transfer ACC to W
sub_052C:
    EXL                  ; 052C: 18 ; XOR ACC with RAM[DP] (ACC = ACC ^ RAM[DP])
    S                    ; 052D: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
    LM 1                 ; 052E: 39 ; Load ACC with RAM[DP], XOR DPH with 0x1 (ACC = RAM[DP]; DPH ^= 0x1)
    XAW                  ; 052F: 4B ; Exchange ACC with W
sub_0530:
    DEC                  ; 0530: 0F ; Decrement ACC (ACC = ACC - 1), skip next instruction if ACC underflows to 15 ;  [CONDITIONAL: skip next on carry (ACC==0xF)]
    JCP sub_0533         ; 0531: F3 ; Jump to address 0x0533 in current page (page 0x0500 + offset 0x33)
    RMB 0                ; 0532: 68 ; Reset bit 0 of RAM[DP] (RAM[DP] &= ~0x1)
sub_0533:
    LDI 0x11             ; 0533: 15 11 ; Load DP with 0x11 (DPH = 0x1, DPL = 0x1)
    TC                   ; 0535: 04 ; skip next on Carry F/F ;  [CONDITIONAL: skip next on Carry F/F]
    SMB 0                ; 0536: 78 ; Set bit 0 of RAM[DP] (RAM[DP] |= 0x1)
    XAZ                  ; 0537: 4A ; Exchange ACC with Z
sub_0538:
    TC                   ; 0538: 04 ; skip next on Carry F/F ;  [CONDITIONAL: skip next on Carry F/F]
    LI 0                 ; 0539: 90 ; Load ACC with 0x0
sub_053A:
    LDI 0x12             ; 053A: 15 12 ; Load DP with 0x12 (DPH = 0x1, DPL = 0x2)
sub_053C:
    S                    ; 053C: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
    LDZ 0xA              ; 053D: 8A ; Load DP with 0x0A (DPH = 0, DPL = 0xA)
    TMB 0                ; 053E: 58 ; Skip next instruction if RAM[DP] bit 0 is set (RAM[DP] & 0x1 != 0) ;  [CONDITIONAL: skip next on bit 0 of RAM]
    LI 0                 ; 053F: 90 ; Load ACC with 0x0, skip next LI instruction, resume at 0x0541
    LI 1                 ; 0540: 91 ; Load ACC with 0x1
    S                    ; 0541: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
    CAL sub_07A0         ; 0542: AF A0 ; Call subroutine at absolute address 0x07A0 (push return address to stack)
    JCP sub_0560         ; 0544: E0 ; Jump to address 0x0560 in current page (page 0x0540 + offset 0x20)
    JMP sub_04DF         ; 0545: A4 DF ; Jump to absolute address 0x04DF
sub_0547:
    SFB 2                ; 0547: 7E ; Set bit 2 of FLAG register (FLAG |= 0x4)
    TMB 0                ; 0548: 58 ; Skip next instruction if RAM[DP] bit 0 is set (RAM[DP] & 0x1 != 0) ;  [CONDITIONAL: skip next on bit 0 of RAM]
    RFB 2                ; 0549: 6E ; Reset bit 2 of FLAG register (FLAG &= ~0x4)
    LDI 0x78             ; 054A: 15 78 ; Load DP with 0x78 (DPH = 0x7, DPL = 0x8)
    LI 9                 ; 054C: 99 ; Load ACC with 0x9
    AD                   ; 054D: 08 ; Add RAM[DP] to ACC, skip next instruction if carry (ACC + RAM[DP] > 15) ;  [CONDITIONAL: skip next on carry]
    JCP sub_0550         ; 054E: D0 ; Jump to address 0x0550 in current page (page 0x0540 + offset 0x10)
    JCP sub_0560         ; 054F: E0 ; Jump to address 0x0560 in current page (page 0x0540 + offset 0x20)
sub_0550:
    LDZ 0xA              ; 0550: 8A ; Load DP with 0x0A (DPH = 0, DPL = 0xA)
    TMB 3                ; 0551: 5B ; Skip next instruction if RAM[DP] bit 3 is set (RAM[DP] & 0x8 != 0) ;  [CONDITIONAL: skip next on bit 3 of RAM]
    JCP sub_0560         ; 0552: E0 ; Jump to address 0x0560 in current page (page 0x0540 + offset 0x20)
    SFB 2                ; 0553: 7E ; Set bit 2 of FLAG register (FLAG |= 0x4)
    LDI 0x75             ; 0554: 15 75 ; Load DP with 0x75 (DPH = 0x7, DPL = 0x5)
    XMD 0                ; 0556: 2C ; Exchange ACC with RAM[DP], decrement DPL, skip next if DPL underflows to 15 ;  [CONDITIONAL: skip next on carry (DPl==0xF) after decrement]
    XMI 0                ; 0557: 3C ; Exchange ACC with RAM[DP], increment DPL, skip next if DPL overflows to 0 ;  [CONDITIONAL: skip next on carry (DPl==0) after increment]
    XMI 0                ; 0558: 3C ; Exchange ACC with RAM[DP], increment DPL, skip next if DPL overflows to 0 ;  [CONDITIONAL: skip next on carry (DPl==0) after increment]
    IND                  ; 0559: 33 ; Increment DPL (DPL = DPL + 1), skip next instruction if DPL overflows to 0 ;  [CONDITIONAL: skip next on carry (DPl==0)]
    LI 6                 ; 055A: 96 ; Load ACC with 0x6
    XM 0                 ; 055B: 28 ; Exchange ACC with RAM[DP] (temp = ACC; ACC = RAM[DP]; RAM[DP] = temp)
    TAB 1                ; 055C: 25 ; Skip next instruction if ACC bit 1 is set (ACC & 0x2 != 0) ;  [CONDITIONAL: skip next on bit 1 of ACC]
    RMB 2                ; 055D: 6A ; Reset bit 2 of RAM[DP] (RAM[DP] &= ~0x4)
    TAB 2                ; 055E: 26 ; Skip next instruction if ACC bit 2 is set (ACC & 0x4 != 0) ;  [CONDITIONAL: skip next on bit 2 of ACC]
    RMB 1                ; 055F: 69 ; Reset bit 1 of RAM[DP] (RAM[DP] &= ~0x2)
sub_0560:
    JMP sub_03B5         ; 0560: A3 B5 ; Jump to absolute address 0x03B5
sub_0562:
    TAB 0                ; 0562: 24 ; Skip next instruction if ACC bit 0 is set (ACC & 0x1 != 0) ;  [CONDITIONAL: skip next on bit 0 of ACC]
    SMB 0                ; 0563: 78 ; Set bit 0 of RAM[DP] (RAM[DP] |= 0x1)
    TAB 1                ; 0564: 25 ; Skip next instruction if ACC bit 1 is set (ACC & 0x2 != 0) ;  [CONDITIONAL: skip next on bit 1 of ACC]
    SMB 1                ; 0565: 79 ; Set bit 1 of RAM[DP] (RAM[DP] |= 0x2)
    TAB 2                ; 0566: 26 ; Skip next instruction if ACC bit 2 is set (ACC & 0x4 != 0) ;  [CONDITIONAL: skip next on bit 2 of ACC]
    SMB 2                ; 0567: 7A ; Set bit 2 of RAM[DP] (RAM[DP] |= 0x4)
    TAB 3                ; 0568: 27 ; Skip next instruction if ACC bit 3 is set (ACC & 0x8 != 0) ;  [CONDITIONAL: skip next on bit 3 of ACC]
    SMB 3                ; 0569: 7B ; Set bit 3 of RAM[DP] (RAM[DP] |= 0x8)
    LDZ 0x7              ; 056A: 87 ; Load DP with 0x07 (DPH = 0, DPL = 0x7)
    RT                   ; 056B: 48 ; Return from subroutine
sub_056C:
    TPB 0                ; 056C: 50 ; Skip next instruction if input port[DPl] bit 0 is set (port[DPl] & 0x1 != 0) ;  [CONDITIONAL: skip next on bit 0 of input port (DPl)]
    JCP sub_0575         ; 056D: F5 ; Jump to address 0x0575 in current page (page 0x0540 + offset 0x35)
    LDZ 0xE              ; 056E: 8E ; Load DP with 0x0E (DPH = 0, DPL = 0xE)
    TMB 2                ; 056F: 5A ; Skip next instruction if RAM[DP] bit 2 is set (RAM[DP] & 0x4 != 0) ;  [CONDITIONAL: skip next on bit 2 of RAM]
    RT                   ; 0570: 48 ; Return from subroutine
    INM                  ; 0571: 1D ; Increment RAM[DP] (RAM[DP] = RAM[DP] + 1), skip next if RAM[DP] overflows to 0 ;  [CONDITIONAL: skip next on carry (RAM==0)]
    TMB 1                ; 0572: 59 ; Skip next instruction if RAM[DP] bit 1 is set (RAM[DP] & 0x2 != 0) ;  [CONDITIONAL: skip next on bit 1 of RAM]
    RT                   ; 0573: 48 ; Return from subroutine
    LI 8                 ; 0574: 98 ; Load ACC with 0x8, skip next LI instruction, resume at 0x0576
sub_0575:
    LI 4                 ; 0575: 94 ; Load ACC with 0x4
    LDZ 0xE              ; 0576: 8E ; Load DP with 0x0E (DPH = 0, DPL = 0xE)
    S                    ; 0577: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
    RT                   ; 0578: 48 ; Return from subroutine
sub_0579:
    LDZ 0x3              ; 0579: 83 ; Load DP with 0x03 (DPH = 0, DPL = 0x3)
    LI 12                ; 057A: 9C ; Load ACC with 0xC
    XMD 0                ; 057B: 2C ; Exchange ACC with RAM[DP], decrement DPL, skip next if DPL underflows to 15 ;  [CONDITIONAL: skip next on carry (DPl==0xF) after decrement]
    LI 11                ; 057C: 9B ; Load ACC with 0xB
    XMD 0                ; 057D: 2C ; Exchange ACC with RAM[DP], decrement DPL, skip next if DPL underflows to 15 ;  [CONDITIONAL: skip next on carry (DPl==0xF) after decrement]
    LI 11                ; 057E: 9B ; Load ACC with 0xB
    XMD 0                ; 057F: 2C ; Exchange ACC with RAM[DP], decrement DPL, skip next if DPL underflows to 15 ;  [CONDITIONAL: skip next on carry (DPl==0xF) after decrement]
    LI 10                ; 0580: 9A ; Load ACC with 0xA
    XMD 2                ; 0581: 2E ; Exchange ACC with RAM[DP], XOR DPH with 0x2, decrement DPL, skip next if DPL underflows to 15 ;  [CONDITIONAL: skip next on carry (DPl==0xF) after decrement]
    NOP                  ; 0582: 00 ; No Operation
    RT                   ; 0583: 48 ; Return from subroutine
sub_0584:
    LDZ 0x8              ; 0584: 88 ; Load DP with 0x08 (DPH = 0, DPL = 0x8)
    LI 15                ; 0585: 9F ; Load ACC with 0xF
    AD                   ; 0586: 08 ; Add RAM[DP] to ACC, skip next instruction if carry (ACC + RAM[DP] > 15) ;  [CONDITIONAL: skip next on carry]
    RT                   ; 0587: 48 ; Return from subroutine
    LDI 0x2E             ; 0588: 15 2E ; Load DP with 0x2E (DPH = 0x2, DPL = 0xE)
    CI 0xC0              ; 058A: 17 C0 ; Compare ACC with 0xC0, skip next instruction if ACC == 0xC0 ;  [CONDITIONAL: skip next on ACC equals X]
    JCP sub_0593         ; 058C: D3 ; Jump to address 0x0593 in current page (page 0x0580 + offset 0x13)
    CM                   ; 058D: 0C ; Compare ACC with RAM[DP], skip next instruction if ACC == RAM[DP] ;  [CONDITIONAL: skip next on ACC equals RAM]
    RT                   ; 058E: 48 ; Return from subroutine
    IND                  ; 058F: 33 ; Increment DPL (DPL = DPL + 1), skip next instruction if DPL overflows to 0 ;  [CONDITIONAL: skip next on carry (DPl==0)]
    CM                   ; 0590: 0C ; Compare ACC with RAM[DP], skip next instruction if ACC == RAM[DP] ;  [CONDITIONAL: skip next on ACC equals RAM]
    RT                   ; 0591: 48 ; Return from subroutine
    DED                  ; 0592: 13 ; Decrement DPL (DPL = DPL - 1), skip next instruction if DPL underflows to 15 ;  [CONDITIONAL: skip next on carry (DPl==0xF)]
sub_0593:
    FBT 0                ; 0593: 5C ; Skip next instruction if FLAG bit 0 is set (FLAG & 0x1 != 0) ;  [CONDITIONAL: skip next on bit 0 of FLAG]
    IND                  ; 0594: 33 ; Increment DPL (DPL = DPL + 1), skip next instruction if DPL overflows to 0 ;  [CONDITIONAL: skip next on carry (DPl==0)]
    LI 0                 ; 0595: 90 ; Load ACC with 0x0
    CM                   ; 0596: 0C ; Compare ACC with RAM[DP], skip next instruction if ACC == RAM[DP] ;  [CONDITIONAL: skip next on ACC equals RAM]
    RT                   ; 0597: 48 ; Return from subroutine
    LI 8                 ; 0598: 98 ; Load ACC with 0x8
    XM 3                 ; 0599: 2B ; Exchange ACC with RAM[DP], XOR DPH with 0x3 (temp = ACC; ACC = RAM[DP]; RAM[DP] = temp; DPH ^= 0x3)
    LI 4                 ; 059A: 94 ; Load ACC with 0x4
    XMD 2                ; 059B: 2E ; Exchange ACC with RAM[DP], XOR DPH with 0x2, decrement DPL, skip next if DPL underflows to 15 ;  [CONDITIONAL: skip next on carry (DPl==0xF) after decrement]
    DED                  ; 059C: 13 ; Decrement DPL (DPL = DPL - 1), skip next instruction if DPL underflows to 15 ;  [CONDITIONAL: skip next on carry (DPl==0xF)]
    LI 2                 ; 059D: 92 ; Load ACC with 0x2
    S                    ; 059E: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
    LDI 0x40             ; 059F: 15 40 ; Load DP with 0x40 (DPH = 0x4, DPL = 0x0)
    FBT 0                ; 05A1: 5C ; Skip next instruction if FLAG bit 0 is set (FLAG & 0x1 != 0) ;  [CONDITIONAL: skip next on bit 0 of FLAG]
    IND                  ; 05A2: 33 ; Increment DPL (DPL = DPL + 1), skip next instruction if DPL overflows to 0 ;  [CONDITIONAL: skip next on carry (DPl==0)]
    XAW                  ; 05A3: 4B ; Exchange ACC with W
    TAW                  ; 05A4: 43 ; Transfer ACC to W
    S                    ; 05A5: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
    RT                   ; 05A6: 48 ; Return from subroutine
sub_05A7:
    LDI 0x73             ; 05A7: 15 73 ; Load DP with 0x73 (DPH = 0x7, DPL = 0x3)
    LM 0                 ; 05A9: 38 ; Load ACC with RAM[DP] (ACC = RAM[DP])
    TAW                  ; 05AA: 43 ; Transfer ACC to W
    LDI 0x2E             ; 05AB: 15 2E ; Load DP with 0x2E (DPH = 0x2, DPL = 0xE)
    FBT 0                ; 05AD: 5C ; Skip next instruction if FLAG bit 0 is set (FLAG & 0x1 != 0) ;  [CONDITIONAL: skip next on bit 0 of FLAG]
    IND                  ; 05AE: 33 ; Increment DPL (DPL = DPL + 1), skip next instruction if DPL overflows to 0 ;  [CONDITIONAL: skip next on carry (DPl==0)]
sub_05AF:
    CM                   ; 05AF: 0C ; Compare ACC with RAM[DP], skip next instruction if ACC == RAM[DP] ;  [CONDITIONAL: skip next on ACC equals RAM]
    RT                   ; 05B0: 48 ; Return from subroutine
    LM 3                 ; 05B1: 3B ; Load ACC with RAM[DP], XOR DPH with 0x3 (ACC = RAM[DP]; DPH ^= 0x3)
    LM 0                 ; 05B2: 38 ; Load ACC with RAM[DP] (ACC = RAM[DP])
    CZP L0038            ; 05B3: BE ; Call subroutine at zero page address 0x0038 (page 14 << 2)
    CI 0xCF              ; 05B4: 17 CF ; Compare ACC with 0xCF, skip next instruction if ACC == 0xCF ;  [CONDITIONAL: skip next on ACC equals X]
    RT                   ; 05B6: 48 ; Return from subroutine
    SMB 1                ; 05B7: 79 ; Set bit 1 of RAM[DP] (RAM[DP] |= 0x2)
    RT                   ; 05B8: 48 ; Return from subroutine
sub_05B9:
    STM 0x32             ; 05B9: 14 B2 ; Reset Timer F/F, Start Timer with 0x32 (3213 ticks)
sub_05BB:
    TTM                  ; 05BB: 05 ; skip next on Timer F/F ;  [CONDITIONAL: skip next on Timer F/F]
    JCP sub_05BB         ; 05BC: FB ; Jump to address 0x05BB in current page (page 0x0580 + offset 0x3B)
    DEC                  ; 05BD: 0F ; Decrement ACC (ACC = ACC - 1), skip next instruction if ACC underflows to 15 ;  [CONDITIONAL: skip next on carry (ACC==0xF)]
    JCP sub_05B9         ; 05BE: F9 ; Jump to address 0x05B9 in current page (page 0x0580 + offset 0x39)
    RT                   ; 05BF: 48 ; Return from subroutine
sub_05C0:
    LI 3                 ; 05C0: 93 ; Load ACC with 0x3
    JCP sub_05E5         ; 05C1: E5 ; Jump to address 0x05E5 in current page (page 0x05C0 + offset 0x25)
sub_05C2:
    LDZ 0x3              ; 05C2: 83 ; Load DP with 0x03 (DPH = 0, DPL = 0x3)
    JCP sub_05DA         ; 05C3: DA ; Jump to address 0x05DA in current page (page 0x05C0 + offset 0x1A)
sub_05C4:
    LI 0                 ; 05C4: 90 ; Load ACC with 0x0
    JCP sub_05D1         ; 05C5: D1 ; Jump to address 0x05D1 in current page (page 0x05C0 + offset 0x11)
sub_05C6:
    LDZ 0x2              ; 05C6: 82 ; Load DP with 0x02 (DPH = 0, DPL = 0x2)
    JCP sub_05E2         ; 05C7: E2 ; Jump to address 0x05E2 in current page (page 0x05C0 + offset 0x22)
sub_05C8:
    LI 5                 ; 05C8: 95 ; Load ACC with 0x5
    XMD 0                ; 05C9: 2C ; Exchange ACC with RAM[DP], decrement DPL, skip next if DPL underflows to 15 ;  [CONDITIONAL: skip next on carry (DPl==0xF) after decrement]
    LI 11                ; 05CA: 9B ; Load ACC with 0xB
    JCP sub_05F9         ; 05CB: F9 ; Jump to address 0x05F9 in current page (page 0x05C0 + offset 0x39)
sub_05CC:
    LI 4                 ; 05CC: 94 ; Load ACC with 0x4
    JCP sub_05E5         ; 05CD: E5 ; Jump to address 0x05E5 in current page (page 0x05C0 + offset 0x25)
sub_05CE:
    LDZ 0x1              ; 05CE: 81 ; Load DP with 0x01 (DPH = 0, DPL = 0x1)
    JCP sub_05DA         ; 05CF: DA ; Jump to address 0x05DA in current page (page 0x05C0 + offset 0x1A)
sub_05D0:
    LI 6                 ; 05D0: 96 ; Load ACC with 0x6
sub_05D1:
    XMD 0                ; 05D1: 2C ; Exchange ACC with RAM[DP], decrement DPL, skip next if DPL underflows to 15 ;  [CONDITIONAL: skip next on carry (DPl==0xF) after decrement]
    LI 6                 ; 05D2: 96 ; Load ACC with 0x6
    JCP sub_05F9         ; 05D3: F9 ; Jump to address 0x05F9 in current page (page 0x05C0 + offset 0x39)
sub_05D4:
    LI 6                 ; 05D4: 96 ; Load ACC with 0x6
    JCP sub_05E9         ; 05D5: E9 ; Jump to address 0x05E9 in current page (page 0x05C0 + offset 0x29)
sub_05D6:
    LDZ 0x0              ; 05D6: 80 ; Load DP with 0x00 (DPH = 0, DPL = 0x0)
    JCP sub_05E2         ; 05D7: E2 ; Jump to address 0x05E2 in current page (page 0x05C0 + offset 0x22)
sub_05D8:
    LI 7                 ; 05D8: 97 ; Load ACC with 0x7
    JCP sub_05E9         ; 05D9: E9 ; Jump to address 0x05E9 in current page (page 0x05C0 + offset 0x29)
sub_05DA:
    LM 0                 ; 05DA: 38 ; Load ACC with RAM[DP] (ACC = RAM[DP])
    JCP sub_05F4         ; 05DB: F4 ; Jump to address 0x05F4 in current page (page 0x05C0 + offset 0x34)
sub_05DC:
    LI 2                 ; 05DC: 92 ; Load ACC with 0x2
    XMD 0                ; 05DD: 2C ; Exchange ACC with RAM[DP], decrement DPL, skip next if DPL underflows to 15 ;  [CONDITIONAL: skip next on carry (DPl==0xF) after decrement]
    LI 7                 ; 05DE: 97 ; Load ACC with 0x7
    JCP sub_05F9         ; 05DF: F9 ; Jump to address 0x05F9 in current page (page 0x05C0 + offset 0x39)
sub_05E0:
    LI 7                 ; 05E0: 97 ; Load ACC with 0x7
    JCP sub_05E5         ; 05E1: E5 ; Jump to address 0x05E5 in current page (page 0x05C0 + offset 0x25)
sub_05E2:
    LM 0                 ; 05E2: 38 ; Load ACC with RAM[DP] (ACC = RAM[DP])
    JCP sub_05F6         ; 05E3: F6 ; Jump to address 0x05F6 in current page (page 0x05C0 + offset 0x36)
sub_05E4:
    LI 6                 ; 05E4: 96 ; Load ACC with 0x6
sub_05E5:
    XMD 0                ; 05E5: 2C ; Exchange ACC with RAM[DP], decrement DPL, skip next if DPL underflows to 15 ;  [CONDITIONAL: skip next on carry (DPl==0xF) after decrement]
    LI 15                ; 05E6: 9F ; Load ACC with 0xF
    JCP sub_05F9         ; 05E7: F9 ; Jump to address 0x05F9 in current page (page 0x05C0 + offset 0x39)
sub_05E8:
    LI 3                 ; 05E8: 93 ; Load ACC with 0x3
sub_05E9:
    XMD 0                ; 05E9: 2C ; Exchange ACC with RAM[DP], decrement DPL, skip next if DPL underflows to 15 ;  [CONDITIONAL: skip next on carry (DPl==0xF) after decrement]
    LI 13                ; 05EA: 9D ; Load ACC with 0xD
    JCP sub_05F9         ; 05EB: F9 ; Jump to address 0x05F9 in current page (page 0x05C0 + offset 0x39)
sub_05EC:
    LI 5                 ; 05EC: 95 ; Load ACC with 0x5
    XMD 0                ; 05ED: 2C ; Exchange ACC with RAM[DP], decrement DPL, skip next if DPL underflows to 15 ;  [CONDITIONAL: skip next on carry (DPl==0xF) after decrement]
    LI 12                ; 05EE: 9C ; Load ACC with 0xC
    JCP sub_05F9         ; 05EF: F9 ; Jump to address 0x05F9 in current page (page 0x05C0 + offset 0x39)
sub_05F0:
    LI 5                 ; 05F0: 95 ; Load ACC with 0x5
    XMD 0                ; 05F1: 2C ; Exchange ACC with RAM[DP], decrement DPL, skip next if DPL underflows to 15 ;  [CONDITIONAL: skip next on carry (DPl==0xF) after decrement]
    LI 14                ; 05F2: 9E ; Load ACC with 0xE
    JCP sub_05F9         ; 05F3: F9 ; Jump to address 0x05F9 in current page (page 0x05C0 + offset 0x39)
sub_05F4:
    LDZ 0x7              ; 05F4: 87 ; Load DP with 0x07 (DPH = 0, DPL = 0x7)
    JPA                  ; 05F5: 41 ; Jump to address in current page based on ACC value (jump table: page | (ACC << 2)) ;  [INDIRECT JUMP: 16/16 targets in ROM, see table above]
sub_05F6:
    LDZ 0x5              ; 05F6: 85 ; Load DP with 0x05 (DPH = 0, DPL = 0x5)
    JPA                  ; 05F7: 41 ; Jump to address in current page based on ACC value (jump table: page | (ACC << 2)) ;  [INDIRECT JUMP: 16/16 targets in ROM, see table above]
sub_05F8:
    LI 0                 ; 05F8: 90 ; Load ACC with 0x0
sub_05F9:
    S                    ; 05F9: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
    RT                   ; 05FA: 48 ; Return from subroutine
    NOP                  ; 05FB: 00 ; No Operation
sub_05FC:
    NOP                  ; 05FC: 00 ; No Operation
    NOP                  ; 05FD: 00 ; No Operation
    NOP                  ; 05FE: 00 ; No Operation
    NOP                  ; 05FF: 00 ; No Operation
sub_0600:
    LI 8                 ; 0600: 98 ; Load ACC with 0x8
    CM                   ; 0601: 0C ; Compare ACC with RAM[DP], skip next instruction if ACC == RAM[DP] ;  [CONDITIONAL: skip next on ACC equals RAM]
    JCP sub_0604         ; 0602: C4 ; Jump to address 0x0604 in current page (page 0x0600 + offset 0x04)
    JCP sub_0606         ; 0603: C6 ; Jump to address 0x0606 in current page (page 0x0600 + offset 0x06)
sub_0604:
    INM                  ; 0604: 1D ; Increment RAM[DP] (RAM[DP] = RAM[DP] + 1), skip next if RAM[DP] overflows to 0 ;  [CONDITIONAL: skip next on carry (RAM==0)]
    RT                   ; 0605: 48 ; Return from subroutine
sub_0606:
    DEM                  ; 0606: 1F ; Decrement RAM[DP] (RAM[DP] = RAM[DP] - 1), skip next if RAM[DP] underflows to 15 ;  [CONDITIONAL: skip next on carry (RAM==0xF)]
    RT                   ; 0607: 48 ; Return from subroutine
sub_0608:
    LM 3                 ; 0608: 3B ; Load ACC with RAM[DP], XOR DPH with 0x3 (ACC = RAM[DP]; DPH ^= 0x3)
sub_0609:
    STC                  ; 0609: 1B ; Set Carry F/F
    LI 0                 ; 060A: 90 ; Load ACC with 0x0
    CM                   ; 060B: 0C ; Compare ACC with RAM[DP], skip next instruction if ACC == RAM[DP] ;  [CONDITIONAL: skip next on ACC equals RAM]
    CLC                  ; 060C: 0B ; Reset Carry F/F
    LM 0                 ; 060D: 38 ; Load ACC with RAM[DP] (ACC = RAM[DP])
    RAR                  ; 060E: 30 ; Rotate ACC Right through Carry F/F
    TC                   ; 060F: 04 ; skip next on Carry F/F ;  [CONDITIONAL: skip next on Carry F/F]
    JCP sub_061A         ; 0610: DA ; Jump to address 0x061A in current page (page 0x0600 + offset 0x1A)
    JCP sub_0613         ; 0611: D3 ; Jump to address 0x0613 in current page (page 0x0600 + offset 0x13)
sub_0612:
    LM 3                 ; 0612: 3B ; Load ACC with RAM[DP], XOR DPH with 0x3 (ACC = RAM[DP]; DPH ^= 0x3)
sub_0613:
    LI 0                 ; 0613: 90 ; Load ACC with 0x0
    CM                   ; 0614: 0C ; Compare ACC with RAM[DP], skip next instruction if ACC == RAM[DP] ;  [CONDITIONAL: skip next on ACC equals RAM]
    JCP sub_0617         ; 0615: D7 ; Jump to address 0x0617 in current page (page 0x0600 + offset 0x17)
    JCP sub_0609         ; 0616: C9 ; Jump to address 0x0609 in current page (page 0x0600 + offset 0x09)
sub_0617:
    LM 0                 ; 0617: 38 ; Load ACC with RAM[DP] (ACC = RAM[DP])
    AD                   ; 0618: 08 ; Add RAM[DP] to ACC, skip next instruction if carry (ACC + RAM[DP] > 15) ;  [CONDITIONAL: skip next on carry]
    NOP                  ; 0619: 00 ; No Operation
sub_061A:
    XM 3                 ; 061A: 2B ; Exchange ACC with RAM[DP], XOR DPH with 0x3 (temp = ACC; ACC = RAM[DP]; RAM[DP] = temp; DPH ^= 0x3)
    RT                   ; 061B: 48 ; Return from subroutine
sub_061C:
    LDZ 0xB              ; 061C: 8B ; Load DP with 0x0B (DPH = 0, DPL = 0xB)
    CZP L0010            ; 061D: B4 ; Call subroutine at zero page address 0x0010 (page 4 << 2)
    LDZ 0x6              ; 061E: 86 ; Load DP with 0x06 (DPH = 0, DPL = 0x6)
    CZP L0014            ; 061F: B5 ; Call subroutine at zero page address 0x0014 (page 5 << 2)
    LDZ 0x3              ; 0620: 83 ; Load DP with 0x03 (DPH = 0, DPL = 0x3)
    CZP L000C            ; 0621: B3 ; Call subroutine at zero page address 0x000C (page 3 << 2)
    LDZ 0x6              ; 0622: 86 ; Load DP with 0x06 (DPH = 0, DPL = 0x6)
    CZP L000C            ; 0623: B3 ; Call subroutine at zero page address 0x000C (page 3 << 2)
    LDZ 0x3              ; 0624: 83 ; Load DP with 0x03 (DPH = 0, DPL = 0x3)
    CZP L000C            ; 0625: B3 ; Call subroutine at zero page address 0x000C (page 3 << 2)
    LDZ 0x1              ; 0626: 81 ; Load DP with 0x01 (DPH = 0, DPL = 0x1)
    CZP L0014            ; 0627: B5 ; Call subroutine at zero page address 0x0014 (page 5 << 2)
    RT                   ; 0628: 48 ; Return from subroutine
sub_0629:
    LDI 0x3C             ; 0629: 15 3C ; Load DP with 0x3C (DPH = 0x3, DPL = 0xC)
    FBT 0                ; 062B: 5C ; Skip next instruction if FLAG bit 0 is set (FLAG & 0x1 != 0) ;  [CONDITIONAL: skip next on bit 0 of FLAG]
    IND                  ; 062C: 33 ; Increment DPL (DPL = DPL + 1), skip next instruction if DPL overflows to 0 ;  [CONDITIONAL: skip next on carry (DPl==0)]
    LI 0                 ; 062D: 90 ; Load ACC with 0x0
    CM                   ; 062E: 0C ; Compare ACC with RAM[DP], skip next instruction if ACC == RAM[DP] ;  [CONDITIONAL: skip next on ACC equals RAM]
    JMP sub_0663         ; 062F: A6 63 ; Jump to absolute address 0x0663
    LDI 0x14             ; 0631: 15 14 ; Load DP with 0x14 (DPH = 0x1, DPL = 0x4)
    LM 0                 ; 0633: 38 ; Load ACC with RAM[DP] (ACC = RAM[DP])
    INM                  ; 0634: 1D ; Increment RAM[DP] (RAM[DP] = RAM[DP] + 1), skip next if RAM[DP] overflows to 0 ;  [CONDITIONAL: skip next on carry (RAM==0)]
    NOP                  ; 0635: 00 ; No Operation
    TAW                  ; 0636: 43 ; Transfer ACC to W
    IND                  ; 0637: 33 ; Increment DPL (DPL = DPL + 1), skip next instruction if DPL overflows to 0 ;  [CONDITIONAL: skip next on carry (DPl==0)]
    LM 0                 ; 0638: 38 ; Load ACC with RAM[DP] (ACC = RAM[DP])
    INM                  ; 0639: 1D ; Increment RAM[DP] (RAM[DP] = RAM[DP] + 1), skip next if RAM[DP] overflows to 0 ;  [CONDITIONAL: skip next on carry (RAM==0)]
    NOP                  ; 063A: 00 ; No Operation
    LDI 0x40             ; 063B: 15 40 ; Load DP with 0x40 (DPH = 0x4, DPL = 0x0)
    FBT 0                ; 063D: 5C ; Skip next instruction if FLAG bit 0 is set (FLAG & 0x1 != 0) ;  [CONDITIONAL: skip next on bit 0 of FLAG]
    IND                  ; 063E: 33 ; Increment DPL (DPL = DPL + 1), skip next instruction if DPL overflows to 0 ;  [CONDITIONAL: skip next on carry (DPl==0)]
    CLC                  ; 063F: 0B ; Reset Carry F/F
    TMB 2                ; 0640: 5A ; Skip next instruction if RAM[DP] bit 2 is set (RAM[DP] & 0x4 != 0) ;  [CONDITIONAL: skip next on bit 2 of RAM]
    STC                  ; 0641: 1B ; Set Carry F/F
    TMB 0                ; 0642: 58 ; Skip next instruction if RAM[DP] bit 0 is set (RAM[DP] & 0x1 != 0) ;  [CONDITIONAL: skip next on bit 0 of RAM]
    JCP sub_064F         ; 0643: CF ; Jump to address 0x064F in current page (page 0x0640 + offset 0x0F)
    LDZ 0x9              ; 0644: 89 ; Load DP with 0x09 (DPH = 0, DPL = 0x9)
    S                    ; 0645: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
    LI 10                ; 0646: 9A ; Load ACC with 0xA
    AD                   ; 0647: 08 ; Add RAM[DP] to ACC, skip next instruction if carry (ACC + RAM[DP] > 15) ;  [CONDITIONAL: skip next on carry]
    JCP sub_064D         ; 0648: CD ; Jump to address 0x064D in current page (page 0x0640 + offset 0x0D)
    LI 5                 ; 0649: 95 ; Load ACC with 0x5
    AD                   ; 064A: 08 ; Add RAM[DP] to ACC, skip next instruction if carry (ACC + RAM[DP] > 15) ;  [CONDITIONAL: skip next on carry]
    LI 7                 ; 064B: 97 ; Load ACC with 0x7, skip next 2 LI instructions, resume at 0x064E
    LI 3                 ; 064C: 93 ; Load ACC with 0x3, skip next LI instruction, resume at 0x064E
sub_064D:
    LI 5                 ; 064D: 95 ; Load ACC with 0x5
    JCP sub_0652         ; 064E: D2 ; Jump to address 0x0652 in current page (page 0x0640 + offset 0x12)
sub_064F:
    TAB 3                ; 064F: 27 ; Skip next instruction if ACC bit 3 is set (ACC & 0x8 != 0) ;  [CONDITIONAL: skip next on bit 3 of ACC]
    LI 4                 ; 0650: 94 ; Load ACC with 0x4, skip next LI instruction, resume at 0x0652
    LI 6                 ; 0651: 96 ; Load ACC with 0x6
sub_0652:
    LDI 0x3E             ; 0652: 15 3E ; Load DP with 0x3E (DPH = 0x3, DPL = 0xE)
    FBT 0                ; 0654: 5C ; Skip next instruction if FLAG bit 0 is set (FLAG & 0x1 != 0) ;  [CONDITIONAL: skip next on bit 0 of FLAG]
    IND                  ; 0655: 33 ; Increment DPL (DPL = DPL + 1), skip next instruction if DPL overflows to 0 ;  [CONDITIONAL: skip next on carry (DPl==0)]
    S                    ; 0656: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
    RMB 3                ; 0657: 6B ; Reset bit 3 of RAM[DP] (RAM[DP] &= ~0x8)
    XAW                  ; 0658: 4B ; Exchange ACC with W
    LDI 0x3C             ; 0659: 15 3C ; Load DP with 0x3C (DPH = 0x3, DPL = 0xC)
    FBT 0                ; 065B: 5C ; Skip next instruction if FLAG bit 0 is set (FLAG & 0x1 != 0) ;  [CONDITIONAL: skip next on bit 0 of FLAG]
    IND                  ; 065C: 33 ; Increment DPL (DPL = DPL + 1), skip next instruction if DPL overflows to 0 ;  [CONDITIONAL: skip next on carry (DPl==0)]
    S                    ; 065D: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
    SMB 3                ; 065E: 7B ; Set bit 3 of RAM[DP] (RAM[DP] |= 0x8)
    TC                   ; 065F: 04 ; skip next on Carry F/F ;  [CONDITIONAL: skip next on Carry F/F]
    JCP sub_0663         ; 0660: E3 ; Jump to address 0x0663 in current page (page 0x0640 + offset 0x23)
    LI 1                 ; 0661: 91 ; Load ACC with 0x1
    S                    ; 0662: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
sub_0663:
    LDI 0x2E             ; 0663: 15 2E ; Load DP with 0x2E (DPH = 0x2, DPL = 0xE)
    FBT 0                ; 0665: 5C ; Skip next instruction if FLAG bit 0 is set (FLAG & 0x1 != 0) ;  [CONDITIONAL: skip next on bit 0 of FLAG]
    IND                  ; 0666: 33 ; Increment DPL (DPL = DPL + 1), skip next instruction if DPL overflows to 0 ;  [CONDITIONAL: skip next on carry (DPl==0)]
    LM 1                 ; 0667: 39 ; Load ACC with RAM[DP], XOR DPH with 0x1 (ACC = RAM[DP]; DPH ^= 0x1)
    DEC                  ; 0668: 0F ; Decrement ACC (ACC = ACC - 1), skip next instruction if ACC underflows to 15 ;  [CONDITIONAL: skip next on carry (ACC==0xF)]
    JCP sub_066C         ; 0669: EC ; Jump to address 0x066C in current page (page 0x0640 + offset 0x2C)
    JMP sub_06DD         ; 066A: A6 DD ; Jump to absolute address 0x06DD
sub_066C:
    LM 1                 ; 066C: 39 ; Load ACC with RAM[DP], XOR DPH with 0x1 (ACC = RAM[DP]; DPH ^= 0x1)
    SEB 3                ; 066D: 77 ; Set bit 3 of output port E (portE |= 0x8)
    JMP sub_068B         ; 066E: A6 8B ; Jump to absolute address 0x068B
sub_0670:
    TAZ                  ; 0670: 42 ; Transfer ACC to Z
    CM                   ; 0671: 0C ; Compare ACC with RAM[DP], skip next instruction if ACC == RAM[DP] ;  [CONDITIONAL: skip next on ACC equals RAM]
    JCP sub_067B         ; 0672: FB ; Jump to address 0x067B in current page (page 0x0640 + offset 0x3B)
    XM 3                 ; 0673: 2B ; Exchange ACC with RAM[DP], XOR DPH with 0x3 (temp = ACC; ACC = RAM[DP]; RAM[DP] = temp; DPH ^= 0x3)
    XAW                  ; 0674: 4B ; Exchange ACC with W
    TAW                  ; 0675: 43 ; Transfer ACC to W
    CM                   ; 0676: 0C ; Compare ACC with RAM[DP], skip next instruction if ACC == RAM[DP] ;  [CONDITIONAL: skip next on ACC equals RAM]
    JCP sub_0679         ; 0677: F9 ; Jump to address 0x0679 in current page (page 0x0640 + offset 0x39)
    RT                   ; 0678: 48 ; Return from subroutine
sub_0679:
    XAZ                  ; 0679: 4A ; Exchange ACC with Z
    TAZ                  ; 067A: 42 ; Transfer ACC to Z
sub_067B:
    LDI 0x2F             ; 067B: 15 2F ; Load DP with 0x2F (DPH = 0x2, DPL = 0xF)
    RTS                  ; 067D: 49 ; Return from subroutine, skip next ;  [CONDITIONAL: skip next (return from subroutine)]
    NOP                  ; 067E: 00 ; No Operation
    NOP                  ; 067F: 00 ; No Operation
sub_0680:
    CAL sub_0600         ; 0680: AE 00 ; Call subroutine at absolute address 0x0600 (push return address to stack)
    JMP sub_069C         ; 0682: A6 9C ; Jump to absolute address 0x069C
sub_0684:
    CAL sub_0600         ; 0684: AE 00 ; Call subroutine at absolute address 0x0600 (push return address to stack)
    JMP sub_06AC         ; 0686: A6 AC ; Jump to absolute address 0x06AC
sub_0688:
    CAL sub_0600         ; 0688: AE 00 ; Call subroutine at absolute address 0x0600 (push return address to stack)
    JCP sub_068C         ; 068A: CC ; Jump to address 0x068C in current page (page 0x0680 + offset 0x0C)
sub_068B:
    JPA                  ; 068B: 41 ; Jump to address in current page based on ACC value (jump table: page | (ACC << 2)) ;  [INDIRECT JUMP: 16/16 targets in ROM, see table above]
sub_068C:
    CAL sub_0608         ; 068C: AE 08 ; Call subroutine at absolute address 0x0608 (push return address to stack)
    JMP sub_06AC         ; 068E: A6 AC ; Jump to absolute address 0x06AC
sub_0690:
    CAL sub_0606         ; 0690: AE 06 ; Call subroutine at absolute address 0x0606 (push return address to stack)
    JMP sub_068C         ; 0692: A6 8C ; Jump to absolute address 0x068C
sub_0694:
    LDI 0x1D             ; 0694: 15 1D ; Load DP with 0x1D (DPH = 0x1, DPL = 0xD)
    JMP sub_069F         ; 0696: A6 9F ; Jump to absolute address 0x069F
sub_0698:
    CAL sub_0606         ; 0698: AE 06 ; Call subroutine at absolute address 0x0606 (push return address to stack)
    NOP                  ; 069A: 00 ; No Operation
    NOP                  ; 069B: 00 ; No Operation
sub_069C:
    CAL sub_0612         ; 069C: AE 12 ; Call subroutine at absolute address 0x0612 (push return address to stack)
    JCP sub_06AC         ; 069E: EC ; Jump to address 0x06AC in current page (page 0x0680 + offset 0x2C)
sub_069F:
    LM 3                 ; 069F: 3B ; Load ACC with RAM[DP], XOR DPH with 0x3 (ACC = RAM[DP]; DPH ^= 0x3)
sub_06A0:
    TAW                  ; 06A0: 43 ; Transfer ACC to W
    LM 0                 ; 06A1: 38 ; Load ACC with RAM[DP] (ACC = RAM[DP])
    IND                  ; 06A2: 33 ; Increment DPL (DPL = DPL + 1), skip next instruction if DPL overflows to 0 ;  [CONDITIONAL: skip next on carry (DPl==0)]
    FBT 0                ; 06A3: 5C ; Skip next instruction if FLAG bit 0 is set (FLAG & 0x1 != 0) ;  [CONDITIONAL: skip next on bit 0 of FLAG]
sub_06A4:
    IND                  ; 06A4: 33 ; Increment DPL (DPL = DPL + 1), skip next instruction if DPL overflows to 0 ;  [CONDITIONAL: skip next on carry (DPl==0)]
    CAL sub_0670         ; 06A5: AE 70 ; Call subroutine at absolute address 0x0670 (push return address to stack)
    JCP sub_06AC         ; 06A7: EC ; Jump to address 0x06AC in current page (page 0x0680 + offset 0x2C)
sub_06A8:
    FBF 0                ; 06A8: 20 ; Skip next instruction if FLAG bit 0 is NOT set (FLAG & 0x1 == 0) ;  [CONDITIONAL: skip next on NOT bit 0 of FLAG]
    DED                  ; 06A9: 13 ; Decrement DPL (DPL = DPL - 1), skip next instruction if DPL underflows to 15 ;  [CONDITIONAL: skip next on carry (DPl==0xF)]
    CAL sub_0606         ; 06AA: AE 06 ; Call subroutine at absolute address 0x0606 (push return address to stack)
sub_06AC:
    LDI 0x3E             ; 06AC: 15 3E ; Load DP with 0x3E (DPH = 0x3, DPL = 0xE)
    FBT 0                ; 06AE: 5C ; Skip next instruction if FLAG bit 0 is set (FLAG & 0x1 != 0) ;  [CONDITIONAL: skip next on bit 0 of FLAG]
    IND                  ; 06AF: 33 ; Increment DPL (DPL = DPL + 1), skip next instruction if DPL overflows to 0 ;  [CONDITIONAL: skip next on carry (DPl==0)]
sub_06B0:
    INM                  ; 06B0: 1D ; Increment RAM[DP] (RAM[DP] = RAM[DP] + 1), skip next if RAM[DP] overflows to 0 ;  [CONDITIONAL: skip next on carry (RAM==0)]
    INM                  ; 06B1: 1D ; Increment RAM[DP] (RAM[DP] = RAM[DP] + 1), skip next if RAM[DP] overflows to 0 ;  [CONDITIONAL: skip next on carry (RAM==0)]
    DEC                  ; 06B2: 0F ; Decrement ACC (ACC = ACC - 1), skip next instruction if ACC underflows to 15 ;  [CONDITIONAL: skip next on carry (ACC==0xF)]
    DEM                  ; 06B3: 1F ; Decrement RAM[DP] (RAM[DP] = RAM[DP] - 1), skip next if RAM[DP] underflows to 15 ;  [CONDITIONAL: skip next on carry (RAM==0xF)]
sub_06B4:
    RMB 3                ; 06B4: 6B ; Reset bit 3 of RAM[DP] (RAM[DP] &= ~0x8)
    LM 1                 ; 06B5: 39 ; Load ACC with RAM[DP], XOR DPH with 0x1 (ACC = RAM[DP]; DPH ^= 0x1)
    LI 13                ; 06B6: 9D ; Load ACC with 0xD
    AD                   ; 06B7: 08 ; Add RAM[DP] to ACC, skip next instruction if carry (ACC + RAM[DP] > 15) ;  [CONDITIONAL: skip next on carry]
sub_06B8:
    JMP sub_06C2         ; 06B8: A6 C2 ; Jump to absolute address 0x06C2
    LM 3                 ; 06BA: 3B ; Load ACC with RAM[DP], XOR DPH with 0x3 (ACC = RAM[DP]; DPH ^= 0x3)
    TLY                  ; 06BB: 46 ; Transfer DPl to Y
sub_06BC:
    FBF 0                ; 06BC: 20 ; Skip next instruction if FLAG bit 0 is NOT set (FLAG & 0x1 == 0) ;  [CONDITIONAL: skip next on NOT bit 0 of FLAG]
    LI 4                 ; 06BD: 94 ; Load ACC with 0x4, skip next LI instruction, resume at 0x06BF
    LI 5                 ; 06BE: 95 ; Load ACC with 0x5
    TAL                  ; 06BF: 07 ; Transfer ACC to DPL (lower 4 bits of data pointer)
    LI 3                 ; 06C0: 93 ; Load ACC with 0x3
    AD                   ; 06C1: 08 ; Add RAM[DP] to ACC, skip next instruction if carry (ACC + RAM[DP] > 15) ;  [CONDITIONAL: skip next on carry]
sub_06C2:
    JCP sub_06D7         ; 06C2: D7 ; Jump to address 0x06D7 in current page (page 0x06C0 + offset 0x17)
    XLY                  ; 06C3: 4E ; Exchange DPl with Y
    LM 3                 ; 06C4: 3B ; Load ACC with RAM[DP], XOR DPH with 0x3 (ACC = RAM[DP]; DPH ^= 0x3)
    TAZ                  ; 06C5: 42 ; Transfer ACC to Z
    LI 6                 ; 06C6: 96 ; Load ACC with 0x6
    AD                   ; 06C7: 08 ; Add RAM[DP] to ACC, skip next instruction if carry (ACC + RAM[DP] > 15) ;  [CONDITIONAL: skip next on carry]
    CMA                  ; 06C8: 10 ; Complement ACC
    TAL                  ; 06C9: 07 ; Transfer ACC to DPL (lower 4 bits of data pointer)
    XAZ                  ; 06CA: 4A ; Exchange ACC with Z
    TLY                  ; 06CB: 46 ; Transfer DPl to Y
    CZP L0034            ; 06CC: BD ; Call subroutine at zero page address 0x0034 (page 13 << 2)
    XM 0                 ; 06CD: 28 ; Exchange ACC with RAM[DP] (temp = ACC; ACC = RAM[DP]; RAM[DP] = temp)
    XM 3                 ; 06CE: 2B ; Exchange ACC with RAM[DP], XOR DPH with 0x3 (temp = ACC; ACC = RAM[DP]; RAM[DP] = temp; DPH ^= 0x3)
    XLY                  ; 06CF: 4E ; Exchange DPl with Y
    INC                  ; 06D0: 0D ; Increment ACC (ACC = ACC + 1), skip next instruction if ACC overflows to 0 ;  [CONDITIONAL: skip next on carry (ACC==0)]
    JCP sub_06D3         ; 06D1: D3 ; Jump to address 0x06D3 in current page (page 0x06C0 + offset 0x13)
    SMB 0                ; 06D2: 78 ; Set bit 0 of RAM[DP] (RAM[DP] |= 0x1)
sub_06D3:
    LDI 0x4A             ; 06D3: 15 4A ; Load DP with 0x4A (DPH = 0x4, DPL = 0xA)
    LI 1                 ; 06D5: 91 ; Load ACC with 0x1
    S                    ; 06D6: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
sub_06D7:
    REB 3                ; 06D7: 67 ; Reset bit 3 of output port E (portE &= ~0x8)
    LDI 0x3C             ; 06D8: 15 3C ; Load DP with 0x3C (DPH = 0x3, DPL = 0xC)
    FBT 0                ; 06DA: 5C ; Skip next instruction if FLAG bit 0 is set (FLAG & 0x1 != 0) ;  [CONDITIONAL: skip next on bit 0 of FLAG]
    IND                  ; 06DB: 33 ; Increment DPL (DPL = DPL + 1), skip next instruction if DPL overflows to 0 ;  [CONDITIONAL: skip next on carry (DPl==0)]
    CZP L002C            ; 06DC: BB ; Call subroutine at zero page address 0x002C (page 11 << 2)
sub_06DD:
    RFB 0                ; 06DD: 6C ; Reset bit 0 of FLAG register (FLAG &= ~0x1)
    RT                   ; 06DE: 48 ; Return from subroutine
sub_06DF:
    LDI 0x4E             ; 06DF: 15 4E ; Load DP with 0x4E (DPH = 0x4, DPL = 0xE)
    JCP sub_06E4         ; 06E1: E4 ; Jump to address 0x06E4 in current page (page 0x06C0 + offset 0x24)
sub_06E2:
    LDI 0x4F             ; 06E2: 15 4F ; Load DP with 0x4F (DPH = 0x4, DPL = 0xF)
sub_06E4:
    LI 0                 ; 06E4: 90 ; Load ACC with 0x0
    CM                   ; 06E5: 0C ; Compare ACC with RAM[DP], skip next instruction if ACC == RAM[DP] ;  [CONDITIONAL: skip next on ACC equals RAM]
    RT                   ; 06E6: 48 ; Return from subroutine
    RTS                  ; 06E7: 49 ; Return from subroutine, skip next ;  [CONDITIONAL: skip next (return from subroutine)]
sub_06E8:
    LDI 0x2D             ; 06E8: 15 2D ; Load DP with 0x2D (DPH = 0x2, DPL = 0xD)
    CM                   ; 06EA: 0C ; Compare ACC with RAM[DP], skip next instruction if ACC == RAM[DP] ;  [CONDITIONAL: skip next on ACC equals RAM]
    RT                   ; 06EB: 48 ; Return from subroutine
    LM 3                 ; 06EC: 3B ; Load ACC with RAM[DP], XOR DPH with 0x3 (ACC = RAM[DP]; DPH ^= 0x3)
sub_06ED:
    LM 0                 ; 06ED: 38 ; Load ACC with RAM[DP] (ACC = RAM[DP])
    LDZ 0x6              ; 06EE: 86 ; Load DP with 0x06 (DPH = 0, DPL = 0x6)
    CZP L0034            ; 06EF: BD ; Call subroutine at zero page address 0x0034 (page 13 << 2)
    CI 0xCF              ; 06F0: 17 CF ; Compare ACC with 0xCF, skip next instruction if ACC == 0xCF ;  [CONDITIONAL: skip next on ACC equals X]
    RT                   ; 06F2: 48 ; Return from subroutine
    SMB 0                ; 06F3: 78 ; Set bit 0 of RAM[DP] (RAM[DP] |= 0x1)
    RT                   ; 06F4: 48 ; Return from subroutine
sub_06F5:
    LDZ 0x0              ; 06F5: 80 ; Load DP with 0x00 (DPH = 0, DPL = 0x0)
    CZP L0004            ; 06F6: B1 ; Call subroutine at zero page address 0x0004 (page 1 << 2)
    LDZ 0x1              ; 06F7: 81 ; Load DP with 0x01 (DPH = 0, DPL = 0x1)
    CZP L0004            ; 06F8: B1 ; Call subroutine at zero page address 0x0004 (page 1 << 2)
    LDZ 0x3              ; 06F9: 83 ; Load DP with 0x03 (DPH = 0, DPL = 0x3)
    CZP L0004            ; 06FA: B1 ; Call subroutine at zero page address 0x0004 (page 1 << 2)
    LDZ 0x6              ; 06FB: 86 ; Load DP with 0x06 (DPH = 0, DPL = 0x6)
    CZP L0004            ; 06FC: B1 ; Call subroutine at zero page address 0x0004 (page 1 << 2)
    LDZ 0xB              ; 06FD: 8B ; Load DP with 0x0B (DPH = 0, DPL = 0xB)
    CZP L0004            ; 06FE: B1 ; Call subroutine at zero page address 0x0004 (page 1 << 2)
    RT                   ; 06FF: 48 ; Return from subroutine
sub_0700:
    TTM                  ; 0700: 05 ; skip next on Timer F/F ;  [CONDITIONAL: skip next on Timer F/F]
    JCP sub_0700         ; 0701: C0 ; Jump to address 0x0700 in current page (page 0x0700 + offset 0x00)
    AD                   ; 0702: 08 ; Add RAM[DP] to ACC, skip next instruction if carry (ACC + RAM[DP] > 15) ;  [CONDITIONAL: skip next on carry]
    JCP sub_070B         ; 0703: CB ; Jump to address 0x070B in current page (page 0x0700 + offset 0x0B)
    FBT 3                ; 0704: 5F ; Skip next instruction if FLAG bit 3 is set (FLAG & 0x8 != 0) ;  [CONDITIONAL: skip next on bit 3 of FLAG]
    JCP sub_070B         ; 0705: CB ; Jump to address 0x070B in current page (page 0x0700 + offset 0x0B)
    LDI 0x14             ; 0706: 15 14 ; Load DP with 0x14 (DPH = 0x1, DPL = 0x4)
    INM                  ; 0708: 1D ; Increment RAM[DP] (RAM[DP] = RAM[DP] + 1), skip next if RAM[DP] overflows to 0 ;  [CONDITIONAL: skip next on carry (RAM==0)]
    TMB 0                ; 0709: 58 ; Skip next instruction if RAM[DP] bit 0 is set (RAM[DP] & 0x1 != 0) ;  [CONDITIONAL: skip next on bit 0 of RAM]
    LI 8                 ; 070A: 98 ; Load ACC with 0x8, skip next LI instruction, resume at 0x070C
sub_070B:
    LI 0                 ; 070B: 90 ; Load ACC with 0x0
    LDZ 0x4              ; 070C: 84 ; Load DP with 0x04 (DPH = 0, DPL = 0x4)
    OE                   ; 070D: 44 ; Output ACC to port E
    OCD 0x00             ; 070E: 1E 00 ; Output 0x0 to port D, 0x0 to port C
sub_0710:
    LI 0                 ; 0710: 90 ; Load ACC with 0x0
    XMI 0                ; 0711: 3C ; Exchange ACC with RAM[DP], increment DPL, skip next if DPL overflows to 0 ;  [CONDITIONAL: skip next on carry (DPl==0) after increment]
    OP                   ; 0712: 0E ; Output ACC to port specified by DPL (port[DPL] = ACC)
    CLI 8                ; 0713: 16 E8 ; Compare DPL with 8, skip next instruction if DPL == 8 ;  [CONDITIONAL: skip next on DPl equals X]
    JCP sub_0710         ; 0715: D0 ; Jump to address 0x0710 in current page (page 0x0700 + offset 0x10)
    STM 0x01             ; 0716: 14 81 ; Reset Timer F/F, Start Timer with 0x01 (126 ticks)
    RT                   ; 0718: 48 ; Return from subroutine
sub_0719:
    LDI 0x4E             ; 0719: 15 4E ; Load DP with 0x4E (DPH = 0x4, DPL = 0xE)
    LM 0                 ; 071B: 38 ; Load ACC with RAM[DP] (ACC = RAM[DP])
    TLY                  ; 071C: 46 ; Transfer DPl to Y
    LDI 0x48             ; 071D: 15 48 ; Load DP with 0x48 (DPH = 0x4, DPL = 0x8)
    XM 0                 ; 071F: 28 ; Exchange ACC with RAM[DP] (temp = ACC; ACC = RAM[DP]; RAM[DP] = temp)
    XLY                  ; 0720: 4E ; Exchange DPl with Y
    S                    ; 0721: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
    RT                   ; 0722: 48 ; Return from subroutine
sub_0723:
    LDI 0x2F             ; 0723: 15 2F ; Load DP with 0x2F (DPH = 0x2, DPL = 0xF)
sub_0725:
    LI 0                 ; 0725: 90 ; Load ACC with 0x0
    XMD 1                ; 0726: 2D ; Exchange ACC with RAM[DP], XOR DPH with 0x1, decrement DPL, skip next if DPL underflows to 15 ;  [CONDITIONAL: skip next on carry (DPl==0xF) after decrement]
    LI 0                 ; 0727: 90 ; Load ACC with 0x0
    XM 1                 ; 0728: 29 ; Exchange ACC with RAM[DP], XOR DPH with 0x1 (temp = ACC; ACC = RAM[DP]; RAM[DP] = temp; DPH ^= 0x1)
    CLI 12               ; 0729: 16 EC ; Compare DPL with 12, skip next instruction if DPL == 12 ;  [CONDITIONAL: skip next on DPl equals X]
    JCP sub_0725         ; 072B: E5 ; Jump to address 0x0725 in current page (page 0x0700 + offset 0x25)
    LDI 0x29             ; 072C: 15 29 ; Load DP with 0x29 (DPH = 0x2, DPL = 0x9)
    CZP L0030            ; 072E: BC ; Call subroutine at zero page address 0x0030 (page 12 << 2)
    RT                   ; 072F: 48 ; Return from subroutine
sub_0730:
    LDI 0x4D             ; 0730: 15 4D ; Load DP with 0x4D (DPH = 0x4, DPL = 0xD)
    STC                  ; 0732: 1B ; Set Carry F/F
    TMB 0                ; 0733: 58 ; Skip next instruction if RAM[DP] bit 0 is set (RAM[DP] & 0x1 != 0) ;  [CONDITIONAL: skip next on bit 0 of RAM]
    CLC                  ; 0734: 0B ; Reset Carry F/F
    LDI 0x1C             ; 0735: 15 1C ; Load DP with 0x1C (DPH = 0x1, DPL = 0xC)
    LM 3                 ; 0737: 3B ; Load ACC with RAM[DP], XOR DPH with 0x3 (ACC = RAM[DP]; DPH ^= 0x3)
    TAZ                  ; 0738: 42 ; Transfer ACC to Z
    LI 14                ; 0739: 9E ; Load ACC with 0xE
    AD                   ; 073A: 08 ; Add RAM[DP] to ACC, skip next instruction if carry (ACC + RAM[DP] > 15) ;  [CONDITIONAL: skip next on carry]
    RT                   ; 073B: 48 ; Return from subroutine
    LI 6                 ; 073C: 96 ; Load ACC with 0x6
    AD                   ; 073D: 08 ; Add RAM[DP] to ACC, skip next instruction if carry (ACC + RAM[DP] > 15) ;  [CONDITIONAL: skip next on carry]
    CMA                  ; 073E: 10 ; Complement ACC
    TAL                  ; 073F: 07 ; Transfer ACC to DPL (lower 4 bits of data pointer)
    LI 0                 ; 0740: 90 ; Load ACC with 0x0
    XM 1                 ; 0741: 29 ; Exchange ACC with RAM[DP], XOR DPH with 0x1 (temp = ACC; ACC = RAM[DP]; RAM[DP] = temp; DPH ^= 0x1)
    LI 0                 ; 0742: 90 ; Load ACC with 0x0
    XM 1                 ; 0743: 29 ; Exchange ACC with RAM[DP], XOR DPH with 0x1 (temp = ACC; ACC = RAM[DP]; RAM[DP] = temp; DPH ^= 0x1)
    TC                   ; 0744: 04 ; skip next on Carry F/F ;  [CONDITIONAL: skip next on Carry F/F]
    RT                   ; 0745: 48 ; Return from subroutine
    XAZ                  ; 0746: 4A ; Exchange ACC with Z
    S                    ; 0747: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
    CI 0xC0              ; 0748: 17 C0 ; Compare ACC with 0xC0, skip next instruction if ACC == 0xC0 ;  [CONDITIONAL: skip next on ACC equals X]
    RT                   ; 074A: 48 ; Return from subroutine
    XM 1                 ; 074B: 29 ; Exchange ACC with RAM[DP], XOR DPH with 0x1 (temp = ACC; ACC = RAM[DP]; RAM[DP] = temp; DPH ^= 0x1)
    SMB 0                ; 074C: 78 ; Set bit 0 of RAM[DP] (RAM[DP] |= 0x1)
    RT                   ; 074D: 48 ; Return from subroutine
sub_074E:
    LDZ 0x7              ; 074E: 87 ; Load DP with 0x07 (DPH = 0, DPL = 0x7)
sub_074F:
    LI 0                 ; 074F: 90 ; Load ACC with 0x0
    XMD 0                ; 0750: 2C ; Exchange ACC with RAM[DP], decrement DPL, skip next if DPL underflows to 15 ;  [CONDITIONAL: skip next on carry (DPl==0xF) after decrement]
    CLI 3                ; 0751: 16 E3 ; Compare DPL with 3, skip next instruction if DPL == 3 ;  [CONDITIONAL: skip next on DPl equals X]
    JCP sub_074F         ; 0753: CF ; Jump to address 0x074F in current page (page 0x0740 + offset 0x0F)
    RT                   ; 0754: 48 ; Return from subroutine
sub_0755:
    LDZ 0xF              ; 0755: 8F ; Load DP with 0x0F (DPH = 0, DPL = 0xF)
    CZP L0008            ; 0756: B2 ; Call subroutine at zero page address 0x0008 (page 2 << 2)
    LDZ 0xA              ; 0757: 8A ; Load DP with 0x0A (DPH = 0, DPL = 0xA)
    CZP L0008            ; 0758: B2 ; Call subroutine at zero page address 0x0008 (page 2 << 2)
    CZP L0028            ; 0759: BA ; Call subroutine at zero page address 0x0028 (page 10 << 2)
    LI 4                 ; 075A: 94 ; Load ACC with 0x4
sub_075B:
    TAW                  ; 075B: 43 ; Transfer ACC to W
    LDZ 0x1              ; 075C: 81 ; Load DP with 0x01 (DPH = 0, DPL = 0x1)
    CZP L0008            ; 075D: B2 ; Call subroutine at zero page address 0x0008 (page 2 << 2)
    LDZ 0x7              ; 075E: 87 ; Load DP with 0x07 (DPH = 0, DPL = 0x7)
    CZP L0008            ; 075F: B2 ; Call subroutine at zero page address 0x0008 (page 2 << 2)
    LDZ 0xB              ; 0760: 8B ; Load DP with 0x0B (DPH = 0, DPL = 0xB)
    CZP L0008            ; 0761: B2 ; Call subroutine at zero page address 0x0008 (page 2 << 2)
    XAW                  ; 0762: 4B ; Exchange ACC with W
    DEC                  ; 0763: 0F ; Decrement ACC (ACC = ACC - 1), skip next instruction if ACC underflows to 15 ;  [CONDITIONAL: skip next on carry (ACC==0xF)]
    JCP sub_075B         ; 0764: DB ; Jump to address 0x075B in current page (page 0x0740 + offset 0x1B)
    CAL L0027            ; 0765: A8 27 ; Call subroutine at absolute address 0x0027 (push return address to stack)
    RT                   ; 0767: 48 ; Return from subroutine
sub_0768:
    CZP L0018            ; 0768: B6 ; Call subroutine at zero page address 0x0018 (page 6 << 2)
    LDZ 0xF              ; 0769: 8F ; Load DP with 0x0F (DPH = 0, DPL = 0xF)
    CZP L000C            ; 076A: B3 ; Call subroutine at zero page address 0x000C (page 3 << 2)
    CAL L0015            ; 076B: A8 15 ; Call subroutine at absolute address 0x0015 (push return address to stack)
    CZP L0010            ; 076D: B4 ; Call subroutine at zero page address 0x0010 (page 4 << 2)
    LDZ 0x9              ; 076E: 89 ; Load DP with 0x09 (DPH = 0, DPL = 0x9)
    CZP L000C            ; 076F: B3 ; Call subroutine at zero page address 0x000C (page 3 << 2)
    LDZ 0xF              ; 0770: 8F ; Load DP with 0x0F (DPH = 0, DPL = 0xF)
    CZP L000C            ; 0771: B3 ; Call subroutine at zero page address 0x000C (page 3 << 2)
    LDZ 0x9              ; 0772: 89 ; Load DP with 0x09 (DPH = 0, DPL = 0x9)
    CZP L000C            ; 0773: B3 ; Call subroutine at zero page address 0x000C (page 3 << 2)
    LDZ 0x5              ; 0774: 85 ; Load DP with 0x05 (DPH = 0, DPL = 0x5)
    CZP L000C            ; 0775: B3 ; Call subroutine at zero page address 0x000C (page 3 << 2)
    LDZ 0x9              ; 0776: 89 ; Load DP with 0x09 (DPH = 0, DPL = 0x9)
    CZP L000C            ; 0777: B3 ; Call subroutine at zero page address 0x000C (page 3 << 2)
    LDZ 0x5              ; 0778: 85 ; Load DP with 0x05 (DPH = 0, DPL = 0x5)
    CZP L000C            ; 0779: B3 ; Call subroutine at zero page address 0x000C (page 3 << 2)
    LDZ 0x3              ; 077A: 83 ; Load DP with 0x03 (DPH = 0, DPL = 0x3)
    CZP L0014            ; 077B: B5 ; Call subroutine at zero page address 0x0014 (page 5 << 2)
    RT                   ; 077C: 48 ; Return from subroutine
sub_077D:
    LDZ 0xB              ; 077D: 8B ; Load DP with 0x0B (DPH = 0, DPL = 0xB)
    CZP L0010            ; 077E: B4 ; Call subroutine at zero page address 0x0010 (page 4 << 2)
    LDZ 0x9              ; 077F: 89 ; Load DP with 0x09 (DPH = 0, DPL = 0x9)
    CZP L0010            ; 0780: B4 ; Call subroutine at zero page address 0x0010 (page 4 << 2)
    LDZ 0x7              ; 0781: 87 ; Load DP with 0x07 (DPH = 0, DPL = 0x7)
    CZP L0010            ; 0782: B4 ; Call subroutine at zero page address 0x0010 (page 4 << 2)
    LDZ 0xB              ; 0783: 8B ; Load DP with 0x0B (DPH = 0, DPL = 0xB)
    CZP L0010            ; 0784: B4 ; Call subroutine at zero page address 0x0010 (page 4 << 2)
    LDZ 0x9              ; 0785: 89 ; Load DP with 0x09 (DPH = 0, DPL = 0x9)
    CZP L0010            ; 0786: B4 ; Call subroutine at zero page address 0x0010 (page 4 << 2)
    LDZ 0x7              ; 0787: 87 ; Load DP with 0x07 (DPH = 0, DPL = 0x7)
    CZP L0010            ; 0788: B4 ; Call subroutine at zero page address 0x0010 (page 4 << 2)
    LDZ 0x6              ; 0789: 86 ; Load DP with 0x06 (DPH = 0, DPL = 0x6)
    CZP L0010            ; 078A: B4 ; Call subroutine at zero page address 0x0010 (page 4 << 2)
    LDZ 0x9              ; 078B: 89 ; Load DP with 0x09 (DPH = 0, DPL = 0x9)
    CZP L0010            ; 078C: B4 ; Call subroutine at zero page address 0x0010 (page 4 << 2)
    LDZ 0x7              ; 078D: 87 ; Load DP with 0x07 (DPH = 0, DPL = 0x7)
    CZP L0010            ; 078E: B4 ; Call subroutine at zero page address 0x0010 (page 4 << 2)
    LDZ 0x3              ; 078F: 83 ; Load DP with 0x03 (DPH = 0, DPL = 0x3)
    CZP L0010            ; 0790: B4 ; Call subroutine at zero page address 0x0010 (page 4 << 2)
    LDZ 0x6              ; 0791: 86 ; Load DP with 0x06 (DPH = 0, DPL = 0x6)
    CZP L0010            ; 0792: B4 ; Call subroutine at zero page address 0x0010 (page 4 << 2)
    LDZ 0x7              ; 0793: 87 ; Load DP with 0x07 (DPH = 0, DPL = 0x7)
    CZP L0010            ; 0794: B4 ; Call subroutine at zero page address 0x0010 (page 4 << 2)
    LDZ 0x9              ; 0795: 89 ; Load DP with 0x09 (DPH = 0, DPL = 0x9)
    CZP L0010            ; 0796: B4 ; Call subroutine at zero page address 0x0010 (page 4 << 2)
    LDZ 0x6              ; 0797: 86 ; Load DP with 0x06 (DPH = 0, DPL = 0x6)
    CZP L0010            ; 0798: B4 ; Call subroutine at zero page address 0x0010 (page 4 << 2)
    LDZ 0x7              ; 0799: 87 ; Load DP with 0x07 (DPH = 0, DPL = 0x7)
    CZP L0010            ; 079A: B4 ; Call subroutine at zero page address 0x0010 (page 4 << 2)
    LDZ 0x9              ; 079B: 89 ; Load DP with 0x09 (DPH = 0, DPL = 0x9)
    CZP L0010            ; 079C: B4 ; Call subroutine at zero page address 0x0010 (page 4 << 2)
    LDZ 0xA              ; 079D: 8A ; Load DP with 0x0A (DPH = 0, DPL = 0xA)
    CZP L0014            ; 079E: B5 ; Call subroutine at zero page address 0x0014 (page 5 << 2)
    RT                   ; 079F: 48 ; Return from subroutine
sub_07A0:
    LDI 0x13             ; 07A0: 15 13 ; Load DP with 0x13 (DPH = 0x1, DPL = 0x3)
sub_07A2:
    CLC                  ; 07A2: 0B ; Reset Carry F/F
sub_07A3:
    LM 1                 ; 07A3: 39 ; Load ACC with RAM[DP], XOR DPH with 0x1 (ACC = RAM[DP]; DPH ^= 0x1)
    DAA                  ; 07A4: 06 ; Add 6 to ACC to adjust decimal for BCD Addition
    ADS                  ; 07A5: 09 ; Add RAM[DP] and carry to ACC, store carry flag, skip next if carry ;  [CONDITIONAL: skip next on carry]
    DAS                  ; 07A6: 0A ; Add 10 to ACC to adjust decimal for BCD Subtraction
    XMD 1                ; 07A7: 2D ; Exchange ACC with RAM[DP], XOR DPH with 0x1, decrement DPL, skip next if DPL underflows to 15 ;  [CONDITIONAL: skip next on carry (DPl==0xF) after decrement]
    JCP sub_07A3         ; 07A8: E3 ; Jump to address 0x07A3 in current page (page 0x0780 + offset 0x23)
    TC                   ; 07A9: 04 ; skip next on Carry F/F ;  [CONDITIONAL: skip next on Carry F/F]
    RT                   ; 07AA: 48 ; Return from subroutine
    LI 7                 ; 07AB: 97 ; Load ACC with 0x7
sub_07AC:
    TAW                  ; 07AC: 43 ; Transfer ACC to W
    CAL sub_07B9         ; 07AD: AF B9 ; Call subroutine at absolute address 0x07B9 (push return address to stack)
    XAW                  ; 07AF: 4B ; Exchange ACC with W
    DEC                  ; 07B0: 0F ; Decrement ACC (ACC = ACC - 1), skip next instruction if ACC underflows to 15 ;  [CONDITIONAL: skip next on carry (ACC==0xF)]
    JCP sub_07AC         ; 07B1: EC ; Jump to address 0x07AC in current page (page 0x0780 + offset 0x2C)
    CAL sub_0579         ; 07B2: AD 79 ; Call subroutine at absolute address 0x0579 (push return address to stack)
    RTS                  ; 07B4: 49 ; Return from subroutine, skip next ;  [CONDITIONAL: skip next (return from subroutine)]
sub_07B5:
    SMB 3                ; 07B5: 7B ; Set bit 3 of RAM[DP] (RAM[DP] |= 0x8)
    RFB 3                ; 07B6: 6F ; Reset bit 3 of FLAG register (FLAG &= ~0x8)
    JMP sub_0360         ; 07B7: A3 60 ; Jump to absolute address 0x0360
sub_07B9:
    LDZ 0xF              ; 07B9: 8F ; Load DP with 0x0F (DPH = 0, DPL = 0xF)
    CZP L000C            ; 07BA: B3 ; Call subroutine at zero page address 0x000C (page 3 << 2)
    CAL L0015            ; 07BB: A8 15 ; Call subroutine at absolute address 0x0015 (push return address to stack)
    CZP L0010            ; 07BD: B4 ; Call subroutine at zero page address 0x0010 (page 4 << 2)
    LDZ 0x9              ; 07BE: 89 ; Load DP with 0x09 (DPH = 0, DPL = 0x9)
    CZP L000C            ; 07BF: B3 ; Call subroutine at zero page address 0x000C (page 3 << 2)
sub_07C0:
    LDZ 0x5              ; 07C0: 85 ; Load DP with 0x05 (DPH = 0, DPL = 0x5)
    CZP L000C            ; 07C1: B3 ; Call subroutine at zero page address 0x000C (page 3 << 2)
    LDZ 0x9              ; 07C2: 89 ; Load DP with 0x09 (DPH = 0, DPL = 0x9)
    CZP L000C            ; 07C3: B3 ; Call subroutine at zero page address 0x000C (page 3 << 2)
sub_07C4:
    LDZ 0x7              ; 07C4: 87 ; Load DP with 0x07 (DPH = 0, DPL = 0x7)
    CZP L0010            ; 07C5: B4 ; Call subroutine at zero page address 0x0010 (page 4 << 2)
    LDZ 0xA              ; 07C6: 8A ; Load DP with 0x0A (DPH = 0, DPL = 0xA)
    CZP L000C            ; 07C7: B3 ; Call subroutine at zero page address 0x000C (page 3 << 2)
sub_07C8:
    LDZ 0x3              ; 07C8: 83 ; Load DP with 0x03 (DPH = 0, DPL = 0x3)
    CZP L0014            ; 07C9: B5 ; Call subroutine at zero page address 0x0014 (page 5 << 2)
    RT                   ; 07CA: 48 ; Return from subroutine
    NOP                  ; 07CB: 00 ; No Operation
sub_07CC:
    NOP                  ; 07CC: 00 ; No Operation
    NOP                  ; 07CD: 00 ; No Operation
    NOP                  ; 07CE: 00 ; No Operation
    NOP                  ; 07CF: 00 ; No Operation
sub_07D0:
    NOP                  ; 07D0: 00 ; No Operation
    IP                   ; 07D1: 32 ; Input from port specified by DPL to ACC (ACC = port[DPL])
    S                    ; 07D2: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
    IP                   ; 07D3: 32 ; Input from port specified by DPL to ACC (ACC = port[DPL])
sub_07D4:
    AD                   ; 07D4: 08 ; Add RAM[DP] to ACC, skip next instruction if carry (ACC + RAM[DP] > 15) ;  [CONDITIONAL: skip next on carry]
    OE                   ; 07D5: 44 ; Output ACC to port E
    LDZ 0x2              ; 07D6: 82 ; Load DP with 0x02 (DPH = 0, DPL = 0x2)
sub_07D7:
    IP                   ; 07D7: 32 ; Input from port specified by DPL to ACC (ACC = port[DPL])
sub_07D8:
    S                    ; 07D8: 02 ; Store ACC into RAM at address pointed to by DP (DPH:DPL)
    OE                   ; 07D9: 44 ; Output ACC to port E
    LI 10                ; 07DA: 9A ; Load ACC with 0xA
    CM                   ; 07DB: 0C ; Compare ACC with RAM[DP], skip next instruction if ACC == RAM[DP] ;  [CONDITIONAL: skip next on ACC equals RAM]
sub_07DC:
    JCP sub_07D7         ; 07DC: D7 ; Jump to address 0x07D7 in current page (page 0x07C0 + offset 0x17)
    LDZ 0x3              ; 07DD: 83 ; Load DP with 0x03 (DPH = 0, DPL = 0x3)
    CM                   ; 07DE: 0C ; Compare ACC with RAM[DP], skip next instruction if ACC == RAM[DP] ;  [CONDITIONAL: skip next on ACC equals RAM]
    JMP sub_07D7         ; 07DF: A7 D7 ; Jump to absolute address 0x07D7
    OP                   ; 07E1: 0E ; Output ACC to port specified by DPL (port[DPL] = ACC)
    LI 5                 ; 07E2: 95 ; Load ACC with 0x5
    OP                   ; 07E3: 0E ; Output ACC to port specified by DPL (port[DPL] = ACC)
sub_07E4:
    LDZ 0x2              ; 07E4: 82 ; Load DP with 0x02 (DPH = 0, DPL = 0x2)
    OP                   ; 07E5: 0E ; Output ACC to port specified by DPL (port[DPL] = ACC)
    LI 10                ; 07E6: 9A ; Load ACC with 0xA
    OP                   ; 07E7: 0E ; Output ACC to port specified by DPL (port[DPL] = ACC)
sub_07E8:
    CAL sub_07F3         ; 07E8: AF F3 ; Call subroutine at absolute address 0x07F3 (push return address to stack)
    INC                  ; 07EA: 0D ; Increment ACC (ACC = ACC + 1), skip next instruction if ACC overflows to 0 ;  [CONDITIONAL: skip next on carry (ACC==0)]
    OE                   ; 07EB: 44 ; Output ACC to port E
sub_07EC:
    LI 12                ; 07EC: 9C ; Load ACC with 0xC
    JPA                  ; 07ED: 41 ; Jump to address in current page based on ACC value (jump table: page | (ACC << 2)) ;  [INDIRECT JUMP: 16/16 targets in ROM, see table above]
    LI 3                 ; 07EE: 93 ; Load ACC with 0x3
    OE                   ; 07EF: 44 ; Output ACC to port E
sub_07F0:
    OCD 0x00             ; 07F0: 1E 00 ; Output 0x0 to port D, 0x0 to port C
    CZP L0000            ; 07F2: B0 ; Call subroutine at zero page address 0x0000 (page 0 << 2)
sub_07F3:
    INC                  ; 07F3: 0D ; Increment ACC (ACC = ACC + 1), skip next instruction if ACC overflows to 0 ;  [CONDITIONAL: skip next on carry (ACC==0)]
sub_07F4:
    OP                   ; 07F4: 0E ; Output ACC to port specified by DPL (port[DPL] = ACC)
    CAL sub_07F8         ; 07F5: AF F8 ; Call subroutine at absolute address 0x07F8 (push return address to stack)
    RTS                  ; 07F7: 49 ; Return from subroutine, skip next ;  [CONDITIONAL: skip next (return from subroutine)]
sub_07F8:
    CMA                  ; 07F8: 10 ; Complement ACC
    OP                   ; 07F9: 0E ; Output ACC to port specified by DPL (port[DPL] = ACC)
    CAL sub_07FD         ; 07FA: AF FD ; Call subroutine at absolute address 0x07FD (push return address to stack)
sub_07FC:
    RT                   ; 07FC: 48 ; Return from subroutine
sub_07FD:
    DEC                  ; 07FD: 0F ; Decrement ACC (ACC = ACC - 1), skip next instruction if ACC underflows to 15 ;  [CONDITIONAL: skip next on carry (ACC==0xF)]
    OP                   ; 07FE: 0E ; Output ACC to port specified by DPL (port[DPL] = ACC)
    RT                   ; 07FF: 48 ; Return from subroutine
    NOP                  ; 0800: 00 ; No Operation
