# I²C Master using Verilog HDL

## Overview

This project implements an **I²C (Inter-Integrated Circuit) Master** using Verilog HDL.

I²C is a synchronous, two-wire serial communication protocol commonly used for communication between integrated circuits and peripheral devices.

The design uses the **SDA (Serial Data)** and **SCL (Serial Clock)** lines for communication.

---

## 🚀 Features

- I²C Master RTL Design
- Two-wire serial communication
- SDA bidirectional data line
- SCL clock generation
- START condition generation
- STOP condition generation
- 7-bit slave addressing
- Read/Write control
- Data transmission
- ACK/NACK handling
- FSM-based control
- Functional simulation
- RTL schematic

---

## 🔹 I²C Signals

I²C uses two main signals:

| Signal | Description |
|--------|-------------|
| `SDA` | Serial Data |
| `SCL` | Serial Clock |

```text
        I²C MASTER
       ┌───────────┐
       │           │
SDA ◄─►│           │◄─► SDA
       │           │
SCL ──►│           │──► SCL
       └───────────┘
             │
             ▼
       I²C SLAVE
```

Both SDA and SCL are shared between the master and slave devices.

---

## 🔹 I²C Communication Sequence

A typical I²C transaction follows:

```text
START
  ↓
7-Bit Slave Address
  ↓
R/W Bit
  ↓
ACK
  ↓
Data Byte
  ↓
ACK
  ↓
STOP
```

---

## 🔹 START Condition

A START condition occurs when:

```text
SDA:  1 ────────┐
                └──── 0
SCL:  1 ─────────────
```

SDA transitions from **HIGH to LOW while SCL is HIGH**.

---

## 🔹 STOP Condition

A STOP condition occurs when:

```text
SDA:  0 ────────┐
                └──── 1
SCL:  1 ─────────────
```

SDA transitions from **LOW to HIGH while SCL is HIGH**.

---

## 🔹 I²C Data Transfer

Data is transferred one bit at a time on the SDA line.

The data is sampled while SCL is HIGH.

```text
SCL  ──┐_┌─┐_┌─┐_┌─┐_┌──

SDA  ──D7─D6─D5─D4─D3─D2─D1─D0─ACK
```

---

## 🔹 ACK/NACK

After every 8 bits of data, the receiver provides an acknowledgment.

```text
D7 D6 D5 D4 D3 D2 D1 D0 ACK
<-------- 8 bits -------->  1 bit
```

- `ACK` indicates successful reception.
- `NACK` indicates that the receiver did not acknowledge the transfer.

---

## 🔹 I²C Master Architecture

```text
              ┌─────────────────────┐
              │     I²C MASTER      │
              │                     │
              │  Control FSM        │
              │         │           │
              │         ▼           │
              │  Address/Data       │
              │  Register           │
              │         │           │
              │         ▼           │
              │  SCL Generator      │
              └──────┬──────┬───────┘
                     │      │
                    SCL    SDA
                     │      │
                     ▼      ▼
                 I²C BUS / SLAVE
```

---

## 🔹 SDA Bidirectional Operation

The SDA line is bidirectional.

```verilog
assign sda = sda_enable ? sda_out : 1'bz;
```

When the master needs to transmit data, it drives SDA.

When the master needs to receive data or monitor ACK, SDA is released and can be driven by the slave.

---

## 🔬 Verification

The I²C Master was functionally verified using a Verilog testbench.

The simulation checks:

- START condition
- STOP condition
- Slave address transmission
- Read/Write control
- Data transmission
- ACK detection
- SCL generation
- SDA bidirectional operation
- Correct transaction sequencing

---

## 📂 Files

```text
I2C/
├── i2c_master.v
├── i2c_tb.v
├── i2c_RTL_schematic.png
├── i2c_waveform.png
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

- I²C communication protocol
- Two-wire serial communication
- SDA and SCL operation
- START and STOP conditions
- Slave addressing
- ACK/NACK handling
- Bidirectional signal control
- FSM-based protocol design
- Testbench-based verification
- RTL waveform analysis

---

## 🚀 Applications

I²C is commonly used for communication with:

- Sensors
- EEPROM
- RTC modules
- Temperature sensors
- ADC/DAC devices
- GPIO expanders
- Embedded peripherals

---

## 🔮 Future Improvements

- I²C Slave implementation
- Master-Slave integration
- Multi-byte transfers
- Repeated START support
- Clock stretching
- Configurable slave address
- Multi-master support

---

## 📜 License

This project is licensed under the MIT License.
