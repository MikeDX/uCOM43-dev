; Round-trip test disassembly
; Original ROM: astrowars.rom
; Test range: 0x0000 - 0x0801
; Size: 2049 bytes

    ORG 0x0000

L0000:
    STM 0x00             ; 0000: 14 80
    JMP L0040            ; 0002: A0 40
L0004:
    STM 0x10             ; 0004: 14 90
    LI 0                 ; 0006: 90
L0007:
    LI 13                ; 0007: 9D
L0008:
    LI 1                 ; 0008: 91
    JMP sub_01DA         ; 0009: A1 DA
    NOP                  ; 000B: 00
L000C:
    LI 3                 ; 000C: 93
    JMP sub_01DA         ; 000D: A1 DA
    NOP                  ; 000F: 00
L0010:
    LI 7                 ; 0010: 97
    JMP sub_01DA         ; 0011: A1 DA
    NOP                  ; 0013: 00
L0014:
    JCP L0007            ; 0014: C7
L0015:
    STM 0x10             ; 0015: 14 90
    LI 0                 ; 0017: 90
L0018:
    LI 7                 ; 0018: 97
    JCP L002A            ; 0019: EA
    NOP                  ; 001A: 00
    NOP                  ; 001B: 00
L001C:
    LDZ 0xF              ; 001C: 8F
    LI 9                 ; 001D: 99
    JMP sub_0700         ; 001E: A7 00
L0020:
    LI 0                 ; 0020: 90
    XMD 0                ; 0021: 2C
    JCP L0020            ; 0022: E0
    RT                   ; 0023: 48
L0024:
    LDI 0x78             ; 0024: 15 78
    JCP L0020            ; 0026: E0
L0027:
    LI 13                ; 0027: 9D
L0028:
    LI 3                 ; 0028: 93
    LI 1                 ; 0029: 91
L002A:
    JMP sub_05BB         ; 002A: A5 BB
L002C:
    LM 0                 ; 002C: 38
    DEC                  ; 002D: 0F
    S                    ; 002E: 02
    RT                   ; 002F: 48
L0030:
    LI 0                 ; 0030: 90
    XM 1                 ; 0031: 29
    LI 0                 ; 0032: 90
    JCP L0035            ; 0033: F5
L0034:
    JCP L003D            ; 0034: FD
L0035:
    XMD 1                ; 0035: 2D
    JCP L0030            ; 0036: F0
    RT                   ; 0037: 48
L0038:
    LDZ 0x5              ; 0038: 85
    JCP L003D            ; 0039: FD
    NOP                  ; 003A: 00
    NOP                  ; 003B: 00
L003C:
    LDZ 0x4              ; 003C: 84
L003D:
    CMA                  ; 003D: 10
    JMP sub_0562         ; 003E: A5 62
L0040:
    LDI 0x7F             ; 0040: 15 7F
    CAL L00FA            ; 0042: A8 FA
    LDZ 0xF              ; 0044: 8F
    CZP L0030            ; 0045: BC
    LM 2                 ; 0046: 3A
    CZP L0030            ; 0047: BC
    CAL sub_061C         ; 0048: AE 1C
    CAL sub_061C         ; 004A: AE 1C
    NOP                  ; 004C: 00
    NOP                  ; 004D: 00
L004E:
    LDZ 0x3              ; 004E: 83
L004F:
    LI 14                ; 004F: 9E
    XMD 0                ; 0050: 2C
    JCP L004F            ; 0051: CF
    LDZ 0xD              ; 0052: 8D
    LM 0                 ; 0053: 38
    LDZ 0x2              ; 0054: 82
    S                    ; 0055: 02
    INM                  ; 0056: 1D
L0057:
    LDZ 0xA              ; 0057: 8A
    LI 0                 ; 0058: 90
    CM                   ; 0059: 0C
    JMP sub_04AC         ; 005A: A4 AC
    LDZ 0xF              ; 005C: 8F
    CM                   ; 005D: 0C
    JMP L00A4            ; 005E: A0 A4
    RFB 1                ; 0060: 6D
    LDI 0x13             ; 0061: 15 13
    CZP L0020            ; 0063: B8
    LDI 0x39             ; 0064: 15 39
    TMB 0                ; 0066: 58
    JCP L007D            ; 0067: FD
    LDI 0x2E             ; 0068: 15 2E
    CM                   ; 006A: 0C
    JCP L0079            ; 006B: F9
    LI 7                 ; 006C: 97
    XM 3                 ; 006D: 2B
    LI 4                 ; 006E: 94
    S                    ; 006F: 02
    LDI 0x40             ; 0070: 15 40
    LM 0                 ; 0072: 38
    AD                   ; 0073: 08
    NOP                  ; 0074: 00
    S                    ; 0075: 02
    DEC                  ; 0076: 0F
    JCP L0079            ; 0077: F9
    SMB 0                ; 0078: 78
L0079:
    LDI 0x2A             ; 0079: 15 2A
    LI 14                ; 007B: 9E
    S                    ; 007C: 02
L007D:
    LDZ 0x1              ; 007D: 81
    CAL sub_056C         ; 007E: AD 6C
    TMB 3                ; 0080: 5B
    JCP L008A            ; 0081: CA
    RMB 3                ; 0082: 6B
    LDZ 0xD              ; 0083: 8D
    INM                  ; 0084: 1D
    RMB 2                ; 0085: 6A
    LDZ 0x5              ; 0086: 85
    CZP L000C            ; 0087: B3
    JMP L004E            ; 0088: A0 4E
L008A:
    LDZ 0x1              ; 008A: 81
    TPB 1                ; 008B: 51
    JMP sub_020C         ; 008C: A2 0C
    LDZ 0x2              ; 008E: 82
    CZP L0008            ; 008F: B2
    LI 4                 ; 0090: 94
    LDI 0x1B             ; 0091: 15 1B
    S                    ; 0093: 02
    LM 3                 ; 0094: 3B
    CZP L0030            ; 0095: BC
L0096:
    CZP L0018            ; 0096: B6
    RFB 1                ; 0097: 6D
    CAL sub_0723         ; 0098: AF 23
    LDZ 0xB              ; 009A: 8B
    LI 15                ; 009B: 9F
    XMI 2                ; 009C: 3E
    LI 1                 ; 009D: 91
    XM 3                 ; 009E: 2B
    LI 4                 ; 009F: 94
    S                    ; 00A0: 02
    LDZ 0xF              ; 00A1: 8F
    LI 1                 ; 00A2: 91
    S                    ; 00A3: 02
L00A4:
    LI 1                 ; 00A4: 91
    CM                   ; 00A5: 0C
    JMP L00C3            ; 00A6: A0 C3
    LDI 0x1B             ; 00A8: 15 1B
    LM 0                 ; 00AA: 38
    INC                  ; 00AB: 0D
    LDZ 0x3              ; 00AC: 83
    XMD 0                ; 00AD: 2C
L00AE:
    LI 14                ; 00AE: 9E
    XMD 0                ; 00AF: 2C
    JCP L00AE            ; 00B0: EE
    LDZ 0xB              ; 00B1: 8B
    LI 0                 ; 00B2: 90
    CM                   ; 00B3: 0C
    JMP sub_03B5         ; 00B4: A3 B5
    LDZ 0x8              ; 00B6: 88
    LI 10                ; 00B7: 9A
    S                    ; 00B8: 02
    LDZ 0xF              ; 00B9: 8F
    INM                  ; 00BA: 1D
L00BB:
    CAL sub_061C         ; 00BB: AE 1C
    CAL sub_01FA         ; 00BD: A9 FA
    CAL sub_0723         ; 00BF: AF 23
    JMP L0057            ; 00C1: A0 57
L00C3:
    LDZ 0x0              ; 00C3: 80
    CAL sub_056C         ; 00C4: AD 6C
    LDZ 0xF              ; 00C6: 8F
    LI 2                 ; 00C7: 92
    CM                   ; 00C8: 0C
    JCP L00F0            ; 00C9: F0
    LDI 0x39             ; 00CA: 15 39
    TMB 0                ; 00CC: 58
    JMP sub_0225         ; 00CD: A2 25
    LDI 0x2A             ; 00CF: 15 2A
    LI 14                ; 00D1: 9E
    S                    ; 00D2: 02
    LDZ 0xF              ; 00D3: 8F
    INM                  ; 00D4: 1D
    INM                  ; 00D5: 1D
L00D6:
    LDI 0x4B             ; 00D6: 15 4B
    LI 0                 ; 00D8: 90
    CM                   ; 00D9: 0C
    JCP L00EE            ; 00DA: EE
    LDI 0x14             ; 00DB: 15 14
    TMB 1                ; 00DD: 59
    LI 1                 ; 00DE: 91
    LI 2                 ; 00DF: 92
    LDZ 0xF              ; 00E0: 8F
    TMB 0                ; 00E1: 58
    JCP L00E4            ; 00E2: E4
    LI 4                 ; 00E3: 94
L00E4:
    TAW                  ; 00E4: 43
    SFB 0                ; 00E5: 7C
    CAL sub_0584         ; 00E6: AD 84
    RFB 0                ; 00E8: 6C
    LDZ 0xD              ; 00E9: 8D
    TMB 1                ; 00EA: 59
    JCP L00EE            ; 00EB: EE
    CAL sub_0584         ; 00EC: AD 84
L00EE:
    JMP sub_020C         ; 00EE: A2 0C
L00F0:
    LDZ 0x8              ; 00F0: 88
    LI 2                 ; 00F1: 92
    CM                   ; 00F2: 0C
    JCP L00F5            ; 00F3: F5
    SFB 1                ; 00F4: 7D
L00F5:
    LI 0                 ; 00F5: 90
    CM                   ; 00F6: 0C
    JCP L00D6            ; 00F7: D6
    JMP sub_0100         ; 00F8: A1 00
L00FA:
    LI 0                 ; 00FA: 90
    XM 3                 ; 00FB: 2B
    LI 0                 ; 00FC: 90
    XMD 3                ; 00FD: 2F
    JCP L00FA            ; 00FE: FA
    RT                   ; 00FF: 48
