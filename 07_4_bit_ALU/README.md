# 4-bit Arithmetic Logic Unit (ALU) using Verilog HDL

## Description
A **4-bit Arithmetic Logic Unit (ALU)** performs arithmetic and logical operations on two 4-bit operands. The operation is selected using a control signal, making the ALU one of the fundamental components of a processor.

## Inputs
- `A[3:0]` – First operand
- `B[3:0]` – Second operand
- `sel` – Operation select signal

## Output
- `result[3:0]` – ALU output

## Operations Implemented

| Select | Operation |
|---------|-----------|
| 000 | Addition (A + B) |
| 001 | Subtraction (A - B) |
| 010 | Bitwise AND |
| 011 | Bitwise OR |
| 100 | Bitwise XOR |
| 101 | Bitwise NOT (A) |
| 110 | Logical Left Shift |
| 111 | Logical Right Shift |

> **Note:** Modify the operation table if your ALU implements different functions.

## Features
- RTL implementation in Verilog HDL
- Arithmetic and logical operations
- Synthesizable combinational design
- Functional verification using a testbench
- Simulation waveform included

## Files
- `alu.v` – RTL implementation
- `alu_tb.v` – Testbench
- `waveform.png` – Simulation waveform

## Applications
- Central Processing Units (CPUs)
- Digital Signal Processors (DSPs)
- Embedded Systems
- Microcontrollers
- Digital Arithmetic Circuits

## Tools Used
- Verilog HDL
- Xilinx Vivado
- Git & GitHub

## Simulation
The testbench verifies each ALU operation by applying multiple input combinations and select values. The waveform confirms correct execution of arithmetic and logical functions.
