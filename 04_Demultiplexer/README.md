# 1:8 Demultiplexer

## Description
A 1:8 Demultiplexer routes a single input (`data`) to one of eight outputs based on the 3-bit select signal (`sel`). The output is enabled only when the `enable` signal is HIGH. If `enable` is LOW, all outputs remain LOW.

## Inputs
- `data` : 1-bit input data
- `enable` : Enable signal
- `sel[2:0]` : 3-bit select input

## Output
- `out[7:0]` : 8-bit output bus

## Functionality
- When `enable = 1`, the selected output receives the value of `data` while all other outputs remain 0.
- When `enable = 0`, all outputs are forced to 0.

## Truth Table

| Enable | Data | Select | Active Output |
|--------|------|--------|---------------|
| 0 | X | XXX | 00000000 |
| 1 | 0 | XXX | 00000000 |
| 1 | 1 | 000 | 00000001 |
| 1 | 1 | 001 | 00000010 |
| 1 | 1 | 010 | 00000100 |
| 1 | 1 | 011 | 00001000 |
| 1 | 1 | 100 | 00010000 |
| 1 | 1 | 101 | 00100000 |
| 1 | 1 | 110 | 01000000 |
| 1 | 1 | 111 | 10000000 |

## Files
- `demultiplexer.v` – Verilog RTL implementation
- `demultiplexer_tb.v` – Testbench
- `waveform.png` – Simulation waveform

## Simulation
The design was verified using a Verilog testbench in Vivado. The waveform confirms correct routing of the input data to the selected output when `enable` is asserted, and all outputs remain LOW when `enable` is deasserted.