sub_0100:
    LDZ 0xF              ; 0100: 8F
    LI 4                 ; 0101: 94
    CM                   ; 0102: 0C
    JCP sub_0108         ; 0103: C8
    LDZ 0x8              ; 0104: 88
    LI 10                ; 0105: 9A
    S                    ; 0106: 02
    JCP sub_010B         ; 0107: CB
sub_0108:
    LI 5                 ; 0108: 95
    CM                   ; 0109: 0C
    JCP sub_0113         ; 010A: D3
sub_010B:
    CAL sub_0768         ; 010B: AF 68
    LDZ 0xF              ; 010D: 8F
    INM                  ; 010E: 1D
    CAL sub_0723         ; 010F: AF 23
    JMP sub_020C         ; 0111: A2 0C
sub_0113:
    LI 6                 ; 0113: 96
    CM                   ; 0114: 0C
    JCP sub_013F         ; 0115: FF
    LDI 0x2A             ; 0116: 15 2A
    LM 1                 ; 0118: 39
    AD                   ; 0119: 08
    DEC                  ; 011A: 0F
    JMP sub_0225         ; 011B: A2 25
    CZP L0018            ; 011D: B6
    LDZ 0x7              ; 011E: 87
    CZP L000C            ; 011F: B3
    LDZ 0xA              ; 0120: 8A
    CZP L000C            ; 0121: B3
    LDZ 0xF              ; 0122: 8F
    CZP L000C            ; 0123: B3
    CAL L0015            ; 0124: A8 15
    CZP L0010            ; 0126: B4
    LDZ 0xA              ; 0127: 8A
    CZP L000C            ; 0128: B3
    LDZ 0x7              ; 0129: 87
    CZP L000C            ; 012A: B3
    LDZ 0xA              ; 012B: 8A
    CZP L000C            ; 012C: B3
    LDZ 0x5              ; 012D: 85
    CZP L000C            ; 012E: B3
    LDZ 0x9              ; 012F: 89
    CZP L000C            ; 0130: B3
    CAL sub_07B9         ; 0131: AF B9
    CZP L0018            ; 0133: B6
    NOP                  ; 0134: 00
    NOP                  ; 0135: 00
    NOP                  ; 0136: 00
    NOP                  ; 0137: 00
    CAL sub_01FA         ; 0138: A9 FA
    CAL sub_0579         ; 013A: AD 79
    CZP L0030            ; 013C: BC
    LDZ 0xF              ; 013D: 8F
    INM                  ; 013E: 1D
sub_013F:
    LI 7                 ; 013F: 97
    CM                   ; 0140: 0C
    JCP sub_016B         ; 0141: EB
    CAL sub_0730         ; 0142: AF 30
    CAL sub_06DF         ; 0144: AE DF
    JCP sub_0168         ; 0146: E8
    LI 7                 ; 0147: 97
    S                    ; 0148: 02
    CAL sub_01FA         ; 0149: A9 FA
    LDI 0x2C             ; 014B: 15 2C
    LI 6                 ; 014D: 96
    CM                   ; 014E: 0C
    JCP sub_0165         ; 014F: E5
    DED                  ; 0150: 13
    LI 15                ; 0151: 9F
    XMI 3                ; 0152: 3F
    LM 0                 ; 0153: 38
    LDI 0x44             ; 0154: 15 44
    S                    ; 0156: 02
    LDI 0x14             ; 0157: 15 14
    LM 0                 ; 0159: 38
    LDI 0x4F             ; 015A: 15 4F
    S                    ; 015C: 02
    CAL sub_01FA         ; 015D: A9 FA
    LDZ 0x3              ; 015F: 83
    CZP L0020            ; 0160: B8
    LDZ 0x0              ; 0161: 80
    SMB 0                ; 0162: 78
    RFB 3                ; 0163: 6F
    LDZ 0xF              ; 0164: 8F
sub_0165:
    INM                  ; 0165: 1D
sub_0166:
    JMP sub_03B5         ; 0166: A3 B5
sub_0168:
    TMB 3                ; 0168: 5B
    SFB 3                ; 0169: 7F
    JCP sub_0166         ; 016A: E6
sub_016B:
    LI 8                 ; 016B: 98
    CM                   ; 016C: 0C
    JMP sub_0200         ; 016D: A2 00
    LDZ 0x3              ; 016F: 83
sub_0170:
    LM 0                 ; 0170: 38
    DEC                  ; 0171: 0F
    JCP sub_017E         ; 0172: FE
    LI 9                 ; 0173: 99
    XMD 0                ; 0174: 2C
    JCP sub_0170         ; 0175: F0
sub_0176:
    LDZ 0xE              ; 0176: 8E
    CZP L0014            ; 0177: B5
    CZP L0028            ; 0178: BA
    CZP L0014            ; 0179: B5
    LDZ 0x3              ; 017A: 83
    CZP L0020            ; 017B: B8
    JMP sub_01C5         ; 017C: A1 C5
sub_017E:
    S                    ; 017E: 02
    LDZ 0xE              ; 017F: 8E
    TMB 3                ; 0180: 5B
    JCP sub_019B         ; 0181: DB
    CAL sub_0730         ; 0182: AF 30
    LDZ 0xB              ; 0184: 8B
    LI 0                 ; 0185: 90
    CM                   ; 0186: 0C
    JCP sub_01A2         ; 0187: E2
    FBT 3                ; 0188: 5F
    JCP sub_0194         ; 0189: D4
    CAL sub_06DF         ; 018A: AE DF
    JCP sub_0199         ; 018C: D9
    LI 12                ; 018D: 9C
    S                    ; 018E: 02
    LDI 0x2C             ; 018F: 15 2C
    LI 6                 ; 0191: 96
    CM                   ; 0192: 0C
    INM                  ; 0193: 1D
sub_0194:
    CAL sub_0719         ; 0194: AF 19
    LI 12                ; 0196: 9C
    S                    ; 0197: 02
    SFB 3                ; 0198: 7F
sub_0199:
    JMP sub_01CB         ; 0199: A1 CB
sub_019B:
    FBF 3                ; 019B: 23
    CAL sub_0719         ; 019C: AF 19
    LDZ 0xB              ; 019E: 8B
    LI 3                 ; 019F: 93
    XMD 2                ; 01A0: 2E
    CZP L0030            ; 01A1: BC
sub_01A2:
    RFB 3                ; 01A2: 6F
    CAL sub_06DF         ; 01A3: AE DF
    JCP sub_0199         ; 01A5: D9
    LI 12                ; 01A6: 9C
    S                    ; 01A7: 02
    LDI 0x2C             ; 01A8: 15 2C
    DEM                  ; 01AA: 1F
    LM 3                 ; 01AB: 3B
    CI 1                 ; 01AC: 17 C1
    JCP sub_01B4         ; 01AE: F4
    LDI 0x4E             ; 01AF: 15 4E
    LI 2                 ; 01B1: 92
    S                    ; 01B2: 02
    JCP sub_0199         ; 01B3: D9
sub_01B4:
    CI 0                 ; 01B4: 17 C0
    JCP sub_0199         ; 01B6: D9
    LM 3                 ; 01B7: 3B
    INM                  ; 01B8: 1D
    LDI 0x44             ; 01B9: 15 44
    CM                   ; 01BB: 0C
    JMP sub_0176         ; 01BC: A1 76
    LDZ 0x2              ; 01BE: 82
    CZP L0008            ; 01BF: B2
    CZP L0018            ; 01C0: B6
    CAL sub_07B9         ; 01C1: AF B9
    CAL sub_07B9         ; 01C3: AF B9
sub_01C5:
    LDZ 0xF              ; 01C5: 8F
    INM                  ; 01C6: 1D
    LDI 0x4E             ; 01C7: 15 4E
    JMP sub_07B5         ; 01C9: A7 B5
sub_01CB:
    CAL sub_06E2         ; 01CB: AE E2
    JCP sub_01D8         ; 01CD: D8
    SMB 2                ; 01CE: 7A
    LDI 0x44             ; 01CF: 15 44
    STC                  ; 01D1: 1B
    LM 0                 ; 01D2: 38
    CI 0                 ; 01D3: 17 C0
    CLC                  ; 01D5: 0B
    RAR                  ; 01D6: 30
    S                    ; 01D7: 02
sub_01D8:
    JMP sub_0360         ; 01D8: A3 60
sub_01DA:
    TLY                  ; 01DA: 46
    REB 0                ; 01DB: 64
    REB 1                ; 01DC: 65
    OCD 0x00             ; 01DD: 1E 00
sub_01DF:
    XLY                  ; 01DF: 4E
    XLY                  ; 01E0: 4E
sub_01E1:
    LDZ 0x8              ; 01E1: 88
sub_01E2:
    DED                  ; 01E2: 13
    JCP sub_01E2         ; 01E3: E2
    XLY                  ; 01E4: 4E
    TLY                  ; 01E5: 46
sub_01E6:
    DED                  ; 01E6: 13
    JCP sub_01F8         ; 01E7: F8
    TC                   ; 01E8: 04
    JCP sub_01EE         ; 01E9: EE
    SEB 3                ; 01EA: 77
    CLC                  ; 01EB: 0B
    NOP                  ; 01EC: 00
    JCP sub_01DF         ; 01ED: DF
sub_01EE:
    REB 3                ; 01EE: 67
    STC                  ; 01EF: 1B
    TTM                  ; 01F0: 05
    JCP sub_01DF         ; 01F1: DF
    STM 0x32             ; 01F2: 14 B2
    DEC                  ; 01F4: 0F
    JCP sub_01E1         ; 01F5: E1
    XLY                  ; 01F6: 4E
    RT                   ; 01F7: 48
sub_01F8:
    NOP                  ; 01F8: 00
    JCP sub_01E6         ; 01F9: E6
sub_01FA:
    LDZ 0x3              ; 01FA: 83
sub_01FB:
    LM 1                 ; 01FB: 39
sub_01FC:
    XM 1                 ; 01FC: 29
    XMD 0                ; 01FD: 2C
    JCP sub_01FB         ; 01FE: FB
    RT                   ; 01FF: 48
