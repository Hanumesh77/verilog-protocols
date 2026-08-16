# SPI Protocol using Verilog HDL

## Overview

This project implements an **SPI (Serial Peripheral Interface)** communication system using Verilog HDL.

The design includes an **SPI Master, SPI Slave, Top-Level Integration, and Functional Verification Testbench**.

SPI is a synchronous serial communication protocol commonly used for communication between a controller and peripheral devices.

---

## 🚀 Features

- SPI Master
- SPI Slave
- Synchronous Serial Communication
- MOSI (Master Out Slave In)
- MISO (Master In Slave Out)
- SCLK (Serial Clock)
- CS/SS (Chip Select)
- Data Transmission and Reception
- Configurable Data Transfer
- FSM-Based Control
- Functional Simulation
- RTL Schematic

---

## 🔹 SPI Signals

SPI commonly uses four main signals:

| Signal | Description |
|--------|-------------|
| `MOSI` | Master Out Slave In |
| `MISO` | Master In Slave Out |
| `SCLK` | Serial Clock |
| `CS/SS` | Chip Select / Slave Select |

### Basic Connection

```text
             SPI MASTER
          ┌──────────────┐
          │              │
MOSI ─────┼─────────────►│
MISO ◄────┼──────────────┤
SCLK ─────┼─────────────►│
CS   ─────┼─────────────►│
          └──────────────┘
                 │
                 │
          ┌──────────────┐
          │   SPI SLAVE  │
          │              │
          └──────────────┘
