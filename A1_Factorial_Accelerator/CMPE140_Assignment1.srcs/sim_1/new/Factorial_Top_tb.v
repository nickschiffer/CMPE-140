`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/05/2019 06:22:54 PM
// Design Name: 
// Module Name: Factorial_Top_tb
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


module Factorial_Top_tb;


reg Go_tb, clk_tb;
reg [3:0] n_tb;
wire Done_tb, Err_tb;
wire [31:0] nf_tb;

Factorial_Top DUT (
    .n(n_tb),
    .Go(Go_tb),
    .clk(clk_tb),
    .Done(Done_tb),
    .Err(Err_tb),
    .nf(nf_tb)
);


task automatic tick;
    begin
        clk_tb <= 1'b0;
        #50;
        clk_tb <= 1'b1;
        #50;
    end
endtask

initial
begin
    $display("Factorial Top Test Begin");
    clk_tb = 0;
    n_tb = 4'd1;
    tick;
    while (n_tb < 15)
    begin  
        Go_tb  = 1;
        clk_tb = 0;
        tick;
        while (!(Done_tb || Err_tb))
        begin
            tick;
        end
        $display("%d! = %d",n_tb, nf_tb);
        n_tb = n_tb + 4'd1;
    end
    
    
//    n_tb = 4'd6;
//    tick;
//    while (!(Done_tb || Err_tb))
//    begin
//        tick;
//    end
//    $display("%d! = %d",n_tb, nf_tb);
    
    $display("Test Complete");
    $finish;
end



endmodule