sub_0200:
    CAL sub_06DF         ; 0200: AE DF
    JMP sub_03B5         ; 0202: A3 B5
    CAL sub_074E         ; 0204: AF 4E
    CAL sub_07A2         ; 0206: AF A2
    JMP L0096            ; 0208: A0 96
    JMP sub_04DF         ; 020A: A4 DF
sub_020C:
    LDZ 0xD              ; 020C: 8D
    STC                  ; 020D: 1B
    TMB 0                ; 020E: 58
    CLC                  ; 020F: 0B
    LDI 0x4B             ; 0210: 15 4B
    LI 0                 ; 0212: 90
    CM                   ; 0213: 0C
    JCP sub_0225         ; 0214: E5
    TAL                  ; 0215: 07
    TMB 2                ; 0216: 5A
    LI 1                 ; 0217: 91
    LDI 0x4B             ; 0218: 15 4B
    S                    ; 021A: 02
    TC                   ; 021B: 04
    LI 4                 ; 021C: 94
    LI 2                 ; 021D: 92
    AD                   ; 021E: 08
    S                    ; 021F: 02
    SFB 0                ; 0220: 7C
    CAL sub_0629         ; 0221: AE 29
    CAL sub_0629         ; 0223: AE 29
sub_0225:
    LDZ 0xF              ; 0225: 8F
    LI 6                 ; 0226: 96
    CM                   ; 0227: 0C
    JMP sub_025C         ; 0228: A2 5C
    LDZ 0xD              ; 022A: 8D
    STC                  ; 022B: 1B
    TMB 0                ; 022C: 58
    CLC                  ; 022D: 0B
    LDI 0x1A             ; 022E: 15 1A
    LI 0                 ; 0230: 90
    CM                   ; 0231: 0C
    JMP sub_0287         ; 0232: A2 87
    TC                   ; 0234: 04
    LI 4                 ; 0235: 94
    LI 2                 ; 0236: 92
    XM 3                 ; 0237: 2B
    LM 1                 ; 0238: 39
    TAZ                  ; 0239: 42
    CLC                  ; 023A: 0B
    TMB 0                ; 023B: 58
    STC                  ; 023C: 1B
    LDI 0x15             ; 023D: 15 15
    LM 0                 ; 023F: 38
    TAW                  ; 0240: 43
    LI 9                 ; 0241: 99
    AD                   ; 0242: 08
    JCP sub_0254         ; 0243: D4
    LDI 0x20             ; 0244: 15 20
    XAZ                  ; 0246: 4A
    S                    ; 0247: 02
    XAW                  ; 0248: 4B
    TAB 1                ; 0249: 25
    JCP sub_024E         ; 024A: CE
    RMB 0                ; 024B: 68
    RMB 2                ; 024C: 6A
    JCP sub_0254         ; 024D: D4
sub_024E:
    RMB 1                ; 024E: 69
    RMB 3                ; 024F: 6B
    LDI 0x30             ; 0250: 15 30
    TC                   ; 0252: 04
    SMB 0                ; 0253: 78
sub_0254:
    LDI 0x3A             ; 0254: 15 3A
    LM 1                 ; 0256: 39
    RAR                  ; 0257: 30
    LM 0                 ; 0258: 38
    RAR                  ; 0259: 30
    RAR                  ; 025A: 30
    JCP sub_026D         ; 025B: ED
sub_025C:
    LDI 0x19             ; 025C: 15 19
    LI 0                 ; 025E: 90
    CM                   ; 025F: 0C
    JCP sub_0273         ; 0260: F3
    LI 3                 ; 0261: 93
    XM 3                 ; 0262: 2B
    CLC                  ; 0263: 0B
    TMB 0                ; 0264: 58
    JCP sub_0267         ; 0265: E7
    JCP sub_0269         ; 0266: E9
sub_0267:
    TMB 1                ; 0267: 59
    STC                  ; 0268: 1B
sub_0269:
    FBF 1                ; 0269: 21
    CLC                  ; 026A: 0B
    LM 0                 ; 026B: 38
    ADC                  ; 026C: 19
sub_026D:
    XM 1                 ; 026D: 29
    TC                   ; 026E: 04
    LI 0                 ; 026F: 90
    LI 1                 ; 0270: 91
    S                    ; 0271: 02
    JCP sub_0275         ; 0272: F5
sub_0273:
    DED                  ; 0273: 13
    CM                   ; 0274: 0C
sub_0275:
    JMP sub_0287         ; 0275: A2 87
    LI 5                 ; 0277: 95
    XM 3                 ; 0278: 2B
    LM 1                 ; 0279: 39
    TAB 3                ; 027A: 27
    JCP sub_027D         ; 027B: FD
    JCP sub_027F         ; 027C: FF
sub_027D:
    TMB 0                ; 027D: 58
    LI 1                 ; 027E: 91
sub_027F:
    LI 0                 ; 027F: 90
    FBF 1                ; 0280: 21
    LI 0                 ; 0281: 90
    XM 1                 ; 0282: 29
    RAR                  ; 0283: 30
    LM 0                 ; 0284: 38
    RAR                  ; 0285: 30
    S                    ; 0286: 02
sub_0287:
    CZP L0024            ; 0287: B9
    LDZ 0xD              ; 0288: 8D
    STC                  ; 0289: 1B
    TMB 0                ; 028A: 58
    CLC                  ; 028B: 0B
    LDI 0x4A             ; 028C: 15 4A
    LI 0                 ; 028E: 90
    CM                   ; 028F: 0C
    JMP sub_02D2         ; 0290: A2 D2
    TC                   ; 0292: 04
    LI 3                 ; 0293: 93
    LI 2                 ; 0294: 92
    S                    ; 0295: 02
    LDI 0x1C             ; 0296: 15 1C
    LM 0                 ; 0298: 38
    LDI 0x74             ; 0299: 15 74
sub_029B:
    S                    ; 029B: 02
    IND                  ; 029C: 33
    CLI 7                ; 029D: 16 E7
    JCP sub_029B         ; 029F: DB
    IND                  ; 02A0: 33
    INM                  ; 02A1: 1D
    LDI 0x27             ; 02A2: 15 27
    CI 0                 ; 02A4: 17 C0
    JCP sub_02B8         ; 02A6: F8
    LM 1                 ; 02A7: 39
    TMB 0                ; 02A8: 58
sub_02A9:
    JMP sub_02C2         ; 02A9: A2 C2
    LI 7                 ; 02AB: 97
    LDI 0x77             ; 02AC: 15 77
    XMD 0                ; 02AE: 2C
    CZP L0020            ; 02AF: B8
sub_02B0:
    LDZ 0xF              ; 02B0: 8F
    LI 15                ; 02B1: 9F
    AD                   ; 02B2: 08
    JCP sub_02A9         ; 02B3: E9
    LDZ 0xA              ; 02B4: 8A
    SMB 0                ; 02B5: 78
    SFB 2                ; 02B6: 7E
    JCP sub_02A9         ; 02B7: E9
sub_02B8:
    TAZ                  ; 02B8: 42
    AD                   ; 02B9: 08
    JCP sub_02BC         ; 02BA: FC
    JCP sub_02B0         ; 02BB: F0
sub_02BC:
    EXL                  ; 02BC: 18
    LDI 0x7A             ; 02BD: 15 7A
    CM                   ; 02BF: 0C
    JMP sub_02B0         ; 02C0: A2 B0
sub_02C2:
    LDI 0x20             ; 02C2: 15 20
    LI 0                 ; 02C4: 90
    TAW                  ; 02C5: 43
sub_02C6:
    XM 1                 ; 02C6: 29
    TAZ                  ; 02C7: 42
    XAW                  ; 02C8: 4B
    XMI 1                ; 02C9: 3D
    TAW                  ; 02CA: 43
    XAZ                  ; 02CB: 4A
    CLI 8                ; 02CC: 16 E8
    JCP sub_02C6         ; 02CE: C6
    FBF 2                ; 02CF: 22
sub_02D0:
    JMP sub_03B5         ; 02D0: A3 B5
sub_02D2:
    LDZ 0xF              ; 02D2: 8F
    LI 15                ; 02D3: 9F
    AD                   ; 02D4: 08
    JCP sub_02D0         ; 02D5: D0
    LDI 0x2D             ; 02D6: 15 2D
    LI 0                 ; 02D8: 90
    CM                   ; 02D9: 0C
    JCP sub_02E7         ; 02DA: E7
    LDZ 0xE              ; 02DB: 8E
    TMB 3                ; 02DC: 5B
    JCP sub_02EA         ; 02DD: EA
    RMB 3                ; 02DE: 6B
    LDI 0x1C             ; 02DF: 15 1C
    LM 0                 ; 02E1: 38
    IND                  ; 02E2: 33
    XM 3                 ; 02E3: 2B
    SMB 1                ; 02E4: 79
    LDZ 0x1              ; 02E5: 81
    CZP L0008            ; 02E6: B2
sub_02E7:
    LDI 0x4C             ; 02E7: 15 4C
    CM                   ; 02E9: 0C
sub_02EA:
    JMP sub_035E         ; 02EA: A3 5E
    LI 1                 ; 02EC: 91
    S                    ; 02ED: 02
    LI 8                 ; 02EE: 98
    LDI 0x78             ; 02EF: 15 78
    XMD 0                ; 02F1: 2C
    CZP L0020            ; 02F2: B8
    LDI 0x1D             ; 02F3: 15 1D
    LI 0                 ; 02F5: 90
    CM                   ; 02F6: 0C
    JCP sub_02FE         ; 02F7: FE
    LI 4                 ; 02F8: 94
    LDI 0x77             ; 02F9: 15 77
    S                    ; 02FB: 02
    JMP sub_0304         ; 02FC: A3 04
sub_02FE:
    JMP sub_0300         ; 02FE: A3 00
sub_0300:
    LM 0                 ; 0300: 38
    LDI 0x74             ; 0301: 15 74
    S                    ; 0303: 02
