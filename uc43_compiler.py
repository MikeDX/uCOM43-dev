#!/usr/bin/env python3
"""
µC43 Compiler
Compiles µC43 high-level language to µCOM-43 assembly language
"""

import re
import sys
import argparse
from typing import List, Dict, Optional, Tuple
from dataclasses import dataclass
from enum import Enum

class TokenType(Enum):
    # Literals
    NUMBER = "NUMBER"
    IDENTIFIER = "IDENTIFIER"
    
    # Keywords
    FUNCTION = "function"
    IF = "if"
    ELSE = "else"
    WHILE = "while"
    GOTO = "goto"
    CALL = "call"
    RETURN = "return"
    SWITCH_ACC = "switch_acc"
    CASE = "case"
    DEFAULT = "default"
    NIBBLE = "nibble"
    TRUE = "true"
    FALSE = "false"
    
    # Built-in functions
    INPUT = "input"
    OUTPUT = "output"
    DELAY = "delay"
    BIT_TEST = "bit_test"
    BIT_SET = "bit_set"
    BIT_CLEAR = "bit_clear"
    
    # Built-in variables
    ACC = "acc"
    DP = "dp"
    DPH = "dph"
    DPL = "dpl"
    RAM = "ram"
    FLAG = "flag"
    TIMER_F = "timer_f"
    CARRY_F = "carry_f"
    
    # Operators
    ASSIGN = "="
    PLUS = "+"
    MINUS = "-"
    XOR = "^"
    NOT = "~"
    AND = "&"
    OR = "|"
    EQ = "=="
    NE = "!="
    
    # Delimiters
    LPAREN = "("
    RPAREN = ")"
    LBRACE = "{"
    RBRACE = "}"
    LBRACKET = "["
    RBRACKET = "]"
    SEMICOLON = ";"
    COLON = ":"
    COMMA = ","
    
    # Special
    EOF = "EOF"
    NEWLINE = "NEWLINE"

@dataclass
class Token:
    type: TokenType
    value: str
    line: int
    column: int

