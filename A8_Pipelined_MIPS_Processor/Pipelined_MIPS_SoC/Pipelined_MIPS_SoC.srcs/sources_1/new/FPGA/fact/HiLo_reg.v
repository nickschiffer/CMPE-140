`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Nickolas Schiffer
// 
// Create Date: 03/26/2019 06:10:08 PM
// Design Name: 
// Module Name: HiLo_reg
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
//module dreg # (parameter WIDTH = 32) (
//        input  wire             clk,
//        input  wire             rst,
//        input  wire [WIDTH-1:0] d,
//        output reg  [WIDTH-1:0] q
//    );

//    always @ (posedge clk, posedge rst) begin
//        if (rst) q <= 0;
//        else     q <= d;
//    end
//endmodule

module HiLo_reg# (parameter WIDTH = 32) (
    input wire clk, rst, we,
    input wire [WIDTH - 1:0] hi, lo,
    output reg [WIDTH - 1:0] hi_out, lo_out
    );
    
    always @ (posedge clk, posedge rst)
    begin
        if (rst) {hi_out, lo_out} <= 0;
        else if (we) {hi_out, lo_out} <= {hi,lo};
        else {hi_out, lo_out} <= {hi_out, lo_out};
    end 
endmodule