sub_0304:
    LDI 0x1D             ; 0304: 15 1D
    LM 3                 ; 0306: 3B
    TAW                  ; 0307: 43
    LI 9                 ; 0308: 99
    CM                   ; 0309: 0C
    JCP sub_0312         ; 030A: D2
    LDZ 0xF              ; 030B: 8F
    LI 6                 ; 030C: 96
    CM                   ; 030D: 0C
    JCP sub_0328         ; 030E: E8
    LDI 0x2A             ; 030F: 15 2A
    JCP sub_031F         ; 0311: DF
sub_0312:
    LI 8                 ; 0312: 98
    CM                   ; 0313: 0C
    JCP sub_0319         ; 0314: D9
    LI 4                 ; 0315: 94
    LDI 0x29             ; 0316: 15 29
    JCP sub_031F         ; 0318: DF
sub_0319:
    LI 7                 ; 0319: 97
    CM                   ; 031A: 0C
    JCP sub_033B         ; 031B: FB
    LI 2                 ; 031C: 92
    LDI 0x28             ; 031D: 15 28
sub_031F:
    TAZ                  ; 031F: 42
    XAW                  ; 0320: 4B
    TAW                  ; 0321: 43
    CI 0                 ; 0322: 17 C0
    JCP sub_032A         ; 0324: EA
    LM 0                 ; 0325: 38
    XM 1                 ; 0326: 29
    TMB 0                ; 0327: 58
sub_0328:
    JCP sub_033B         ; 0328: FB
    JCP sub_0335         ; 0329: F5
sub_032A:
    AD                   ; 032A: 08
    JCP sub_032D         ; 032B: ED
    JCP sub_0335         ; 032C: F5
sub_032D:
    EXL                  ; 032D: 18
    LDZ 0x9              ; 032E: 89
    S                    ; 032F: 02
    XAW                  ; 0330: 4B
    TAW                  ; 0331: 43
    CM                   ; 0332: 0C
    JCP sub_0335         ; 0333: F5
    JCP sub_033B         ; 0334: FB
sub_0335:
    LDZ 0x9              ; 0335: 89
    XAW                  ; 0336: 4B
    SFB 2                ; 0337: 7E
    XMI 0                ; 0338: 3C
    JMP sub_034E         ; 0339: A3 4E
sub_033B:
    LDI 0x2D             ; 033B: 15 2D
    LM 0                 ; 033D: 38
    TAZ                  ; 033E: 42
    IND                  ; 033F: 33
    CAL sub_0670         ; 0340: AE 70
    JCP sub_0347         ; 0342: C7
    CAL sub_0670         ; 0343: AE 70
    JCP sub_0348         ; 0345: C8
    JCP sub_0351         ; 0346: D1
sub_0347:
    LI 8                 ; 0347: 98
sub_0348:
    LI 10                ; 0348: 9A
    LDZ 0xA              ; 0349: 8A
    S                    ; 034A: 02
    SFB 2                ; 034B: 7E
    LDI 0x78             ; 034C: 15 78
sub_034E:
    XAZ                  ; 034E: 4A
    S                    ; 034F: 02
    JCP sub_0357         ; 0350: D7
sub_0351:
    LDI 0x2D             ; 0351: 15 2D
    INM                  ; 0353: 1D
    LI 10                ; 0354: 9A
    CM                   ; 0355: 0C
    JCP sub_035E         ; 0356: DE
sub_0357:
    LDI 0x2D             ; 0357: 15 2D
    LI 0                 ; 0359: 90
    S                    ; 035A: 02
    FBF 2                ; 035B: 22
    JMP sub_04FD         ; 035C: A4 FD
sub_035E:
    STC                  ; 035E: 1B
    JCP sub_0366         ; 035F: E6
sub_0360:
    LDI 0x2C             ; 0360: 15 2C
    LI 14                ; 0362: 9E
    AD                   ; 0363: 08
    JCP sub_036A         ; 0364: EA
    CLC                  ; 0365: 0B
sub_0366:
    LDI 0x4D             ; 0366: 15 4D
    TMB 0                ; 0368: 58
    JCP sub_036C         ; 0369: EC
sub_036A:
    JMP sub_038D         ; 036A: A3 8D
sub_036C:
    LDI 0x2B             ; 036C: 15 2B
    LI 0                 ; 036E: 90
    CM                   ; 036F: 0C
    JCP sub_036A         ; 0370: EA
    XC                   ; 0371: 1A
    XMI 3                ; 0372: 3F
    STC                  ; 0373: 1B
    CM                   ; 0374: 0C
    CLC                  ; 0375: 0B
    LM 0                 ; 0376: 38
    TPA 2                ; 0377: 56
    JCP sub_037D         ; 0378: FD
    TMB 0                ; 0379: 58
    RAR                  ; 037A: 30
    JMP sub_0383         ; 037B: A3 83
sub_037D:
    TPA 1                ; 037D: 55
    JMP sub_038A         ; 037E: A3 8A
    TC                   ; 0380: 04
    AD                   ; 0381: 08
    NOP                  ; 0382: 00
sub_0383:
    XC                   ; 0383: 1A
sub_0384:
    XMD 3                ; 0384: 2F
    TC                   ; 0385: 04
    LI 15                ; 0386: 9F
    LI 3                 ; 0387: 93
    S                    ; 0388: 02
    JCP sub_038D         ; 0389: CD
sub_038A:
    XC                   ; 038A: 1A
    TC                   ; 038B: 04
    JCP sub_0384         ; 038C: C4
sub_038D:
    CZP L0024            ; 038D: B9
    LDI 0x1C             ; 038E: 15 1C
    LM 3                 ; 0390: 3B
    TAW                  ; 0391: 43
    LM 0                 ; 0392: 38
    TAZ                  ; 0393: 42
    LDI 0x78             ; 0394: 15 78
    XMD 0                ; 0396: 2C
    XAW                  ; 0397: 4B
    TAW                  ; 0398: 43
    CI 0                 ; 0399: 17 C0
    JCP sub_039F         ; 039B: DF
    LI 7                 ; 039C: 97
    S                    ; 039D: 02
    JCP sub_03A5         ; 039E: E5
sub_039F:
    DED                  ; 039F: 13
sub_03A0:
    S                    ; 03A0: 02
    DED                  ; 03A1: 13
    CLI 3                ; 03A2: 16 E3
    JCP sub_03A0         ; 03A4: E0
sub_03A5:
    XAZ                  ; 03A5: 4A
    LDI 0x2E             ; 03A6: 15 2E
    CAL sub_0670         ; 03A8: AE 70
    JCP sub_03AF         ; 03AA: EF
    CAL sub_0670         ; 03AB: AE 70
    JCP sub_03B0         ; 03AD: F0
    JCP sub_03B5         ; 03AE: F5
sub_03AF:
    LI 9                 ; 03AF: 99
sub_03B0:
    LI 11                ; 03B0: 9B
    LDZ 0xA              ; 03B1: 8A
    S                    ; 03B2: 02
    JMP sub_0502         ; 03B3: A5 02
sub_03B5:
    CZP L001C            ; 03B5: B7
    OCD 0x01             ; 03B6: 1E 01
    LM 2                 ; 03B8: 3A
sub_03B9:
    EXL                  ; 03B9: 18
    IND                  ; 03BA: 33
    JCP sub_03B9         ; 03BB: F9
    LDI 0x14             ; 03BC: 15 14
    ADC                  ; 03BE: 19
    XMI 0                ; 03BF: 3C
    ADC                  ; 03C0: 19
    S                    ; 03C1: 02
    CAL sub_05C2         ; 03C2: AD C2
    CAL sub_05C6         ; 03C4: AD C6
    CZP L001C            ; 03C6: B7
    SEB 0                ; 03C7: 74
    CAL sub_05CE         ; 03C8: AD CE
    STM 0x01             ; 03CA: 14 81
    CAL sub_05D6         ; 03CC: AD D6
    LDI 0x49             ; 03CE: 15 49
    DEM                  ; 03D0: 1F
    JCP sub_03EB         ; 03D1: EB
    LI 3                 ; 03D2: 93
    XMI 0                ; 03D3: 3C
sub_03D4:
    CZP L002C            ; 03D4: BB
    IND                  ; 03D5: 33
    CLI 13               ; 03D6: 16 ED
    JCP sub_03D4         ; 03D8: D4
    INM                  ; 03D9: 1D
    JCP sub_03E0         ; 03DA: E0
    LI 14                ; 03DB: 9E
    XMI 0                ; 03DC: 3C
sub_03DD:
    CZP L002C            ; 03DD: BB
    IND                  ; 03DE: 33
    JCP sub_03DD         ; 03DF: DD
sub_03E0:
    LDZ 0xB              ; 03E0: 8B
    CZP L002C            ; 03E1: BB
    LM 2                 ; 03E2: 3A
    CZP L002C            ; 03E3: BB
    LDI 0x18             ; 03E4: 15 18
sub_03E6:
    CZP L002C            ; 03E6: BB
    IND                  ; 03E7: 33
    CLI 11               ; 03E8: 16 EB
    JCP sub_03E6         ; 03EA: E6
sub_03EB:
    CZP L001C            ; 03EB: B7
    SEB 1                ; 03EC: 75
    LDI 0x43             ; 03ED: 15 43
    SMB 3                ; 03EF: 7B
    LM 3                 ; 03F0: 3B
    S                    ; 03F1: 02
    JMP sub_040D         ; 03F2: A4 0D
sub_03F4:
    XAW                  ; 03F4: 4B
    TAW                  ; 03F5: 43
sub_03F6:
    CM                   ; 03F6: 0C
    RT                   ; 03F7: 48
    LM 3                 ; 03F8: 3B
    LM 0                 ; 03F9: 38
    CZP L003C            ; 03FA: BF
    CI 15                ; 03FB: 17 CF
    RT                   ; 03FD: 48
    SMB 2                ; 03FE: 7A
    RT                   ; 03FF: 48
sub_0400:
    CZP L001C            ; 0400: B7
    LDI 0x43             ; 0401: 15 43
    CLC                  ; 0403: 0B
    LM 0                 ; 0404: 38
    OP                   ; 0405: 0E
    RAR                  ; 0406: 30
    XMD 0                ; 0407: 2C
    LM 0                 ; 0408: 38
    OP                   ; 0409: 0E
    RAR                  ; 040A: 30
    XMI 3                ; 040B: 3F
    DEM                  ; 040C: 1F