class Lexer:
    def __init__(self, source: str):
        self.source = source
        self.pos = 0
        self.line = 1
        self.column = 1
        self.tokens = []
        
        self.keywords = {
            'function': TokenType.FUNCTION,
            'if': TokenType.IF,
            'else': TokenType.ELSE,
            'while': TokenType.WHILE,
            'goto': TokenType.GOTO,
            'call': TokenType.CALL,
            'return': TokenType.RETURN,
            'switch_acc': TokenType.SWITCH_ACC,
            'case': TokenType.CASE,
            'default': TokenType.DEFAULT,
            'nibble': TokenType.NIBBLE,
            'true': TokenType.TRUE,
            'false': TokenType.FALSE,
            'input': TokenType.INPUT,
            'output': TokenType.OUTPUT,
            'delay': TokenType.DELAY,
            'bit_test': TokenType.BIT_TEST,
            'bit_set': TokenType.BIT_SET,
            'bit_clear': TokenType.BIT_CLEAR,
            'acc': TokenType.ACC,
            'dp': TokenType.DP,
            'dph': TokenType.DPH,
            'dpl': TokenType.DPL,
            'ram': TokenType.RAM,
            'flag': TokenType.FLAG,
            'timer_f': TokenType.TIMER_F,
            'carry_f': TokenType.CARRY_F,
        }
    
    def current_char(self) -> Optional[str]:
        if self.pos >= len(self.source):
            return None
        return self.source[self.pos]
    
    def peek_char(self, offset: int = 1) -> Optional[str]:
        peek_pos = self.pos + offset
        if peek_pos >= len(self.source):
            return None
        return self.source[peek_pos]
    
    def advance(self):
        if self.pos < len(self.source) and self.source[self.pos] == '\n':
            self.line += 1
            self.column = 1
        else:
            self.column += 1
        self.pos += 1
    
    def skip_whitespace(self):
        while self.current_char() and self.current_char() in ' \t\r':
            self.advance()
    
    def skip_comment(self):
        if self.current_char() == '/' and self.peek_char() == '/':
            while self.current_char() and self.current_char() != '\n':
                self.advance()
    
    def read_number(self) -> str:
        start_pos = self.pos
        
        # Handle hex numbers (0x...)
        if self.current_char() == '0' and self.peek_char() == 'x':
            self.advance()  # Skip '0'
            self.advance()  # Skip 'x'
            while self.current_char() and self.current_char() in '0123456789abcdefABCDEF':
                self.advance()
        # Handle binary numbers (0b...)
        elif self.current_char() == '0' and self.peek_char() == 'b':
            self.advance()  # Skip '0'
            self.advance()  # Skip 'b'
            while self.current_char() and self.current_char() in '01':
                self.advance()
        # Handle decimal numbers
        else:
            while self.current_char() and self.current_char().isdigit():
                self.advance()
        
        return self.source[start_pos:self.pos]
    
    def read_identifier(self) -> str:
        start_pos = self.pos
        while (self.current_char() and 
               (self.current_char().isalnum() or self.current_char() == '_')):
            self.advance()
        return self.source[start_pos:self.pos]
    
    def tokenize(self) -> List[Token]:
        while self.pos < len(self.source):
            self.skip_whitespace()
            
            if not self.current_char():
                break
            
            # Skip comments
            if self.current_char() == '/' and self.peek_char() == '/':
                self.skip_comment()
                continue
            
            line, column = self.line, self.column
            char = self.current_char()
            
            # Newlines
            if char == '\n':
                self.tokens.append(Token(TokenType.NEWLINE, char, line, column))
                self.advance()
            
            # Numbers
            elif char.isdigit() or (char == '0' and self.peek_char() in 'xb'):
                number = self.read_number()
                self.tokens.append(Token(TokenType.NUMBER, number, line, column))
            
            # Identifiers and keywords
            elif char.isalpha() or char == '_':
                identifier = self.read_identifier()
                token_type = self.keywords.get(identifier, TokenType.IDENTIFIER)
                self.tokens.append(Token(token_type, identifier, line, column))
            
            # Two-character operators
            elif char == '=' and self.peek_char() == '=':
                self.tokens.append(Token(TokenType.EQ, '==', line, column))
                self.advance()
                self.advance()
            elif char == '!' and self.peek_char() == '=':
                self.tokens.append(Token(TokenType.NE, '!=', line, column))
                self.advance()
                self.advance()
            
            # Single-character tokens
            elif char == '=':
                self.tokens.append(Token(TokenType.ASSIGN, char, line, column))
                self.advance()
            elif char == '+':
                self.tokens.append(Token(TokenType.PLUS, char, line, column))
                self.advance()
            elif char == '-':
                self.tokens.append(Token(TokenType.MINUS, char, line, column))
                self.advance()
            elif char == '^':
                self.tokens.append(Token(TokenType.XOR, char, line, column))
                self.advance()
            elif char == '~':
                self.tokens.append(Token(TokenType.NOT, char, line, column))
                self.advance()
            elif char == '&':
                self.tokens.append(Token(TokenType.AND, char, line, column))
                self.advance()
            elif char == '|':
                self.tokens.append(Token(TokenType.OR, char, line, column))
                self.advance()
            elif char == '(':
                self.tokens.append(Token(TokenType.LPAREN, char, line, column))
                self.advance()
            elif char == ')':
                self.tokens.append(Token(TokenType.RPAREN, char, line, column))
                self.advance()
            elif char == '{':
                self.tokens.append(Token(TokenType.LBRACE, char, line, column))
                self.advance()
            elif char == '}':
                self.tokens.append(Token(TokenType.RBRACE, char, line, column))
                self.advance()
            elif char == '[':
                self.tokens.append(Token(TokenType.LBRACKET, char, line, column))
                self.advance()
            elif char == ']':
                self.tokens.append(Token(TokenType.RBRACKET, char, line, column))
                self.advance()
            elif char == ';':
                self.tokens.append(Token(TokenType.SEMICOLON, char, line, column))
                self.advance()
            elif char == ':':
                self.tokens.append(Token(TokenType.COLON, char, line, column))
                self.advance()
            elif char == ',':
                self.tokens.append(Token(TokenType.COMMA, char, line, column))
                self.advance()
            else:
                raise SyntaxError(f"Unexpected character '{char}' at line {line}, column {column}")
        
        self.tokens.append(Token(TokenType.EOF, '', self.line, self.column))
        return self.tokens

