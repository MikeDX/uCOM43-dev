#!/usr/bin/env python3
"""
ucom43 Assembler/Compiler
Supports the NEC µCOM-43 (ucom43) 4-bit microprocessor instruction set

Based on analysis of the Astrowars disassembly and instruction patterns.
"""

import sys
import re
import argparse
from typing import Dict, List, Tuple, Optional, Union

class UCOM43Assembler:
    def __init__(self):
        # Initialize instruction set tables
        self.opcodes = {}
        self.labels = {}
        self.symbols = {}
        self.output = []
        self.address = 0
        self.pass_num = 1
        self.errors = []
        
        self._init_instruction_set()
    
    def _init_instruction_set(self):
        """Initialize the complete ucom43 instruction set"""
        
        # Basic operations (single byte, no arguments)
        basic_ops = {
            'NOP':  0x00,  # No operation
            'DI':   0x01,  # Disable interrupts
            'S':    0x02,  # Store ACC to RAM[dp]
            'TIT':  0x03,  # Test interrupt flag and clear
            'TC':   0x04,  # Test carry flag
            'TTM':  0x05,  # Test timer flag
            'DAA':  0x06,  # Decimal adjust accumulator
            'TAL':  0x07,  # Transfer ACC low to data pointer low
            'AD':   0x08,  # Add RAM[dp] to ACC
            'ADS':  0x09,  # Add RAM[dp] to ACC with skip on carry
            'DAS':  0x0A,  # Decimal add with skip
            'CLC':  0x0B,  # Clear carry
            'CM':   0x0C,  # Compare ACC with RAM[dp]
            'INC':  0x0D,  # Increment ACC
            'OP':   0x0E,  # Output ACC to port(dpl)
            'DEC':  0x0F,  # Decrement ACC
            'CMA':  0x10,  # Complement ACC
            'CIA':  0x11,  # Complement and increment ACC
            'TLA':  0x12,  # Transfer ACC low
            'DED':  0x13,  # Decimal decrement
            'EXL':  0x18,  # XOR ACC with RAM[dp]
            'ADC':  0x19,  # Add with carry
            'XC':   0x1A,  # Exchange carry
            'STC':  0x1B,  # Set carry
            'INM':  0x1D,  # Increment RAM[dp]
            'DEM':  0x1F,  # Decrement RAM[dp]
            'RAR':  0x30,  # Rotate ACC right through carry
            'EI':   0x31,  # Enable interrupts
            'IP':   0x32,  # Input from port(dpl) to ACC
            'IND':  0x33,  # Increment data pointer
            'IA':   0x40,  # Input from port A to ACC
            'JPA':  0x41,  # Jump to page ACC
            'TAZ':  0x42,  # Transfer ACC to Z register
            'TAW':  0x43,  # Transfer ACC to W register
            'OE':   0x44,  # Output ACC to port E
            'TLY':  0x46,  # Transfer dpl to Y register
            'THX':  0x47,  # Transfer dph to X register
            'RT':   0x48,  # Return
            'RTS':  0x49,  # Return and skip
            'XAZ':  0x4A,  # Exchange ACC with Z
            'XAW':  0x4B,  # Exchange ACC with W
            'XLS':  0x4C,  # Exchange low nibbles
            'XHR':  0x4D,  # Exchange high nibbles
            'XLY':  0x4E,  # Exchange dpl with Y
            'XHX':  0x4F,  # Exchange dph with X
        }
        
        for mnem, opcode in basic_ops.items():
            self.opcodes[mnem] = {'opcode': opcode, 'format': 'none', 'length': 1}
        
        # Instructions with immediate values
        immediate_ops = {
            'STM':  {'opcode': 0x14},  # Set timer (no mask - uses full 8-bit value)
            'LDI':  {'opcode': 0x15},  # Load immediate to data register
            'OCD':  {'opcode': 0x1E},  # Output code/data
        }
        
        # Add immediate operations with variable masks
        for mnemonic, info in immediate_ops.items():
            self.opcodes[mnemonic] = {
                'mnemonic': mnemonic, 'format': 'immediate', 
                'length': 2, 'opcode': info['opcode']}
            if 'mask' in info:
                self.opcodes[mnemonic]['mask'] = info['mask']
        
        # Special handling for CI and CLI instructions (Compare and conditional jump)
        self.opcodes['CI'] = {'opcode': 0x17, 'format': 'ci_special', 'length': 2}
        self.opcodes['CLI'] = {'opcode': 0x16, 'format': 'cli_special', 'length': 2}
        
        # LI and LDZ instructions (special handling)
        self.opcodes['LI'] = {'opcode': 0x90, 'format': 'li_variant', 'length': 1}
        self.opcodes['LDZ'] = {'opcode': 0x80, 'format': 'ldz_variant', 'length': 1}
        
        # Bit manipulation instructions (with bit field)
        bit_ops = {
            'FBF': 0x20, 'TAB': 0x24, 'XM': 0x28, 'XMD': 0x2C,
            'CMB': 0x34, 'LM': 0x38, 'XMI': 0x3C, 'TPB': 0x50,
            'TPA': 0x54, 'TMB': 0x58, 'FBT': 0x5C, 'RPB': 0x60,
            'REB': 0x64, 'RMB': 0x68, 'RFB': 0x6C, 'SPB': 0x70,
            'SEB': 0x74, 'SMB': 0x78, 'SFB': 0x7C
        }
        
        for mnem, base_opcode in bit_ops.items():
            self.opcodes[mnem] = {'opcode': base_opcode, 'format': 'bit_field', 'length': 1}
        
        # Jump and call instructions
        jump_ops = {
            'JMP': {'opcode': 0xA0, 'format': 'address11'},  # Jump 11-bit
            'CAL': {'opcode': 0xA8, 'format': 'address11'},  # Call 11-bit
            'CZP': {'opcode': 0xB0, 'format': 'page'},       # Call zero page
            'JCP': {'opcode': 0xC0, 'format': 'page'},       # Jump current page
        }
        
        for mnem, info in jump_ops.items():
            if info['format'] == 'address11':
                # JMP and CAL are 2 bytes
                self.opcodes[mnem] = {'opcode': info['opcode'], 'format': info['format'], 'length': 2}
            else:
                # JCP and CZP are 1 byte
                self.opcodes[mnem] = {'opcode': info['opcode'], 'format': info['format'], 'length': 1}
    
    def parse_line(self, line: str, line_num: int) -> Optional[Dict]:
        """Parse a single line of assembly code"""
        # Remove comments
        comment_pos = line.find(';')
        if comment_pos >= 0:
            line = line[:comment_pos]
        
        line = line.strip()
        if not line:
            return None
        
        # Check for labels
        if ':' in line:
            parts = line.split(':', 1)
            label = parts[0].strip()
            self.labels[label] = self.address
            if len(parts) > 1 and parts[1].strip():
                line = parts[1].strip()
            else:
                return None
        
        # Parse instruction
        parts = line.split()
        if not parts:
            return None
        
        mnemonic = parts[0].upper()
        operands = []
        
        # Handle ORG directive
        if mnemonic == 'ORG':
            operands = []
            if len(parts) > 1:
                operands = [parts[1]]
            return {
                'mnemonic': mnemonic,
                'operands': operands,
                'line_num': line_num,
                'address': self.address
            }
        
        if len(parts) > 1:
            # Join remaining parts and split by comma
            operand_str = ' '.join(parts[1:])
            operands = [op.strip() for op in operand_str.split(',')]
        
        return {
            'mnemonic': mnemonic,
            'operands': operands,
            'line_num': line_num,
            'address': self.address
        }
    
    def resolve_operand(self, operand: str) -> int:
        """Resolve an operand to its numeric value"""
        operand = operand.strip()
        
        # Handle different number formats
        if operand.startswith('0x') or operand.startswith('0X'):
            return int(operand, 16)
        elif operand.startswith('0b') or operand.startswith('0B'):
            return int(operand, 2)
        elif operand.startswith('$'):
            return int(operand[1:], 16)
        elif operand.startswith('%'):
            return int(operand[1:], 2)
        elif operand.isdigit():
            return int(operand)
        elif operand in self.labels:
            return self.labels[operand]
        elif operand in self.symbols:
            return self.symbols[operand]
        else:
            # Try to evaluate as expression
            try:
                return eval(operand, {"__builtins__": {}}, {**self.labels, **self.symbols})
            except:
                if self.pass_num == 2:  # Only report errors on second pass
                    self.errors.append(f"Undefined symbol: {operand}")
                return 0
    
    def assemble_instruction(self, instr: Dict) -> List[int]:
        """Assemble a single instruction"""
        mnemonic = instr['mnemonic']
        operands = instr['operands']
        
        if mnemonic not in self.opcodes:
            self.errors.append(f"Line {instr['line_num']}: Unknown instruction {mnemonic}")
            return []
        
        op_info = self.opcodes[mnemonic]
        result = []
        
        if op_info['format'] == 'none':
            # No operands
            result = [op_info['opcode']]
            
        elif op_info['format'] == 'immediate':
            if len(operands) != 1:
                self.errors.append(f"Line {instr['line_num']}: {mnemonic} requires 1 operand")
                return []
            
            value = self.resolve_operand(operands[0])
            if mnemonic == 'STM':
                # STM has special encoding: displayed_value + 0x80 = raw_byte
                value = (value + 0x80) & 0xFF
            elif 'mask' in op_info:
                value &= op_info['mask']
            result = [op_info['opcode'], value]
            
        elif op_info['format'] == 'ci_special':
            # CI instruction: Compare ACC immediate with special encoding
            if len(operands) != 1:
                self.errors.append(f"Line {instr['line_num']}: CI requires 1 operand")
                return []
            
            value = self.resolve_operand(operands[0]) & 0x0F
            # CI n encodes as 17 (C0+n)
            result = [op_info['opcode'], 0xC0 + value]
            
        elif op_info['format'] == 'cli_special':
            # CLI instruction: Compare DPL immediate with special encoding
            if len(operands) != 1:
                self.errors.append(f"Line {instr['line_num']}: CLI requires 1 operand")
                return []
            
            value = self.resolve_operand(operands[0]) & 0x0F
            # CLI n encodes as 16 (E0+n)
            result = [op_info['opcode'], 0xE0 + value]
            
        elif op_info['format'] == 'li_variant':
            # LI with immediate value
            if len(operands) != 1:
                self.errors.append(f"Line {instr['line_num']}: LI requires 1 operand")
                return []
            
            value = self.resolve_operand(operands[0]) & 0x0F
            result = [0x90 | value]
            
        elif op_info['format'] == 'ldz_variant':
            # LDZ with immediate value
            if len(operands) != 1:
                self.errors.append(f"Line {instr['line_num']}: LDZ requires 1 operand")
                return []
            
            value = self.resolve_operand(operands[0]) & 0x0F
            result = [0x80 | value]
            
        elif op_info['format'] == 'bit_field':
            # Bit manipulation with bit number
            if len(operands) != 1:
                self.errors.append(f"Line {instr['line_num']}: {mnemonic} requires 1 operand")
                return []
            
            bit_num = self.resolve_operand(operands[0]) & 0x03
            result = [op_info['opcode'] | bit_num]
            
        elif op_info['format'] == 'address11':
            # 11-bit address (JMP, CAL)
            if len(operands) != 1:
                self.errors.append(f"Line {instr['line_num']}: {mnemonic} requires 1 operand")
                return []
            
            addr = self.resolve_operand(operands[0]) & 0x7FF
            result = [op_info['opcode'] | ((addr >> 8) & 0x07), addr & 0xFF]
            
        elif op_info['format'] == 'page':
            # Page address (6-bit for JCP, 4-bit for CZP)
            if len(operands) != 1:
                self.errors.append(f"Line {instr['line_num']}: {mnemonic} requires 1 operand")
                return []
            
            addr = self.resolve_operand(operands[0])
            if mnemonic == 'JCP':
                # 6-bit offset in current page
                page_addr = addr & 0x3F
                result = [0xC0 | page_addr]
            else:  # CZP
                # 4-bit zero page address (shift right by 2 for 4-byte addressing)
                page_addr = (addr >> 2) & 0x0F
                result = [op_info['opcode'] | page_addr]
        
        return result
    
    def assemble(self, source_lines: List[str]) -> Tuple[List[int], List[str]]:
        """Assemble the source code"""
        self.errors = []
        self.labels = {}
        self.output = []
        
        # Pass 1: Collect labels and calculate addresses
        self.pass_num = 1
        self.address = 0
        instructions = []
        
        for line_num, line in enumerate(source_lines, 1):
            instr = self.parse_line(line, line_num)
            if instr:
                # Handle ORG changes in pass 1 too
                if instr['mnemonic'] == 'ORG' and len(instr['operands']) > 0:
                    self.address = self.resolve_operand(instr['operands'][0])
                    continue
                    
                instructions.append(instr)
                # Estimate instruction length
                mnemonic = instr['mnemonic']
                if mnemonic in self.opcodes:
                    self.address += self.opcodes[mnemonic]['length']
        
        # Pass 2: Generate machine code
        self.pass_num = 2
        self.address = 0
        binary_data = {}  # Address -> byte mapping
        
        for instr in instructions:
            # Handle ORG changes
            if instr['mnemonic'] == 'ORG' and len(instr['operands']) > 0:
                self.address = self.resolve_operand(instr['operands'][0])
                continue
                
            instr['address'] = self.address
            machine_code = self.assemble_instruction(instr)
            
            # Store bytes at their addresses
            for i, byte_val in enumerate(machine_code):
                binary_data[self.address + i] = byte_val
            
            self.address += len(machine_code)
        
        # Convert to sequential output
        if binary_data:
            max_addr = max(binary_data.keys())
            self.output = [0] * (max_addr + 1)
            for addr, byte_val in binary_data.items():
                self.output[addr] = byte_val
        
        return self.output, self.errors
    
    def assemble_file(self, filename: str) -> Tuple[List[int], List[str]]:
        """Assemble a source file"""
        try:
            with open(filename, 'r') as f:
                lines = f.readlines()
            return self.assemble(lines)
        except FileNotFoundError:
            return [], [f"File not found: {filename}"]
        except Exception as e:
            return [], [f"Error reading file: {e}"]