sub_040D:
    SFB 0                ; 040D: 7C
    CAL sub_05A7         ; 040E: AD A7
    RFB 0                ; 0410: 6C
    CAL sub_05A7         ; 0411: AD A7
    LDI 0x42             ; 0413: 15 42
    TMB 0                ; 0415: 58
    JCP sub_0419         ; 0416: D9
    JMP sub_0470         ; 0417: A4 70
sub_0419:
    IND                  ; 0419: 33
    TMB 3                ; 041A: 5B
    JCP sub_043D         ; 041B: FD
    LDI 0x20             ; 041C: 15 20
    LM 1                 ; 041E: 39
    CLC                  ; 041F: 0B
    TMB 0                ; 0420: 58
    STC                  ; 0421: 1B
    LDZ 0x6              ; 0422: 86
    CZP L0034            ; 0423: BD
    TC                   ; 0424: 04
    SMB 0                ; 0425: 78
    LI 9                 ; 0426: 99
    CAL sub_06E8         ; 0427: AE E8
    LDI 0x29             ; 0429: 15 29
    LM 1                 ; 042B: 39
    CLC                  ; 042C: 0B
    TMB 0                ; 042D: 58
    STC                  ; 042E: 1B
    CZP L0038            ; 042F: BE
    TC                   ; 0430: 04
    SMB 1                ; 0431: 79
    LDI 0x2A             ; 0432: 15 2A
    LM 1                 ; 0434: 39
    CLC                  ; 0435: 0B
    TMB 0                ; 0436: 58
    STC                  ; 0437: 1B
    CZP L003C            ; 0438: BF
    TC                   ; 0439: 04
    SMB 2                ; 043A: 7A
    JMP sub_0489         ; 043B: A4 89
sub_043D:
    LDI 0x73             ; 043D: 15 73
    LI 6                 ; 043F: 96
    AD                   ; 0440: 08
    CMA                  ; 0441: 10
    LDI 0x27             ; 0442: 15 27
    TAL                  ; 0444: 07
    LM 1                 ; 0445: 39
    CLC                  ; 0446: 0B
    TMB 0                ; 0447: 58
    STC                  ; 0448: 1B
    LDZ 0x6              ; 0449: 86
    CZP L0034            ; 044A: BD
    TC                   ; 044B: 04
    SMB 0                ; 044C: 78
    XAW                  ; 044D: 4B
    TAW                  ; 044E: 43
    CAL sub_06E8         ; 044F: AE E8
    LDI 0x73             ; 0451: 15 73
    LI 7                 ; 0453: 97
    CM                   ; 0454: 0C
    JCP sub_047C         ; 0455: FC
    LDI 0x2D             ; 0456: 15 2D
    LI 8                 ; 0458: 98
    CAL sub_03F6         ; 0459: AB F6
    RFB 0                ; 045B: 6C
    LDI 0x21             ; 045C: 15 21
    LM 1                 ; 045E: 39
    CLC                  ; 045F: 0B
    TMB 0                ; 0460: 58
    STC                  ; 0461: 1B
    CZP L003C            ; 0462: BF
    TC                   ; 0463: 04
    SMB 2                ; 0464: 7A
    LDI 0x28             ; 0465: 15 28
    LM 1                 ; 0467: 39
    CLC                  ; 0468: 0B
    TMB 0                ; 0469: 58
    STC                  ; 046A: 1B
    CZP L0038            ; 046B: BE
    TC                   ; 046C: 04
    SMB 1                ; 046D: 79
    JMP sub_0489         ; 046E: A4 89
sub_0470:
    LDZ 0xF              ; 0470: 8F
    LI 15                ; 0471: 9F
    AD                   ; 0472: 08
    JCP sub_047C         ; 0473: FC
    LM 0                 ; 0474: 38
    LDI 0x44             ; 0475: 15 44
    TAB 3                ; 0477: 27
    LDI 0x1C             ; 0478: 15 1C
    CAL sub_06ED         ; 047A: AE ED
sub_047C:
    LDI 0x2E             ; 047C: 15 2E
    CAL sub_03F4         ; 047E: AB F4
    LDI 0x2F             ; 0480: 15 2F
    CAL sub_03F4         ; 0482: AB F4
    XAW                  ; 0484: 4B
    LDI 0x2C             ; 0485: 15 2C
    CAL sub_05AF         ; 0487: AD AF
sub_0489:
    FBT 2                ; 0489: 5E
    JCP sub_04A0         ; 048A: E0
    LDZ 0x4              ; 048B: 84
    THX                  ; 048C: 47
    LDI 0x78             ; 048D: 15 78
    LM 0                 ; 048F: 38
    LDI 0x73             ; 0490: 15 73
    CM                   ; 0492: 0C
    JCP sub_04A0         ; 0493: E0
sub_0494:
    REB 1                ; 0494: 65
    OCD 0x00             ; 0495: 1E 00
    IND                  ; 0497: 33
    LM 0                 ; 0498: 38
    XHX                  ; 0499: 4F
    EXL                  ; 049A: 18
    S                    ; 049B: 02
    XHX                  ; 049C: 4F
    CLI 7                ; 049D: 16 E7
    JCP sub_0494         ; 049F: D4
sub_04A0:
    LDI 0x42             ; 04A0: 15 42
    TMB 0                ; 04A2: 58
    JMP sub_0400         ; 04A3: A4 00
    RMB 0                ; 04A5: 68
sub_04A6:
    TTM                  ; 04A6: 05
    JCP sub_04A6         ; 04A7: E6
    OCD 0x00             ; 04A8: 1E 00
    JMP L0057            ; 04AA: A0 57
sub_04AC:
    LDZ 0x9              ; 04AC: 89
    LM 0                 ; 04AD: 38
    TAW                  ; 04AE: 43
    LDZ 0xA              ; 04AF: 8A
    LI 2                 ; 04B0: 92
    CM                   ; 04B1: 0C
    LI 4                 ; 04B2: 94
    CM                   ; 04B3: 0C
    JCP sub_04B7         ; 04B4: F7
    JMP sub_04CF         ; 04B5: A4 CF
sub_04B7:
    LDZ 0xB              ; 04B7: 8B
    LI 0                 ; 04B8: 90
    CM                   ; 04B9: 0C
    JMP sub_0560         ; 04BA: A5 60
    LI 1                 ; 04BC: 91
    XMI 0                ; 04BD: 3C
    LI 1                 ; 04BE: 91
    CM                   ; 04BF: 0C
    JCP sub_04C7         ; 04C0: C7
    DEM                  ; 04C1: 1F
    LI 0                 ; 04C2: 90
    LDZ 0xA              ; 04C3: 8A
    S                    ; 04C4: 02
    JMP L00BB            ; 04C5: A0 BB
sub_04C7:
    LI 0                 ; 04C7: 90
    CM                   ; 04C8: 0C
    JCP sub_04CC         ; 04C9: CC
    LI 9                 ; 04CA: 99
    S                    ; 04CB: 02
sub_04CC:
    INM                  ; 04CC: 1D
    JMP sub_0547         ; 04CD: A5 47
sub_04CF:
    CAL sub_074E         ; 04CF: AF 4E
    RFB 2                ; 04D1: 6E
    LDZ 0xA              ; 04D2: 8A
    LI 1                 ; 04D3: 91
    CM                   ; 04D4: 0C
    JMP sub_0500         ; 04D5: A5 00
    CAL sub_0755         ; 04D7: AF 55
    LDI 0x1B             ; 04D9: 15 1B
    DEM                  ; 04DB: 1F
    JCP sub_04E8         ; 04DC: E8
    CAL sub_077D         ; 04DD: AF 7D
sub_04DF:
    LDZ 0xF              ; 04DF: 8F
    LI 0                 ; 04E0: 90
    S                    ; 04E1: 02
    LDZ 0xA              ; 04E2: 8A
    S                    ; 04E3: 02
    LDI 0x2F             ; 04E4: 15 2F
    CZP L0030            ; 04E6: BC
    JCP sub_04FB         ; 04E7: FB
sub_04E8:
    LM 1                 ; 04E8: 39
    INC                  ; 04E9: 0D
    S                    ; 04EA: 02
    LI 15                ; 04EB: 9F
    XM 0                 ; 04EC: 28
    LDZ 0x3              ; 04ED: 83
    CAL sub_01FC         ; 04EE: A9 FC
    LDZ 0x2              ; 04F0: 82
sub_04F1:
    LI 14                ; 04F1: 9E
    XMD 0                ; 04F2: 2C
    JCP sub_04F1         ; 04F3: F1
    CAL sub_0723         ; 04F4: AF 23
    LDZ 0xC              ; 04F6: 8C
    INM                  ; 04F7: 1D
    LM 1                 ; 04F8: 39
    LI 4                 ; 04F9: 94
    S                    ; 04FA: 02
sub_04FB:
    JMP sub_0560         ; 04FB: A5 60
sub_04FD:
    RFB 2                ; 04FD: 6E
    JMP sub_0550         ; 04FE: A5 50
sub_0500:
    CAL sub_06F5         ; 0500: AE F5
sub_0502:
    LDI 0x13             ; 0502: 15 13
    CZP L0020            ; 0504: B8
    LDZ 0xA              ; 0505: 8A
    LI 8                 ; 0506: 98
    AD                   ; 0507: 08
    JCP sub_051B         ; 0508: DB
    LM 0                 ; 0509: 38
    TAW                  ; 050A: 43
    LDI 0x2F             ; 050B: 15 2F
    TAB 1                ; 050D: 25
    DED                  ; 050E: 13
    LI 0                 ; 050F: 90
    S                    ; 0510: 02
    XAW                  ; 0511: 4B
    LDI 0x41             ; 0512: 15 41
    TAB 1                ; 0514: 25
    DED                  ; 0515: 13
    LI 3                 ; 0516: 93
    AD                   ; 0517: 08
    LDZ 0x8              ; 0518: 88
    DEM                  ; 0519: 1F
    JCP sub_053A         ; 051A: FA
