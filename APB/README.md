# APB Protocol using Verilog HDL

## Overview

This project implements an **AMBA APB (Advanced Peripheral Bus) Master-Slave interface** using Verilog HDL.

APB is a low-complexity, low-power bus protocol designed for communication between a processor or bus master and low-bandwidth peripheral devices.

The design demonstrates APB transfer control, address and data handling, read/write operations, and peripheral response through the APB interface.

---

## 🚀 Features

- APB Master
- APB Slave
- Master-Slave Interface
- Address Transfer
- Write Data Transfer
- Read Data Transfer
- Read/Write Control
- `PSEL` Generation
- `PENABLE` Control
- `PREADY` Handling
- `PSLVERR` Response
- FSM-Based Control
- Functional Simulation
- RTL Schematic

---

## 🔹 APB Interface Signals

| Signal | Description |
|--------|-------------|
| `PCLK` | APB clock |
| `PRESETn` | Active-low reset |
| `PADDR` | Address bus |
| `PWRITE` | Write/Read control |
| `PWDATA` | Write data |
| `PRDATA` | Read data |
| `PSEL` | Slave select |
| `PENABLE` | Enable signal |
| `PREADY` | Transfer completion |
| `PSLVERR` | Transfer error indication |

---

## 🔹 APB Transfer Phases

An APB transfer consists of two main phases:

### 1. Setup Phase

During the setup phase:

- `PSEL` is asserted.
- `PENABLE` remains LOW.
- Address and control signals are valid.

```text
PSEL     ────────┐
                 └────────────
PENABLE  ────────────────┐
                         └────
PADDR    ====== ADDRESS =======
PWRITE   ====== CONTROL =======
PWDATA    ====== DATA =========
```

### 2. Access Phase

During the access phase:

- `PSEL` remains HIGH.
- `PENABLE` becomes HIGH.
- Transfer completes when `PREADY` is HIGH.

```text
PSEL     ────────┐─────────────
                 │
PENABLE  ────────┘───────┐
                         │
PREADY   ────────────────┘
```

---

## 🔄 APB Write Transfer

The basic write sequence is:

```text
IDLE
 ↓
SETUP
 ↓
ACCESS
 ↓
IDLE
```

During a write transfer:

```text
PADDR  → Address
PWDATA  → Write Data
PWRITE → 1
PSEL   → 1
PENABLE → 1
```

The transfer completes when `PREADY` is asserted.

---

## 🔄 APB Read Transfer

During a read transfer:

```text
PADDR  → Address
PWRITE → 0
PSEL   → 1
PENABLE → 1
PRDATA ← Read Data
```

The master samples `PRDATA` when the transfer completes.

---

## 🔹 APB Master Architecture

```text
              ┌──────────────────┐
              │    APB MASTER    │
              │                  │
              │   Control FSM    │
              │                  │
              │  Address/Data    │
              │    Registers     │
              └────────┬─────────┘
                       │
              APB Interface
                       │
       ┌───────────────┼────────────────┐
       │               │                │
     PADDR           PWDATA           PWRITE
     PSEL            PENABLE          PCLK
       │               │                │
       └───────────────┼────────────────┘
                       ▼
              ┌──────────────────┐
              │     APB SLAVE    │
              │                  │
              │  Address Decode  │
              │                  │
              │  Register Bank   │
              └──────────────────┘
```

---

## 🔹 APB State Machine

The APB controller operates using three primary states:

```text
          ┌───────┐
          │ IDLE  │
          └───┬───┘
              │
              ▼
          ┌────────┐
          │ SETUP  │
          └───┬────┘
              │
              ▼
          ┌────────┐
          │ ACCESS │
          └───┬────┘
              │
              ▼
            IDLE
```

If `PREADY` is LOW during the ACCESS phase, the master remains in the ACCESS state until the slave is ready.

---

## 🔬 Verification

The APB Master-Slave interface was functionally verified using a Verilog testbench.

The simulation verifies:

- APB reset operation
- Setup phase
- Access phase
- Write transfer
- Read transfer
- Address handling
- `PSEL` generation
- `PENABLE` control
- `PREADY` response
- `PRDATA` handling
- `PSLVERR` response
- Correct state transitions

---

## 📂 Files

```text
APB/
├── apb_master.v
├── apb_slave.v
├── apb_top.v
├── apb_tb.v
├── apb_RTL_schematic.png
├── apb_waveform.png
└── README.md
```

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

- AMBA APB protocol
- Master-Slave bus architecture
- Setup and Access phases
- APB signal timing
- Read and Write transfers
- Peripheral register access
- FSM-based bus control
- Handshake using `PREADY`
- Error response using `PSLVERR`
- Testbench-based verification
- RTL waveform analysis

---

## 🚀 Applications

APB is commonly used for low-bandwidth peripheral interfaces such as:

- GPIO
- UART
- Timers
- Watchdogs
- Interrupt Controllers
- Control Registers
- Peripheral Configuration Registers

---

## 🔮 Future Improvements

- Multiple APB slaves
- Address decoder
- Wait-state support
- Configurable data width
- Configurable address width
- APB register bank
- APB4 support
- APB-to-peripheral bridge

---

## 📜 License

This project is licensed under the MIT License.
