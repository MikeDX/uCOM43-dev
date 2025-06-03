# µCOM-43/µC43 Development Toolchain

A complete development toolchain for the NEC µCOM-43 4-bit microprocessor, featuring assembly/disassembly tools and a high-level language compiler.

## 🚀 Quick Start

```bash
# Clone the repository
git clone https://github.com/yourusername/ucom43-toolchain.git
cd ucom43-toolchain

# Disassemble a ROM file
python3 ucom43_disassembler.py your_rom.bin

# Assemble source code
python3 ucom43_assembler.py -o output.bin source.s

# Compile high-level µC43 code (work in progress)
python3 uc43_compiler.py -o output.s program.uc43
```

## 📋 Overview

This toolchain provides comprehensive development tools for the µCOM-43 microprocessor:

| Tool | Status | Description |
|------|--------|-------------|
| **Disassembler** | ✅ Complete | Converts binary ROM to readable assembly |
| **Assembler** | ✅ Complete | Converts assembly to binary ROM |
| **Compiler** | 🚧 In Progress | Compiles µC43 high-level language to assembly |
| **Decompiler** | 🚧 In Progress | Converts assembly back to µC43 code |

## 🛠️ Tools

### µCOM-43 Disassembler (`ucom43_disassembler.py`)

**Status: ✅ Production Ready**

Converts binary ROM files to human-readable µCOM-43 assembly language with advanced analysis features.

**Key Features:**
- Complete instruction set support (all 256 opcodes)
- Intelligent label generation for jumps/calls
- LI instruction skip behavior analysis
- JPA jump table documentation
- Detailed instruction comments

```bash
# Basic usage
python3 ucom43_disassembler.py rom.bin

# Advanced options
python3 ucom43_disassembler.py -s 0x0800 -e 0x1000 -o output.s rom.bin
```

### µCOM-43 Assembler (`ucom43_assembler.py`)

**Status: ✅ Production Ready**

Converts µCOM-43 assembly language to binary ROM files with full syntax support.

**Key Features:**
- Complete instruction set support
- Label resolution (forward/backward references)
- Multiple number formats (decimal, hex, binary)
- Expression evaluation
- Comprehensive error reporting

```bash
# Assemble to binary
python3 ucom43_assembler.py -o output.bin source.s

# Generate hex dump and listing
python3 ucom43_assembler.py -x output.hex -l listing.txt source.s
```

### µC43 Compiler (`uc43_compiler.py`)

**Status: 🚧 In Development**

Compiles µC43 high-level language to µCOM-43 assembly.

**Currently Implemented:**
- Function definitions
- Basic assignments (`acc = 5`, `dp = 0x30`)
- I/O operations (`input()`, `output()`)
- Return statements

**In Progress:**
- Control flow (`if`, `while`, `goto`)
- Expressions and arithmetic
- Switch statements
- Local variables

```bash
python3 uc43_compiler.py -o output.s program.uc43
```

### µC43 Decompiler (`uc43_decompiler.py`)

**Status: 🚧 In Development**

Converts µCOM-43 assembly back to µC43 high-level language.

**Currently Implemented:**
- Basic pattern recognition
- Function boundary detection
- I/O operation reconstruction
- Simple data movement patterns

**In Progress:**
- Control flow reconstruction
- Variable analysis
- Advanced pattern matching

```bash
python3 uc43_decompiler.py -o output.uc43 assembly.s
```

## 📝 µC43 Language

µC43 is a C-like high-level language designed for the µCOM-43's 4-bit architecture:

```c
function main() {
    acc = 5;                // Load value into accumulator
    dp = 0x30;              // Set data pointer
    ram[dp] = acc;          // Store to RAM
    
    output(0xE, 0xF);       // Write to output port
    acc = input(0xA);       // Read from input port
    
    return;
}
```

## 📚 Examples

### LED Blinker (Assembly)

```assembly
    ORG 0x0000

main:
    LI 0xF              ; Turn on LEDs
    LDZ 0xE
    OP
    
    STM 0xFF            ; Delay
delay_loop:
    TTM
    JCP delay_loop
    
    LI 0x0              ; Turn off LEDs
    LDZ 0xE
    OP
    JMP main
```

### LED Blinker (µC43)

```c
function main() {
    while (true) {
        output(0xE, 0xF);    // LEDs on
        delay(1000);
        output(0xE, 0x0);    // LEDs off
        delay(1000);
    }
}
```

## 🔧 Installation

### Requirements

- Python 3.6 or higher
- No external dependencies required

### Setup

1. Clone the repository:
```bash
git clone https://github.com/yourusername/ucom43-toolchain.git
cd ucom43-toolchain
```

2. Make scripts executable (optional):
```bash
chmod +x *.py
```

3. Test the tools:
```bash
python3 ucom43_disassembler.py --help
python3 ucom43_assembler.py --help
```

## 📖 Documentation

- **[Complete Toolchain Documentation](TOOLCHAIN_DOCUMENTATION.md)** - Comprehensive guide
- **[µC43 Language Specification](uc43_language.md)** - High-level language reference
- **[Instruction Set Reference](INSTRUCTION_SET.md)** - µCOM-43 instruction details
- **[Examples](examples/)** - Sample programs and tutorials

## 🤝 Contributing

We welcome contributions! The compiler and decompiler are actively being developed.

### Current Priorities

1. **Compiler improvements:**
   - Control flow statements (`if`, `while`)
   - Expression evaluation
   - Switch statements with JPA generation

2. **Decompiler enhancements:**
   - Control flow reconstruction
   - Variable analysis
   - Pattern matching improvements

### Development Setup

1. Fork the repository
2. Create a feature branch: `git checkout -b feature-name`
3. Make changes and test thoroughly
4. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Based on analysis of the NEC µCOM-43 instruction set
- Inspired by classic 4-bit microprocessor development tools
- Community contributions and feedback

## 🐛 Bug Reports

Please report bugs and feature requests through GitHub Issues:
- Include tool version and Python version
- Provide sample input files when possible
- Describe expected vs actual behavior

## 📊 Project Status

### Completed ✅
- µCOM-43 Disassembler (production ready)
- µCOM-43 Assembler (production ready)
- Basic µC43 language specification
- Core documentation

### In Progress 🚧
- µC43 Compiler (basic features working)
- µC43 Decompiler (pattern recognition implemented)
- Advanced language features
- Optimization passes

### Planned 🔮
- Integrated development environment
- µCOM-43 simulator/emulator
- Debugger with source-level debugging
- Library system for common functions 