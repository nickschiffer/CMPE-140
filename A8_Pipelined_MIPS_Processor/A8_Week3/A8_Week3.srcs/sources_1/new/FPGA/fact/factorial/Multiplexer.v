`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/02/2019 10:37:49 PM
// Design Name: 
// Module Name: Multiplexer
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


module Multiplexer#(parameter DATA_WIDTH = 32)(
    input wire sel, 
    input wire [DATA_WIDTH-1:0] a, 
    input wire [DATA_WIDTH -1:0] b,
    output wire [DATA_WIDTH-1:0] out);
    
  
    
    assign out = (sel == 0) ? a : b;
    
endmodule
