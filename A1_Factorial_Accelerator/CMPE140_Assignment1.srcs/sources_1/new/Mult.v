`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Nickolas Schiffer
// 
// Create Date: 01/29/2019 02:58:04 PM
// Design Name: 
// Module Name: Mult
// Project Name: Factorial
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


module MUL #(parameter Data_Width = 32)(
    input [Data_Width - 1:0] x, y,
    output reg [Data_Width - 1:0] z
);

    always @ (x or y)
        begin
            z <= x * y;
        end

endmodule
