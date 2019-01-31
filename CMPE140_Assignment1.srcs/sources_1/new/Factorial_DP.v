`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Nickolas Schiffer
// 
// Create Date: 01/29/2019 02:14:58 PM
// Design Name: 
// Module Name: Factorial_DP
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


module Factorial_DP #(parameter Data_Width = 32)(
    input [Data_Width - 1:0] n,
    input Clk, En, Sel, Load_Reg, Load_Cnt, OE,
    output [Data_Width - 1:0] nf,
    output GT_Input, GT_Fact
);

    wire [3:0]              CNT_Out;
    wire [Data_Width - 1:0] MUX_Out;
    wire [Data_Width - 1:0] REG_Out;
    wire [Data_Width - 1:0] MUL_Out;

    
    CMP_GT #(4)  CMP_INPUT  (.A(n), .B(4'd12), .GT(GT_Input));
    CMP_GT #(4)  CMP_FACT   (.A(CNT_Out), .B(4'b1), .GT(GT_Fact));
    CNT    #(4)  COUNTER    (.D(n), .Q(CNT_Out), .Load_Cnt(Load_Cnt), .En(En), .Clk(Clk));
    MUL    #(32) MUL        (.x({28'b0,CNT_Out}), .y(REG_Out), .z(MUL_Out));
    MUX2   #(32) MUX        (.D1(32'b1), .D0(MUL_Out), .Sel(Sel));
    MUX2   #(32) OUT_BUFFER (.D0(32'b0), .D1(REG_Out), .Sel(OE));
    REG    #(32) REG        (.D(MUX_Out), .Q(REG_Out), .Load_Reg(Load_Reg), .Clk(Clk));
    
   
endmodule
