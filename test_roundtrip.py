#!/usr/bin/env python3
"""
Round-trip test for µCOM-43 toolchain
Tests: ROM -> Disassembly -> Assembly -> ROM -> Binary Diff

This validates the accuracy of our disassembler and assembler working together.
"""

import sys
import os
import subprocess
import argparse
from typing import Tuple, List
from ucom43_disassembler import UCOM43Disassembler
from ucom43_assembler import UCOM43Assembler

def run_command(cmd: List[str]) -> Tuple[int, str, str]:
    """Run a command and return exit code, stdout, stderr"""
    try:
        result = subprocess.run(cmd, capture_output=True, text=True)
        return result.returncode, result.stdout, result.stderr
    except Exception as e:
        return 1, "", str(e)

def binary_diff(file1: str, file2: str) -> Tuple[bool, List[str]]:
    """Compare two binary files and return differences"""
    try:
        with open(file1, 'rb') as f1, open(file2, 'rb') as f2:
            data1 = f1.read()
            data2 = f2.read()
        
        differences = []
        max_len = max(len(data1), len(data2))
        
        if len(data1) != len(data2):
            differences.append(f"Size difference: {len(data1)} vs {len(data2)} bytes")
        
        for i in range(max_len):
            byte1 = data1[i] if i < len(data1) else None
            byte2 = data2[i] if i < len(data2) else None
            
            if byte1 != byte2:
                byte1_str = f"0x{byte1:02X}" if byte1 is not None else "EOF"
                byte2_str = f"0x{byte2:02X}" if byte2 is not None else "EOF"
                differences.append(f"Offset 0x{i:04X}: {byte1_str} vs {byte2_str}")
        
        return len(differences) == 0, differences
    except Exception as e:
        return False, [f"Error comparing files: {e}"]

def hex_dump_section(data: bytes, start: int, length: int = 16) -> str:
    """Create a hex dump of a section of data"""
    lines = []
    for i in range(0, length, 16):
        if start + i >= len(data):
            break
        
        addr = start + i
        end = min(addr + 16, len(data))
        hex_bytes = ' '.join(f'{data[j]:02X}' for j in range(addr, end))
        ascii_chars = ''.join(chr(data[j]) if 32 <= data[j] <= 126 else '.' 
                             for j in range(addr, end))
        lines.append(f"{addr:04X}: {hex_bytes:<48} {ascii_chars}")
    
    return '\n'.join(lines)

