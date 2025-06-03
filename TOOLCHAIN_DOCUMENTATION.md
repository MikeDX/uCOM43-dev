# µCOM-43/µC43 Development Toolchain Documentation

This document describes the complete development toolchain for the NEC µCOM-43 4-bit microprocessor, including assembly/disassembly tools and a high-level language compiler/decompiler.

## Table of Contents

1. [Overview](#overview)
2. [µCOM-43 Disassembler](#μcom-43-disassembler)
3. [µCOM-43 Assembler](#μcom-43-assembler)
4. [µC43 High-Level Language](#μc43-high-level-language)
5. [µC43 Compiler](#μc43-compiler)
6. [µC43 Decompiler](#μc43-decompiler)
7. [Usage Examples](#usage-examples)
8. [File Formats](#file-formats)
9. [Development Workflow](#development-workflow)

## Overview

The µCOM-43/µC43 toolchain provides a complete development environment for the NEC µCOM-43 4-bit microprocessor, supporting both low-level assembly language and a custom high-level language called µC43.

### Toolchain Components

| Tool | Status | Purpose |
|------|--------|---------|
| `ucom43_disassembler.py` | ✅ Complete | Converts binary ROM to µCOM-43 assembly |
| `ucom43_assembler.py` | ✅ Complete | Converts µCOM-43 assembly to binary |
| `uc43_compiler.py` | 🚧 In Progress | Converts µC43 high-level code to assembly |
| `uc43_decompiler.py` | 🚧 In Progress | Converts assembly back to µC43 code |

### Data Flow

```
µC43 Source (.uc43) ←→ µCOM-43 Assembly (.s) ←→ Binary ROM (.bin)
     ↑    ↓                    ↑    ↓                  ↑    ↓
   Compiler/              Assembler/               ROM Data
  Decompiler             Disassembler
```

## µCOM-43 Disassembler

**File:** `ucom43_disassembler.py`  
**Status:** ✅ Complete and fully functional

### Features

- **Complete instruction set support** - All 256 opcodes of the µCOM-43
- **Intelligent label generation** - Automatic labels for jump/call targets
- **Instruction sequence analysis** - Detects LI instruction skip patterns
- **Jump table detection** - Identifies and documents JPA indirect jump tables
- **Detailed comments** - Comprehensive explanations for each instruction
- **Address mapping** - Supports custom start addresses with ORG directive

### Supported Instructions

#### Basic Operations (Single Byte)
- **NOP, DI, EI** - Control flow
- **S, AD, CM** - Memory operations  
- **INC, DEC, CMA** - Arithmetic
- **OP, IP** - I/O operations
- **RT, RTS** - Subroutine control

#### Immediate Instructions (Two Bytes)
- **STM, LDI, CLI, CI, OCD** - Operations with 8-bit operands

#### Variable-Length Instructions
- **LI** (0x90-0x9F) - Load immediate with skip behavior
- **LDZ** (0x80-0x8F) - Load data pointer with zero high byte

#### Bit Manipulation (Single Byte)
- **FBF, FBT** - Flag bit operations
- **TAB, TMB** - Bit testing
- **SEB, REB** - Port E bit control
- **SMB, RMB** - RAM bit control

#### Jump and Call Instructions
- **JMP, CAL** - 11-bit absolute addressing
- **JCP** - 6-bit current page jump
- **CZP** - 4-bit zero page call
- **JPA** - Indirect jump using ACC

### Advanced Analysis Features

#### LI Instruction Skip Analysis
The disassembler detects consecutive LI instructions and documents their skip behavior:

```assembly
; LI INSTRUCTION ANALYSIS
; Found 3 LI instructions that skip following LI instructions
;   0x0100: skips 2 LI instructions, resumes at 0x0103
```

#### JPA Jump Table Documentation
Automatically generates jump table documentation for indirect jumps:

```assembly
; JPA jump table at 0x0200 (page 0x0200):
;   Jump targets based on ACC value (ACC << 2 | page):
;   ACC=0→0x0200  ACC=1→0x0204  ACC=2→0x0208  ACC=3→0x020C
;   Targets within ROM: 16 of 16
```

### Usage

```bash
# Basic disassembly
python3 ucom43_disassembler.py rom.bin

# Disassemble with custom start address
python3 ucom43_disassembler.py -s 0x0800 rom.bin

# Output to file
python3 ucom43_disassembler.py -o output.s rom.bin

# Disassemble specific range
python3 ucom43_disassembler.py -s 0x0000 -e 0x0400 rom.bin
```

### Output Format

```assembly
    ORG 0x0000

L0000:
    LI 5                 ; 0000: 95 Load ACC with 0x5
    LDZ 0xE              ; 0001: 8E Load DP with 0xE (DPH = 0, DPL = 0xE)
    OP                   ; 0002: 0E Output ACC to port specified by DPL (port[DPL] = ACC)
    RTS                  ; 0003: 49 Return from subroutine, skip next instruction
```

## µCOM-43 Assembler

**File:** `ucom43_assembler.py`  
**Status:** ✅ Complete and fully functional

### Features

- **Complete instruction set** - Supports all µCOM-43 instructions
- **Label resolution** - Forward and backward label references
- **Multiple number formats** - Decimal, hexadecimal (0x, $), binary (0b, %)
- **Expression evaluation** - Basic arithmetic in operands
- **Error reporting** - Detailed syntax and semantic error messages
- **Two-pass assembly** - Proper label resolution

### Supported Syntax

#### Basic Instructions
```assembly
NOP                      ; No operation
LI 5                     ; Load immediate
LDZ 0xE                  ; Load data pointer
JMP label                ; Jump to label
CAL subroutine           ; Call subroutine
```

#### Labels and Symbols
```assembly
main:                    ; Function label
    LI 10               ; Load 10 into ACC
    JMP loop            ; Jump to loop label

loop:
    DEC                 ; Decrement ACC
    JCP loop            ; Jump if not zero
```

#### Number Formats
```assembly
LI 15                   ; Decimal
LI 0xF                  ; Hexadecimal (0x prefix)
LI $F                   ; Hexadecimal ($ prefix)
LI 0b1111               ; Binary (0b prefix)  
LI %1111                ; Binary (% prefix)
```

#### Special Instruction Encoding

**STM (Set Timer)** - Special encoding with offset:
```assembly
STM 0x10                ; Encodes as 0x14, 0x90 (0x10 + 0x80)
```

**CI/CLI Instructions** - Compare with special encoding:
```assembly
CI 5                    ; Compare ACC with 5, encodes as 0x17, 0xC5
CLI 3                   ; Compare DPL with 3, encodes as 0x16, 0xE3
```

### Usage

```bash
# Assemble to binary
python3 ucom43_assembler.py -o output.bin source.s

# Generate hex dump
python3 ucom43_assembler.py -x output.hex source.s

# Create assembly listing
python3 ucom43_assembler.py -l listing.txt source.s
```

### Error Handling

The assembler provides detailed error messages:

```
Assembly errors:
  Line 15: Unknown instruction INVALID
  Line 23: Undefined symbol: undefined_label
  Line 31: JMP requires 1 operand
```

## µC43 High-Level Language

**File:** `uc43_language.md`

µC43 is a C-like high-level language designed specifically for the µCOM-43's 4-bit architecture.

### Key Features

- **4-bit data types** - Native `nibble` type (0-15)
- **Built-in variables** - Direct access to `acc`, `dp`, `dph`, `dpl`
- **Memory access** - `ram[address]` syntax
- **I/O functions** - `input(port)`, `output(port, value)`
- **Control flow** - `if`, `while`, `goto`, `switch_acc`
- **Function definitions** - C-style function syntax

### Data Types and Variables

```c
nibble value;           // 4-bit value (0-15)
acc = 5;               // Accumulator access
dp = 0x30;             // Data pointer
ram[dp] = acc;         // RAM access through data pointer
```

### Built-in Functions

```c
acc = input(0xA);      // Read from input port A
output(0xE, 0xF);      // Write 0xF to output port E
delay(100);            // Timer delay
bit_test(acc, 2);      // Test bit 2 of accumulator
```

## µC43 Compiler

**File:** `uc43_compiler.py`  
**Status:** 🚧 In Progress

### Current Features

- **Lexical analysis** - Complete tokenizer for µC43 syntax
- **Basic parsing** - Function definitions and simple statements
- **Code generation** - Basic assembly output for assignments and I/O
- **Error reporting** - Syntax error detection with line numbers

### Implemented Language Features

#### Function Definitions
```c
function main() {
    acc = 5;
    output(0xE, acc);
    return;
}
```

#### Variable Assignments
```c
acc = 15;              // Compiles to: LI 15
dp = 0x30;             // Compiles to: LDI 0x30
ram[dp] = acc;         // Compiles to: S
```

#### I/O Operations
```c
output(0xE, 5);        // Compiles to: LI 5; LDZ 0xE; OP
acc = input(0xA);      // Compiles to: LDZ 0xA; IP
```

### Current Limitations

- **No control flow** - `if`, `while`, `goto` not yet implemented
- **No expressions** - Limited arithmetic and logical operations
- **No switch statements** - `switch_acc` construct not implemented
- **No local variables** - Only built-in registers supported

### Usage

```bash
# Compile µC43 to assembly
python3 uc43_compiler.py -o output.s program.uc43

# View generated assembly
python3 uc43_compiler.py program.uc43
```

### Example Output

Input µC43 code:
```c
function main() {
    acc = 5;
    output(0xE, acc);
    return;
}
```

Generated assembly:
```assembly
; µC43 Compiled Assembly
    ORG 0x0000

func_main:
    ; Function: main
    LI 5
    LDZ 0xE
    OP
    RTS
```

## µC43 Decompiler

**File:** `uc43_decompiler.py`  
**Status:** 🚧 In Progress

### Current Features

- **Assembly parsing** - Reads disassembled µCOM-43 assembly
- **Pattern recognition** - Identifies common instruction sequences
- **Function boundary detection** - Recognizes function labels
- **Basic code generation** - Outputs µC43-style high-level code

### Recognized Patterns

#### I/O Operations
```assembly
LI 5                    ; \
LDZ 0xE                 ; } → output(0xE, 5);
OP                      ; /

LDZ 0xA                 ; \
IP                      ; } → acc = input(0xA);
```

#### Data Movement
```assembly
LI 10                   ; → acc = 10;
LDI 0x30                ; → dp = 0x30;
S                       ; → ram[dp] = acc;
```

#### Control Flow
```assembly
CAL func_name           ; → call func_name();
JMP label               ; → goto label;
RTS                     ; → return;
```

### Current Limitations

- **Limited pattern matching** - Only basic sequences recognized
- **No control flow reconstruction** - Conditional statements not detected
- **No variable analysis** - Cannot track data flow through variables
- **No function parameters** - Functions assumed to be parameterless

### Usage

```bash
# Decompile assembly to µC43
python3 uc43_decompiler.py -o output.uc43 assembly.s

# View decompiled code
python3 uc43_decompiler.py assembly.s
```

### Example Output

Input assembly:
```assembly
func_main:
    LI 5
    LDZ 0xE
    OP
    RTS
```

Generated µC43 code:
```c
// µC43 Decompiled Code
// Generated from µCOM-43 assembly

function main() {
    output(0xE, 5);
    return;
}
```

## Usage Examples

### Complete Development Workflow

#### 1. Write µC43 High-Level Code
```c
// blink.uc43
function main() {
    while (true) {
        output(0xE, 0xF);    // LEDs on
        delay(1000);
        output(0xE, 0x0);    // LEDs off  
        delay(1000);
    }
}
```

#### 2. Compile to Assembly
```bash
python3 uc43_compiler.py -o blink.s blink.uc43
```

#### 3. Assemble to Binary
```bash
python3 ucom43_assembler.py -o blink.bin blink.s
```

#### 4. Disassemble for Verification
```bash
python3 ucom43_disassembler.py -o blink_disasm.s blink.bin
```

#### 5. Decompile Back to High-Level
```bash
python3 uc43_decompiler.py -o blink_decompiled.uc43 blink_disasm.s
```

### Assembly Language Programming

#### Direct Assembly Development
```assembly
; Direct assembly programming
    ORG 0x0000

main:
    LI 0xF              ; Load 15 into ACC
    LDZ 0xE             ; Set port to E
    OP                  ; Output ACC to port E
    
loop:
    LI 0x1              ; Load 1
    STM 0xFF            ; Start timer with max delay
    TTM                 ; Test timer flag
    JCP loop            ; Loop until timer expires
    
    LI 0x0              ; Load 0  
    LDZ 0xE             ; Set port to E
    OP                  ; Output ACC to port E (turn off)
    JMP main            ; Repeat
```

### ROM Analysis Workflow

#### Reverse Engineering Existing ROMs
```bash
# 1. Disassemble unknown ROM
python3 ucom43_disassembler.py -s 0x0800 -o unknown.s unknown.bin

# 2. Analyze the assembly output for patterns
# 3. Decompile to high-level code
python3 uc43_decompiler.py -o unknown.uc43 unknown.s

# 4. Edit and modify the decompiled code
# 5. Recompile the modified version
python3 uc43_compiler.py -o modified.s unknown_modified.uc43
python3 ucom43_assembler.py -o modified.bin modified.s
```

## File Formats

### Input/Output File Types

| Extension | Type | Tools | Description |
|-----------|------|-------|-------------|
| `.bin` | Binary ROM | Disassembler input, Assembler output | Raw µCOM-43 machine code |
| `.s`, `.asm` | Assembly | All tools | µCOM-43 assembly language |
| `.uc43` | High-level source | Compiler input, Decompiler output | µC43 high-level language |
| `.hex` | Hex dump | Assembler output | Human-readable hex format |
| `.lst` | Listing | Assembler output | Assembly listing with addresses |

### Assembly File Format

```assembly
; Comments start with semicolon
    ORG 0x0000          ; Origin directive

label:                  ; Labels end with colon
    NOP                 ; Instructions indented
    LI 0x5              ; Immediate operand
    JMP label           ; Label reference
```

### Binary File Format

- **Raw binary data** - Direct µCOM-43 machine code
- **No headers** - Pure instruction bytes
- **Address mapping** - Position in file = memory address (unless ORG used)

## Development Workflow

### Recommended Development Process

1. **Design Phase**
   - Plan program structure in µC43 high-level language
   - Define I/O requirements and memory usage
   - Consider µCOM-43 architectural constraints

2. **Implementation Phase**
   - Write code in µC43 high-level language
   - Use compiler to generate assembly
   - Review assembly output for optimization opportunities

3. **Testing Phase**
   - Assemble to binary ROM format
   - Test in µCOM-43 simulator/emulator
   - Use disassembler to verify code generation

4. **Optimization Phase**
   - Hand-optimize critical assembly sections
   - Use assembler for final binary generation
   - Document changes for future maintenance

5. **Maintenance Phase**
   - Use decompiler to recover high-level structure
   - Modify µC43 source code
   - Repeat compilation process

### Best Practices

#### µC43 Programming
- **Keep functions small** - Limited stack depth
- **Minimize variable usage** - Limited RAM
- **Use I/O efficiently** - Plan port assignments
- **Consider instruction timing** - Critical for real-time applications

#### Assembly Programming  
- **Use meaningful labels** - Aid in debugging
- **Comment extensively** - Document algorithm and data flow
- **Optimize for size** - ROM space is limited
- **Test instruction sequences** - Verify skip behaviors

#### Tool Usage
- **Always verify with disassembler** - Check compiler output
- **Use listing files** - Debug assembly issues
- **Keep source and binary in sync** - Version control recommended
- **Document toolchain versions** - Ensure reproducible builds

## Development Status

### Completed Features ✅

**µCOM-43 Disassembler:**
- Complete instruction set support
- Intelligent analysis and documentation
- Advanced pattern recognition
- Production ready

**µCOM-43 Assembler:**
- Full syntax support
- Error reporting and validation
- Multiple output formats
- Production ready

### In Development 🚧

**µC43 Compiler:**
- ✅ Lexical analysis and parsing
- ✅ Basic code generation
- ⏳ Control flow statements (`if`, `while`)
- ⏳ Expression evaluation
- ⏳ Switch statements and jump tables
- ⏳ Local variables and scoping

**µC43 Decompiler:**
- ✅ Basic pattern recognition
- ✅ Function boundary detection
- ⏳ Control flow reconstruction
- ⏳ Variable analysis and data flow
- ⏳ Advanced pattern matching
- ⏳ Code structure optimization

### Future Enhancements 🔮

- **Integrated development environment (IDE)**
- **µCOM-43 simulator/emulator**
- **Debugger with source-level debugging**
- **Optimization passes in compiler**
- **Library system for common functions**
- **Documentation generation tools**

## Conclusion

The µCOM-43/µC43 toolchain provides a complete development environment for the µCOM-43 microprocessor. While the assembler and disassembler are production-ready, the compiler and decompiler are actively being developed to provide a seamless high-level programming experience.

The tools are designed to work together as an integrated workflow, supporting both low-level assembly programming and high-level µC43 development, making µCOM-43 programming accessible to developers at all levels. 