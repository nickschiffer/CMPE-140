`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/05/2019 10:46:42 PM
// Design Name: 
// Module Name: CMP
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


module CMP(
    input wire [DATA_WIDTH-1:0] a,
    input wire [DATA_WIDTH-1:0] b,
    output wire gt);
    
	parameter DATA_WIDTH = 32;

	assign gt = (a > b) ? 1 : 0;

endmodule

