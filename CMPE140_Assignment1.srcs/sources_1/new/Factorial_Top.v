`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/29/2019 02:07:51 PM
// Design Name: 
// Module Name: Factorial_Top
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


module Factorial_Top(
    input Go, clk,
    input [3:0] n,
    output Done, Err,
    output [3:0] nf
    );
    
    wire Sel, Load_Reg, Load_Cnt, OE, En;
    wire GT_Fact, GT_Input;
    
    
    Factorial_DP DP (
        .Clk(clk),
        .En(En),
        .n(n),
        .Sel(Sel),
        .Load_Reg(Load_Reg),
        .Load_Cnt(Load_Cnt),
        .OE(OE),
        .GT_Fact(GT_Fact),
        .GT_Input(GT_Input),
        .nf(nf)
    );
    
    Factorial_CU CU (
        .En(En),
        .go(Go),
        .clk(clk),
        .Sel(Sel),
        .Load_Reg(Load_Reg),
        .Load_Cnt(Load_Cnt),
        .OE(OE),
        .GT_Fact(GT_Fact),
        .GT_Input(GT_Input),
        .Done(Done),
        .Err(Err)
    );
endmodule
