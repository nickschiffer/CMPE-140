`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/29/2019 03:08:07 PM
// Design Name: 
// Module Name: REG
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


module REG #(parameter Data_Width = 32)(
    input [Data_Width - 1:0] D,
    input Clk, Load_Reg,
    output reg [Data_Width - 1:0] Q
);

    always @ (posedge Clk)
        begin
           if (Load_Reg)
                Q <= D; 
        end
endmodule
