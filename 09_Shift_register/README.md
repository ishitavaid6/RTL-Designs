# 4-bit Shift Register using Verilog HDL

## Description
A **4-bit Shift Register** is a sequential circuit that stores and shifts data by one bit on each clock pulse. It is widely used for serial-to-parallel conversion, data storage, and digital communication applications.

## Inputs
- `clk` – Clock input
- `reset` – Reset signal
- `serial_in` – Serial data input

## Output
- `q[3:0]` – Shift register output

## Features
- Sequential RTL implementation
- Positive-edge triggered operation
- Serial data shifting
- Synthesizable Verilog design
- Functional verification using a testbench

## Files
- `shift_register.v` – RTL implementation
- `shift_register_tb.v` – Testbench
- `waveform.png` – Simulation waveform

## Applications
- Serial-to-parallel conversion
- Parallel-to-serial conversion
- Data buffering
- Delay elements
- Digital communication systems

## Tools Used
- Verilog HDL
- Xilinx Vivado
- Git & GitHub

## Simulation
The testbench applies serial input data over multiple clock cycles and verifies correct shifting of data through the register.
