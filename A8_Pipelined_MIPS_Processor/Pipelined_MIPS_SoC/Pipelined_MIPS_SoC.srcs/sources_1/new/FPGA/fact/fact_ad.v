`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/23/2019 11:02:37 PM
// Design Name: 
// Module Name: fact_ad
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


module fact_ad(
    input wire [1:0] A,
    input wire WE,
    output reg WE1, WE2,
    output wire [1:0] RdSel
    );
    
    always @ (*) begin
        case(A)
            2'b00: begin
                WE1 <= WE;
                WE2 <= 1'b0;
            end
            2'b01: begin
                WE1 <= 1'b0;
                WE2 <= WE;
            end
            2'b10: begin
                WE1 <= 1'b0;
                WE2 <= 1'b0;
            end
            2'b11: begin
                WE1 <= 1'b0;
                WE2 <= 1'b0;
            end
            default: begin
                WE1 <= 1'bx;
                WE1 <= 1'bx;
            end
        endcase
    end
    assign RdSel = A;  
endmodule
