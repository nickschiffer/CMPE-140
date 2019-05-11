`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/23/2019 11:34:29 PM
// Design Name: 
// Module Name: fact_res_err_reg
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


module fact_res_err_reg(
    input Clk, Rst, GoPulseCmb, Err,
    output reg ResErr
    );
    
    always @ (posedge Clk, posedge Rst) begin
    if (Rst)
        ResErr <= 1'b0;
    else
        ResErr <= (~GoPulseCmb) & (Err | ResErr);
    end
endmodule