class Compiler:
    def __init__(self, tokens: List[Token]):
        self.tokens = tokens
        self.pos = 0
        self.current_token = self.tokens[0] if tokens else None
        self.assembly_lines = []
        self.labels = {}
        self.label_counter = 0
        self.functions = {}
        
    def error(self, message: str):
        if self.current_token:
            raise SyntaxError(f"{message} at line {self.current_token.line}, column {self.current_token.column}")
        else:
            raise SyntaxError(message)
    
    def advance(self):
        if self.pos < len(self.tokens) - 1:
            self.pos += 1
            self.current_token = self.tokens[self.pos]
    
    def expect(self, token_type: TokenType) -> Token:
        if self.current_token.type != token_type:
            self.error(f"Expected {token_type.value}, got {self.current_token.type.value}")
        token = self.current_token
        self.advance()
        return token
    
    def match(self, token_type: TokenType) -> bool:
        return self.current_token.type == token_type
    
    def generate_label(self) -> str:
        label = f"L{self.label_counter:04d}"
        self.label_counter += 1
        return label
    
    def emit(self, instruction: str):
        self.assembly_lines.append(f"    {instruction}")
    
    def emit_label(self, label: str):
        self.assembly_lines.append(f"{label}:")
    
    def emit_comment(self, comment: str):
        self.assembly_lines.append(f"    ; {comment}")
    
    def parse_value(self) -> int:
        """Parse a numeric value (decimal, hex, or binary)"""
        if self.current_token.type != TokenType.NUMBER:
            self.error("Expected number")
        
        value_str = self.current_token.value
        if value_str.startswith('0x'):
            value = int(value_str, 16)
        elif value_str.startswith('0b'):
            value = int(value_str, 2)
        else:
            value = int(value_str)
        
        self.advance()
        return value
    
    def compile_expression(self):
        """Compile expressions to assembly"""
        # Simple expression parsing for now
        if self.match(TokenType.NUMBER):
            value = self.parse_value()
            self.emit(f"LI {value & 0xF}")  # Load immediate (4-bit value)
        elif self.match(TokenType.ACC):
            self.advance()
            # ACC is already in accumulator
        elif self.match(TokenType.INPUT):
            self.advance()
            self.expect(TokenType.LPAREN)
            port = self.parse_value()
            self.expect(TokenType.RPAREN)
            self.emit(f"LDZ 0x{port:X}")  # Set DPL to port
            self.emit("IP")  # Input from port to ACC
        else:
            self.error("Unexpected expression")
    
    def compile_assignment(self):
        """Compile assignment statements"""
        if self.match(TokenType.ACC):
            self.advance()
            self.expect(TokenType.ASSIGN)
            self.compile_expression()
        elif self.match(TokenType.DP):
            self.advance()
            self.expect(TokenType.ASSIGN)
            value = self.parse_value()
            self.emit(f"LDI 0x{value:02X}")
        elif self.match(TokenType.RAM):
            self.advance()
            self.expect(TokenType.LBRACKET)
            # For now, assume DP is address
            self.expect(TokenType.DP)
            self.expect(TokenType.RBRACKET)
            self.expect(TokenType.ASSIGN)
            self.compile_expression()
            self.emit("S")  # Store ACC to RAM[DP]
        else:
            self.error("Invalid assignment target")
    
    def compile_statement(self):
        """Compile a single statement"""
        # Skip newlines
        while self.match(TokenType.NEWLINE):
            self.advance()
        
        # Return early if we hit a closing brace - this should be handled by the function compiler
        if self.match(TokenType.RBRACE):
            return False
        
        if self.match(TokenType.ACC) or self.match(TokenType.DP) or self.match(TokenType.RAM):
            self.compile_assignment()
        elif self.match(TokenType.OUTPUT):
            self.advance()
            self.expect(TokenType.LPAREN)
            port = self.parse_value()
            self.expect(TokenType.COMMA)
            # Use compile_expression instead of parse_value to support acc variable
            self.compile_expression()
            self.expect(TokenType.RPAREN)
            self.emit(f"LDZ 0x{port:X}")
            self.emit("OP")
        elif self.match(TokenType.RETURN):
            self.advance()
            self.emit("RTS")
            # Expect semicolon
            if self.match(TokenType.SEMICOLON):
                self.advance()
            return True  # Indicate that a return was compiled
        else:
            self.error("Unknown statement")
        
        # Expect semicolon
        if self.match(TokenType.SEMICOLON):
            self.advance()
        
        return False  # No return statement was compiled
    
    def compile_function(self):
        """Compile a function definition"""
        self.expect(TokenType.FUNCTION)
        name = self.expect(TokenType.IDENTIFIER).value
        self.expect(TokenType.LPAREN)
        self.expect(TokenType.RPAREN)
        self.expect(TokenType.LBRACE)
        
        # Emit function label
        self.emit_label(f"func_{name}")
        self.emit_comment(f"Function: {name}")
        
        # Track if we've seen an explicit return
        has_explicit_return = False
        
        # Compile function body
        while not self.match(TokenType.RBRACE) and not self.match(TokenType.EOF):
            if self.compile_statement():
                has_explicit_return = True
        
        self.expect(TokenType.RBRACE)
        
        # Add return only if not present
        if not has_explicit_return:
            self.emit("RTS")
        self.emit("")  # Empty line
    
    def compile(self) -> List[str]:
        """Compile the entire program"""
        self.assembly_lines.append("; µC43 Compiled Assembly")
        self.assembly_lines.append("    ORG 0x0000")
        self.assembly_lines.append("")
        
        while not self.match(TokenType.EOF):
            # Skip newlines at top level
            while self.match(TokenType.NEWLINE):
                self.advance()
            
            if self.match(TokenType.FUNCTION):
                self.compile_function()
            elif self.match(TokenType.EOF):
                break
            else:
                self.error("Expected function definition")
        
        return self.assembly_lines

def main():
    parser = argparse.ArgumentParser(description='µC43 Compiler')
    parser.add_argument('input', help='Input µC43 source file')
    parser.add_argument('-o', '--output', help='Output assembly file')
    
    args = parser.parse_args()
    
    try:
        # Read source file
        with open(args.input, 'r') as f:
            source = f.read()
        
        # Tokenize
        lexer = Lexer(source)
        tokens = lexer.tokenize()
        
        # Compile
        compiler = Compiler(tokens)
        assembly = compiler.compile()
        
        # Output
        if args.output:
            with open(args.output, 'w') as f:
                for line in assembly:
                    f.write(line + '\n')
            print(f"Compiled to {args.output}")
        else:
            for line in assembly:
                print(line)
        
    except Exception as e:
        print(f"Error: {e}", file=sys.stderr)
        return 1
    
    return 0

if __name__ == '__main__':
    sys.exit(main()) 