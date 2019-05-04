`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/23/2019 11:19:40 PM
// Design Name: 
// Module Name: fact_res_done_reg
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


module fact_res_done_reg(
    input Clk, Rst, GoPulseCmb, Done,
    output reg ResDone
    );
    
    always @ (posedge Clk, posedge Rst) begin
    if (Rst)
        ResDone <= 1'b0;
    else
        ResDone <= (~GoPulseCmb) & (Done | ResDone);
    end
endmodule
