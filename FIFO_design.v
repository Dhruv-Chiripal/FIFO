`timescale 1ns / 1ps


module fifo #(parameter WIDTH = 8, ADDR = 4, DEPTH = 16) (
    input wire clk,
    input wire reset,
    input wire wr_en,rd_en ,
    input wire [WIDTH-1:0] din,
    output reg [WIDTH-1:0] dout,
    output wire full,
    output wire empty
);
    reg [WIDTH-1:0] mem [0:DEPTH-1];
    reg [ADDR:0] wr_ptr,rd_ptr;
    
    //write
    always @(posedge clk or posedge reset)begin
        if(reset)begin
            wr_ptr <=0;
        end
        else if(wr_en && ~full)begin
            mem[wr_ptr[ADDR-1:0]] <= din;
            wr_ptr <= wr_ptr+1;
        end
    end
    //read
    always @(posedge clk or posedge reset)begin
        if(reset)begin
            dout <=0;
            rd_ptr <=0;
        end
        else if(rd_en && ~empty)begin
            dout <= mem[rd_ptr[ADDR-1:0]];
            rd_ptr <= rd_ptr+1;
            end
      
    end
    assign empty = (rd_ptr == wr_ptr);
    assign full = ( rd_ptr[ADDR] != wr_ptr[ADDR] ) && (rd_ptr[ADDR-1:0] == wr_ptr[ADDR-1:0]);
endmodule
