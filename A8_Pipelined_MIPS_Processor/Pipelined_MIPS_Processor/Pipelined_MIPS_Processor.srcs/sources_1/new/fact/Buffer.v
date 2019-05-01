`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/04/2019 12:01:46 AM
// Design Name: 
// Module Name: Buffer
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


module Buffer(
    input wire out_en,
    input wire [DATA_WIDTH-1:0] in, 
    output wire [DATA_WIDTH -1:0] out);
    
    parameter DATA_WIDTH = 32;
    
    assign out = out_en ? in : {DATA_WIDTH -1'bz};
endmodule
