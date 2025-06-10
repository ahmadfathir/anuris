# Anuris Wordlist Generator  
*Powerful wordlist generation tool inspired by Crunch*

## Table of Contents
- [Introduction](#introduction)
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
  - [Basic Wordlist Generation](#basic-wordlist-generation)
  - [Pattern-Based Generation](#pattern-based-generation)
  - [File-Based Generation](#file-based-generation)
  - [Dictionary-Based Generation](#dictionary-based-generation)
- [Advanced Options](#advanced-options)
- [Examples](#examples)
- [Limitations](#limitations)
- [License](#license)

## Introduction

Anuris Wordlist Generator (named after the Egyptian god Anhur, deity of war and hunting) is a powerful bash-based tool for creating custom wordlists. Designed as an alternative to Crunch, it provides an intuitive interface with additional features for penetration testers, security researchers, and password crackers.

## Features

- Multiple generation modes:
  - Basic character combinations
  - Advanced pattern matching
  - File-based transformations
  - Dictionary manipulations
- Customizable output formats
- Memory and CPU management options
- Cross-platform compatibility (any system with Bash)
- Open source (GPLv3 licensed)

## Installation

1. **Download the script**:
   ```bash
   wget https://example.com/anuris.sh
   ```

2. **Make it executable**:
   ```bash
   chmod +x anuris.sh
   ```

3. **Optional**: Install system dictionary (for dictionary mode):
   ```bash
   sudo apt install wamerican  # For Debian/Ubuntu
   ```

## Usage

Run the tool with:
```bash
./anuris.sh
```

### Basic Wordlist Generation
Creates wordlists from character sets with specified length ranges.

Example:
```
Min length: 4
Max length: 6
Characters: abc123
Output file: mywordlist.txt
```

### Pattern-Based Generation
Generate wordlists using pattern syntax:

- `@` = lowercase letters
- `,` = uppercase letters
- `%` = numbers
- `^` = symbols

Example pattern: `@%%2023` generates:
```
a002023
b002023
...
z992023
```

### File-Based Generation
Transform existing wordlists by:
- Adding prefixes/suffixes
- Combining words
- Case variations

### Dictionary-Based Generation
Leverages system dictionaries (/usr/share/dict/words) to create:
- Length-filtered wordlists
- Case variations
- Number-appended words

## Advanced Options

1. **Memory Limits**: Control RAM usage for large generations
2. **CPU Cores**: Specify processor cores to use
3. **Output Compression**: Automatically gzip output files

## Examples

1. Generate all 6-character lowercase + number combinations:
   ```
   Min: 6
   Max: 6
   Chars: abcdefghijklmnopqrstuvwxyz0123456789
   ```

2. Create password variations from a base word:
   ```
   Base word: password
   Options: Add numbers (0-999), case variations
   ```

3. Generate all possible 8-character passwords with special chars:
   ```
   Pattern: @%%%^^^
   ```

## Limitations

- Large character sets/lengths may produce huge files
- Pattern complexity affects generation time
- Requires sufficient disk space for output

---

*Anuris Wordlist Generator - For educational and authorized testing purposes only.*
