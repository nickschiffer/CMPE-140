`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Nickolas Schiffer
// 
// Create Date: 03/26/2019 06:40:29 PM
// Design Name: 
// Module Name: mux4
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


module mux4 #(parameter WIDTH = 8) (
        input  wire [1:0]     sel,
        input  wire [WIDTH-1:0] a,
        input  wire [WIDTH-1:0] b,
        input  wire [WIDTH-1:0] c,
        input  wire [WIDTH-1:0] d, 
        output reg [WIDTH-1:0]  y
    );
    
    always @ (*)
    begin
        case (sel)
            2'b00: y <= a;
            2'b01: y <= b;
            2'b10: y <= c;
            2'b11: y <= d;
        endcase
//    assign y = (sel) ? b : a;
    end
    

endmodule