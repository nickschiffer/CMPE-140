`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/23/2019 10:49:51 PM
// Design Name: 
// Module Name: fact_top
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


module fact_top(
    input  [1:0]  A,
    input         WE,
    input  [3:0]  WD,
    input         Rst,
    input         clk,
    output [31:0] RD
    );
    
    and_fact #(1) and_fact ();
    fact_ad address_decoder ();
    fact fact ();
    fact_reg #(32) result_reg ();
    fact_reg #(4) n_reg ();
    fact_reg #(1) go_reg ();
    fact_reg #(1) go_pulse_reg ();
    fact_res_done_reg fact_res_done_reg();
    fact_res_err_reg fact_res_err_reg ();
    mux4 #(32) fact_mux ();
    //...some other registers
endmodule
