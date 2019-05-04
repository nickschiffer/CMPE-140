`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/16/2019 08:53:01 PM
// Design Name: 
// Module Name: mult_inf
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


module mult_inf #(parameter SIZE = 32)(

    input wire [SIZE - 1:0] a, b,
    output reg [2*SIZE - 1:0] out

    );
    
    always @ (a, b) begin
        out <= a * b;
    end
endmodule
