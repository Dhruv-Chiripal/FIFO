# Parameterized Synchronous FIFO Memory & FPGA Implementation

A fully synthesizable, parameterized Synchronous FIFO memory buffer designed in Verilog HDL and deployed on the AMD Xilinx Basys-3 FPGA board. 

## System Components

* **Core FIFO Logic (`fifo.v`):** A parameterized queue featuring an extra MSB pointer trick to reliably distinguish between complete **Full** and **Empty** states without losing memory depth. It includes built-in protection logic against overflow and underflow conditions.
* **Clock Scaler (`clock_divider.v`):** A custom clock divider that scales down the rapid $100\text{ MHz}$ internal FPGA oscillator to a lower frequency for human-readable visual verification.
* **Simulation Testbench (`fifo_tb.v`):** A comprehensive behavioral verification script used to validate pointer wrap-around boundaries and simultaneous read/write cycles before physical hardware deployment.
* **Constraints Mapping (`basys3_mapping.xdc`):** The physical mapping blueprint routing the system clock to pin `W5`, the reset signal to the **Center Push Button (U18)**, and output flags to the onboard **LEDs (U16, E19, U19)**.

## Specifications

### Parameters
* `WIDTH` (Default: 8): Data bus width.
* `DEPTH` (Default: 16): Total slot capacity.
* `ADDR`  (Default: 4): Address bits ($\log_2\text{DEPTH}$).

### Flag Logic
* **Empty Condition:** `assign empty = (rd_ptr == wr_ptr);`
* **Full Condition:** `assign full = (rd_ptr[ADDR] != wr_ptr[ADDR]) && (rd_ptr[ADDR-1:0] == wr_ptr[ADDR-1:0]);`

---

## Hardware Demonstration

The entire design pipeline has been successfully synthesized, placed, routed, and verified on physical hardware.

