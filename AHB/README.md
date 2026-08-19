# AMBA AHB-Lite Protocol using Verilog HDL

## Overview

This project implements an **AMBA AHB-Lite (Advanced High-performance Bus) Master-Slave interface** using Verilog HDL.

AHB-Lite is a high-performance on-chip bus protocol used for communication between a bus master and peripheral or memory components in SoC designs.

The project demonstrates address and data transfer, read/write operations, transfer control, and master-slave communication at the RTL level.

---

## 🚀 Features

- AHB-Lite Master
- AHB-Lite Slave
- Master-Slave Communication
- Read Transfer
- Write Transfer
- Address and Data Handling
- Transfer Control
- `HADDR` Generation
- `HWDATA` Handling
- `HRDATA` Handling
- `HWRITE` Control
- `HTRANS` Control
- `HREADY` Handshake
- `HRESP` Response
- FSM-Based Control
- Functional Simulation
- RTL Schematic

---

## 🔹 AHB-Lite Interface Signals

| Signal | Description |
|--------|-------------|
| `HCLK` | AHB clock |
| `HRESETn` | Active-low reset |
| `HADDR` | Address bus |
| `HWRITE` | Transfer direction |
| `HTRANS` | Transfer type |
| `HWDATA` | Write data |
| `HRDATA` | Read data |
| `HREADY` | Transfer completion |
| `HRESP` | Transfer response |
| `HSIZE` | Transfer size |
| `HBURST` | Burst type |

---

## 🔄 AHB Transfer

A basic AHB transfer contains an **address/control phase** followed by a **data phase**.

```text
Address / Control Phase
          ↓
       Data Phase
          ↓
      Transfer Complete
```

The master provides the address and control information, followed by write data for a write transaction or receives read data during a read transaction.

---

## 🔹 HTRANS

The `HTRANS` signal identifies the type of transfer.

| HTRANS | Description |
|--------|-------------|
| `00` | IDLE |
| `01` | BUSY |
| `10` | NONSEQ |
| `11` | SEQ |

`NONSEQ` is typically used for the first transfer of a burst or for a single transfer, while `SEQ` is used for subsequent transfers in a burst.

---

## 🔹 Write Transfer

```text
Master
  │
  ├── HADDR
  ├── HWRITE = 1
  ├── HTRANS
  └── HWDATA
          │
          ▼
      AHB SLAVE
          │
          └── HREADY / HRESP
```

The master places the address and control signals on the bus and provides write data during the data phase.

---

## 🔹 Read Transfer

```text
AHB MASTER
     │
     ├── HADDR
     ├── HWRITE = 0
     └── HTRANS
           │
           ▼
       AHB SLAVE
           │
           ├── HRDATA
           ├── HREADY
           └── HRESP
```

During a read transfer, the slave provides the requested data on `HRDATA`.

---

## 🔹 AHB-Lite Architecture

```text
             ┌───────────────────┐
             │    AHB MASTER     │
             │                   │
             │   Control FSM     │
             │   Address Logic   │
             │   Data Logic      │
             └─────────┬─────────┘
                       │
                  AHB-Lite BUS
                       │
       ┌───────────────┼────────────────┐
       │               │                │
     HADDR           HWDATA           HWRITE
     HTRANS          HREADY           HRESP
       │               │                │
       └───────────────┼────────────────┘
                       ▼
             ┌───────────────────┐
             │     AHB SLAVE     │
             │                   │
             │ Address Decode    │
             │ Register / Memory │
             │ Read Data Logic   │
             └───────────────────┘
```

---

## 🔬 Verification

The AHB-Lite Master-Slave interface was functionally verified using a Verilog testbench.

The simulation verifies:

- Reset operation
- IDLE transfer
- NONSEQ transfer
- Read transaction
- Write transaction
- Address transfer
- Write data transfer
- Read data transfer
- `HREADY` handshake
- `HRESP` response
- Correct state transitions

---

## 📂 Files

```text
AHB/
├── ahb_master.v
├── ahb_slave.v
├── ahb_top.v
├── ahb_tb.v
├── ahb_RTL_schematic.png
├── ahb_waveform.png
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

- AMBA AHB-Lite architecture
- High-performance on-chip bus communication
- Address and data phases
- AHB transfer types
- Read and write transactions
- `HTRANS` control
- `HREADY` handshake
- `HRESP` response
- Master-Slave bus architecture
- FSM-based bus control
- Functional verification
- RTL waveform analysis

---

## 🚀 Applications

AHB/AHB-Lite is commonly used in:

- SoC architectures
- Processor-to-memory communication
- High-performance peripherals
- DMA interfaces
- Embedded systems
- FPGA-based SoC designs

---

## 🔮 Future Improvements

- Burst transfer support
- Configurable transfer size
- `HSIZE` support
- `HBURST` support
- Multiple slave support
- AHB address decoder
- AHB-to-APB bridge
- AXI4-Lite interface

---

## 📜 License

This project is licensed under the MIT License.
