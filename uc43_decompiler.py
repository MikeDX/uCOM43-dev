#!/usr/bin/env python3
"""
µC43 Decompiler
Analyzes µCOM-43 assembly language and reconstructs µC43 high-level language
"""

import re
import sys
import argparse
from typing import List, Dict, Optional, Tuple
from dataclasses import dataclass
from enum import Enum

@dataclass
class Instruction:
    address: int
    mnemonic: str
    operands: List[str]
    comment: str
    raw_line: str

@dataclass
class Function:
    name: str
    start_addr: int
    end_addr: int
    instructions: List[Instruction]
    
class DecompilerAnalysis:
    def __init__(self):
        self.functions = []
        self.labels = {}
        self.patterns = []
        
class UC43Decompiler:
    def __init__(self):
        self.instructions = []
        self.analysis = DecompilerAnalysis()
        self.output_lines = []
        
    def parse_assembly_line(self, line: str) -> Optional[Instruction]:
        """Parse a single line of assembly into an Instruction object"""
        # Skip comments, empty lines, and directives
        line = line.strip()
        if not line or line.startswith(';') or line.startswith('    ORG'):
            return None
            
        # Extract address and instruction parts
        # Format: "    MNEMONIC operands ; address: bytes comment"
        if ';' in line:
            instr_part, comment_part = line.split(';', 1)
            comment = comment_part.strip()
            
            # Extract address from comment
            addr_match = re.search(r'([0-9A-Fa-f]{4}):', comment)
            address = int(addr_match.group(1), 16) if addr_match else 0
        else:
            instr_part = line
            comment = ""
            address = 0
            
        instr_part = instr_part.strip()
        if not instr_part:
            return None
            
        # Parse instruction and operands
        parts = instr_part.split()
        if not parts:
            return None
            
        mnemonic = parts[0]
        operands = parts[1:] if len(parts) > 1 else []
        
        # Handle operands that might have commas
        if operands and ',' in ' '.join(operands):
            operands = [op.strip() for op in ' '.join(operands).split(',')]
        
        return Instruction(address, mnemonic, operands, comment, line)
    
    def identify_function_boundaries(self):
        """Identify function boundaries in the assembly code"""
        current_function = None
        function_start = 0
        
        for i, instr in enumerate(self.instructions):
            # Look for function labels (our compiler generates func_name:)
            if ':' in instr.raw_line and 'func_' in instr.raw_line:
                # End previous function
                if current_function:
                    current_function.end_addr = self.instructions[i-1].address
                    self.analysis.functions.append(current_function)
                
                # Start new function
                func_name = instr.raw_line.split(':')[0].strip()
                current_function = Function(func_name, instr.address, 0, [])
                function_start = i
                continue
            
            # Add instruction to current function
            if current_function and instr.mnemonic:
                current_function.instructions.append(instr)
        
        # End last function
        if current_function:
            current_function.end_addr = self.instructions[-1].address
            self.analysis.functions.append(current_function)
    
    def analyze_patterns(self, instructions: List[Instruction]) -> List[str]:
        """Analyze instruction patterns and convert to high-level constructs"""
        high_level_lines = []
        i = 0
        
        while i < len(instructions):
            instr = instructions[i]
            
            # Pattern: LI n followed by LDZ and OP -> output(port, n)
            if (instr.mnemonic == 'LI' and 
                i + 2 < len(instructions) and 
                instructions[i + 1].mnemonic == 'LDZ' and 
                instructions[i + 2].mnemonic == 'OP'):
                value = instr.operands[0] if instr.operands else '0'
                port = instructions[i + 1].operands[0] if instructions[i + 1].operands else '0x0'
                high_level_lines.append(f"    output({port}, {value});")
                i += 3  # Skip LI, LDZ, and OP
                
            # Pattern: LDZ 0xX; IP -> acc = input(0xX)
            elif (instr.mnemonic == 'LDZ' and 
                  i + 1 < len(instructions) and 
                  instructions[i + 1].mnemonic == 'IP'):
                port = instr.operands[0] if instr.operands else '0x0'
                high_level_lines.append(f"    acc = input({port});")
                i += 2  # Skip both LDZ and IP
                
            # Pattern: LDZ 0xX; OP -> output(0xX, acc) (without preceding LI)
            elif (instr.mnemonic == 'LDZ' and 
                  i + 1 < len(instructions) and 
                  instructions[i + 1].mnemonic == 'OP' and
                  (i == 0 or instructions[i - 1].mnemonic != 'LI')):
                port = instr.operands[0] if instr.operands else '0x0'
                high_level_lines.append(f"    output({port}, acc);")
                i += 2  # Skip LDZ and OP
                
            # Pattern: LI n -> acc = n (standalone)
            elif instr.mnemonic == 'LI':
                value = instr.operands[0] if instr.operands else '0'
                high_level_lines.append(f"    acc = {value};")
                i += 1
                
            # Pattern: LDI 0xXX -> dp = 0xXX
            elif instr.mnemonic == 'LDI':
                value = instr.operands[0] if instr.operands else '0x00'
                high_level_lines.append(f"    dp = {value};")
                i += 1
                
            # Pattern: LDZ 0xX -> dp = 0xX (standalone)
            elif instr.mnemonic == 'LDZ':
                port = instr.operands[0] if instr.operands else '0x0'
                high_level_lines.append(f"    dp = {port};  // DPH=0, DPL={port}")
                i += 1
                
            # Pattern: S -> ram[dp] = acc
            elif instr.mnemonic == 'S':
                high_level_lines.append(f"    ram[dp] = acc;")
                i += 1
            
            # Pattern: RTS -> return;
            elif instr.mnemonic == 'RTS':
                high_level_lines.append(f"    return;")
                i += 1
                
            # Pattern: CAL address -> call function_address();
            elif instr.mnemonic == 'CAL':
                addr = instr.operands[0] if instr.operands else '0x0000'
                high_level_lines.append(f"    call {addr}();  // Call subroutine")
                i += 1
                
            # Pattern: JMP address -> goto address; 
            elif instr.mnemonic == 'JMP':
                addr = instr.operands[0] if instr.operands else '0x0000'
                high_level_lines.append(f"    goto {addr};  // Jump")
                i += 1
                
            # Fallback: Add as comment
            else:
                operand_str = ' '.join(instr.operands) if instr.operands else ''
                high_level_lines.append(f"    // {instr.mnemonic} {operand_str}")
                i += 1
        
        return high_level_lines
    
    def decompile_function(self, func: Function) -> List[str]:
        """Decompile a single function to high-level µC43 code"""
        lines = []
        
        # Extract clean function name
        func_name = func.name.replace('func_', '') if func.name.startswith('func_') else func.name
        
        # Function header
        lines.append(f"function {func_name}() {{")
        
        # Analyze and convert instructions
        high_level_instructions = self.analyze_patterns(func.instructions)
        lines.extend(high_level_instructions)
        
        # Function footer
        lines.append("}")
        lines.append("")  # Empty line between functions
        
        return lines
    
    def decompile_from_file(self, filename: str) -> List[str]:
        """Decompile assembly from a file"""
        try:
            with open(filename, 'r') as f:
                lines = f.readlines()
            return self.decompile_from_lines(lines)
        except FileNotFoundError:
            return [f"; Error: File '{filename}' not found"]
        except Exception as e:
            return [f"; Error reading file: {e}"]
    
    def decompile_from_lines(self, assembly_lines: List[str]) -> List[str]:
        """Decompile assembly from lines of text"""
        self.instructions = []
        self.output_lines = []
        
        # Parse all assembly lines
        for line in assembly_lines:
            instr = self.parse_assembly_line(line)
            if instr:
                self.instructions.append(instr)
        
        # Identify function boundaries
        self.identify_function_boundaries()
        
        # Generate decompiled header
        self.output_lines.append("// µC43 Decompiled Code")
        self.output_lines.append("// Generated from µCOM-43 assembly")
        self.output_lines.append("")
        
        # Decompile each function
        if not self.analysis.functions:
            # No functions found, treat as single block
            self.output_lines.append("function main() {")
            high_level_instructions = self.analyze_patterns(self.instructions)
            self.output_lines.extend(high_level_instructions)
            self.output_lines.append("}")
        else:
            for func in self.analysis.functions:
                func_lines = self.decompile_function(func)
                self.output_lines.extend(func_lines)
        
        return self.output_lines

def main():
    parser = argparse.ArgumentParser(description='µC43 Decompiler')
    parser.add_argument('input', help='Input assembly file')
    parser.add_argument('-o', '--output', help='Output µC43 source file')
    
    args = parser.parse_args()
    
    decompiler = UC43Decompiler()
    decompiled_code = decompiler.decompile_from_file(args.input)
    
    # Output
    if args.output:
        with open(args.output, 'w') as f:
            for line in decompiled_code:
                f.write(line + '\n')
        print(f"Decompiled to {args.output}")
    else:
        for line in decompiled_code:
            print(line)
    
    print(f"Decompilation complete: {len(decompiled_code)} lines generated")
    return 0

if __name__ == '__main__':
    sys.exit(main()) 