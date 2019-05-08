`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/04/2019 05:06:40 PM
// Design Name: 
// Module Name: D_Stage_Reg
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


module D_Stage_Reg(
    input        clk, rst,
    input [31:0] instrF,
    input [31:0] pc_plus4F,
    
    output reg [31:0] instrD,
    output reg [31:0] pc_plus4D
    );
    
    always @ (negedge clk, posedge rst) begin
        if (rst) begin
            instrD    <= 0;
            pc_plus4D <= 0;
        end
        else begin
            instrD    <= instrF;
            pc_plus4D <= pc_plus4F;
        end
    end
    
endmodule
