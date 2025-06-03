#!/usr/bin/env python3
"""
ucom43 Disassembler
Converts binary ROM data back to µCOM-43 assembly language

Based on the complete instruction set analysis from the Astrowars disassembly.
"""

import sys
import argparse
from typing import Dict, List, Tuple, Optional

class UCOM43Disassembler:
    def __init__(self):
        self.opcodes = {}
        self.rom_data = bytearray()
        self.pc = 0
        self.start_addr = 0  # Add start_addr attribute
        self.output_lines = []
        self.labels = {}
        self.label_refs = set()
        self._init_opcode_table()
    
    def _init_opcode_table(self):
        """Initialize the opcode decode table"""
        # Basic single-byte instructions
        basic_ops = {
            0x00: 'NOP', 0x01: 'DI', 0x02: 'S', 0x03: 'TIT', 0x04: 'TC',
            0x05: 'TTM', 0x06: 'DAA', 0x07: 'TAL', 0x08: 'AD', 0x09: 'ADS',
            0x0A: 'DAS', 0x0B: 'CLC', 0x0C: 'CM', 0x0D: 'INC', 0x0E: 'OP',
            0x0F: 'DEC', 0x10: 'CMA', 0x11: 'CIA', 0x12: 'TLA', 0x13: 'DED',
            0x18: 'EXL', 0x19: 'ADC', 0x1A: 'XC', 0x1B: 'STC', 0x1D: 'INM',
            0x1F: 'DEM', 0x30: 'RAR', 0x31: 'EI', 0x32: 'IP', 0x33: 'IND',
            0x40: 'IA', 0x41: 'JPA', 0x42: 'TAZ', 0x43: 'TAW', 0x44: 'OE',
            0x46: 'TLY', 0x47: 'THX', 0x48: 'RT', 0x49: 'RTS', 0x4A: 'XAZ',
            0x4B: 'XAW', 0x4C: 'XLS', 0x4D: 'XHR', 0x4E: 'XLY', 0x4F: 'XHX'
        }
        
        for opcode, mnemonic in basic_ops.items():
            self.opcodes[opcode] = {'mnemonic': mnemonic, 'length': 1, 'format': 'none'}
        
        # Two-byte immediate instructions
        immediate_ops = {
            0x14: 'STM', 0x15: 'LDI', 0x16: 'CLI', 0x17: 'CI', 0x1E: 'OCD'
        }
        
        for opcode, mnemonic in immediate_ops.items():
            self.opcodes[opcode] = {'mnemonic': mnemonic, 'length': 2, 'format': 'immediate'}
        
        # LI instructions (0x90-0x9F)
        for i in range(16):
            self.opcodes[0x90 + i] = {'mnemonic': 'LI', 'length': 1, 'format': 'li', 'value': i}
        
        # LDZ instructions (0x80-0x8F)
        for i in range(16):
            self.opcodes[0x80 + i] = {'mnemonic': 'LDZ', 'length': 1, 'format': 'ldz', 'value': i}
        
        # Bit manipulation instructions with 2-bit operands
        bit_base_ops = {
            0x20: 'FBF', 0x24: 'TAB', 0x28: 'XM', 0x2C: 'XMD',
            0x34: 'CMB', 0x38: 'LM', 0x3C: 'XMI', 0x50: 'TPB',
            0x54: 'TPA', 0x58: 'TMB', 0x5C: 'FBT', 0x60: 'RPB',
            0x64: 'REB', 0x68: 'RMB', 0x6C: 'RFB', 0x70: 'SPB',
            0x74: 'SEB', 0x78: 'SMB', 0x7C: 'SFB'
        }
        
        for base_opcode, mnemonic in bit_base_ops.items():
            for bit in range(4):
                self.opcodes[base_opcode + bit] = {
                    'mnemonic': mnemonic, 'length': 1, 'format': 'bit', 'bit': bit
                }
        
        # Jump and call instructions
        # JMP (0xA0-0xA7) - 11-bit address
        for i in range(8):
            self.opcodes[0xA0 + i] = {'mnemonic': 'JMP', 'length': 2, 'format': 'addr11', 'high_bits': i}
        
        # CAL (0xA8-0xAF) - 11-bit address  
        for i in range(8):
            self.opcodes[0xA8 + i] = {'mnemonic': 'CAL', 'length': 2, 'format': 'addr11', 'high_bits': i}
        
        # CZP (0xB0-0xBF) - zero page call
        for i in range(16):
            self.opcodes[0xB0 + i] = {'mnemonic': 'CZP', 'length': 1, 'format': 'czp', 'page': i}
        
        # JCP (0xC0-0xFF) - current page jump
        for i in range(64):
            self.opcodes[0xC0 + i] = {'mnemonic': 'JCP', 'length': 1, 'format': 'jcp', 'offset': i}
    
    def read_byte(self) -> int:
        """Read a byte from ROM at current PC"""
        if self.pc >= len(self.rom_data):
            return 0
        value = self.rom_data[self.pc]
        self.pc += 1
        return value
    
    def peek_byte(self, offset: int = 0) -> int:
        """Peek at a byte without advancing PC"""
        addr = self.pc + offset
        if addr >= len(self.rom_data):
            return 0
        return self.rom_data[addr]
    
    def generate_label(self, address: int) -> str:
        """Generate a label name for an address"""
        if address in self.labels:
            return self.labels[address]
        
        # Use different prefixes for different types
        if address < 0x100:
            label = f"L{address:04X}"
        else:
            label = f"sub_{address:04X}"
        
        self.labels[address] = label
        return label
    
    def collect_labels(self):
        """First pass: collect all jump/call targets for label generation"""
        saved_pc = self.pc
        self.pc = 0
        
        while self.pc < len(self.rom_data):
            opcode = self.read_byte()
            
            if opcode in self.opcodes:
                op_info = self.opcodes[opcode]
                
                if op_info['format'] == 'addr11':
                    # JMP/CAL with 11-bit address
                    low_byte = self.read_byte()
                    address = ((op_info['high_bits'] & 0x7) << 8) | low_byte
                    # Check if address is within the ROM's address space
                    if self.start_addr <= address < (self.start_addr + len(self.rom_data)):
                        self.label_refs.add(address)
                
                elif op_info['format'] == 'jcp':
                    # JCP - current page jump
                    current_page = (self.start_addr + self.pc - 1) & 0xFC0  # Use absolute address for page calc
                    address = current_page | op_info['offset']
                    # Check if address is within the ROM's address space
                    if self.start_addr <= address < (self.start_addr + len(self.rom_data)):
                        self.label_refs.add(address)
                
                elif op_info['format'] == 'czp':
                    # CZP - zero page call
                    address = op_info['page'] << 2  # Multiply by 4 for 4-byte addressing
                    # Check if address is within the ROM's address space
                    if self.start_addr <= address < (self.start_addr + len(self.rom_data)):
                        self.label_refs.add(address)
                
                elif op_info['length'] == 2:
                    # Skip operand byte
                    self.read_byte()
        
        # Generate labels for all referenced addresses within ROM
        for addr in self.label_refs:
            self.generate_label(addr)
        
        self.pc = saved_pc
    
    def disassemble_instruction(self) -> Tuple[int, str]:
        """Disassemble one instruction at current PC"""
        start_pc = self.pc
        opcode = self.read_byte()
        
        if opcode not in self.opcodes:
            return start_pc, f"DB      0x{opcode:02X}        ; Unknown opcode"
        
        op_info = self.opcodes[opcode]
        mnemonic = op_info['mnemonic']
        
        if op_info['format'] == 'none':
            return start_pc, f"{mnemonic}"
        
        elif op_info['format'] == 'immediate':
            operand = self.read_byte()
            if mnemonic == 'STM':
                # STM has special encoding: raw_byte - 0x80 = displayed_value
                stm_value = operand - 0x80
                return start_pc, f"{mnemonic} 0x{stm_value:02X}"
            elif mnemonic in ['CLI', 'CI']:
                return start_pc, f"{mnemonic} {operand & 0x0F}"
            else:
                return start_pc, f"{mnemonic} 0x{operand:02X}"
        
        elif op_info['format'] == 'li':
            return start_pc, f"{mnemonic} {op_info['value']}"
        
        elif op_info['format'] == 'ldz':
            return start_pc, f"{mnemonic} 0x{op_info['value']:X}"
        
        elif op_info['format'] == 'bit':
            return start_pc, f"{mnemonic} {op_info['bit']}"
        
        elif op_info['format'] == 'addr11':
            low_byte = self.read_byte()
            address = ((op_info['high_bits'] & 0x7) << 8) | low_byte
            # Use label if address has one, otherwise use absolute address
            if address in self.labels:
                return start_pc, f"{mnemonic} {self.labels[address]}"
            else:
                return start_pc, f"{mnemonic} 0x{address:04X}"
        
        elif op_info['format'] == 'jcp':
            current_page = (self.start_addr + start_pc) & 0xFC0  # Use absolute address for page calc
            address = current_page | op_info['offset']
            # Use label if address has one, otherwise use absolute address
            if address in self.labels:
                return start_pc, f"{mnemonic} {self.labels[address]}"
            else:
                return start_pc, f"{mnemonic} 0x{address:04X}"
        
        elif op_info['format'] == 'czp':
            address = op_info['page'] << 2
            # Use label if address has one, otherwise use absolute address
            if address in self.labels:
                return start_pc, f"CZP {self.labels[address]}"
            else:
                return start_pc, f"CZP 0x{address:04X}"
        
        return start_pc, f"DB      0x{opcode:02X}        ; Unknown format"
    
    def disassemble(self, rom_data: bytes, start_addr: int = 0) -> List[str]:
        """Disassemble ROM data to assembly language"""
        self.rom_data = bytearray(rom_data)
        self.pc = 0  # Always start PC at 0 for relative addressing
        self.start_addr = start_addr  # Store start address separately
        self.output_lines = []
        self.labels = {}
        self.label_refs = set()
        
        # First pass: collect labels
        self.collect_labels()
        
        # Add ORG directive to explicitly set the origin address
        self.output_lines.append(f"    ORG 0x{start_addr:04X}")
        self.output_lines.append("")  # Add blank line
        
        # Second pass: disassemble with labels
        self.pc = 0
        
        while self.pc < len(self.rom_data):
            # Check if this address has a label (convert PC to absolute address)
            current_addr = self.start_addr + self.pc
            if current_addr in self.labels:
                self.output_lines.append(f"{self.labels[current_addr]}:")
            
            addr, instruction = self.disassemble_instruction()
            
            # Format with address and bytes
            bytes_at_addr = []
            for i in range(addr, self.pc):
                if i < len(self.rom_data):
                    bytes_at_addr.append(f"{self.rom_data[i]:02X}")
            
            bytes_str = " ".join(bytes_at_addr)
            actual_addr = self.start_addr + addr
            self.output_lines.append(f"    {instruction:20s} ; {actual_addr:04X}: {bytes_str}")
        
        return self.output_lines
    
    def disassemble_file(self, filename: str, start_addr: int = 0) -> List[str]:
        """Disassemble a ROM file"""
        try:
            with open(filename, 'rb') as f:
                rom_data = f.read()
            return self.disassemble(rom_data, start_addr)
        except FileNotFoundError:
            return [f"; Error: File '{filename}' not found"]
        except Exception as e:
            return [f"; Error reading file: {e}"]

