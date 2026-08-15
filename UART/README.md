# UART Protocol using Verilog HDL

## Overview

This project implements a **UART (Universal Asynchronous Receiver/Transmitter)** communication system using Verilog HDL.

The design includes a **Baud Rate Generator, UART Transmitter, UART Receiver, and Top-Level UART Module**.

The project demonstrates asynchronous serial communication between digital systems, including serial data transmission and reception.

---

## 🚀 Features

- UART Transmitter (TX)
- UART Receiver (RX)
- Baud Rate Generator
- 8-bit Data Transmission
- 8-bit Data Reception
- Start Bit Detection
- Stop Bit Handling
- LSB-First Data Transmission
- Serial-to-Parallel Conversion
- Parallel-to-Serial Conversion
- TX/RX Control Logic
- Functional Simulation
- RTL Schematic

---

## 🔹 UART Frame Format

The UART frame used in this project consists of:

```text
Idle | Start | D0 | D1 | D2 | D3 | D4 | D5 | D6 | D7 | Stop | Idle
  1     0                                      1
```

Data is transmitted **LSB first**.

### Frame Components

- **Idle:** Logic `1`
- **Start Bit:** Logic `0`
- **Data:** 8 bits
- **Stop Bit:** Logic `1`

---

## 🔹 System Architecture

```text
                    ┌─────────────────────┐
                    │   Baud Generator    │
                    └──────────┬──────────┘
                               │
                               ▼
        ┌─────────────────────────────────────────┐
        │               UART System               │
        │                                         │
        │   ┌─────────────┐    ┌─────────────┐   │
TX Data ──► │ UART TX     │───►│ Serial Line │   │
        │   └─────────────┘    └──────┬──────┘   │
        │                              │          │
RX Data ◄──│ UART RX     │◄────────────┘          │
        │   └─────────────┘                       │
        └─────────────────────────────────────────┘
```

---

## 🔹 Baud Rate Generator

The Baud Rate Generator generates the timing required for UART transmission and reception.

It controls the timing of each transmitted and received bit according to the configured baud rate.

For example:

```text
System Clock
     ↓
Baud Rate Generator
     ↓
Baud Tick
     ↓
UART TX / UART RX
```

---

## 🔹 UART Transmitter

The UART Transmitter converts parallel data into a serial UART frame.

### Transmission sequence

```text
Parallel Data
     ↓
Start Bit
     ↓
8 Data Bits
     ↓
Stop Bit
     ↓
Serial TX Output
```

The transmitter sends the data **LSB first**.

---

## 🔹 UART Receiver

The UART Receiver receives the serial UART frame and converts it back into parallel data.

### Reception sequence

```text
Serial RX Input
      ↓
Start Bit Detection
      ↓
Data Bit Sampling
      ↓
8-Bit Data
      ↓
Stop Bit
      ↓
Parallel Received Data
```

---

## 🔹 Main Modules

| Module | Description |
|--------|-------------|
| `baud_generator` | Generates UART timing/baud tick |
| `uart_tx` | Converts parallel data to serial data |
| `uart_rx` | Converts serial data to parallel data |
| `uart_top` | Integrates UART TX, RX and baud generation |
| `uart_tb` | Functional verification testbench |

---

## 📂 Files

```text
UART/
├── baud_generator.v
├── uart_tx.v
├── uart_rx.v
├── uart_top.v
├── uart_tb.v
├── uart_RTL_schematic.png
├── uart_waveform.png
└── README.md
```

---

## 🔬 Verification

The UART design was functionally verified using a Verilog testbench.

The simulation verifies:

- Baud rate generation
- UART TX operation
- UART RX operation
- Start bit generation
- Data transmission
- Data reception
- LSB-first transmission
- Stop bit handling
- Correct received data

---

## 🛠️ Tools Used

- Verilog HDL
- Xilinx Vivado
- RTL Simulation
- Git
- GitHub

---

## 📚 Key Learning

Through this project, I gained practical understanding of:

- UART communication
- Asynchronous serial communication
- Baud rate generation
- TX and RX architecture
- FSM-based protocol design
- Serial-to-parallel conversion
- Parallel-to-serial conversion
- Testbench-based verification
- RTL schematic and waveform analysis

---

## 🚀 Applications

UART is commonly used in:

- Microcontroller communication
- FPGA development boards
- Embedded systems
- Debug interfaces
- Serial communication
- Device-to-device communication

---

## 🔮 Future Improvements

- Configurable baud rate
- Parameterized data width
- Parity bit support
- Multiple stop-bit configurations
- UART loopback implementation
- FIFO integration

---

## 📜 License

This project is licensed under the MIT License.
