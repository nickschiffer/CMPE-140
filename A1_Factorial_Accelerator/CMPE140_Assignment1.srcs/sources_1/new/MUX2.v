`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Nickolas Schiffer
// 
// Create Date: 01/29/2019 02:52:31 PM
// Design Name: 
// Module Name: MUX2
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


module MUX2 #(parameter Data_Width = 32)(
    input [Data_Width - 1:0] D0, D1,
    input Sel,
    output reg [Data_Width - 1:0] Out
);

    always @ (D0, D1, Sel)
        begin
            if (Sel)
                Out <= D1;
            else
                Out <= D0;
        end
    
    
endmodule
