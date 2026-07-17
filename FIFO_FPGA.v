`timescale 1ns / 1ps


module fifo #(parameter DATA_WIDTH = 8, DEPTH = 16, ADDR = 4)(
                    input wire clk,
                    input wire reset,
                    input wire wr_en,rd_en,
                    input wire [DATA_WIDTH-1:0] din,
                    output reg [DATA_WIDTH-1:0] dout,
                    output wire full,
                    output wire empty);
                    
             reg [DATA_WIDTH-1 : 0] mem [0:DEPTH-1];
             reg [ADDR:0] wr_ptr, rd_ptr; //we take addr bit as one higher to see the msb so that empty full is detected)
             
             
             //write
             always @(posedge clk) begin
                if(reset)
                    wr_ptr <=0;
                else if(wr_en && ~full) begin
                    mem[wr_ptr[ADDR-1:0]] <= din;
                    wr_ptr <= wr_ptr+1;
                end
             end 
             
             //read
             always @(posedge clk) begin
                if(reset)begin
                    rd_ptr <=0;
                    dout <=0;
                    end
                else if(rd_en && ~empty) begin
                    dout <= mem[rd_ptr[ADDR-1:0]];
                    rd_ptr <= rd_ptr+1;
                end
             end 
    assign empty = (wr_ptr == rd_ptr);

    assign full  = (wr_ptr[ADDR]     != rd_ptr[ADDR]) &&
                   (wr_ptr[ADDR-1:0] == rd_ptr[ADDR-1:0]);
endmodule

module clk_divider (
    input  wire clk,
    input  wire reset,
    output reg  clk_slow
);

    reg [28:0] count;

    always @(posedge clk) begin
        if (reset) begin
            count    <= 0;
            clk_slow <= 0;
        end else if (count == 29'd50_000_000) begin //made it count till 50M, 50M*2 = 100M => 1sec clock
            clk_slow <= ~clk_slow;   // toggle
            count    <= 0;
        end else begin
            count <= count + 1;
        end
    end
endmodule
module top_fifo_basys (
    input  wire clk,
    input  wire reset,
    input  wire wr_en,
    input  wire rd_en,
    input  wire [7:0] sw,
    output wire [7:0] led,
    output wire full,
    output wire empty
);

    wire [7:0] dout;
    wire clk_slower;
    clk_divider clk_div_inst(
        .clk(clk),
        .reset(reset),
        .clk_slow(clk_slow)
    );
    fifo fifo_inst (
        .clk(clk_slow),
        .reset(reset),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .din(sw),
        .dout(dout),
        .full(full),
        .empty(empty)
    );

    assign led = dout;
    
    

endmodule
