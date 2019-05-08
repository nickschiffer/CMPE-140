`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/04/2019 05:06:40 PM
// Design Name: 
// Module Name: D_Stage_Reg
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


module W_Stage_Reg(
    input        clk, rst,
    input        jr_mux_ctrlM,
    input        jumpM,
    input [1:0]  hilo_mux_ctrlM,
    input        dm2regM,
    input        we_regM,

    input [31:0] alu_outM,

    input [31:0] rd_dmM,

    input [31:0] hi_outM,
    input [31:0] lo_outM,
    
    input [31:0] jrM,
    input [4:0]  waM,
    input [31:0] jtaM,
    input        jal_wd_muxM,

    output reg        jr_mux_ctrlW,
    output reg        jumpW,
    output reg [1:0]  hilo_mux_ctrlW,
    output reg        dm2regW,
    output reg        we_regW,

    output reg [31:0] alu_outW,

    output reg [31:0] rd_dmW,

    output reg [31:0] hi_outW,
    output reg [31:0] lo_outW,
    output reg        jal_wd_muxW,

    output reg [31:0] jrW,
    output reg [4:0]  waW,
    output reg [31:0] jtaW
    );
always @ (negedge clk, posedge rst) begin
    if (rst) begin
        jr_mux_ctrlW   <= 0;
        jumpW          <= 0;
        hilo_mux_ctrlW <= 0;
        dm2regW        <= 0;
        we_regW        <= 0;

        alu_outW       <= 0;
        jal_wd_muxW    <= 0;
        rd_dmW         <= 0;

        hi_outW        <= 0;
        lo_outW        <= 0;

        jrW            <= 0;
        waW            <= 0;
        jtaW           <= 0;
    end

    else begin
        jr_mux_ctrlW   <= jr_mux_ctrlM;
        jumpW          <= jumpM;
        hilo_mux_ctrlW <= hilo_mux_ctrlM;
        dm2regW        <= dm2regM;
        we_regW        <= we_regM;

        alu_outW       <= alu_outM;
        
        rd_dmW         <= rd_dmM;

        hi_outW        <= hi_outM;
        lo_outW        <= lo_outM;

        jrW            <= jrM;
        waW            <= waM;
        
        jtaW           <= jtaM;
        
        jal_wd_muxW    <= jal_wd_muxM;
    end
end
endmodule