# µCOM-43/µC43 Examples

This directory contains example programs demonstrating the µCOM-43 instruction set and µC43 high-level language.

## Assembly Examples

### blink.s
Simple LED blinker that toggles all LEDs on port E with timer delays.

**Features demonstrated:**
- Basic I/O operations (`LDZ`, `OP`)
- Timer usage (`STM`, `TTM`)
- Loops (`JCP`, `JMP`)
- Load immediate (`LI`)

**To assemble and run:**
```bash
python3 ../ucom43_assembler.py -o blink.bin blink.s
python3 ../ucom43_disassembler.py blink.bin  # Verify
```

### counter.s
Displays an incrementing counter on port E.

**Features demonstrated:**
- Memory operations (`S`, `LM`, `INM`)
- Data pointer usage (`LDZ`)
- Skip instructions (`INM` skips on overflow)
- RAM storage and retrieval

**To assemble and run:**
```bash
python3 ../ucom43_assembler.py -o counter.bin counter.s
python3 ../ucom43_disassembler.py counter.bin
```

## µC43 High-Level Examples

### hello.uc43
Basic µC43 program demonstrating language features.

**Features demonstrated:**
- Function definitions
- Variable assignments (`acc`, `dp`, `ram[dp]`)
- I/O functions (`input()`, `output()`)
- Control flow (`while`, `return`)
- Comments and basic syntax

**To compile (when compiler is complete):**
```bash
python3 ../uc43_compiler.py -o hello.s hello.uc43
python3 ../ucom43_assembler.py -o hello.bin hello.s
```

## Running Examples

### Prerequisites
- Python 3.6 or higher
- µCOM-43 toolchain in parent directory

### Basic Usage
1. **Assemble** assembly files to binary:
   ```bash
   python3 ../ucom43_assembler.py -o output.bin source.s
   ```

2. **Disassemble** binary files for verification:
   ```bash
   python3 ../ucom43_disassembler.py output.bin
   ```

3. **Compile** µC43 files (when available):
   ```bash
   python3 ../uc43_compiler.py -o output.s source.uc43
   ```

### Testing Hardware
These examples are designed for the µCOM-43 microprocessor with:
- **Port E**: LED output (4-bit)
- **Port A**: Input (4-bit)
- **RAM**: Internal 4-bit × 64 nibbles
- **Timer**: Internal timer with overflow flag

### Simulation
To test without hardware:
1. Use the disassembler to verify correct assembly
2. Trace through instruction execution manually
3. Use debugging features in the assembler listings

## Educational Value

These examples demonstrate:
- **µCOM-43 architecture** - 4-bit operations, paged memory
- **Assembly programming** - Low-level control, optimization
- **High-level abstraction** - µC43 language features
- **Development workflow** - Compile, assemble, disassemble, debug

## Contributing Examples

When adding new examples:
1. **Document thoroughly** - Comments and README entries
2. **Test completely** - Assemble and verify output
3. **Follow patterns** - Consistent style and structure
4. **Start simple** - Build complexity gradually

### Suggested Examples
- **Arithmetic operations** - Addition, subtraction, BCD
- **Bit manipulation** - Flag operations, port control
- **Subroutines** - CAL/RTS usage, parameter passing
- **Jump tables** - JPA indirect jumps, state machines
- **Interrupt handling** - Timer interrupts, I/O response 