`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2019 12:03:36 AM
// Design Name: 
// Module Name: and_fact
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


module and_fact #(parameter WIDTH = 32)(
    input [WIDTH - 1:0] a, b,
    output wire c
    );
    
    assign c = a & b;
endmodule
