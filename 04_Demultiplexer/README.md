# 1:8 Demultiplexer

## Description
This project implements a **1:8 Demultiplexer** in Verilog. A demultiplexer routes a single input to one of eight outputs based on the 3-bit select input. Only the selected output receives the input value, while all other outputs remain low.

## Truth Table

| Select (S2 S1 S0) | Output |
|-------------------|--------|
| 000 | Y0 = D |
| 001 | Y1 = D |
| 010 | Y2 = D |
| 011 | Y3 = D |
| 100 | Y4 = D |
| 101 | Y5 = D |
| 110 | Y6 = D |
| 111 | Y7 = D |

## Files

- `demultiplexer.v` – Verilog implementation of the 1:8 Demultiplexer
- `demultiplexer_tb.v` – Testbench for functional verification
- `waveform.png` – Simulation waveform showing correct output selection

## Tools Used

- Verilog HDL
- Xilinx Vivado Simulator

## Simulation

The testbench applies different select values while toggling the input signal. The simulation verifies that only the selected output follows the input and all other outputs remain logic 0.

