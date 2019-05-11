`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/01/2019 01:02:24 AM
// Design Name: 
// Module Name: fpga_top_tb
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


module fpga_top_tb;


        task tick; 
    begin 
        button_clk = 1'b0; #5;
        button_clk = 1'b1; #5;
    end
    endtask

    task reset;
    begin 
        button_rst = 1'b0; #5;
        button_rst = 1'b1; #5;
        button_rst = 1'b0;
    end
    endtask
    reg button_clk;
    reg button_rst;
    reg [3:0] n;
    reg Sel; 
    wire [7:0] LEDSEL;
    wire [7:0] LEDOUT;
    wire factErr;

    fpga_top DUT(
    .clk100MHz(),
    .button_clk(button_clk),
    .button_rst(button_rst),
     .n(n),
    .Sel(Sel), 
    .LEDSEL(LEDSEL),
    .LEDOUT(LEDOUT),
    .factErr(factErr)
    );
    integer i;
    initial begin
    n = 5;
    Sel = 1;
    reset;
    for(i = 0; i < 40; i = i + 1) begin
    tick;
    end
    
    
    end
    
    
    
    


endmodule
