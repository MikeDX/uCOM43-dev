# µCOM-43 Instruction Set Reference

Complete reference for all µCOM-43 4-bit microprocessor instructions, organized by category and function.

## Table of Contents

1. [Instruction Format](#instruction-format)
2. [Addressing Modes](#addressing-modes)
3. [Register Set](#register-set)
4. [Basic Operations](#basic-operations)
5. [Arithmetic & Logic](#arithmetic--logic)
6. [Memory Operations](#memory-operations)
7. [I/O Operations](#io-operations)
8. [Bit Manipulation](#bit-manipulation)
9. [Jump & Call Instructions](#jump--call-instructions)
10. [Control & Status](#control--status)
11. [Immediate Instructions](#immediate-instructions)
12. [Special Instructions](#special-instructions)

## Instruction Format

### Encoding Structure
- **1-byte instructions**: Most common format
- **2-byte instructions**: Include immediate operand
- **Variable encoding**: Some instructions use opcode bits for operands

### Notation
- `ACC` - Accumulator (4-bit)
- `DP` - Data Pointer (DPH:DPL, 8-bit)
- `DPH` - Data Pointer High (4-bit)
- `DPL` - Data Pointer Low (4-bit)
- `RAM[addr]` - RAM at address
- `#imm` - Immediate value
- `addr` - Memory address
- `bit` - Bit number (0-3)
- `port` - I/O port

## Addressing Modes

| Mode | Description | Example |
|------|-------------|---------|
| **Implicit** | No operand needed | `NOP`, `RT` |
| **Immediate** | Operand in instruction | `LI #5`, `CI #10` |
| **Direct** | Absolute address | `JMP addr`, `CAL addr` |
| **Indexed** | ACC as index | `JPA` (jump to page + ACC*4) |
| **Relative** | Current page offset | `JCP offset` |

## Register Set

| Register | Size | Description |
|----------|------|-------------|
| **ACC** | 4-bit | Accumulator |
| **DPH** | 4-bit | Data Pointer High |
| **DPL** | 4-bit | Data Pointer Low |
| **Z** | 4-bit | Z Register |
| **W** | 4-bit | W Register |
| **X** | 4-bit | X Register |
| **Y** | 4-bit | Y Register |
| **FLAG** | 4-bit | Flag Register |

### Status Flags
- **Carry Flag (C)** - Arithmetic carry/borrow
- **Timer Flag (T)** - Timer overflow
- **Interrupt Enable (I)** - Interrupt control

## Basic Operations

### No Operation & Control
| Mnemonic | Opcode | Description |
|----------|--------|-------------|
| `NOP` | 0x00 | No operation |
| `DI` | 0x01 | Disable interrupts |
| `EI` | 0x31 | Enable interrupts |
| `RT` | 0x48 | Return from subroutine |
| `RTS` | 0x49 | Return and skip next instruction |

### Register Transfers
| Mnemonic | Opcode | Description |
|----------|--------|-------------|
| `TAL` | 0x07 | Transfer ACC to DPL |
| `TLA` | 0x12 | Transfer DPL to ACC |
| `TAZ` | 0x42 | Transfer ACC to Z |
| `TAW` | 0x43 | Transfer ACC to W |
| `TLY` | 0x46 | Transfer DPL to Y |
| `THX` | 0x47 | Transfer DPH to X |

### Register Exchanges
| Mnemonic | Opcode | Description |
|----------|--------|-------------|
| `XAZ` | 0x4A | Exchange ACC with Z |
| `XAW` | 0x4B | Exchange ACC with W |
| `XLY` | 0x4E | Exchange DPL with Y |
| `XHX` | 0x4F | Exchange DPH with X |
| `XLS` | 0x4C | Exchange low nibbles |
| `XHR` | 0x4D | Exchange high nibbles |

## Arithmetic & Logic

### Arithmetic Operations
| Mnemonic | Opcode | Description | Flags |
|----------|--------|-------------|-------|
| `INC` | 0x0D | Increment ACC, skip if zero | C |
| `DEC` | 0x0F | Decrement ACC, skip if 0xF | C |
| `AD` | 0x08 | Add RAM[DP] to ACC, skip if carry | C |
| `ADS` | 0x09 | Add RAM[DP] and carry to ACC, skip if carry | C |
| `ADC` | 0x19 | Add RAM[DP] and carry to ACC | C |
| `DAS` | 0x0A | Decimal adjust for subtraction | C |
| `DAA` | 0x06 | Decimal adjust for addition | C |

### Logical Operations
| Mnemonic | Opcode | Description |
|----------|--------|-------------|
| `CMA` | 0x10 | Complement ACC |
| `CIA` | 0x11 | Complement and increment ACC |
| `EXL` | 0x18 | XOR ACC with RAM[DP] |

### Rotate Operations
| Mnemonic | Opcode | Description |
|----------|--------|-------------|
| `RAR` | 0x30 | Rotate ACC right through carry |

### Compare Operations
| Mnemonic | Opcode | Description |
|----------|--------|-------------|
| `CM` | 0x0C | Compare ACC with RAM[DP], skip if equal |

## Memory Operations

### Load Instructions
| Mnemonic | Opcode | Operand | Description |
|----------|--------|---------|-------------|
| `LI` | 0x90-0x9F | 0-15 | Load immediate to ACC |
| `LDZ` | 0x80-0x8F | 0-15 | Load DP with (0, operand) |
| `LDI` | 0x15 | #imm8 | Load immediate to DP |

### Store Instructions
| Mnemonic | Opcode | Description |
|----------|--------|-------------|
| `S` | 0x02 | Store ACC to RAM[DP] |

### Memory Increment/Decrement
| Mnemonic | Opcode | Description |
|----------|--------|-------------|
| `INM` | 0x1D | Increment RAM[DP], skip if zero |
| `DEM` | 0x1F | Decrement RAM[DP], skip if 0xF |
| `IND` | 0x33 | Increment DPL, skip if zero |
| `DED` | 0x13 | Decrement DPL, skip if 0xF |

## I/O Operations

### Port Operations
| Mnemonic | Opcode | Description |
|----------|--------|-------------|
| `OP` | 0x0E | Output ACC to port[DPL] |
| `IP` | 0x32 | Input from port[DPL] to ACC |
| `IA` | 0x40 | Input from port A to ACC |
| `OE` | 0x44 | Output ACC to port E |

### Special I/O
| Mnemonic | Opcode | Operand | Description |
|----------|--------|---------|-------------|
| `OCD` | 0x1E | #imm8 | Output immediate to ports C and D |

## Bit Manipulation

### Bit Test Instructions
| Mnemonic | Opcode Range | Bit | Description |
|----------|--------------|-----|-------------|
| `FBF` | 0x20-0x23 | 0-3 | Skip if FLAG bit NOT set |
| `FBT` | 0x5C-0x5F | 0-3 | Skip if FLAG bit set |
| `TAB` | 0x24-0x27 | 0-3 | Skip if ACC bit set |
| `TMB` | 0x58-0x5B | 0-3 | Skip if RAM[DP] bit set |
| `TPA` | 0x54-0x57 | 0-3 | Skip if port A bit set |
| `TPB` | 0x50-0x53 | 0-3 | Skip if port[DPL] bit set |
| `CMB` | 0x34-0x37 | 0-3 | Skip if ACC bit equals RAM[DP] bit |

### Bit Set Instructions
| Mnemonic | Opcode Range | Bit | Description |
|----------|--------------|-----|-------------|
| `SFB` | 0x7C-0x7F | 0-3 | Set FLAG bit |
| `SMB` | 0x78-0x7B | 0-3 | Set RAM[DP] bit |
| `SEB` | 0x74-0x77 | 0-3 | Set port E bit |
| `SPB` | 0x70-0x73 | 0-3 | Set port bit (no operation) |

### Bit Reset Instructions
| Mnemonic | Opcode Range | Bit | Description |
|----------|--------------|-----|-------------|
| `RFB` | 0x6C-0x6F | 0-3 | Reset FLAG bit |
| `RMB` | 0x68-0x6B | 0-3 | Reset RAM[DP] bit |
| `REB` | 0x64-0x67 | 0-3 | Reset port E bit |
| `RPB` | 0x60-0x63 | 0-3 | Reset port bit (no operation) |

## Jump & Call Instructions

### Unconditional Jumps
| Mnemonic | Opcode Range | Operand | Description |
|----------|--------------|---------|-------------|
| `JMP` | 0xA0-0xA7 | addr11 | Jump to 11-bit address |
| `JCP` | 0xC0-0xFF | offset6 | Jump to current page + offset |
| `JPA` | 0x41 | - | Jump to (current page | ACC*4) |

### Subroutine Calls
| Mnemonic | Opcode Range | Operand | Description |
|----------|--------------|---------|-------------|
| `CAL` | 0xA8-0xAF | addr11 | Call 11-bit address |
| `CZP` | 0xB0-0xBF | page4 | Call zero page (page*4) |

### Address Encoding
- **11-bit addresses**: High 3 bits in opcode, low 8 bits in next byte
- **Current page**: Upper 10 bits of PC, lower 6 bits from instruction
- **Zero page**: 4-bit page number shifted left by 2

## Control & Status

### Flag Operations
| Mnemonic | Opcode | Description |
|----------|--------|-------------|
| `CLC` | 0x0B | Clear carry flag |
| `STC` | 0x1B | Set carry flag |
| `XC` | 0x1A | Exchange carry with carry save |

### Test Operations
| Mnemonic | Opcode | Description |
|----------|--------|-------------|
| `TC` | 0x04 | Skip if carry flag set |
| `TTM` | 0x05 | Skip if timer flag set |
| `TIT` | 0x03 | Skip if interrupt flag set |

### Timer Operations
| Mnemonic | Opcode | Operand | Description |
|----------|--------|---------|-------------|
| `STM` | 0x14 | #imm8 | Start timer with value+0x80 |

## Immediate Instructions

### Compare Instructions
| Mnemonic | Opcode | Operand | Description |
|----------|--------|---------|-------------|
| `CI` | 0x17 | #imm4 | Compare ACC with immediate |
| `CLI` | 0x16 | #imm4 | Compare DPL with immediate |

### Special Encoding
- `CI #n` encodes as: `0x17 0xC0+n`
- `CLI #n` encodes as: `0x16 0xE0+n`
- `STM #n` encodes as: `0x14 n+0x80`

## Special Instructions

### Memory Exchange Operations
| Mnemonic | Opcode Range | X Value | Description |
|----------|--------------|---------|-------------|
| `XM` | 0x28-0x2B | 0-3 | Exchange ACC with RAM[DP], XOR DPH with X |
| `XMI` | 0x3C-0x3F | 0-3 | XM + increment DPL, skip if zero |
| `XMD` | 0x2C-0x2F | 0-3 | XM + decrement DPL, skip if 0xF |
| `LM` | 0x38-0x3B | 0-3 | Load ACC from RAM[DP], XOR DPH with X |

### Special Cases
- When X=0, only exchange/load occurs (no XOR)
- When X≠0, DPH is XORed with X value

## Instruction Categories Summary

| Category | Count | Opcodes | Description |
|----------|-------|---------|-------------|
| **Basic Operations** | 16 | 0x00-0x4F | Core operations, transfers, arithmetic |
| **Bit Operations** | 32 | 0x20-0x7F | Bit manipulation on various targets |
| **Load Data Zero** | 16 | 0x80-0x8F | Load DP with zero page addresses |
| **Load Immediate** | 16 | 0x90-0x9F | Load immediate values to ACC |
| **Jumps** | 8 | 0xA0-0xA7 | 11-bit absolute jumps |
| **Calls** | 8 | 0xA8-0xAF | 11-bit absolute calls |
| **Zero Page Calls** | 16 | 0xB0-0xBF | 4-bit zero page calls |
| **Page Jumps** | 64 | 0xC0-0xFF | 6-bit current page jumps |

## Programming Notes

### Skip Instructions
Many instructions skip the next instruction on certain conditions:
- Arithmetic operations skip on overflow/underflow
- Compare operations skip on equality
- Bit test operations skip based on bit state
- I/O and memory operations may skip on specific conditions

### Page Addressing
The µCOM-43 uses a paged memory model:
- **Current page jumps** (JCP): 6-bit offset within current 64-byte page
- **Zero page calls** (CZP): 4-bit address in zero page (addresses 0x00-0x3C, step 4)
- **Absolute addressing** (JMP/CAL): Full 11-bit address space

### LI Instruction Behavior
LI instructions have special skip behavior:
- Only the first LI in a sequence executes
- Subsequent consecutive LI instructions are skipped
- Execution resumes at the first non-LI instruction

### Timer Operation
The STM instruction has special encoding:
- Display value + 0x80 = actual byte stored
- Timer counts (value + 1) × 63 cycles before setting flag

This comprehensive instruction set provides fine-grained control over the µCOM-43's 4-bit architecture while maintaining the simplicity expected of early microprocessors. 