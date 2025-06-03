# Getting Started with µCOM-43/µC43 Toolchain

This guide will help you get started with the µCOM-43/µC43 development toolchain.

## Quick Setup

### 1. Prerequisites
- **Python 3.6+** (no external dependencies required)
- **Text editor** for writing code
- **Terminal/Command prompt** for running tools

### 2. Verify Installation
Test that the tools work correctly:

```bash
# Test the disassembler
python3 ucom43_disassembler.py --help

# Test the assembler  
python3 ucom43_assembler.py --help

# Test the compiler
python3 uc43_compiler.py --help
```

## Your First Program

### Option A: Start with Assembly

1. **Create a simple assembly program** (`hello.s`):
```assembly
; Hello World for µCOM-43
    ORG 0x0000

main:
    LI 0xF              ; Load 15 (all bits set)
    LDZ 0xE             ; Set port to E
    OP                  ; Output to port E
    RTS                 ; Return
```

2. **Assemble to binary**:
```bash
python3 ucom43_assembler.py -o hello.bin hello.s
```

3. **Verify the output**:
```bash
python3 ucom43_disassembler.py hello.bin
```

### Option B: Start with µC43 High-Level Language

1. **Create a µC43 program** (`hello.uc43`):
```c
function main() {
    acc = 15;           // Load value 15
    output(0xE, acc);   // Output to port E
    return;
}
```

2. **Compile to assembly**:
```bash
python3 uc43_compiler.py -o hello.s hello.uc43
```

3. **Assemble to binary**:
```bash
python3 ucom43_assembler.py -o hello.bin hello.s
```

4. **Verify the complete workflow**:
```bash
python3 ucom43_disassembler.py hello.bin
```

## Understanding the Output

### Disassembler Output Explained
```assembly
    ORG 0x0000                    ; Origin address

    LI 15                ; 0000: 9F ; Load ACC with 0xF
    ; ^^                 ^^        ^^
    ; |                  |         |
    ; Instruction        Address   Machine code & description
```

### Assembly Syntax
- **Labels**: End with colon (`main:`)
- **Instructions**: Indented (`    LI 15`)
- **Comments**: Start with semicolon (`; This is a comment`)
- **Numbers**: Decimal (`15`), hex (`0xF`), binary (`0b1111`)

### µC43 Syntax
- **Functions**: `function name() { ... }`
- **Variables**: `acc`, `dp`, `ram[address]`
- **I/O**: `input(port)`, `output(port, value)`
- **Comments**: `// Single line` or `/* Multi-line */`

## Common Operations

### LED Control
```c
// µC43 version
function blink() {
    output(0xE, 0xF);   // Turn on LEDs
    output(0xE, 0x0);   // Turn off LEDs
}
```

```assembly
; Assembly version
blink:
    LI 0xF              ; Load 15
    LDZ 0xE             ; Set port E
    OP                  ; Output
    LI 0x0              ; Load 0  
    LDZ 0xE             ; Set port E
    OP                  ; Output
    RTS                 ; Return
```

### Memory Operations
```c
// µC43 version
function memory_test() {
    dp = 0x20;          // Set memory address
    acc = 5;            // Load value
    ram[dp] = acc;      // Store in memory
}
```

```assembly
; Assembly version
memory_test:
    LDI 0x20            ; Set DP to 0x20
    LI 5                ; Load 5
    S                   ; Store ACC to RAM[DP]
    RTS                 ; Return
```

### Input/Output
```c
// µC43 version
function echo() {
    acc = input(0xA);   // Read from port A
    output(0xE, acc);   // Echo to port E
}
```

```assembly
; Assembly version  
echo:
    LDZ 0xA             ; Set port A
    IP                  ; Input to ACC
    LDZ 0xE             ; Set port E
    OP                  ; Output ACC
    RTS                 ; Return
```

## Development Workflow

### Recommended Process
1. **Plan** your program structure
2. **Write** in µC43 high-level language (easier to debug)
3. **Compile** to assembly to see generated code
4. **Optimize** critical sections by hand-editing assembly
5. **Assemble** final code to binary
6. **Test** using disassembler to verify

### Debugging Tips
1. **Use listings**: `python3 ucom43_assembler.py -l listing.txt source.s`
2. **Check disassembly**: Always verify your binary with the disassembler
3. **Start simple**: Build complexity gradually
4. **Comment heavily**: Both assembly and µC43 benefit from good comments

## Tool Options Reference

### Disassembler Options
```bash
python3 ucom43_disassembler.py [options] input.bin

-o output.s         # Save to file
-s 0x0800          # Start address  
-e 0x1000          # End address
```

### Assembler Options
```bash
python3 ucom43_assembler.py [options] input.s

-o output.bin      # Binary output
-x output.hex      # Hex dump output
-l listing.txt     # Assembly listing
```

### Compiler Options
```bash
python3 uc43_compiler.py [options] input.uc43

-o output.s        # Assembly output
```

## Learning Path

### Beginner (Start Here)
1. **Read** the [µC43 Language Specification](uc43_language.md)
2. **Try** the examples in the `examples/` directory
3. **Write** simple programs using basic I/O
4. **Experiment** with the tools

### Intermediate
1. **Study** the [Instruction Set Reference](INSTRUCTION_SET.md)
2. **Write** assembly programs directly
3. **Understand** µCOM-43 architecture details
4. **Optimize** compiled code by hand

### Advanced
1. **Read** the [Complete Toolchain Documentation](TOOLCHAIN_DOCUMENTATION.md)
2. **Contribute** to compiler/decompiler development
3. **Create** complex programs using all features
4. **Share** your programs and improvements

## Getting Help

### Documentation
- **[README.md](README.md)** - Project overview
- **[TOOLCHAIN_DOCUMENTATION.md](TOOLCHAIN_DOCUMENTATION.md)** - Complete reference
- **[INSTRUCTION_SET.md](INSTRUCTION_SET.md)** - µCOM-43 instructions
- **[uc43_language.md](uc43_language.md)** - µC43 language reference

### Examples
- **[examples/](examples/)** - Sample programs and tutorials
- **[examples/README.md](examples/README.md)** - Examples documentation

### Common Issues
1. **"Unknown instruction"** - Check spelling and instruction set reference
2. **"Undefined symbol"** - Ensure labels are defined before use
3. **"Syntax error"** - Check syntax against language specification
4. **Compilation fails** - Remember compiler is still in development

## Next Steps

Once you're comfortable with the basics:
1. **Explore** the advanced features in the examples
2. **Try** reverse engineering with the disassembler
3. **Contribute** to the project development
4. **Build** your own µCOM-43 projects

The µCOM-43/µC43 toolchain is designed to make 4-bit microprocessor programming accessible and enjoyable. Start simple, experiment freely, and don't hesitate to dive into the documentation when you need more details! 