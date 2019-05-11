`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/04/2019 06:16:51 PM
// Design Name: 
// Module Name: M_Stage_Reg
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


module M_Stage_Reg(
    input        clk, rst,
    input        jr_mux_ctrlE,
    input        jumpE,
    input        hilo_weE,
    input [1:0]  hilo_mux_ctrlE,
    input        dm2regE,
    input        we_dmE,
    //input        branchE,
    input        we_regE,

    //input        zeroE,
    
    input [31:0] alu_outE,
    
    input [31:0] wd_dmE,
    
    input [31:0] mult_hiE,
    input [31:0] mult_loE,
    
    //input [31:0] btaE,
    
    input [31:0] jrE,
    input [4:0]  waE,
    input        jal_wa_muxE,
    input        jal_wd_muxE,
    
    input [31:0] addressE,
    input [31:0] jtaE,

    output reg        jr_mux_ctrlM,
    output reg        jumpM,
    output reg        hilo_weM,
    output reg [1:0]  hilo_mux_ctrlM,
    output reg        dm2regM,
    output reg        we_dmM,
    //output reg        branchM,
    output reg        we_regM,

    //output reg        zeroM,

    output reg [31:0] alu_outM,

    output reg [31:0] wd_dmM,

    output reg [31:0] mult_hiM,
    output reg [31:0] mult_loM,

    //output reg [31:0] btaM,

    output reg [31:0] jrM,
    output reg [4:0]  waM,
    output reg        jal_wa_muxM,
    output reg        jal_wd_muxM,
    output reg [31:0] addressM,
    output reg [31:0] jtaM
    );

always @ (negedge clk, posedge rst) begin
    if (rst) begin
        jr_mux_ctrlM   <= 0;
        jumpM          <= 0;
        hilo_weM       <= 0;
        hilo_mux_ctrlM <= 0;
        dm2regM        <= 0;
        we_dmM         <= 0;
        //branchM        <= 0;
        we_regM        <= 0;

        //zeroM          <= 0;

        alu_outM       <= 0;

        wd_dmM         <= 0;

        mult_hiM       <= 0;
        mult_loM       <= 0;

        //btaM           <= 0;

        jrM            <= 0;
        waM            <= 0;
        
        jal_wa_muxM    <= 0;
        jal_wd_muxM    <= 0;
        addressM       <= 0;
        jtaM           <= 0;
    end

    else begin
        jr_mux_ctrlM   <= jr_mux_ctrlE;
        jumpM          <= jumpE;
        hilo_weM       <= hilo_weE;
        hilo_mux_ctrlM <= hilo_mux_ctrlE;
        dm2regM        <= dm2regE;
        we_dmM         <= we_dmE;
        //branchM        <= branchE;
        we_regM        <= we_regE;

        //zeroM          <= zeroE;

        alu_outM       <= alu_outE;
        
        wd_dmM         <= wd_dmE;
        
        mult_hiM       <= mult_hiE;
        mult_loM       <= mult_loE;
        
        //btaM           <= btaE;
        
        jrM            <= jrE;
        waM            <= waE;
        
        jal_wa_muxM    <= jal_wa_muxE;
        jal_wd_muxM    <= jal_wd_muxE;
        addressM       <= addressE;
        jtaM           <= jtaE;
    end
end
endmodule
