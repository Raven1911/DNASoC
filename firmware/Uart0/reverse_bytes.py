# reverse_bytes.py
import sys

with open("main.bin", "rb") as f:
    data = f.read()

# Đảo byte trong từng word 32-bit
reversed_data = bytearray()
for i in range(0, len(data), 4):
    word = data[i:i+4]
    reversed_data.extend(word[::-1])

with open("main.bin", "wb") as f:
    f.write(reversed_data)