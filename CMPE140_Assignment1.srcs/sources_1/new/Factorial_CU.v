`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/29/2019 02:14:58 PM
// Design Name: 
// Module Name: Factorial_CU
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


module Factorial_CU(
    input go, clk,
    input GT_Fact, GT_Input,
    output reg Sel, Load_Reg, Load_Cnt, OE, En,
    output Done, Err
);

    //Next and Current State Registers
    reg [2:0] CS = 0, NS;
    reg Err_Internal, Done_Internal;
    
    assign Err  = Err_Internal;
    assign Done = Done_Internal;

    //encode states
    parameter Idle             = 3'd0,
              Load_Cnt_AND_Reg = 3'd1,
              Wait             = 3'd2,
              OE_AND_Done      = 3'd3,
              Mult_AND_Dec     = 3'd4;
    

    
    //Next State Logic (combinational) based on State Transition Diagram
    always @ (CS, go)
    begin
        case (CS)
            Idle:
            case({go,GT_Input})
                2'b11:  {NS,Err_Internal} = {Idle,1'b1};
                2'b10:  {NS,Err_Internal} = {Load_Cnt_AND_Reg,1'b0};
                2'b0?:  {NS,Err_Internal} = {Idle,1'b0};
                default: NS = Idle; 
            endcase
            Load_Cnt_AND_Reg:          NS = Wait;
            Wait:                      NS = GT_Fact ? Mult_AND_Dec : OE_AND_Done;
            OE_AND_Done:               NS = Idle;
            Mult_AND_Dec:              NS = Wait;
        endcase
    end
    
    //State Register (sequential)
    always @ (posedge clk)
        CS <= NS;
    
    //Output Logic
    always @ (CS)
    begin
        case (CS)
            Idle: //S0
            begin
                {Sel, Load_Cnt, En, Load_Reg, OE, Done_Internal} <= 6'b1_0_0_0_0_0;
            end
            Load_Cnt_AND_Reg: //S1
            begin
                {Sel, Load_Cnt, En, Load_Reg, OE, Done_Internal} <= 6'b1_1_1_1_0_0;
            end
            Wait: //S2
            begin
                {Sel, Load_Cnt, En, Load_Reg, OE, Done_Internal} <= 6'b0_0_0_0_0_0;
            end
            OE_AND_Done: //S3
            begin
                {Sel, Load_Cnt, En, Load_Reg, OE, Done_Internal} <= 6'b0_0_0_0_1_1;
            end
            Mult_AND_Dec: //S4
            begin
                {Sel, Load_Cnt, En, Load_Reg, OE, Done_Internal} <= 6'b0_0_1_1_0_0;
            end
        endcase
                
    end
        
              
   
endmodule