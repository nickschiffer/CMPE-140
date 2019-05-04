`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/02/2019 09:38:55 PM
// Design Name: 
// Module Name: Register
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


module Register(
    	input wire clk,
    	input wire load_reg,
    	input wire [DATA_WIDTH-1:0] in,
    	output reg [DATA_WIDTH-1:0] out);

	parameter DATA_WIDTH = 32;

	always@(posedge clk) begin
    	if(load_reg) begin
        	out = in;
    	end
    	// else out = out
	end

endmodule
