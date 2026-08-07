`timescale 1ns / 1ps
module tb();
    reg clk;
    reg reset;
    reg rd_en;
    reg wr_en;
    reg [7:0] din;
    wire [7:0] dout;
    wire full;
    wire empty;
    
    
    integer i;
     
   
    fifo dut (
        .clk(clk),
        .reset(reset),
        .rd_en(rd_en),
        .wr_en(wr_en),
        .din(din),
        .dout(dout),
        .full(full),
        .empty(empty)
    );
     
    // Clock Generator (10ns cycle)
    always #5 clk = ~clk;
     
    initial begin
        
        clk = 0;
        reset = 1;
        rd_en = 0;
        wr_en = 0;
        din = 0;
        
        #10 reset = 0; // Release reset
        
           
      
        for (i = 0; i < 16; i = i + 1) begin
            @(posedge clk);
            wr_en = 1;
            din = 8'hA0 + i; // A0, A1, A2...
        end
    
        @(posedge clk);
        wr_en = 0;
        din = 0;
             
        #20;

        
       for(i=0;i<16;i=i+1)begin
         @(posedge clk); rd_en=1;
       end

        @(posedge clk);
        rd_en = 0;
        
         
         #20;
        
        $finish;
        
        
    end
     
endmodule
