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
        """Initialize the opcode decode table with descriptions"""
        
        # Opcode descriptions extracted from dump_c.py
        opcode_descriptions = {
            0x00: "No Operation",
            0x01: "Reset Interrupt Enable F/F", 
            0x02: "Store ACC into RAM",
            0x03: "skip next on Interrupt (astro wars doesn't use interrupts)",
            0x04: "skip next on Carry F/F",
            0x05: "skip next on Timer F/F",
            0x06: "Add 6 to ACC to adjust decimal for BCD Addition",
            0x07: "Transfer ACC to DPl",
            0x08: "Add RAM to ACC, skip next on carry",
            0x09: "Add RAM and carry to ACC, store Carry F/F, skip next on carry",
            0x0A: "Add 10 to ACC to adjust decimal for BCD Subtraction", 
            0x0B: "Reset Carry F/F",
            0x0C: "skip next on ACC equals RAM",
            0x0D: "Increment ACC, skip next on carry (ACC==0)",
            0x0E: "Output ACC to port (DPl)",
            0x0F: "Decrement ACC, skip next on carry (ACC==0xF)",
            0x10: "Complement ACC",
            0x11: "Complement ACC, Increment ACC",
            0x12: "Transfer DPl to ACC",
            0x13: "Decrement DPl, skip next on carry (DPl==0xF)",
            0x14: "Reset Timer F/F, Start Timer with X",
            0x15: "Load DP with X",
            0x16: "skip next on DPl equals X",
            0x17: "skip next on ACC equals X",
            0x18: "Xor ACC with RAM",
            0x19: "Add RAM and carry to ACC, store Carry F/F",
            0x1A: "Exchange Carry F/F with Carry Save F/F",
            0x1B: "Set Carry F/F",
            0x1D: "Increment RAM, skip next on carry (RAM==0)",
            0x1E: "Output X to ports C and D",
            0x1F: "Decrement RAM, skip next on carry (RAM==0xF)",
            0x30: "Rotate ACC Right through Carry F/F",
            0x31: "Set Interrupt Enable F/F",
            0x32: "Input port (DPl) to ACC",
            0x33: "Increment DPl, skip next on carry (DPl==0)",
            0x40: "do nothing",
            0x41: "Jump to (ACC) in current page - indirect jump using ACC as index",
            0x42: "Transfer ACC to Z",
            0x43: "Transfer ACC to W", 
            0x44: "Output ACC to port E",
            0x46: "Transfer DPl to Y",
            0x47: "Transfer DPh to X",
            0x48: "Return from subroutine",
            0x49: "Return from subroutine, skip next",
            0x4A: "Exchange ACC with Z",
            0x4B: "Exchange ACC with W",
            0x4C: "do nothing",
            0x4D: "do nothing", 
            0x4E: "Exchange DPl with Y",
            0x4F: "Exchange DPh with X"
        }
        
        # Bit operation descriptions
        bit_descriptions = {
            'FBF': "skip next on NOT bit(FLAG)",
            'TAB': "skip next on bit(ACC)",
            'XM': "Exchange ACC with RAM, xor DPh with X",
            'XMD': "Exchange ACC with RAM, xor DPh with X, Decrement DPl, skip next on carry (DPl==0xF)",
            'CMB': "skip next on bit(ACC) equals bit(RAM)",
            'LM': "Load ACC with RAM, xor DPh with X", 
            'XMI': "Exchange ACC with RAM, xor DPh with X, Increment DPl, skip next on carry (DPl==0)",
            'TPB': "skip next on bit(input port (DPl))",
            'TPA': "skip next on bit(input port A)",
            'TMB': "skip next on bit(RAM)",
            'FBT': "skip next on bit(FLAG)",
            'RPB': "do nothing",
            'REB': "Reset a single bit of output port E",
            'RMB': "Reset a single bit of RAM",
            'RFB': "Reset a single bit of FLAG",
            'SPB': "do nothing",
            'SEB': "Set a single bit of output port E", 
            'SMB': "Set a single bit of RAM",
            'SFB': "Set a single bit of FLAG"
        }
        
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
            desc = opcode_descriptions.get(opcode, "Unknown operation")
            self.opcodes[opcode] = {'mnemonic': mnemonic, 'length': 1, 'format': 'none', 'description': desc}
        
        # Two-byte immediate instructions
        immediate_ops = {
            0x14: 'STM', 0x15: 'LDI', 0x16: 'CLI', 0x17: 'CI', 0x1E: 'OCD'
        }
        
        for opcode, mnemonic in immediate_ops.items():
            desc = opcode_descriptions.get(opcode, "Unknown operation")
            self.opcodes[opcode] = {'mnemonic': mnemonic, 'length': 2, 'format': 'immediate', 'description': desc}
        
        # LI instructions (0x90-0x9F)
        for i in range(16):
            self.opcodes[0x90 + i] = {'mnemonic': 'LI', 'length': 1, 'format': 'li', 'value': i, 'description': 'Load ACC with X (only first in sequence executes, rest are skipped)'}
        
        # LDZ instructions (0x80-0x8F)
        for i in range(16):
            self.opcodes[0x80 + i] = {'mnemonic': 'LDZ', 'length': 1, 'format': 'ldz', 'value': i, 'description': 'Load DPh with 0, Load DPl with X'}
        
        # Bit manipulation instructions with 2-bit operands
        bit_base_ops = {
            0x20: 'FBF', 0x24: 'TAB', 0x28: 'XM', 0x2C: 'XMD',
            0x34: 'CMB', 0x38: 'LM', 0x3C: 'XMI', 0x50: 'TPB',
            0x54: 'TPA', 0x58: 'TMB', 0x5C: 'FBT', 0x60: 'RPB',
            0x64: 'REB', 0x68: 'RMB', 0x6C: 'RFB', 0x70: 'SPB',
            0x74: 'SEB', 0x78: 'SMB', 0x7C: 'SFB'
        }
        
        for base_opcode, mnemonic in bit_base_ops.items():
            desc = bit_descriptions.get(mnemonic, "Unknown bit operation")
            for bit in range(4):
                self.opcodes[base_opcode + bit] = {
                    'mnemonic': mnemonic, 'length': 1, 'format': 'bit', 'bit': bit, 'description': desc
                }
        
        # Jump and call instructions
        # JMP (0xA0-0xA7) - 11-bit address
        for i in range(8):
            self.opcodes[0xA0 + i] = {'mnemonic': 'JMP', 'length': 2, 'format': 'addr11', 'high_bits': i, 'description': 'Jump to Address'}
        
        # CAL (0xA8-0xAF) - 11-bit address  
        for i in range(8):
            self.opcodes[0xA8 + i] = {'mnemonic': 'CAL', 'length': 2, 'format': 'addr11', 'high_bits': i, 'description': 'Call Address'}
        
        # CZP (0xB0-0xBF) - zero page call
        for i in range(16):
            self.opcodes[0xB0 + i] = {'mnemonic': 'CZP', 'length': 1, 'format': 'czp', 'page': i, 'description': 'Call Address (short)'}
        
        # JCP (0xC0-0xFF) - current page jump
        for i in range(64):
            self.opcodes[0xC0 + i] = {'mnemonic': 'JCP', 'length': 1, 'format': 'jcp', 'offset': i, 'description': 'Jump to Address in current page'}
    
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
    
    def disassemble_instruction(self) -> Tuple[int, str, str]:
        """Disassemble one instruction at current PC"""
        start_pc = self.pc
        opcode = self.read_byte()
        
        if opcode not in self.opcodes:
            return start_pc, f"DB      0x{opcode:02X}", "Unknown opcode"
        
        op_info = self.opcodes[opcode]
        mnemonic = op_info['mnemonic']
        base_description = op_info.get('description', 'Unknown operation')
        
        # Generate verbose, value-specific descriptions
        if op_info['format'] == 'none':
            if mnemonic == 'S':
                description = "Store ACC into RAM at address pointed to by DP (DPH:DPL)"
            elif mnemonic == 'TAL':
                description = "Transfer ACC to DPL (lower 4 bits of data pointer)"
            elif mnemonic == 'TLA':
                description = "Transfer DPL to ACC (load ACC from lower 4 bits of data pointer)"
            elif mnemonic == 'AD':
                description = "Add RAM[DP] to ACC, skip next instruction if carry (ACC + RAM[DP] > 15)"
            elif mnemonic == 'ADS':
                description = "Add RAM[DP] and carry to ACC, store carry flag, skip next if carry"
            elif mnemonic == 'CM':
                description = "Compare ACC with RAM[DP], skip next instruction if ACC == RAM[DP]"
            elif mnemonic == 'INC':
                description = "Increment ACC (ACC = ACC + 1), skip next instruction if ACC overflows to 0"
            elif mnemonic == 'DEC':
                description = "Decrement ACC (ACC = ACC - 1), skip next instruction if ACC underflows to 15"
            elif mnemonic == 'DED':
                description = "Decrement DPL (DPL = DPL - 1), skip next instruction if DPL underflows to 15"
            elif mnemonic == 'IND':
                description = "Increment DPL (DPL = DPL + 1), skip next instruction if DPL overflows to 0"
            elif mnemonic == 'INM':
                description = "Increment RAM[DP] (RAM[DP] = RAM[DP] + 1), skip next if RAM[DP] overflows to 0"
            elif mnemonic == 'DEM':
                description = "Decrement RAM[DP] (RAM[DP] = RAM[DP] - 1), skip next if RAM[DP] underflows to 15"
            elif mnemonic == 'EXL':
                description = "XOR ACC with RAM[DP] (ACC = ACC ^ RAM[DP])"
            elif mnemonic == 'ADC':
                description = "Add RAM[DP] and carry to ACC, store carry flag (ACC = ACC + RAM[DP] + carry)"
            elif mnemonic == 'OP':
                description = "Output ACC to port specified by DPL (port[DPL] = ACC)"
            elif mnemonic == 'IP':
                description = "Input from port specified by DPL to ACC (ACC = port[DPL])"
            elif mnemonic == 'JPA':
                description = "Jump to address in current page based on ACC value (jump table: page | (ACC << 2))"
            else:
                description = base_description
            return start_pc, f"{mnemonic}", description
        
        elif op_info['format'] == 'immediate':
            operand = self.read_byte()
            if mnemonic == 'STM':
                # STM has special encoding: raw_byte - 0x80 = displayed_value
                stm_value = operand - 0x80
                description = f"Reset Timer F/F, Start Timer with 0x{stm_value:02X} ({(stm_value + 1) * 63} ticks)"
                return start_pc, f"{mnemonic} 0x{stm_value:02X}", description
            elif mnemonic == 'LDI':
                dph = (operand >> 4) & 0xF
                dpl = operand & 0xF
                description = f"Load DP with 0x{operand:02X} (DPH = 0x{dph:X}, DPL = 0x{dpl:X})"
                return start_pc, f"{mnemonic} 0x{operand:02X}", description
            elif mnemonic == 'CLI':
                value = operand & 0x0F
                description = f"Compare DPL with {value}, skip next instruction if DPL == {value}"
                return start_pc, f"{mnemonic} {value}", description
            elif mnemonic == 'CI':
                description = f"Compare ACC with 0x{operand:02X}, skip next instruction if ACC == 0x{operand:02X}"
                return start_pc, f"{mnemonic} 0x{operand:02X}", description
            elif mnemonic == 'OCD':
                port_d = (operand >> 4) & 0xF
                port_c = operand & 0xF
                description = f"Output 0x{port_d:X} to port D, 0x{port_c:X} to port C"
                return start_pc, f"{mnemonic} 0x{operand:02X}", description
        
        elif op_info['format'] == 'li':
            value = op_info['value']
            
            # Check if this LI has skip behavior
            current_addr = self.start_addr + start_pc
            
            if hasattr(self, 'li_skip_info') and current_addr in self.li_skip_info:
                info = self.li_skip_info[current_addr]
                skip_count = info['skip_count']
                resume_addr = info['resume_addr']
                
                if skip_count == 0:
                    description = f"Load ACC with 0x{value:X}"
                elif skip_count == 1:
                    description = f"Load ACC with 0x{value:X}, skip next LI instruction, resume at 0x{resume_addr:04X}"
                else:
                    description = f"Load ACC with 0x{value:X}, skip next {skip_count} LI instructions, resume at 0x{resume_addr:04X}"
            else:
                # Single LI instruction with no following LI instructions
                description = f"Load ACC with 0x{value:X}"
            
            return start_pc, f"{mnemonic} {value}", description
        
        elif op_info['format'] == 'ldz':
            value = op_info['value']
            description = f"Load DP with 0x{value:02X} (DPH = 0, DPL = 0x{value:X})"
            return start_pc, f"{mnemonic} 0x{value:X}", description
        
        elif op_info['format'] == 'bit':
            bit = op_info['bit']
            if mnemonic == 'FBF':
                description = f"Skip next instruction if FLAG bit {bit} is NOT set (FLAG & 0x{1 << bit:X} == 0)"
            elif mnemonic == 'TAB':
                description = f"Skip next instruction if ACC bit {bit} is set (ACC & 0x{1 << bit:X} != 0)"
            elif mnemonic == 'XM':
                if bit == 0:
                    description = "Exchange ACC with RAM[DP] (temp = ACC; ACC = RAM[DP]; RAM[DP] = temp)"
                else:
                    description = f"Exchange ACC with RAM[DP], XOR DPH with 0x{bit:X} (temp = ACC; ACC = RAM[DP]; RAM[DP] = temp; DPH ^= 0x{bit:X})"
            elif mnemonic == 'XMD':
                if bit == 0:
                    description = "Exchange ACC with RAM[DP], decrement DPL, skip next if DPL underflows to 15"
                else:
                    description = f"Exchange ACC with RAM[DP], XOR DPH with 0x{bit:X}, decrement DPL, skip next if DPL underflows to 15"
            elif mnemonic == 'CMB':
                description = f"Skip next instruction if ACC bit {bit} equals RAM[DP] bit {bit}"
            elif mnemonic == 'LM':
                if bit == 0:
                    description = "Load ACC with RAM[DP] (ACC = RAM[DP])"
                else:
                    description = f"Load ACC with RAM[DP], XOR DPH with 0x{bit:X} (ACC = RAM[DP]; DPH ^= 0x{bit:X})"
            elif mnemonic == 'XMI':
                if bit == 0:
                    description = "Exchange ACC with RAM[DP], increment DPL, skip next if DPL overflows to 0"
                else:
                    description = f"Exchange ACC with RAM[DP], XOR DPH with 0x{bit:X}, increment DPL, skip next if DPL overflows to 0"
            elif mnemonic == 'TPB':
                description = f"Skip next instruction if input port[DPl] bit {bit} is set (port[DPl] & 0x{1 << bit:X} != 0)"
            elif mnemonic == 'TPA':
                description = f"Skip next instruction if input port A bit {bit} is set (portA & 0x{1 << bit:X} != 0)"
            elif mnemonic == 'TMB':
                description = f"Skip next instruction if RAM[DP] bit {bit} is set (RAM[DP] & 0x{1 << bit:X} != 0)"
            elif mnemonic == 'FBT':
                description = f"Skip next instruction if FLAG bit {bit} is set (FLAG & 0x{1 << bit:X} != 0)"
            elif mnemonic == 'REB':
                description = f"Reset bit {bit} of output port E (portE &= ~0x{1 << bit:X})"
            elif mnemonic == 'RMB':
                description = f"Reset bit {bit} of RAM[DP] (RAM[DP] &= ~0x{1 << bit:X})"
            elif mnemonic == 'RFB':
                description = f"Reset bit {bit} of FLAG register (FLAG &= ~0x{1 << bit:X})"
            elif mnemonic == 'SEB':
                description = f"Set bit {bit} of output port E (portE |= 0x{1 << bit:X})"
            elif mnemonic == 'SMB':
                description = f"Set bit {bit} of RAM[DP] (RAM[DP] |= 0x{1 << bit:X})"
            elif mnemonic == 'SFB':
                description = f"Set bit {bit} of FLAG register (FLAG |= 0x{1 << bit:X})"
            else:
                description = base_description
            return start_pc, f"{mnemonic} {bit}", description
        
        elif op_info['format'] == 'addr11':
            low_byte = self.read_byte()
            address = ((op_info['high_bits'] & 0x7) << 8) | low_byte
            
            if mnemonic == 'JMP':
                description = f"Jump to absolute address 0x{address:04X}"
            elif mnemonic == 'CAL':
                description = f"Call subroutine at absolute address 0x{address:04X} (push return address to stack)"
            else:
                description = base_description
            
            # Use label if address has one, otherwise use absolute address
            if address in self.labels:
                return start_pc, f"{mnemonic} {self.labels[address]}", description
            else:
                return start_pc, f"{mnemonic} 0x{address:04X}", description
        
        elif op_info['format'] == 'jcp':
            current_page = (self.start_addr + start_pc) & 0xFC0  # Use absolute address for page calc
            address = current_page | op_info['offset']
            description = f"Jump to address 0x{address:04X} in current page (page 0x{current_page:04X} + offset 0x{op_info['offset']:02X})"
            
            # Use label if address has one, otherwise use absolute address
            if address in self.labels:
                return start_pc, f"{mnemonic} {self.labels[address]}", description
            else:
                return start_pc, f"{mnemonic} 0x{address:04X}", description
        
        elif op_info['format'] == 'czp':
            address = op_info['page'] << 2
            description = f"Call subroutine at zero page address 0x{address:04X} (page {op_info['page']} << 2)"
            
            # Use label if address has one, otherwise use absolute address
            if address in self.labels:
                return start_pc, f"CZP {self.labels[address]}", description
            else:
                return start_pc, f"CZP 0x{address:04X}", description
        
        return start_pc, f"DB      0x{opcode:02X}", "Unknown format"
    
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
        
        # Analyze instruction sequences
        self.analyze_instruction_sequences()
        
        # Add JPA targets to labels after analysis
        if hasattr(self, 'jpa_tables'):
            for addr, info in self.jpa_tables.items():
                for acc_val, target in info['targets']:
                    if self.start_addr <= target < (self.start_addr + len(self.rom_data)):
                        self.label_refs.add(target)
            
            # Generate labels for JPA targets
            for addr in self.label_refs:
                if addr not in self.labels:
                    self.generate_label(addr)
        
        # Add ORG directive to explicitly set the origin address
        self.output_lines.append(f"    ORG 0x{start_addr:04X}")
        self.output_lines.append("")  # Add blank line
        
        # Add summary of conditional instructions if found
        if hasattr(self, 'li_skip_info') and self.li_skip_info:
            self.output_lines.append("; === LI INSTRUCTION ANALYSIS ===")
            li_with_skips = [addr for addr, info in self.li_skip_info.items() if info['skip_count'] > 0]
            if li_with_skips:
                self.output_lines.append(f"; Found {len(li_with_skips)} LI instructions that skip following LI instructions")
                for addr in sorted(li_with_skips):
                    info = self.li_skip_info[addr]
                    self.output_lines.append(f";   0x{addr:04X}: skips {info['skip_count']} LI instructions, resumes at 0x{info['resume_addr']:04X}")
            else:
                self.output_lines.append("; All LI instructions are standalone (no consecutive LI sequences)")
            self.output_lines.append("")
        
        # Add JPA jump table documentation if found
        if hasattr(self, 'jpa_tables') and self.jpa_tables:
            if not (hasattr(self, 'li_skip_info') and self.li_skip_info):
                self.output_lines.append("; === INSTRUCTION SEQUENCE ANALYSIS ===")
            
            for addr, info in self.jpa_tables.items():
                self.output_lines.append(f"; JPA jump table at 0x{addr:04X} (page 0x{info['page']:04X}):")
                self.output_lines.append(f";   Jump targets based on ACC value (ACC << 2 | page):")
                
                # Show targets in groups of 4 for readability
                for i in range(0, 16, 4):
                    targets_line = ";   "
                    for j in range(4):
                        if i + j < 16:
                            acc_val, target = info['targets'][i + j]
                            targets_line += f"ACC={acc_val:X}→0x{target:04X}  "
                    self.output_lines.append(targets_line)
                
                # Check if any targets are within our ROM range and generate labels
                rom_targets = []
                for acc_val, target in info['targets']:
                    if self.start_addr <= target < (self.start_addr + len(self.rom_data)):
                        rom_targets.append((acc_val, target))
                        self.label_refs.add(target)  # Add to label references
                
                if rom_targets:
                    self.output_lines.append(f";   Targets within ROM: {len(rom_targets)} of 16")
                else:
                    self.output_lines.append(f";   No targets within current ROM range")
            self.output_lines.append("")
        
        # Second pass: disassemble with labels
        self.pc = 0
        
        while self.pc < len(self.rom_data):
            # Check if this address has a label (convert PC to absolute address)
            current_addr = self.start_addr + self.pc
            if current_addr in self.labels:
                self.output_lines.append(f"{self.labels[current_addr]}:")
            
            addr, instruction, desc = self.disassemble_instruction()
            
            # Format with address and bytes
            bytes_at_addr = []
            for i in range(addr, self.pc):
                if i < len(self.rom_data):
                    bytes_at_addr.append(f"{self.rom_data[i]:02X}")
            
            bytes_str = " ".join(bytes_at_addr)
            actual_addr = self.start_addr + addr
            
            # Check for special instruction behaviors
            special_comment = ""
            
            # Check if this is a conditional instruction
            opcode = self.rom_data[addr] if addr < len(self.rom_data) else 0
            if hasattr(self, 'conditional_opcodes') and opcode in self.conditional_opcodes:
                special_comment = f" [CONDITIONAL: {self.conditional_opcodes[opcode]}]"
            
            # Check if this is a JPA instruction
            if opcode == 0x41 and hasattr(self, 'jpa_tables') and actual_addr in self.jpa_tables:
                if not special_comment:  # Don't override other comments
                    jpa_info = self.jpa_tables[actual_addr]
                    # Count how many targets are in ROM
                    rom_targets = sum(1 for _, target in jpa_info['targets'] 
                                    if self.start_addr <= target < (self.start_addr + len(self.rom_data)))
                    special_comment = f" [INDIRECT JUMP: {rom_targets}/16 targets in ROM, see table above]"
            
            # Build the complete comment line
            comment_parts = [f"{actual_addr:04X}: {bytes_str}", desc]
            if special_comment:
                comment_parts.append(special_comment)
            
            full_comment = " ; ".join(comment_parts)
            self.output_lines.append(f"    {instruction:20s} ; {full_comment}")
        
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

    def analyze_instruction_sequences(self):
        """Analyze the ROM for special instruction sequences and conditional behaviors"""
        self.li_skip_info = {}  # Track LI instruction skip behavior
        self.conditional_skips = {}  # Track conditional instructions that skip next
        self.jpa_tables = {}  # Track JPA jump tables
        
        # Analyze each LI instruction independently - count consecutive LI instructions that follow
        pc = 0
        while pc < len(self.rom_data):
            opcode = self.rom_data[pc]
            
            # Check if this is an LI instruction
            if 0x90 <= opcode <= 0x9F:  # LI instruction
                li_addr = self.start_addr + pc
                
                # Count consecutive LI instructions that follow this one
                consecutive_li_count = 0
                check_pc = pc + 1  # Start checking from next instruction
                
                while check_pc < len(self.rom_data):
                    check_opcode = self.rom_data[check_pc]
                    if 0x90 <= check_opcode <= 0x9F:  # Another LI follows
                        consecutive_li_count += 1
                        check_pc += 1  # LI is always 1 byte
                    else:
                        break
                
                # Calculate where execution resumes after skipping
                resume_addr = self.start_addr + pc + 1 + consecutive_li_count
                
                self.li_skip_info[li_addr] = {
                    'skip_count': consecutive_li_count,
                    'resume_addr': resume_addr
                }
            
            # Skip this instruction properly based on its length
            if opcode in self.opcodes:
                pc += self.opcodes[opcode]['length']
            else:
                pc += 1  # Unknown opcode, assume 1 byte
        
        # Scan for JPA instructions and calculate their jump tables
        for i in range(len(self.rom_data)):
            if self.rom_data[i] == 0x41:  # JPA instruction
                jpa_addr = self.start_addr + i
                current_page = jpa_addr & ~0x3F  # Get current page (upper 10 bits)
                
                # Calculate all possible jump targets
                jump_targets = []
                for acc_value in range(16):
                    target_addr = current_page | (acc_value << 2)
                    jump_targets.append((acc_value, target_addr))
                
                self.jpa_tables[jpa_addr] = {
                    'targets': jump_targets,
                    'page': current_page
                }
        
        # Identify conditional instructions
        conditional_opcodes = {
            0x04: 'skip next on Carry F/F',
            0x05: 'skip next on Timer F/F', 
            0x08: 'skip next on carry',
            0x09: 'skip next on carry',
            0x0C: 'skip next on ACC equals RAM',
            0x0D: 'skip next on carry (ACC==0)',
            0x0F: 'skip next on carry (ACC==0xF)',
            0x13: 'skip next on carry (DPl==0xF)',
            0x16: 'skip next on DPl equals X',
            0x17: 'skip next on ACC equals X',
            0x1D: 'skip next on carry (RAM==0)',
            0x1F: 'skip next on carry (RAM==0xF)',
            0x33: 'skip next on carry (DPl==0)',
            0x49: 'skip next (return from subroutine)'
        }
        
        # Add bit operation conditional instructions
        for base in [0x20, 0x24, 0x2C, 0x34, 0x3C, 0x50, 0x54, 0x58, 0x5C]:
            for bit in range(4):
                opcode = base + bit
                if base == 0x20:  # FBF
                    conditional_opcodes[opcode] = f'skip next on NOT bit {bit} of FLAG'
                elif base == 0x24:  # TAB
                    conditional_opcodes[opcode] = f'skip next on bit {bit} of ACC'
                elif base == 0x2C:  # XMD
                    conditional_opcodes[opcode] = f'skip next on carry (DPl==0xF) after decrement'
                elif base == 0x34:  # CMB
                    conditional_opcodes[opcode] = f'skip next on bit {bit} of ACC equals bit {bit} of RAM'
                elif base == 0x3C:  # XMI
                    conditional_opcodes[opcode] = f'skip next on carry (DPl==0) after increment'
                elif base == 0x50:  # TPB
                    conditional_opcodes[opcode] = f'skip next on bit {bit} of input port (DPl)'
                elif base == 0x54:  # TPA
                    conditional_opcodes[opcode] = f'skip next on bit {bit} of input port A'
                elif base == 0x58:  # TMB
                    conditional_opcodes[opcode] = f'skip next on bit {bit} of RAM'
                elif base == 0x5C:  # FBT
                    conditional_opcodes[opcode] = f'skip next on bit {bit} of FLAG'
        
        self.conditional_opcodes = conditional_opcodes

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