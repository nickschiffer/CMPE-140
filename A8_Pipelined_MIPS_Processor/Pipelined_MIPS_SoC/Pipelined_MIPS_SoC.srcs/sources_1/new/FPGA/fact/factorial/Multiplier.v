`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/02/2019 10:32:36 PM
// Design Name: 
// Module Name: Multiplier
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


module Multiplier(
    	input wire [DATA_WIDTH-1:0] a,
    	input wire [DATA_WIDTH-1:0] b,
    	output wire [DATA_WIDTH-1:0] out);

	parameter DATA_WIDTH = 32;

	assign out = a * b;

endmodule

