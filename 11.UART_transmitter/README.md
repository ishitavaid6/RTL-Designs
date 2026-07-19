# UART Transmitter using Verilog HDL

## Description
This project implements a **UART (Universal Asynchronous Receiver/Transmitter) Transmitter** in Verilog HDL. The transmitter converts 8-bit parallel data into a serial data stream following the UART protocol. The design is based on a **Finite State Machine (FSM)** and includes configurable baud rate generation using a parameterized clock divider.

## Features
- FSM-based UART transmitter
- Parameterized baud rate (`CLKS_PER_BIT`)
- 8-bit data transmission (LSB first)
- Start and Stop bit generation
- `tx_busy` signal to indicate an ongoing transmission
- `tx_done` pulse upon successful transmission
- Asynchronous active-high reset
- Synthesizable Verilog RTL
- Functional verification using a testbench

## UART Frame Format

| Start Bit | Data Bits | Parity | Stop Bit |
|-----------|-----------|--------|----------|
| 0 | D0 – D7 (LSB First) | None | 1 |

**Frame Configuration:** **8N1**
- 8 Data Bits
- No Parity
- 1 Stop Bit

## Parameters

| Parameter | Description |
|-----------|-------------|
| `CLKS_PER_BIT` | Number of clock cycles per UART bit (Default: 5208 for 50 MHz clock and 9600 baud) |

## Inputs

| Signal | Description |
|--------|-------------|
| `clk` | System clock |
| `rst` | Active-high asynchronous reset |
| `tx_start` | Starts data transmission |
| `tx_data[7:0]` | 8-bit parallel input data |

## Outputs

| Signal | Description |
|--------|-------------|
| `tx` | UART serial transmit output |
| `tx_busy` | Indicates transmitter is busy |
| `tx_done` | Pulses HIGH after transmission completes |

## FSM States

- **IDLE** – Waits for transmission request.
- **START** – Transmits the start bit (`0`).
- **DATA** – Serially transmits the 8-bit data (LSB first).
- **STOP** – Transmits the stop bit (`1`) and returns to the IDLE state.

## Files

- `uart_tx.v` – UART transmitter RTL implementation
- `uart_tx_tb.v` – Testbench
- `waveform.png` – Simulation waveform

## Tools Used

- Verilog HDL
- Xilinx Vivado
- Git & GitHub

## Simulation

The design was verified in Xilinx Vivado using a comprehensive testbench. The simulation confirms:
- Correct generation of the start bit
- LSB-first transmission of the 8-bit data
- Proper stop bit generation
- Accurate baud-rate timing
- Correct assertion of `tx_busy` and `tx_done` signals

## Applications

- FPGA-to-PC serial communication
- Embedded systems
- Microcontroller interfaces
- Debug and console communication
- UART-based peripheral communication
