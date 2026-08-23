# UART (Transmitter + Receiver)

An FSM-based UART transmitter and receiver, implemented in synthesizable Verilog HDL, for asynchronous serial communication at 9600 baud using a 50 MHz system clock.

## Overview

This project implements both halves of a UART link:

- **`transmitter.v`** — serializes an 8-bit parallel input and drives it out one bit at a time, framed with a start bit and stop bit.
- **`receiver.v`** — detects an incoming start bit, samples the serial line, and reconstructs the original 8-bit byte, flagging framing errors if the frame is malformed.

Both modules are built as 4-state FSMs (`IDLE → START → DATA → STOP`) sharing the same baud-rate timing approach, so their behavior is easy to reason about together.

## Why UART needs a baud rate at all

Unlike purely internal, single-clock-domain modules, UART talks to a separate device with **no shared clock line** between transmitter and receiver. The only thing both sides can agree on ahead of time is how long one bit lasts — the baud rate. Both modules derive their bit timing from:

```
CLKS_PER_BIT = system_clock_frequency / baud_rate
            = 50,000,000 / 9600
            ≈ 5208
```

Each bit is held on the line for `CLKS_PER_BIT` clock cycles before advancing.

## Module details

### Transmitter (`transmitter.v`)

| Signal | Direction | Description |
|---|---|---|
| `clk`, `rst` | input | System clock, asynchronous reset |
| `tx_start` | input | Pulse to begin transmitting `tx_data` |
| `tx_data[7:0]` | input | Byte to transmit |
| `tx` | output | Serial output line |
| `tx_busy` | output | High while a transmission is in progress |
| `tx_done` | output | One-cycle pulse when transmission completes |

Frame format: **1 start bit (0) → 8 data bits, LSB first → 1 stop bit (1)**. Line idles high, matching standard UART convention.

### Receiver (`receiver.v`)

| Signal | Direction | Description |
|---|---|---|
| `clk`, `rst` | input | System clock, asynchronous reset |
| `rx` | input | Serial input line |
| `rx_data[7:0]` | output | Reconstructed byte, valid when `rx_done` pulses |
| `rx_done` | output | One-cycle pulse on successful frame reception |
| `rx_busy` | output | High while receiving a frame |
| `rx_error` | output | One-cycle pulse if the stop bit isn't high as expected (framing error) |

Key differences from the transmitter, since receiving is inherently harder than sending:

- **No explicit "start" command** — the receiver detects the start bit itself by watching for a falling edge on `rx`.
- **Dual-flop synchronizer on `rx`** — since `rx` is an external, asynchronous input with no relationship to this module's clock, it's passed through two flip-flops before being used anywhere in the FSM, to avoid metastability.
- **Midpoint sampling** — every bit is sampled at the midpoint of its bit period rather than at an edge, to maximize margin against timing drift between transmitter and receiver clocks.
- **False-start rejection** — if the line doesn't remain low through the midpoint of the start bit, it's treated as a glitch and the receiver returns to `IDLE` instead of proceeding.
- **Framing error detection** — if the stop bit isn't high when expected, `rx_error` asserts instead of accepting potentially corrupted data into `rx_data`.

## Verification

### Approach

The receiver is verified using a **TX→RX loopback testbench** (`rx_tx_tb`): the transmitter's output is wired directly into the receiver's input, and whatever byte is sent is expected to come back out identically. This validates both modules together against each other rather than requiring a separately hand-written reference model, and is closer to how the two modules would actually be used together in a real system.

The testbench is **self-checking** — it doesn't just wait for `rx_done`, it compares the actual received byte against the transmitted byte and reports a pass/fail verdict automatically, rather than requiring manual waveform inspection.

### Test cases

| # | Test | Purpose |
|---|---|---|
| 1 | Post-reset idle check | Confirms `tx`/`rx` start in a correct, matching idle state |
| 2 | `0xA5` | Mixed bit pattern, general functional check |
| 3 | `0x3C` | Mixed bit pattern |
| 4 | `0x00` | All-zero edge case — catches a stuck-at-1 fault that a mixed pattern could mask |
| 5 | `0xFF` | All-one edge case — catches a stuck-at-0 fault |
| 6 | `0x55` / `0xAA` | Alternating bit patterns, sent back-to-back — stresses the receiver's ability to re-arm for a new frame promptly |

### Results

```
TEST PASSED: 7 checks run, 0 mismatches
```

All directed test cases pass with the receiver correctly reconstructing every transmitted byte.

### A verification finding worth noting

Testing back-to-back frames with a near-zero gap between them caused the receiver to miss the next start bit — the receiver needs a small settle margin after completing a frame (covering its FSM's return to `IDLE` plus the 2-cycle input synchronizer delay) before it can reliably detect the next one. This is reflected in the current test spacing, and is a natural next thing to characterize precisely if pushing the design toward tighter back-to-back throughput.

## Files

```
transmitter.v      - UART transmitter RTL
receiver.v          - UART receiver RTL
receiver.md         - Receiver design notes
transmitter_tb.v   - Standalone self-checking transmitter testbench
rx_tx_tb            - Combined TX->RX loopback self-checking testbench
```

## Possible extensions

- Parity bit support (even/odd)
- Configurable data width / stop bit count
- Precise characterization of the receiver's minimum inter-frame gap
- SystemVerilog assertions for protocol-level checks (e.g. `tx_busy`/`rx_busy` never asserting simultaneously with idle-line conditions)
- Constrained-random stimulus on top of the current directed test cases
