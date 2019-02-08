`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/07/2019 07:32:15 PM
// Design Name: 
// Module Name: bcd_to_7seg
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


module bcd_to_7seg
(input [3:0] BCD, output reg [7:0] s);
        always @ (BCD)
        begin
                case (BCD)
                        0:      s = 8'b10001000;
                        1:      s = 8'b11101101;
                        2:      s = 8'b10100010;
                        3:      s = 8'b10100100;
                        4:      s = 8'b11000101;
                        5:      s = 8'b10010100;
                        6:      s = 8'b10010000;
                        7:      s = 8'b10101101;
                        8:      s = 8'b10000000;
                        9:      s = 8'b10000100;
                        /*
                        TODO: Need to figure out these letters
                        */
                        4'ha:   s = 8'b10000001;
                        4'hb:   s = 8'b11010000;
                        4'hc:   s = 8'b10011010;
                        4'hd:   s = 8'b11100000;
                        4'he:   s = 8'b10010010;
                        4'hf:   s = 8'b10010011;
                        default:s = 8'b01111111;
                endcase
        end
endmodule