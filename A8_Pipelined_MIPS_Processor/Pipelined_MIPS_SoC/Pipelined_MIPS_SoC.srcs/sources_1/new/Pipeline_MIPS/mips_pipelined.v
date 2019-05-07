`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/04/2019 04:26:16 PM
// Design Name: 
// Module Name: mips_pipelined
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


module mips_pipelined(
        input  wire        clk,
        input  wire        rst,
        input  wire [4:0]  ra3,
        input  wire [31:0] instr,
        input  wire [31:0] rd_dm,
        output wire        we_dm,
        output wire [31:0] pc_current,
        output wire [31:0] alu_out,
        output wire [31:0] wd_dm,
        output wire [31:0] rd3
    );
    
    
    
/* Wires */
    
    /* FETCH STAGE */
        wire [31:0] pc_currentF;
        wire [31:0] pc_plus4F;
    
    
    /* DECODE STAGE */
        wire [31:0] instrD;
        wire [31:0] pc_plus4D;
        
        wire [31:0] jtaD;
        
        wire [31:0] rd1D;
        wire [31:0] rd2D;
        
        /* CU */
            wire        branchD;
            wire        jumpD;
            wire        reg_dstD;
            wire        we_regD;
            wire        alu_srcD;
            wire        we_dmD;
            wire        dm2regD;
            wire [3:0]  alu_ctrlD;
            wire [1:0]  hilo_mux_ctrlD;
            wire        hilo_weD;
            wire        jr_mux_ctrlD;
            wire        jal_wd_muxD;
            wire        jal_wa_muxD;
        
        wire [31:0] sext_immD;
        
        wire [4:0]  instrD_20_16;
        wire [4:0]  instrD_15_11;
        
        wire [4:0]  shamtD;
        
        
        
    
    /* EXECUTE STAGE */
        wire [31:0] wdE;
        
        wire        jr_mux_ctrlE;
        wire        jumpE;
        wire        hilo_weE;
        wire [1:0]  hilo_mux_ctrlE;
        wire        dm2regE;
        wire        we_dmE;
        wire        branchE;
        wire [3:0]  alu_ctrlE;
        wire        alu_srcE;
        wire        reg_dstE;
        wire        we_regE;
        wire        jal_wa_muxE;
        wire        jal_wd_muxE;
        
        wire [31:0] rd1_outE;
        wire [31:0] rd2_outE;
        
        wire [4:0]  instrE_20_16;
        wire [4:0]  instrE_15_11;
        
        wire [31:0] pc_plus4E;
        
        wire [4:0]  shamtE;
        wire [31:0] sext_immE;
        
        wire [31:0] alu_outE;
        
        assign alu_out = alu_outE;
    
    
    /* MEMORY STAGE */
        wire        pc_srcM;
        wire [31:0] btaM;  
    /* WRITEBACK STAGE */
        wire [31:0] pc_nextW;
        wire        jr_mux_ctrlW;
        wire        jumpW;
        wire [31:0] jrW;
        wire        we_regW;
        wire [4:0]  waW;
        
assign pc_current = pc_currentF;
    
/* FETCH STAGE */

    wire [31:0] pc_pc_src_mux;
    wire [31:0] pc_jump_mux;

    mux2 #(32) pc_src_mux (
        .sel              (pc_srcM),
        .a                (pc_plus4F), //TODO: double check that this shouldn't be 27:0
        .b                (btaM),
         
        .y                (pc_pc_src_mux)
    );
    
    mux2 #(32) jump_mux   (
        .sel              (jumpW),
        .a                (pc_pc_src_mux), 
        .b                (jtaD),
         
        .y                (pc_jump_mux)
    );
    
    mux2 #(32) jr_mux     (
        .sel              (jr_mux_ctrlW),
        .a                (pc_jump_mux), 
        .b                (jrW),
         
        .y                (pc_nextW)
    );
    
    
    
    dreg #(32) pc_reg     (
        .clk              (clk),
        .rst              (rst),
        .d                (pc_nextW),
         
        .q                (pc_currentF)
    );
    //imem
    
    adder pc_plus4        (
        .a                (pc_currentF),
        .b                (32'd4),
        
        .y                (pc_plus4F)
    );
    
    /* D Stage Reg Interface */
    D_Stage_Reg D_Stage_Reg (
        .clk              (clk), 
        .rst              (rst),
        .instrF           (instr),
        .pc_plus4F        (pc_plus4F),
    
        .instrD           (instrD),
        .pc_plus4D        (pc_plus4D)
    );   

/* DECODE STAGE */
    controlunit cu (
        .opcode           (instrD[31:26]),
        .funct            (instrD[5:0]),
        
        .branch           (branchD),
        .jump             (jumpD),
        .reg_dst          (reg_dstD),
        .we_reg           (we_regD),
        .alu_src          (alu_srcD),
        .we_dm            (we_dmD),
        .dm2reg           (dm2regD),
        .alu_ctrl         (alu_ctrlD),
        .hilo_mux_ctrl    (hilo_mux_ctrlD),
        .hilo_we          (hilo_weD),
        .jr_mux_ctrl      (jr_mux_ctrlD),
        .jal_wd_mux_sel   (jal_wd_muxD),
        .jal_wa_mux_sel   (jal_wa_muxD)
        
    );
    regfile rf     (
        .clk               (clk),
        .we                (we_regW),
        .ra1               (instrD[25:21]),
        .ra2               (instrD[20:16]),
        .ra3               (ra3),
        .wa                (waW),
        .wd                (wdE),
        .rd1               (rd1D),
        .rd2               (rd2D),
        .rd3               () //TODO not sure if we're using this
    );
    signext se  (
        .a                 (instrD[15:0]),
        .y                 (sext_immD)
    );
    
    assign shamtD = instrD[10:6];
    
    assign instrD_20_16 = instrD[20:16];
    assign instrD_15_11 = instrD[15:11];
    
    assign jtaD = {pc_plus4F[31:28], instrD[25:0], 2'b00}; //TODO not sure about this one.
    
    /* E Stage Reg Interface */
    E_Stage_Reg E_Stage_Reg (
        .clk               (clk),
        .rst               (rst),
        .jr_mux_ctrlD      (jr_mux_ctrlD),
        .jumpD             (jumpD),
        .hilo_weD          (hilo_weD),
        .hilo_mux_ctrlD    (hilo_mux_ctrlD),
        .dm2regD           (dm2regD),
        .we_dmD            (we_dmD),
        .branchD           (branchD),
        .alu_ctrlD         (alu_ctrlD),
        .alu_srcD          (alu_srcD),
        .reg_dstD          (reg_dstD),
        .we_regD           (we_regD),
        .jal_wa_muxD       (jal_wa_muxD),
        .jal_wd_muxD       (jal_wd_muxD),
        
        .rd1D              (rd1D),
        .rd2D              (rd2D),
        
        .instrD_20_16      (instrD_20_16),
        .instrD_15_11      (instrD_15_11),
        
        .pc_plus4D         (pc_plus4D),
        
        .shamtD            (shamtD),
        .sext_immD         (sext_immD),
        
        
        .jr_mux_ctrlE      (jr_mux_ctrlE),
        .jumpE             (jumpE),
        .hilo_weE          (hilo_weE),
        .hilo_mux_ctrlE    (hilo_mux_ctrlE),
        .dm2regE           (dm2regE),
        .we_dmE            (we_dmE),
        .branchE           (branchE),
        .alu_ctrlE         (alu_ctrlE),
        .alu_srcE          (alu_srcE),
        .reg_dstE          (reg_dstE),
        .we_regE           (we_regE),
        .jal_wa_muxE       (jal_wa_muxE),
        .jal_wd_muxE       (jal_wd_muxE),
        
        .rd1_outE          (rd1_outE),
        .rd2_outE          (rd2_outE),
        
        .instrE_20_16      (instrE_20_16),
        .instrE_15_11      (instrE_15_11),
        
        .pc_plus4E         (pc_plus4E),
        
        .shamtE            (shamtE),
        .sext_immE         (sext_immE)
    );

/* EXECUTE STAGE */

    wire [31:0] alu_paE;
    wire [31:0] alu_pbE;
    wire        zeroE;
    
    assign alu_paE = rd1_outE;
    
    mux2 #(32) alu_pb_mux (
        .sel            (alu_srcE),
        .a              (rd2_outE),
        .b              (sext_immE),
        .y              (alu_pbE)
    );
    alu alu               (
        .op             (alu_ctrlE),
        .a              (alu_paE),
        .b              (alu_pbE),
        .zero           (zeroE),
        .y              (alu_outE),
        .shamt          (shamtE)
    );
    
    mux2 #(5)  rf_wa_mux  (
        .sel            (reg_dstE),
        .a              (instrE_20_16),
        .b              (),
        .y              ()
    );
    mux2 #(32) jal_wd_mux ();
    mux2 #(5)  jal_wa_mux ();
    
    mult_inf #(32) mult   ();
    adder pc_plus_br      ();
    
    /* M Stage Interface */
    M_Stage_Reg M_Stage_Reg ();

/* MEMORY STAGE */

    
    //inferred and gate
    //connections to data mem
    HiLo_reg #(32) hi_lo_reg ();
    
    /* W Stage Reg Interface */
    W_Stage_Reg W_Stage_Reg ();
    

/* WRITEBACK STAGE */


    
    mux2 #(32) rf_wd_mux ();
    mux4 #(32) hilo_mux  ();
    
        
endmodule
