`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/29/2019 03:12:05 PM
// Design Name: 
// Module Name: CNT
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


 module CNT #(parameter Data_Width = 4)(
    input [Data_Width - 1:0] D,
    input Load_Cnt, En, Clk,
    output reg Q
);    

    always @ (En, Load_Cnt, Clk)
    begin
        if (En)
        begin
            if (Load_Cnt)
                Q <= D;
            else
            begin 
                Q = Q - 1;
            end
        end
        else
            Q <= Q;
    end
endmodule