def output_binary(data: List[int], filename: str):
    """Output binary data to file"""
    with open(filename, 'wb') as f:
        f.write(bytes(data))

def output_hex(data: List[int], filename: str):
    """Output Intel hex format"""
    with open(filename, 'w') as f:
        # Simple hex dump format
        for i in range(0, len(data), 16):
            chunk = data[i:i+16]
            hex_bytes = ' '.join(f'{b:02X}' for b in chunk)
            f.write(f'{i:04X}: {hex_bytes}\n')

def output_listing(data: List[int], source_lines: List[str], filename: str):
    """Output assembly listing"""
    with open(filename, 'w') as f:
        f.write("ucom43 Assembly Listing\n")
        f.write("=" * 50 + "\n\n")
        
        addr = 0
        for line_num, line in enumerate(source_lines, 1):
            if line.strip() and not line.strip().startswith(';'):
                # Show machine code bytes
                machine_code = ""
                if addr < len(data):
                    machine_code = f"{data[addr]:02X}"
                    addr += 1
                    if addr < len(data) and len(line.split()) > 1:
                        machine_code += f" {data[addr]:02X}"
                        addr += 1
                
                f.write(f"{line_num:4d} {addr-len(machine_code.split()):04X} {machine_code:8s} {line}")
            else:
                f.write(f"{line_num:4d}                    {line}")

