# Synchronous FIFO

A synthesizable, parameterized Synchronous FIFO written in Verilog HDL.

## Interface
* **Inputs:** `clk`, `reset`, `wr_en`, `rd_en`, `din [WIDTH-1:0]`
* **Outputs:** `dout [WIDTH-1:0]`, `full`, `empty`

## Key Logic
* **Full/Empty Detection:** Uses an extra MSB pointer bit to identify memory wrap-around.
* **Overflow/Underflow Guard:** Protection logic drops illegal write requests when full and read requests when empty.