def main():
    parser = argparse.ArgumentParser(description='ucom43 Disassembler')
    parser.add_argument('input', help='Input ROM file')
    parser.add_argument('-o', '--output', help='Output assembly file')
    parser.add_argument('-s', '--start', type=lambda x: int(x,0), default=0, 
                       help='Start address (default: 0)')
    parser.add_argument('-e', '--end', type=lambda x: int(x,0), 
                       help='End address (default: end of file)')
    
    args = parser.parse_args()
    
    disassembler = UCOM43Disassembler()
    
    # Read ROM file
    try:
        with open(args.input, 'rb') as f:
            rom_data = f.read()
    except FileNotFoundError:
        print(f"Error: File '{args.input}' not found")
        return 1
    except Exception as e:
        print(f"Error reading file: {e}")
        return 1
    
    # Limit to specified range
    if args.end:
        rom_data = rom_data[args.start:args.end]
        start_addr = args.start
    else:
        rom_data = rom_data[args.start:]
        start_addr = args.start
    
    # Disassemble
    assembly_lines = disassembler.disassemble(rom_data, start_addr)
    
    # Output
    if args.output:
        with open(args.output, 'w') as f:
            f.write("; ucom43 Disassembly\n")
            f.write(f"; Source: {args.input}\n")
            f.write(f"; Start: 0x{start_addr:04X}\n")
            f.write(f"; Length: {len(rom_data)} bytes\n\n")
            
            for line in assembly_lines:
                f.write(line + '\n')
        
        print(f"Disassembly written to {args.output}")
    else:
        for line in assembly_lines:
            print(line)
    
    print(f"Disassembly complete: {len(assembly_lines)} lines generated")
    return 0

if __name__ == '__main__':
    sys.exit(main()) 