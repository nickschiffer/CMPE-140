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
    
    wire RdSel;
    wire WE1, WE2;
    wire [3:0] n;
    wire GoPulseCmb;
    wire Go;
    
    wire [31:0] nf;
    wire fact_done;
    wire [31:0] result;
    
    wire ResDone, ResErr;
    
    and_fact #(1) and_fact (
        .a          (WE2),
        .b          (WD[0]),
        .c          (GoPulseCmb)
        );
    fact_ad address_decoder (
        .A          (A),
        .WE         (WE),
        .WE2        (WE2),
        .WE1        (WE1),
        .RdSel      (RdSel)
        );
        
    fact_reg #(4) n_reg (
        .Clk         (clk),
        .Load_Reg    (WE1),
        .D           (WD),
        .Q           (n)
        );
    fact_reg #(1) go_reg (
        .Clk         (clk),
        .Load_Reg    (WE2),
        .D           (WD[0]),
        .Q           (Go)
        );
    fact_reg #(1) go_pulse_reg (
        .Clk         (clk),
        .Load_Reg    (1'b1),
        .D           (WD[0]),
        .Q           (n)
        );
        
    fact fact (); // TODO
    fact_reg #(32) result_reg (
        .Clk         (clk),
        .Load_Reg    (fact_done),
        .D           (nf),
        .Q           (result)
        );
    
    fact_res_done_reg fact_res_done_reg(
        .Clk         (clk), 
        .Rst         (Rst), 
        .GoPulseCmb  (GoPulseCmb), 
        .Done        (fact_done),
        .ResDone     (ResDone)
        );
    fact_res_err_reg fact_res_err_reg (
        .Clk         (clk), 
        .Rst         (Rst), 
        .GoPulseCmb  (GoPulseCmb), 
        .Err         (fact_done),
        .ResErr      (ResErr)
        );
    mux4 #(32) fact_mux (
        .a           ({28'b0,n}),
        .b           ({31'b0,Go}),
        .c           ({30'b0,ResErr,ResDone}),
        .d           (result),
        .y           (RD)
    );
endmodule
