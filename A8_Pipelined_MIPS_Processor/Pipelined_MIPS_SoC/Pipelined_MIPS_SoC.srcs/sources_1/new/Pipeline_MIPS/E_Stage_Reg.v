`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/04/2019 05:22:38 PM
// Design Name: 
// Module Name: E_Stage_Reg
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


module E_Stage_Reg(
    input        clk, rst,
    input        jr_mux_ctrlD,
    input        jumpD,
    input        hilo_weD,
    input [1:0]  hilo_mux_ctrlD,
    input        dm2regD,
    input        we_dmD,
    
    //input        branchD,
    input [3:0]  alu_ctrlD,
    input        alu_srcD,
    input        reg_dstD,
    input        we_regD,
    input        jal_wa_muxD,
    input        jal_wd_muxD,
    
    input [31:0] rd1D,
    input [31:0] rd2D,
    
    input [4:0]  instrD_20_16,
    input [4:0]  instrD_15_11,
    
    input [31:0] pc_plus4D,
    
    input [4:0]  shamtD,
    input [31:0] sext_immD,
    
    input [31:0] addressD,
    input [31:0] jtaD,
    
    
    output reg        jr_mux_ctrlE,
    output reg        jumpE,
    output reg        hilo_weE,
    output reg [1:0]  hilo_mux_ctrlE,
    output reg        dm2regE,
    output reg        we_dmE,
    //output reg        branchE,
    output reg [3:0]  alu_ctrlE,
    output reg        alu_srcE,
    output reg        reg_dstE,
    output reg        we_regE,
    output reg        jal_wa_muxE,
    output reg        jal_wd_muxE,
    
    
    output reg [31:0] rd1_outE,
    output reg [31:0] rd2_outE,
    
    output reg [4:0]  instrE_20_16,
    output reg [4:0]  instrE_15_11,
    
    output reg [31:0] pc_plus4E,
    
    output reg [4:0]  shamtE,
    output reg [31:0] sext_immE,
    
    output reg [31:0] addressE,
    output reg [31:0] jtaE
    );
    
always @ (negedge clk, posedge rst) begin
    if (rst) begin
        jr_mux_ctrlE   <= 0;
        jumpE          <= 0;
        hilo_weE       <= 0;
        hilo_mux_ctrlE <= 0;
        dm2regE        <= 0;
        we_dmE         <= 0;
        //branchE        <= 0;
        alu_ctrlE      <= 0;
        alu_srcE       <= 0;
        reg_dstE       <= 0;
        we_regE        <= 0;
        jal_wa_muxE    <= 0;
        jal_wd_muxE    <= 0;

        rd1_outE       <= 0;
        rd2_outE       <= 0;

        instrE_20_16   <= 0;
        instrE_15_11   <= 0;

        pc_plus4E      <= 0;

        shamtE         <= 0;
        sext_immE      <= 0;
        
        addressE       <= 0;
        jtaE           <= 0;
    end
    
    else begin
        jr_mux_ctrlE   <= jr_mux_ctrlD;
        jumpE          <= jumpD;
        hilo_weE       <= hilo_weD;
        hilo_mux_ctrlE <= hilo_mux_ctrlD;
        dm2regE        <= dm2regD;
        we_dmE         <= we_dmD;
        //branchE        <= branchD;
        alu_ctrlE      <= alu_ctrlD;
        alu_srcE       <= alu_srcD;
        reg_dstE       <= reg_dstD;
        we_regE        <= we_regD;
        jal_wa_muxE    <= jal_wa_muxD;
        jal_wd_muxE    <= jal_wd_muxD;

        rd1_outE       <= rd1D;
        rd2_outE       <= rd2D;

        instrE_20_16   <= instrD_20_16;
        instrE_15_11   <= instrD_15_11;

        pc_plus4E      <= pc_plus4D;

        shamtE         <= shamtD;
        sext_immE      <= sext_immD;
        
        addressE       <= addressD;
        jtaE           <= jtaD;
    end
        
end


endmodule
