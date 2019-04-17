`timescale 1ns / 1ps

// from https://www.xilinx.com/support/answers/8657.html
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/15/2019 03:33:42 PM
// Design Name: 
// Module Name: pipelined_multiplier
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


module pipelined_multiplier (a, b, clk, pdt);
/*
* parameter 'size' is the width of multiplier/multiplicand;.Application Notes 10-5
* parameter 'level' is the intended number of stages of the
* pipelined multiplier;
* which is typically the smallest integer greater than or equal
* to base 2 logarithm of 'size'
*/
parameter size = 16, level = 4;
input [size-1 : 0] a;
input [size-1 : 0] b;
input clk;
output [2*size-1 : 0] pdt;
reg [size-1 : 0] a_int, b_int;
reg [2*size-1 : 0] pdt_int [level-1 : 0];
integer i;

assign pdt = pdt_int [level-1];

always @ (posedge clk)
    begin
        // registering input of the multiplier
        a_int <= a;
        b_int <= b;
        // 'level' levels of registers to be inferred at the output
        // of the multiplier
        pdt_int[0] <= a_int * b_int;
        for(i = 1; i < level; i = i + 1)
        pdt_int[i] <= pdt_int [i - 1];


    end // always @ (posedge clk)
endmodule // pipelined_multiplier