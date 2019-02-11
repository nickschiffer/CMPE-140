`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/05/2019 05:55:08 PM
// Design Name: 
// Module Name: CU_tb
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


module CU_tb;


reg clk_tb, go_tb;

reg GT_Fact_tb, GT_Input_tb; 
wire Sel_tb, Load_Reg_tb, Load_Cnt_tb, OE_tb, En_tb, Done_tb, Err_tb;



Factorial_CU DUT (
    .go(go_tb), .clk(clk_tb), .GT_Fact(GT_Fact_tb), .GT_Input(GT_Input_tb),
    .Sel(Sel_tb), .Load_Reg(Load_Reg_tb), .Load_Cnt(Load_Cnt_tb), .OE(OE_tb), .En(En_tb),
    .Done(Done_tb), .Err(Err_tb)

);


task tick;
    begin  
        clk_tb <= 1;
        #5;
        clk_tb <= 0;
        #5;
    end 
endtask


initial
begin
$display("CU Test Start");

go_tb         = 1'b1;
GT_Fact_tb    = 1'b0;
GT_Input_tb   = 1'b0;


    tick;
    tick;
    tick;
    tick;
    tick;
    GT_Input_tb = 1'b1;
    tick;
    tick;
    tick;
    tick;

$display("Test Complete");
$finish;
end



endmodule