def test_roundtrip(rom_file: str, start_addr: int = 0, length: int = None, test_name: str = "test") -> bool:
    """Perform complete round-trip test"""
    
    print(f"=" * 60)
    print(f"Round-trip Test: {test_name}")
    print(f"=" * 60)
    
    # Step 1: Read original ROM
    print(f"\n1. Reading original ROM: {rom_file}")
    try:
        with open(rom_file, 'rb') as f:
            original_rom = f.read()
    except Exception as e:
        print(f"Error reading ROM: {e}")
        return False
    
    # Limit to specified range if given
    if length:
        test_rom = original_rom[start_addr:start_addr + length]
        print(f"   Testing subset: 0x{start_addr:04X} to 0x{start_addr + length:04X} ({length} bytes)")
    else:
        test_rom = original_rom[start_addr:]
        print(f"   Testing from 0x{start_addr:04X} to end ({len(test_rom)} bytes)")
    
    # Save test ROM section
    test_rom_file = f"{test_name}_original.rom"
    with open(test_rom_file, 'wb') as f:
        f.write(test_rom)
    print(f"   Saved test section to: {test_rom_file}")
    
    # Step 2: Disassemble ROM to assembly
    print(f"\n2. Disassembling ROM to assembly...")
    disassembler = UCOM43Disassembler()
    assembly_lines = disassembler.disassemble(test_rom, start_addr)
    
    asm_file = f"{test_name}_disassembled.asm"
    with open(asm_file, 'w') as f:
        f.write("; Round-trip test disassembly\n")
        f.write(f"; Original ROM: {rom_file}\n")
        f.write(f"; Test range: 0x{start_addr:04X} - 0x{start_addr + len(test_rom):04X}\n")
        f.write(f"; Size: {len(test_rom)} bytes\n\n")
        for line in assembly_lines:
            f.write(line + '\n')
    
    print(f"   Generated {len(assembly_lines)} lines of assembly")
    print(f"   Saved to: {asm_file}")
    
    # Step 3: Reassemble assembly to ROM
    print(f"\n3. Reassembling assembly to ROM...")
    assembler = UCOM43Assembler()
    
    try:
        regenerated_rom, errors = assembler.assemble_file(asm_file)
        
        if errors:
            print("   Assembly errors:")
            for error in errors:
                print(f"     {error}")
            return False
        
        regenerated_rom_file = f"{test_name}_regenerated.rom"
        with open(regenerated_rom_file, 'wb') as f:
            f.write(bytes(regenerated_rom))
        
        print(f"   Generated {len(regenerated_rom)} bytes")
        print(f"   Saved to: {regenerated_rom_file}")
        
    except Exception as e:
        print(f"   Assembly failed: {e}")
        return False
    
    # Step 4: Binary comparison
    print(f"\n4. Comparing original vs regenerated ROM...")
    is_identical, differences = binary_diff(test_rom_file, regenerated_rom_file)
    
    if is_identical:
        print("   ✅ SUCCESS: Files are identical!")
        print("   Round-trip test PASSED")
        success = True
    else:
        print("   ❌ FAILURE: Files differ")
        print(f"   Found {len(differences)} differences:")
        
        # Show first 10 differences
        for diff in differences[:10]:
            print(f"     {diff}")
        
        if len(differences) > 10:
            print(f"     ... and {len(differences) - 10} more differences")
        
        print("\n   Hex comparison (first 64 bytes):")
        print("   Original:")
        print("   " + hex_dump_section(test_rom, 0, 64).replace('\n', '\n   '))
        print("\n   Regenerated:")
        print("   " + hex_dump_section(bytes(regenerated_rom), 0, 64).replace('\n', '\n   '))
        
        success = False
    
    # Step 5: Statistics
    print(f"\n5. Test Statistics:")
    print(f"   Original size:    {len(test_rom)} bytes")
    print(f"   Regenerated size: {len(regenerated_rom)} bytes")
    print(f"   Assembly lines:   {len(assembly_lines)}")
    print(f"   Differences:      {len(differences) if not is_identical else 0}")
    
    return success

def main():
    parser = argparse.ArgumentParser(description='Round-trip test for µCOM-43 toolchain')
    parser.add_argument('rom_file', help='Input ROM file to test')
    parser.add_argument('-s', '--start', type=lambda x: int(x,0), default=0,
                       help='Start address (default: 0)')
    parser.add_argument('-l', '--length', type=lambda x: int(x,0), 
                       help='Length to test (default: all)')
    parser.add_argument('-n', '--name', default='roundtrip',
                       help='Test name prefix (default: roundtrip)')
    parser.add_argument('--quick', action='store_true',
                       help='Quick test (first 128 bytes only)')
    parser.add_argument('--comprehensive', action='store_true',
                       help='Comprehensive test (multiple sections)')
    
    args = parser.parse_args()
    
    if not os.path.exists(args.rom_file):
        print(f"Error: ROM file '{args.rom_file}' not found")
        return 1
    
    # Quick test mode
    if args.quick:
        print("Running quick round-trip test...")
        success = test_roundtrip(args.rom_file, 0, 128, "quick_test")
        return 0 if success else 1
    
    # Comprehensive test mode
    if args.comprehensive:
        print("Running comprehensive round-trip tests...")
        tests = [
            ("startup", 0, 64),      # Startup code
            ("early", 64, 128),      # Early functions  
            ("mid", 128, 256),       # Mid-range code
            ("functions", 256, 256), # More functions
        ]
        
        all_passed = True
        for test_name, start, length in tests:
            success = test_roundtrip(args.rom_file, start, length, test_name)
            all_passed = all_passed and success
            print()
        
        print("=" * 60)
        if all_passed:
            print("🎉 ALL COMPREHENSIVE TESTS PASSED!")
        else:
            print("❌ Some tests failed")
        print("=" * 60)
        
        return 0 if all_passed else 1
    
    # Single test mode
    success = test_roundtrip(args.rom_file, args.start, args.length, args.name)
    return 0 if success else 1

if __name__ == '__main__':
    sys.exit(main()) 