sub_051B:
    CLC                  ; 051B: 0B
    TMB 2                ; 051C: 5A
    LI 1                 ; 051D: 91
    LI 2                 ; 051E: 92
    TMB 1                ; 051F: 59
    TMB 2                ; 0520: 5A
    TMB 2                ; 0521: 5A
    STC                  ; 0522: 1B
    TAZ                  ; 0523: 42
    LDI 0x29             ; 0524: 15 29
    TAB 1                ; 0526: 25
    DED                  ; 0527: 13
    TC                   ; 0528: 04
    IND                  ; 0529: 33
    XAW                  ; 052A: 4B
    TAW                  ; 052B: 43
    EXL                  ; 052C: 18
    S                    ; 052D: 02
    LM 1                 ; 052E: 39
    XAW                  ; 052F: 4B
    DEC                  ; 0530: 0F
    JCP sub_0533         ; 0531: F3
    RMB 0                ; 0532: 68
sub_0533:
    LDI 0x11             ; 0533: 15 11
    TC                   ; 0535: 04
    SMB 0                ; 0536: 78
    XAZ                  ; 0537: 4A
    TC                   ; 0538: 04
    LI 0                 ; 0539: 90
sub_053A:
    LDI 0x12             ; 053A: 15 12
    S                    ; 053C: 02
    LDZ 0xA              ; 053D: 8A
    TMB 0                ; 053E: 58
    LI 0                 ; 053F: 90
    LI 1                 ; 0540: 91
    S                    ; 0541: 02
    CAL sub_07A0         ; 0542: AF A0
    JCP sub_0560         ; 0544: E0
    JMP sub_04DF         ; 0545: A4 DF
sub_0547:
    SFB 2                ; 0547: 7E
    TMB 0                ; 0548: 58
    RFB 2                ; 0549: 6E
    LDI 0x78             ; 054A: 15 78
    LI 9                 ; 054C: 99
    AD                   ; 054D: 08
    JCP sub_0550         ; 054E: D0
    JCP sub_0560         ; 054F: E0
sub_0550:
    LDZ 0xA              ; 0550: 8A
    TMB 3                ; 0551: 5B
    JCP sub_0560         ; 0552: E0
    SFB 2                ; 0553: 7E
    LDI 0x75             ; 0554: 15 75
    XMD 0                ; 0556: 2C
    XMI 0                ; 0557: 3C
    XMI 0                ; 0558: 3C
    IND                  ; 0559: 33
    LI 6                 ; 055A: 96
    XM 0                 ; 055B: 28
    TAB 1                ; 055C: 25
    RMB 2                ; 055D: 6A
    TAB 2                ; 055E: 26
    RMB 1                ; 055F: 69
sub_0560:
    JMP sub_03B5         ; 0560: A3 B5
sub_0562:
    TAB 0                ; 0562: 24
    SMB 0                ; 0563: 78
    TAB 1                ; 0564: 25
    SMB 1                ; 0565: 79
    TAB 2                ; 0566: 26
    SMB 2                ; 0567: 7A
    TAB 3                ; 0568: 27
    SMB 3                ; 0569: 7B
    LDZ 0x7              ; 056A: 87
    RT                   ; 056B: 48
sub_056C:
    TPB 0                ; 056C: 50
    JCP sub_0575         ; 056D: F5
    LDZ 0xE              ; 056E: 8E
    TMB 2                ; 056F: 5A
    RT                   ; 0570: 48
    INM                  ; 0571: 1D
    TMB 1                ; 0572: 59
    RT                   ; 0573: 48
    LI 8                 ; 0574: 98
sub_0575:
    LI 4                 ; 0575: 94
    LDZ 0xE              ; 0576: 8E
    S                    ; 0577: 02
    RT                   ; 0578: 48
sub_0579:
    LDZ 0x3              ; 0579: 83
    LI 12                ; 057A: 9C
    XMD 0                ; 057B: 2C
    LI 11                ; 057C: 9B
    XMD 0                ; 057D: 2C
    LI 11                ; 057E: 9B
    XMD 0                ; 057F: 2C
    LI 10                ; 0580: 9A
    XMD 2                ; 0581: 2E
    NOP                  ; 0582: 00
    RT                   ; 0583: 48
sub_0584:
    LDZ 0x8              ; 0584: 88
    LI 15                ; 0585: 9F
    AD                   ; 0586: 08
    RT                   ; 0587: 48
    LDI 0x2E             ; 0588: 15 2E
    CI 0                 ; 058A: 17 C0
    JCP sub_0593         ; 058C: D3
    CM                   ; 058D: 0C
    RT                   ; 058E: 48
    IND                  ; 058F: 33
    CM                   ; 0590: 0C
    RT                   ; 0591: 48
    DED                  ; 0592: 13
sub_0593:
    FBT 0                ; 0593: 5C
    IND                  ; 0594: 33
    LI 0                 ; 0595: 90
    CM                   ; 0596: 0C
    RT                   ; 0597: 48
    LI 8                 ; 0598: 98
    XM 3                 ; 0599: 2B
    LI 4                 ; 059A: 94
    XMD 2                ; 059B: 2E
    DED                  ; 059C: 13
    LI 2                 ; 059D: 92
    S                    ; 059E: 02
    LDI 0x40             ; 059F: 15 40
    FBT 0                ; 05A1: 5C
    IND                  ; 05A2: 33
    XAW                  ; 05A3: 4B
    TAW                  ; 05A4: 43
    S                    ; 05A5: 02
    RT                   ; 05A6: 48
sub_05A7:
    LDI 0x73             ; 05A7: 15 73
    LM 0                 ; 05A9: 38
    TAW                  ; 05AA: 43
    LDI 0x2E             ; 05AB: 15 2E
    FBT 0                ; 05AD: 5C
    IND                  ; 05AE: 33
sub_05AF:
    CM                   ; 05AF: 0C
    RT                   ; 05B0: 48
    LM 3                 ; 05B1: 3B
    LM 0                 ; 05B2: 38
    CZP L0038            ; 05B3: BE
    CI 15                ; 05B4: 17 CF
    RT                   ; 05B6: 48
    SMB 1                ; 05B7: 79
    RT                   ; 05B8: 48
sub_05B9:
    STM 0x32             ; 05B9: 14 B2
sub_05BB:
    TTM                  ; 05BB: 05
    JCP sub_05BB         ; 05BC: FB
    DEC                  ; 05BD: 0F
    JCP sub_05B9         ; 05BE: F9
    RT                   ; 05BF: 48
    LI 3                 ; 05C0: 93
    JCP sub_05E5         ; 05C1: E5
sub_05C2:
    LDZ 0x3              ; 05C2: 83
    JCP sub_05DA         ; 05C3: DA
    LI 0                 ; 05C4: 90
    JCP sub_05D1         ; 05C5: D1
sub_05C6:
    LDZ 0x2              ; 05C6: 82
    JCP sub_05E2         ; 05C7: E2
    LI 5                 ; 05C8: 95
    XMD 0                ; 05C9: 2C
    LI 11                ; 05CA: 9B
    JCP sub_05F9         ; 05CB: F9
    LI 4                 ; 05CC: 94
    JCP sub_05E5         ; 05CD: E5
sub_05CE:
    LDZ 0x1              ; 05CE: 81
    JCP sub_05DA         ; 05CF: DA
    LI 6                 ; 05D0: 96
sub_05D1:
    XMD 0                ; 05D1: 2C
    LI 6                 ; 05D2: 96
    JCP sub_05F9         ; 05D3: F9
    LI 6                 ; 05D4: 96
    JCP sub_05E9         ; 05D5: E9
sub_05D6:
    LDZ 0x0              ; 05D6: 80
    JCP sub_05E2         ; 05D7: E2
    LI 7                 ; 05D8: 97
    JCP sub_05E9         ; 05D9: E9
sub_05DA:
    LM 0                 ; 05DA: 38
    JCP sub_05F4         ; 05DB: F4
    LI 2                 ; 05DC: 92
    XMD 0                ; 05DD: 2C
    LI 7                 ; 05DE: 97
    JCP sub_05F9         ; 05DF: F9
    LI 7                 ; 05E0: 97
    JCP sub_05E5         ; 05E1: E5
sub_05E2:
    LM 0                 ; 05E2: 38
    JCP sub_05F6         ; 05E3: F6
    LI 6                 ; 05E4: 96
sub_05E5:
    XMD 0                ; 05E5: 2C
    LI 15                ; 05E6: 9F
    JCP sub_05F9         ; 05E7: F9
    LI 3                 ; 05E8: 93
sub_05E9:
    XMD 0                ; 05E9: 2C
    LI 13                ; 05EA: 9D
    JCP sub_05F9         ; 05EB: F9
    LI 5                 ; 05EC: 95
    XMD 0                ; 05ED: 2C
    LI 12                ; 05EE: 9C
    JCP sub_05F9         ; 05EF: F9
    LI 5                 ; 05F0: 95
    XMD 0                ; 05F1: 2C
    LI 14                ; 05F2: 9E
    JCP sub_05F9         ; 05F3: F9
sub_05F4:
    LDZ 0x7              ; 05F4: 87
    JPA                  ; 05F5: 41
sub_05F6:
    LDZ 0x5              ; 05F6: 85
    JPA                  ; 05F7: 41
    LI 0                 ; 05F8: 90
sub_05F9:
    S                    ; 05F9: 02
    RT                   ; 05FA: 48
    NOP                  ; 05FB: 00
    NOP                  ; 05FC: 00
    NOP                  ; 05FD: 00
    NOP                  ; 05FE: 00
    NOP                  ; 05FF: 00
sub_0600:
    LI 8                 ; 0600: 98
    CM                   ; 0601: 0C
    JCP sub_0604         ; 0602: C4
    JCP sub_0606         ; 0603: C6
sub_0604:
    INM                  ; 0604: 1D
    RT                   ; 0605: 48
sub_0606:
    DEM                  ; 0606: 1F
    RT                   ; 0607: 48
