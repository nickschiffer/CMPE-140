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

    reg [Data_Width - 1:0] Count_To = 1;
    reg [Data_Width - 1:0] Count = 1;
    

    always @ (En, Load_Cnt, Clk)
    begin
        if (En)
        begin
            if (Load_Cnt)
                Count_To <= D;
            else
            begin 
                Count = Count - 1;
                if (Count <= Count_To)
                    Q <= 1;
                else
                    Q <= 0;
            end
        end
        else
            Q <= 0;
    end
endmodule
