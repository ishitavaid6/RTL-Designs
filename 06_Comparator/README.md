# 4-bit Comparator using Verilog HDL

## Description
A **4-bit Comparator** is a combinational logic circuit that compares two 4-bit binary numbers and determines their relationship. The circuit generates one of three outputs indicating whether the first input is greater than, less than, or equal to the second input.

## Inputs
- `A[3:0]` – First 4-bit input
- `B[3:0]` – Second 4-bit input

## Outputs
- `A_gt_B` – HIGH when A > B
- `A_lt_B` – HIGH when A < B
- `A_eq_B` – HIGH when A = B

## Features
- RTL implementation in Verilog HDL
- Pure combinational logic
- Synthesizable design
- Functional verification using a testbench
- Simulation waveform included

## Files
- `comparator.v` – RTL implementation
- `comparator_tb.v` – Testbench
- `waveform.png` – Simulation waveform

## Applications
- Arithmetic Logic Units (ALUs)
- CPUs and Processors
- Sorting Circuits
- Address Comparison
- Digital Control Systems

## Tools Used
- Verilog HDL
- Xilinx Vivado
- Git & GitHub

## Simulation
The testbench verifies all comparison conditions (A > B, A < B, and A = B) using different input combinations. The waveform confirms correct comparator functionality.
