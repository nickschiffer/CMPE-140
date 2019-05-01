`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2019 02:32:36 PM
// Design Name: 
// Module Name: fact_top_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////



module fact_top_tb;
    reg [1:0]   tb_A;
    reg         tb_WE;
    reg [3:0]   tb_WD;
    reg         tb_RST, tb_CLK;
    wire [31:0] tb_RD;
    
    fact_top DUT(
        .A(tb_A),
        .WE(tb_WE),
        .WD(tb_WD),
        .Rst(tb_RST),
        .clk(tb_CLK),
        .RD(tb_RD)
    );
    integer i;
    integer iLoop;
    initial begin
    tb_RST = 1;
    tick;
    tb_RST = 0;
    for(iLoop =1; iLoop < 13; iLoop = iLoop + 1) begin
    
    i = 0;
    //tb_CLK = 0;
     tb_A = 2'b00;
    
    tb_WD = iLoop;
    tb_WE = 1;
    #3;
    tick;
    tb_A = 2'b01;
    tb_WD = 1;
    #3;
    tick;
    tb_A = 2'd2;
    tb_WE = 1'b0;
    tick;
    
    
//    while (i < 100) begin
//    tick;
//    i = i + 1;
//    end
    
    while ((tb_RD[1:0] != 2'b01)) begin
        tick;
    end
    tb_A = 2'd3;
    tick;
    //tb_RST = 1;
    //tick;
    //tb_RST = 0;
    end
//    for(i = 2; i < 4; i = i + 1) begin
//        tb_WD = i * 100;
//        tb_A = i;
//        tb_WE = 1;
//        tick;
//        tick;
//    end    
    
    
    
    
    $finish;
    
    
    end
    task tick;
        begin
            tb_CLK = 1'b1; #5;
            tb_CLK = 1'b0; #5;
            
        end
    endtask 
endmodule
