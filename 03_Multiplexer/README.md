# 4:1 Multiplexer (MUX)

## Overview
This project implements a **4:1 Multiplexer** in Verilog HDL.

A 4:1 multiplexer selects one of four input lines and forwards it to a single output based on the value of two select lines.

## Truth Table

| S1 | S0 | Output |
|----|----|--------|
| 0  | 0  | I0 |
| 0  | 1  | I1 |
| 1  | 0  | I2 |
| 1  | 1  | I3 |

## Files

- **mux4to1.v** – Verilog RTL design of the 4:1 multiplexer.
- **mux4to1_tb.v** – Testbench used for functional simulation.
- **waveform.png** – Simulation waveform showing correct operation.

## Tools Used

- Verilog HDL
- Xilinx Vivado Simulator

## How to Simulate

1. Open the project in Vivado.
2. Add the design and testbench files.
3. Run **Behavioral Simulation**.
4. Verify that the output follows the selected input for each select signal combination.

## Learning Outcomes

- Designed a combinational logic circuit in Verilog.
- Implemented a 4:1 multiplexer using RTL coding.
- Developed a Verilog testbench for functional verification.
- Analyzed simulation waveforms to validate design correctness.
