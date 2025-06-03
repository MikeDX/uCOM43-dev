# µC43 High-Level Language Specification

µC43 is a high-level language designed specifically for the µCOM-43 4-bit microprocessor.

## Language Features

### Data Types
- `nibble` (4-bit values: 0-15, 0x0-0xF)
- `addr` (11-bit addresses for jumps/calls)
- `port` (port identifiers)

### Variables
- `acc` - The accumulator (built-in)
- `dp` - Data pointer (DPH:DPL, built-in)
- `dph`, `dpl` - High/low parts of data pointer
- `ram[addr]` - RAM access
- `flag`, `timer_f`, `carry_f` - Status flags

### Literals
- Decimal: `0`, `1`, `15`
- Hexadecimal: `0x0`, `0x1`, `0xF`
- Binary: `0b0000`, `0b1111`

### Operators
- Arithmetic: `+`, `-`, `^` (XOR), `~` (complement)
- Comparison: `==`, `!=`
- Bit operations: `&` (AND), `|` (OR), `<<`, `>>`
- Assignment: `=`

### Control Flow
- `if (condition) { ... }`
- `if (condition) { ... } else { ... }`
- `while (condition) { ... }`
- `goto label`
- `call function()`
- `return`

### Built-in Functions
- `input(port)` - Read from input port
- `output(port, value)` - Write to output port
- `delay(ticks)` - Timer delay
- `bit_test(value, bit)` - Test bit
- `bit_set(value, bit)` - Set bit
- `bit_clear(value, bit)` - Clear bit

### Special Constructs
- `switch_acc { case 0: ...; case 1: ...; }` - Compiles to JPA
- `load_immediate(value)` - Handles LI sequences automatically

## Example Programs

### Simple LED Blinker
```uc43
function main() {
    dp = 0x30;  // Set data pointer
    
    while (true) {
        output(0xE, 0xF);    // Turn on LEDs
        delay(1000);         // Wait
        output(0xE, 0x0);    // Turn off LEDs  
        delay(1000);         // Wait
    }
}
```

### Arithmetic Example
```uc43
function add_numbers() {
    dp = 0x10;           // Point to RAM location
    acc = 5;             // Load first number
    ram[dp] = acc;       // Store in RAM
    
    acc = 3;             // Load second number
    acc = acc + ram[dp]; // Add RAM to ACC
    
    output(0xE, acc);    // Display result
}
```

### Conditional Example
```uc43
function check_input() {
    nibble input_val = input(0xA);
    
    if (input_val == 0xF) {
        output(0xE, 0x1);  // Signal high
    } else {
        output(0xE, 0x0);  // Signal low
    }
}
```

### Switch/Jump Table Example
```uc43
function state_machine() {
    nibble state = input(0xA);
    
    switch_acc (state) {
        case 0: goto state0;
        case 1: goto state1;
        case 2: goto state2;
        default: goto error;
    }
    
    state0:
        output(0xE, 0x1);
        return;
        
    state1:
        output(0xE, 0x2);
        return;
        
    state2:
        output(0xE, 0x4);
        return;
        
    error:
        output(0xE, 0xF);
        return;
}
```

## Compilation Strategy

### Register Allocation
- ACC is the primary working register
- DP (DPH:DPL) for memory addressing
- Temporary values stored in RAM when needed

### Code Generation Patterns
- Arithmetic operations use ACC as accumulator
- Memory operations through DP register
- Conditional statements use skip instructions
- Loops use conditional jumps
- Function calls use CAL/RTS instructions

### Optimizations
- Combine consecutive LI instructions where beneficial
- Use skip instructions for simple conditionals
- Optimize DP register usage for memory access patterns
- Generate efficient jump tables for switch statements 