sub_0608:
    LM 3                 ; 0608: 3B
sub_0609:
    STC                  ; 0609: 1B
    LI 0                 ; 060A: 90
    CM                   ; 060B: 0C
    CLC                  ; 060C: 0B
    LM 0                 ; 060D: 38
    RAR                  ; 060E: 30
    TC                   ; 060F: 04
    JCP sub_061A         ; 0610: DA
    JCP sub_0613         ; 0611: D3
sub_0612:
    LM 3                 ; 0612: 3B
sub_0613:
    LI 0                 ; 0613: 90
    CM                   ; 0614: 0C
    JCP sub_0617         ; 0615: D7
    JCP sub_0609         ; 0616: C9
sub_0617:
    LM 0                 ; 0617: 38
    AD                   ; 0618: 08
    NOP                  ; 0619: 00
sub_061A:
    XM 3                 ; 061A: 2B
    RT                   ; 061B: 48
sub_061C:
    LDZ 0xB              ; 061C: 8B
    CZP L0010            ; 061D: B4
    LDZ 0x6              ; 061E: 86
    CZP L0014            ; 061F: B5
    LDZ 0x3              ; 0620: 83
    CZP L000C            ; 0621: B3
    LDZ 0x6              ; 0622: 86
    CZP L000C            ; 0623: B3
    LDZ 0x3              ; 0624: 83
    CZP L000C            ; 0625: B3
    LDZ 0x1              ; 0626: 81
    CZP L0014            ; 0627: B5
    RT                   ; 0628: 48
sub_0629:
    LDI 0x3C             ; 0629: 15 3C
    FBT 0                ; 062B: 5C
    IND                  ; 062C: 33
    LI 0                 ; 062D: 90
    CM                   ; 062E: 0C
    JMP sub_0663         ; 062F: A6 63
    LDI 0x14             ; 0631: 15 14
    LM 0                 ; 0633: 38
    INM                  ; 0634: 1D
    NOP                  ; 0635: 00
    TAW                  ; 0636: 43
    IND                  ; 0637: 33
    LM 0                 ; 0638: 38
    INM                  ; 0639: 1D
    NOP                  ; 063A: 00
    LDI 0x40             ; 063B: 15 40
    FBT 0                ; 063D: 5C
    IND                  ; 063E: 33
    CLC                  ; 063F: 0B
    TMB 2                ; 0640: 5A
    STC                  ; 0641: 1B
    TMB 0                ; 0642: 58
    JCP sub_064F         ; 0643: CF
    LDZ 0x9              ; 0644: 89
    S                    ; 0645: 02
    LI 10                ; 0646: 9A
    AD                   ; 0647: 08
    JCP sub_064D         ; 0648: CD
    LI 5                 ; 0649: 95
    AD                   ; 064A: 08
    LI 7                 ; 064B: 97
    LI 3                 ; 064C: 93
sub_064D:
    LI 5                 ; 064D: 95
    JCP sub_0652         ; 064E: D2
sub_064F:
    TAB 3                ; 064F: 27
    LI 4                 ; 0650: 94
    LI 6                 ; 0651: 96
sub_0652:
    LDI 0x3E             ; 0652: 15 3E
    FBT 0                ; 0654: 5C
    IND                  ; 0655: 33
    S                    ; 0656: 02
    RMB 3                ; 0657: 6B
    XAW                  ; 0658: 4B
    LDI 0x3C             ; 0659: 15 3C
    FBT 0                ; 065B: 5C
    IND                  ; 065C: 33
    S                    ; 065D: 02
    SMB 3                ; 065E: 7B
    TC                   ; 065F: 04
    JCP sub_0663         ; 0660: E3
    LI 1                 ; 0661: 91
    S                    ; 0662: 02
sub_0663:
    LDI 0x2E             ; 0663: 15 2E
    FBT 0                ; 0665: 5C
    IND                  ; 0666: 33
    LM 1                 ; 0667: 39
    DEC                  ; 0668: 0F
    JCP sub_066C         ; 0669: EC
    JMP sub_06DD         ; 066A: A6 DD
sub_066C:
    LM 1                 ; 066C: 39
    SEB 3                ; 066D: 77
    JMP sub_068B         ; 066E: A6 8B
sub_0670:
    TAZ                  ; 0670: 42
    CM                   ; 0671: 0C
    JCP sub_067B         ; 0672: FB
    XM 3                 ; 0673: 2B
    XAW                  ; 0674: 4B
    TAW                  ; 0675: 43
    CM                   ; 0676: 0C
    JCP sub_0679         ; 0677: F9
    RT                   ; 0678: 48
sub_0679:
    XAZ                  ; 0679: 4A
    TAZ                  ; 067A: 42
sub_067B:
    LDI 0x2F             ; 067B: 15 2F
    RTS                  ; 067D: 49
    NOP                  ; 067E: 00
    NOP                  ; 067F: 00
    CAL sub_0600         ; 0680: AE 00
    JMP sub_069C         ; 0682: A6 9C
    CAL sub_0600         ; 0684: AE 00
    JMP sub_06AC         ; 0686: A6 AC
    CAL sub_0600         ; 0688: AE 00
    JCP sub_068C         ; 068A: CC
sub_068B:
    JPA                  ; 068B: 41
sub_068C:
    CAL sub_0608         ; 068C: AE 08
    JMP sub_06AC         ; 068E: A6 AC
    CAL sub_0606         ; 0690: AE 06
    JMP sub_068C         ; 0692: A6 8C
    LDI 0x1D             ; 0694: 15 1D
    JMP sub_069F         ; 0696: A6 9F
    CAL sub_0606         ; 0698: AE 06
    NOP                  ; 069A: 00
    NOP                  ; 069B: 00
sub_069C:
    CAL sub_0612         ; 069C: AE 12
    JCP sub_06AC         ; 069E: EC
sub_069F:
    LM 3                 ; 069F: 3B
    TAW                  ; 06A0: 43
    LM 0                 ; 06A1: 38
    IND                  ; 06A2: 33
    FBT 0                ; 06A3: 5C
    IND                  ; 06A4: 33
    CAL sub_0670         ; 06A5: AE 70
    JCP sub_06AC         ; 06A7: EC
    FBF 0                ; 06A8: 20
    DED                  ; 06A9: 13
    CAL sub_0606         ; 06AA: AE 06
sub_06AC:
    LDI 0x3E             ; 06AC: 15 3E
    FBT 0                ; 06AE: 5C
    IND                  ; 06AF: 33
    INM                  ; 06B0: 1D
    INM                  ; 06B1: 1D
    DEC                  ; 06B2: 0F
    DEM                  ; 06B3: 1F
    RMB 3                ; 06B4: 6B
    LM 1                 ; 06B5: 39
    LI 13                ; 06B6: 9D
    AD                   ; 06B7: 08
    JMP sub_06C2         ; 06B8: A6 C2
    LM 3                 ; 06BA: 3B
    TLY                  ; 06BB: 46
    FBF 0                ; 06BC: 20
    LI 4                 ; 06BD: 94
    LI 5                 ; 06BE: 95
    TAL                  ; 06BF: 07
    LI 3                 ; 06C0: 93
    AD                   ; 06C1: 08
sub_06C2:
    JCP sub_06D7         ; 06C2: D7
    XLY                  ; 06C3: 4E
    LM 3                 ; 06C4: 3B
    TAZ                  ; 06C5: 42
    LI 6                 ; 06C6: 96
    AD                   ; 06C7: 08
    CMA                  ; 06C8: 10
    TAL                  ; 06C9: 07
    XAZ                  ; 06CA: 4A
    TLY                  ; 06CB: 46
    CZP L0034            ; 06CC: BD
    XM 0                 ; 06CD: 28
    XM 3                 ; 06CE: 2B
    XLY                  ; 06CF: 4E
    INC                  ; 06D0: 0D
    JCP sub_06D3         ; 06D1: D3
    SMB 0                ; 06D2: 78
sub_06D3:
    LDI 0x4A             ; 06D3: 15 4A
    LI 1                 ; 06D5: 91
    S                    ; 06D6: 02
sub_06D7:
    REB 3                ; 06D7: 67
    LDI 0x3C             ; 06D8: 15 3C
    FBT 0                ; 06DA: 5C
    IND                  ; 06DB: 33
    CZP L002C            ; 06DC: BB
sub_06DD:
    RFB 0                ; 06DD: 6C
    RT                   ; 06DE: 48
sub_06DF:
    LDI 0x4E             ; 06DF: 15 4E
    JCP sub_06E4         ; 06E1: E4
sub_06E2:
    LDI 0x4F             ; 06E2: 15 4F
sub_06E4:
    LI 0                 ; 06E4: 90
    CM                   ; 06E5: 0C
    RT                   ; 06E6: 48
    RTS                  ; 06E7: 49
sub_06E8:
    LDI 0x2D             ; 06E8: 15 2D
    CM                   ; 06EA: 0C
    RT                   ; 06EB: 48
    LM 3                 ; 06EC: 3B
sub_06ED:
    LM 0                 ; 06ED: 38
    LDZ 0x6              ; 06EE: 86
    CZP L0034            ; 06EF: BD
    CI 15                ; 06F0: 17 CF
    RT                   ; 06F2: 48
    SMB 0                ; 06F3: 78
    RT                   ; 06F4: 48
sub_06F5:
    LDZ 0x0              ; 06F5: 80
    CZP L0004            ; 06F6: B1
    LDZ 0x1              ; 06F7: 81
    CZP L0004            ; 06F8: B1
    LDZ 0x3              ; 06F9: 83
    CZP L0004            ; 06FA: B1
    LDZ 0x6              ; 06FB: 86
    CZP L0004            ; 06FC: B1
    LDZ 0xB              ; 06FD: 8B
    CZP L0004            ; 06FE: B1
    RT                   ; 06FF: 48
sub_0700:
    TTM                  ; 0700: 05
    JCP sub_0700         ; 0701: C0
    AD                   ; 0702: 08
    JCP sub_070B         ; 0703: CB
    FBT 3                ; 0704: 5F
    JCP sub_070B         ; 0705: CB
    LDI 0x14             ; 0706: 15 14
    INM                  ; 0708: 1D
    TMB 0                ; 0709: 58
    LI 8                 ; 070A: 98