def main():
    parser = argparse.ArgumentParser(description='ucom43 Assembler')
    parser.add_argument('input', help='Input assembly file')
    parser.add_argument('-o', '--output', help='Output binary file')
    parser.add_argument('-l', '--listing', help='Output listing file')
    parser.add_argument('-x', '--hex', help='Output hex dump file')
    
    args = parser.parse_args()
    
    assembler = UCOM43Assembler()
    
    # Read source file
    try:
        with open(args.input, 'r') as f:
            source_lines = f.readlines()
    except FileNotFoundError:
        print(f"Error: File '{args.input}' not found")
        return 1
    except Exception as e:
        print(f"Error reading file: {e}")
        return 1
    
    # Assemble
    machine_code, errors = assembler.assemble(source_lines)
    
    # Report errors
    if errors:
        print("Assembly errors:")
        for error in errors:
            print(f"  {error}")
        return 1
    
    # Output files
    if args.output:
        output_binary(machine_code, args.output)
        print(f"Binary output written to {args.output}")
    
    if args.hex:
        output_hex(machine_code, args.hex)
        print(f"Hex output written to {args.hex}")
    
    if args.listing:
        output_listing(machine_code, source_lines, args.listing)
        print(f"Listing written to {args.listing}")
    
    print(f"Assembly complete: {len(machine_code)} bytes generated")
    return 0

if __name__ == '__main__':
    sys.exit(main()) 