`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/29/2019 02:16:46 PM
// Design Name: 
// Module Name: Mag_Comp
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


module CMP_GT #(parameter Data_Width = 4)(
    input [Data_Width - 1:0] A, B,
    output reg GT);
    
    always @ (A or B)
        begin
            GT <= 1'b0;
            
            if (A > B)
                GT <= 1'b1;
        end

endmodule
