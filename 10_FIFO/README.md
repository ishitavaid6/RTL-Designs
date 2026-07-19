# Synchronous FIFO (First-In-First-Out)

## Overview
This project implements an 8-bit synchronous FIFO (First-In-First-Out) memory in Verilog HDL. The FIFO stores incoming data in the order it is received and outputs it in the same order. Both read and write operations are synchronized with a common clock. Status flags are generated to indicate when the FIFO is full or empty.

## Features
- 8-bit data width
- Synchronous read and write operations
- Full and Empty status flags
- Reset support
- Configurable FIFO depth
- Prevents overflow and underflow conditions

## Inputs
| Signal | Description |
|--------|-------------|
| clk | System clock |
| reset | Active-high reset |
| wr_en | Write enable |
| rd_en | Read enable |
| data_in [7:0] | Input data |

## Outputs
| Signal | Description |
|--------|-------------|
| data_out [7:0] | Output data |
| full | FIFO Full flag |
| empty | FIFO Empty flag |

## Working
- On reset, the FIFO is cleared and the Empty flag is asserted.
- When `wr_en` is high and the FIFO is not full, input data is written into the FIFO.
- When `rd_en` is high and the FIFO is not empty, the oldest stored data is read from the FIFO.
- The Full flag is asserted when the FIFO reaches its maximum capacity.
- The Empty flag is asserted when all stored data has been read.

## Simulation
The testbench verifies:
- FIFO reset operation
- Write operation
- Read operation
- Correct data transfer
- Full flag generation
- Empty flag generation

## Files
- `fifo.v` – FIFO design
- `fifo_tb.v` – Testbench
- `waveform.png` – Simulation waveform
- `README.md` – Project documentation

## Tools Used
- Verilog HDL
- Xilinx Vivado Simulator

## Applications
- UART communication
- Data buffering
- Processor pipelines
- Network packet buffering
- Embedded systems
- FPGA and ASIC designs