sub_070B:
    LI 0                 ; 070B: 90
    LDZ 0x4              ; 070C: 84
    OE                   ; 070D: 44
    OCD 0x00             ; 070E: 1E 00
sub_0710:
    LI 0                 ; 0710: 90
    XMI 0                ; 0711: 3C
    OP                   ; 0712: 0E
    CLI 8                ; 0713: 16 E8
    JCP sub_0710         ; 0715: D0
    STM 0x01             ; 0716: 14 81
    RT                   ; 0718: 48
sub_0719:
    LDI 0x4E             ; 0719: 15 4E
    LM 0                 ; 071B: 38
    TLY                  ; 071C: 46
    LDI 0x48             ; 071D: 15 48
    XM 0                 ; 071F: 28
    XLY                  ; 0720: 4E
    S                    ; 0721: 02
    RT                   ; 0722: 48
sub_0723:
    LDI 0x2F             ; 0723: 15 2F
sub_0725:
    LI 0                 ; 0725: 90
    XMD 1                ; 0726: 2D
    LI 0                 ; 0727: 90
    XM 1                 ; 0728: 29
    CLI 12               ; 0729: 16 EC
    JCP sub_0725         ; 072B: E5
    LDI 0x29             ; 072C: 15 29
    CZP L0030            ; 072E: BC
    RT                   ; 072F: 48
sub_0730:
    LDI 0x4D             ; 0730: 15 4D
    STC                  ; 0732: 1B
    TMB 0                ; 0733: 58
    CLC                  ; 0734: 0B
    LDI 0x1C             ; 0735: 15 1C
    LM 3                 ; 0737: 3B
    TAZ                  ; 0738: 42
    LI 14                ; 0739: 9E
    AD                   ; 073A: 08
    RT                   ; 073B: 48
    LI 6                 ; 073C: 96
    AD                   ; 073D: 08
    CMA                  ; 073E: 10
    TAL                  ; 073F: 07
    LI 0                 ; 0740: 90
    XM 1                 ; 0741: 29
    LI 0                 ; 0742: 90
    XM 1                 ; 0743: 29
    TC                   ; 0744: 04
    RT                   ; 0745: 48
    XAZ                  ; 0746: 4A
    S                    ; 0747: 02
    CI 0                 ; 0748: 17 C0
    RT                   ; 074A: 48
    XM 1                 ; 074B: 29
    SMB 0                ; 074C: 78
    RT                   ; 074D: 48
sub_074E:
    LDZ 0x7              ; 074E: 87
sub_074F:
    LI 0                 ; 074F: 90
    XMD 0                ; 0750: 2C
    CLI 3                ; 0751: 16 E3
    JCP sub_074F         ; 0753: CF
    RT                   ; 0754: 48
sub_0755:
    LDZ 0xF              ; 0755: 8F
    CZP L0008            ; 0756: B2
    LDZ 0xA              ; 0757: 8A
    CZP L0008            ; 0758: B2
    CZP L0028            ; 0759: BA
    LI 4                 ; 075A: 94
sub_075B:
    TAW                  ; 075B: 43
    LDZ 0x1              ; 075C: 81
    CZP L0008            ; 075D: B2
    LDZ 0x7              ; 075E: 87
    CZP L0008            ; 075F: B2
    LDZ 0xB              ; 0760: 8B
    CZP L0008            ; 0761: B2
    XAW                  ; 0762: 4B
    DEC                  ; 0763: 0F
    JCP sub_075B         ; 0764: DB
    CAL L0027            ; 0765: A8 27
    RT                   ; 0767: 48
sub_0768:
    CZP L0018            ; 0768: B6
    LDZ 0xF              ; 0769: 8F
    CZP L000C            ; 076A: B3
    CAL L0015            ; 076B: A8 15
    CZP L0010            ; 076D: B4
    LDZ 0x9              ; 076E: 89
    CZP L000C            ; 076F: B3
    LDZ 0xF              ; 0770: 8F
    CZP L000C            ; 0771: B3
    LDZ 0x9              ; 0772: 89
    CZP L000C            ; 0773: B3
    LDZ 0x5              ; 0774: 85
    CZP L000C            ; 0775: B3
    LDZ 0x9              ; 0776: 89
    CZP L000C            ; 0777: B3
    LDZ 0x5              ; 0778: 85
    CZP L000C            ; 0779: B3
    LDZ 0x3              ; 077A: 83
    CZP L0014            ; 077B: B5
    RT                   ; 077C: 48
sub_077D:
    LDZ 0xB              ; 077D: 8B
    CZP L0010            ; 077E: B4
    LDZ 0x9              ; 077F: 89
    CZP L0010            ; 0780: B4
    LDZ 0x7              ; 0781: 87
    CZP L0010            ; 0782: B4
    LDZ 0xB              ; 0783: 8B
    CZP L0010            ; 0784: B4
    LDZ 0x9              ; 0785: 89
    CZP L0010            ; 0786: B4
    LDZ 0x7              ; 0787: 87
    CZP L0010            ; 0788: B4
    LDZ 0x6              ; 0789: 86
    CZP L0010            ; 078A: B4
    LDZ 0x9              ; 078B: 89
    CZP L0010            ; 078C: B4
    LDZ 0x7              ; 078D: 87
    CZP L0010            ; 078E: B4
    LDZ 0x3              ; 078F: 83
    CZP L0010            ; 0790: B4
    LDZ 0x6              ; 0791: 86
    CZP L0010            ; 0792: B4
    LDZ 0x7              ; 0793: 87
    CZP L0010            ; 0794: B4
    LDZ 0x9              ; 0795: 89
    CZP L0010            ; 0796: B4
    LDZ 0x6              ; 0797: 86
    CZP L0010            ; 0798: B4
    LDZ 0x7              ; 0799: 87
    CZP L0010            ; 079A: B4
    LDZ 0x9              ; 079B: 89
    CZP L0010            ; 079C: B4
    LDZ 0xA              ; 079D: 8A
    CZP L0014            ; 079E: B5
    RT                   ; 079F: 48
sub_07A0:
    LDI 0x13             ; 07A0: 15 13
sub_07A2:
    CLC                  ; 07A2: 0B
sub_07A3:
    LM 1                 ; 07A3: 39
    DAA                  ; 07A4: 06
    ADS                  ; 07A5: 09
    DAS                  ; 07A6: 0A
    XMD 1                ; 07A7: 2D
    JCP sub_07A3         ; 07A8: E3
    TC                   ; 07A9: 04
    RT                   ; 07AA: 48
    LI 7                 ; 07AB: 97
sub_07AC:
    TAW                  ; 07AC: 43
    CAL sub_07B9         ; 07AD: AF B9
    XAW                  ; 07AF: 4B
    DEC                  ; 07B0: 0F
    JCP sub_07AC         ; 07B1: EC
    CAL sub_0579         ; 07B2: AD 79
    RTS                  ; 07B4: 49
sub_07B5:
    SMB 3                ; 07B5: 7B
    RFB 3                ; 07B6: 6F
    JMP sub_0360         ; 07B7: A3 60
sub_07B9:
    LDZ 0xF              ; 07B9: 8F
    CZP L000C            ; 07BA: B3
    CAL L0015            ; 07BB: A8 15
    CZP L0010            ; 07BD: B4
    LDZ 0x9              ; 07BE: 89
    CZP L000C            ; 07BF: B3
    LDZ 0x5              ; 07C0: 85
    CZP L000C            ; 07C1: B3
    LDZ 0x9              ; 07C2: 89
    CZP L000C            ; 07C3: B3
    LDZ 0x7              ; 07C4: 87
    CZP L0010            ; 07C5: B4
    LDZ 0xA              ; 07C6: 8A
    CZP L000C            ; 07C7: B3
    LDZ 0x3              ; 07C8: 83
    CZP L0014            ; 07C9: B5
    RT                   ; 07CA: 48
    NOP                  ; 07CB: 00
    NOP                  ; 07CC: 00
    NOP                  ; 07CD: 00
    NOP                  ; 07CE: 00
    NOP                  ; 07CF: 00
    NOP                  ; 07D0: 00
    IP                   ; 07D1: 32
    S                    ; 07D2: 02
    IP                   ; 07D3: 32
    AD                   ; 07D4: 08
    OE                   ; 07D5: 44
    LDZ 0x2              ; 07D6: 82
sub_07D7:
    IP                   ; 07D7: 32
    S                    ; 07D8: 02
    OE                   ; 07D9: 44
    LI 10                ; 07DA: 9A
    CM                   ; 07DB: 0C
    JCP sub_07D7         ; 07DC: D7
    LDZ 0x3              ; 07DD: 83
    CM                   ; 07DE: 0C
    JMP sub_07D7         ; 07DF: A7 D7
    OP                   ; 07E1: 0E
    LI 5                 ; 07E2: 95
    OP                   ; 07E3: 0E
    LDZ 0x2              ; 07E4: 82
    OP                   ; 07E5: 0E
    LI 10                ; 07E6: 9A
    OP                   ; 07E7: 0E
    CAL sub_07F3         ; 07E8: AF F3
    INC                  ; 07EA: 0D
    OE                   ; 07EB: 44
    LI 12                ; 07EC: 9C
    JPA                  ; 07ED: 41
    LI 3                 ; 07EE: 93
    OE                   ; 07EF: 44
    OCD 0x00             ; 07F0: 1E 00
    CZP L0000            ; 07F2: B0
sub_07F3:
    INC                  ; 07F3: 0D
    OP                   ; 07F4: 0E
    CAL sub_07F8         ; 07F5: AF F8
    RTS                  ; 07F7: 49
sub_07F8:
    CMA                  ; 07F8: 10
    OP                   ; 07F9: 0E
    CAL sub_07FD         ; 07FA: AF FD
    RT                   ; 07FC: 48
sub_07FD:
    DEC                  ; 07FD: 0F
    OP                   ; 07FE: 0E
    RT                   ; 07FF: 48
    NOP                  ; 0800: 00
