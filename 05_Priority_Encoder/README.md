# 8:3 Priority Encoder(CaseX Statement)

## Description
An **8:3 Priority Encoder** is a combinational logic circuit that converts one of eight input lines into a 3-bit binary output. Unlike a standard encoder, a priority encoder gives precedence to the highest-order active input. If multiple inputs are HIGH simultaneously, the output corresponds to the highest-priority input.

This design is implemented in **Verilog HDL** using a **casex statement**, where `x` bits in the case items act as don't-care conditions, making it easier to describe priority logic.

## Truth Table

| Inputs (D7...D0) | Output (Y2 Y1 Y0) | Valid |
|------------------|-------------------|-------|
| 00000001 | 000 | 1 |
| 0000001x | 001 | 1 |
| 000001xx | 010 | 1 |
| 00001xxx | 011 | 1 |
| 0001xxxx | 100 | 1 |
| 001xxxxx | 101 | 1 |
| 01xxxxxx | 110 | 1 |
| 1xxxxxxx | 111 | 1 |
| 00000000 | 000 | 0 |

**Note:** When multiple inputs are HIGH, the encoder always outputs the binary code corresponding to the highest-priority input.

## Files
- `priority_encoder.v` – RTL implementation using `casex`
- `priority_encoder_tb.v` – Testbench
- `waveform.png` – Simulation waveform

## Tools Used
- Verilog HDL
- Xilinx Vivado
- Git & GitHub

## Simulation
The testbench verifies:
- Single active input
- Multiple active inputs
- Highest-priority input selection
- No active input condition

## Applications
- Interrupt Controllers
- Bus Arbitration
- Keyboard Encoders
- Processor Interrupt Handling
- Digital Communication Systems

