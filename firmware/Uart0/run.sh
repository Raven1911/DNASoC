#!/bin/bash -f

riscv32-unknown-elf-gcc -march=rv32im -mabi=ilp32 -nostdlib -nostartfiles -T linker.ld -o main.elf main.cpp uart.cpp
riscv32-unknown-elf-objcopy -O binary main.elf main.bin
python3 reverse_bytes.py
xxd -e -c 4 -g 4 -p main.bin > main.hex
riscv32-unknown-elf-objdump -d main.elf > main_disasm.s