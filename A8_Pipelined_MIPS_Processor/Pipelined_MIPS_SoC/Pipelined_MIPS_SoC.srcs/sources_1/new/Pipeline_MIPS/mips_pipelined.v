`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Nickolas Schiffer
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
        output wire [31:0] rd3,
        output wire [31:0] address
    );
    
    
    
/* Wires */
    
    /* FETCH STAGE */
        wire [31:0] pc_currentF;
        wire [31:0] pc_plus4F;
    
    
    /* DECODE STAGE */
        wire        pc_srcD;
        wire [31:0] instrD;
        wire [31:0] pc_plus4D;
        
        wire [31:0] btaD;
        
        
        
        wire [31:0] rd1D;
        wire [31:0] rd2D;
        
        wire [31:0] wdD;
        wire [31:0] jtaD;
        
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
        
        wire [31:0] addressD;
        
        
        
    
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
        
        wire [31:0] addressE;
        
        wire [31:0] jtaE;
        
        wire [31:0] jrE;
        wire [4:0]  waE;
        
        wire [31:0] mult_hiE;
        wire [31:0] mult_loE;
        
        wire [31:0] wd_dmE;
        
        assign wd_dmE = rd2_outE;
        //assign wd_dm = wd_dmE;
        
        
        assign alu_out = alu_outM;
    
    
    /* MEMORY STAGE */
        //wire        pc_srcM;
       // wire [31:0] btaM;
       wire         jr_mux_ctrlM;
       wire         jumpM;
       wire         hilo_weM;
       wire [1:0]   hilo_mux_ctrlM;
       wire         dm2regM;
       wire         we_dmM;
       wire         we_regM;
       wire [31:0]  alu_outM;

       wire [31:0]  wd_dmM;
       wire [31:0]  mult_hiM;
       wire [31:0]  mult_loM;
       wire [31:0]  jrM;
       wire [4:0]   waM;
       wire         jal_wa_muxM;
       wire         jal_wd_muxM;
       wire [31:0]  rd_dmM;
       wire [31:0]  hi_outM;
       wire [31:0]  lo_outM;
       wire [31:0]  jtaM;
       
       
       
    /* WRITEBACK STAGE */
        wire [31:0] pc_nextW;
        wire        jr_mux_ctrlW;
        wire        jumpW;
        wire [31:0] jrW;
        wire        we_regW;
        wire [4:0]  waW;
        wire [31:0] jtaW;
        wire        jal_wd_muxW;
        wire [31:0] hilo_mux_outW;
        wire [1:0]  hilo_mux_ctrlW;
        wire        dm2regW;
        wire [31:0] alu_outW;
        wire [31:0] hi_outW;
        wire [31:0] lo_outW;
        wire [31:0] wd_rfW;
        wire [31:0] rd_dmW;
        
        
assign pc_current = pc_currentF;
    
/* FETCH STAGE */

    wire [31:0] pc_pc_src_mux;
    wire [31:0] pc_jump_mux;

    mux2 #(32) pc_src_mux (
        .sel              (pc_srcD),
        .a                (pc_plus4D), //TODO: double check that this shouldn't be 27:0
        .b                (btaD),
         
        .y                (pc_pc_src_mux)
    );
    
    mux2 #(32) jump_mux   (
        .sel              (jumpW),
        .a                (pc_pc_src_mux), 
        .b                (jtaW),
         
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
        .wd                (wdD),
        .rd1               (rd1D),
        .rd2               (rd2D),
        .rd3               () //TODO not sure if we're using this
    );
    signext se  (
        .a                 (instrD[15:0]),
        .y                 (sext_immD)
    );
    
    mux2 #(32) jal_wd_mux (
        .sel               (jal_wd_muxW),
        .a                 (hilo_mux_outW),
        .b                 (pc_plus4D),
        
        .y                 (wdD)
    );
    
    assign shamtD = instrD[10:6];
    
    assign instrD_20_16 = instrD[20:16];
    assign instrD_15_11 = instrD[15:11];
    
    assign jtaD = {pc_plus4D[31:28], instrD[25:0], 2'b00}; //TODO not sure about this one.
    
    adder pc_plus_br      (
        .a                ({sext_immD[29:0], 2'b00}),
        .b                (pc_plus4D),
        
        .y                (btaD)
    );
    
    assign pc_srcD  = ((rd1D == rd2D) && branchD) ? 1 : 0;
    
    assign addressD = instrD;
    
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
        //.branchD           (branchD),
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
        
        .addressD          (addressD),
        .jtaD              (jtaD),
        
        
        .jr_mux_ctrlE      (jr_mux_ctrlE),
        .jumpE             (jumpE),
        .hilo_weE          (hilo_weE),
        .hilo_mux_ctrlE    (hilo_mux_ctrlE),
        .dm2regE           (dm2regE),
        .we_dmE            (we_dmE),
        //.branchE           (branchE),
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
        .sext_immE         (sext_immE),
        
        .addressE          (addressE),
        .jtaE              (jtaE)
       
    );

/* EXECUTE STAGE */

    wire [31:0] alu_paE;
    wire [31:0] alu_pbE;
    wire        zeroE;
    
    wire [4:0]  rf_wa;
    
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
        //.zero           (zeroE),
        .y              (alu_outE),
        .shamt          (shamtE)
    );
    
    mux2 #(5)  rf_wa_mux  ( //TODO move to D
        .sel            (reg_dstE),
        .a              (instrE_20_16),
        .b              (instrE_15_11),
        .y              (rf_wa)
    );
    
    mux2 #(5)  jal_wa_mux (
        .sel            (jal_wa_muxE),
        .a              (rf_wa),
        .b              (5'd31),
        
        .y              (waE)
        
    ); 
    
    mult_inf #(32) mult   (
        .a              (rd1_outE),
        .b              (rd2_outE),
        
        .out            ({mult_hiE, mult_loE})
    );
    
    
    /* M Stage Interface */
    M_Stage_Reg M_Stage_Reg (
        .clk            (clk),
        .rst            (rst),
        .jr_mux_ctrlE   (jr_mux_ctrlE),
        .jumpE          (jumpE),
        .hilo_weE       (hilo_weE),
        .hilo_mux_ctrlE (hilo_mux_ctrlE),
        .dm2regE        (dm2regE),
        .we_dmE         (we_dmE),
        .we_regE        (we_regE),    
        .alu_outE       (alu_outE),
    
    .wd_dmE         (wd_dmE),
        .mult_hiE       (mult_hiE),
        .mult_loE       (mult_loE),
    
        .jrE            (jrE),
        .waE            (waE),
        .jal_wa_muxE    (jal_wa_muxE),
        .jal_wd_muxE    (jal_wd_muxE),
        .addressE       (addressE),
        .jtaE           (jtaE),

        .jr_mux_ctrlM   (jr_mux_ctrlM),
        .jumpM          (jumpM),
        .hilo_weM       (hilo_weM),
        .hilo_mux_ctrlM (hilo_mux_ctrlM),
        .dm2regM        (dm2regM),
        .we_dmM         (we_dmM),
        .we_regM        (we_regM),
        .alu_outM       (alu_outM),

        .wd_dmM         (wd_dm),
        .mult_hiM       (mult_hiM),
        .mult_loM       (mult_loM),


        .jrM            (jrM),
        .waM            (waM),
        .jal_wa_muxM    (jal_wa_muxM),
        .jal_wd_muxM    (jal_wd_muxM),
        .addressM       (address),
        .jtaM           (jtaM)
    );

/* MEMORY STAGE */

    assign alu_out = alu_outM;
    assign wd_dm   = wd_dmM;
    assign we_dm   = we_dmM;
    assign rd_dmM  = rd_dm;
    //inferred and gate
    //connections to data mem
    HiLo_reg #(32) hi_lo_reg (
        .clk            (clk),
        .rst            (rst),
        .we             (hilo_weM),
        .hi             (mult_hiM),
        .lo             (mult_loM),
        
        .hi_out         (hi_outM),
        .lo_out         (lo_outM)
    );
    
    /* W Stage Reg Interface */
    W_Stage_Reg W_Stage_Reg (
        .clk            (clk),
        .rst            (rst),
        .jr_mux_ctrlM   (jr_mux_ctrlM),
        .jumpM          (jumpM),
        .hilo_mux_ctrlM (hilo_mux_ctrlM),
        .dm2regM        (dm2regM),
        .we_regM        (we_regM),
        .alu_outM       (alu_outM),
        .rd_dmM         (rd_dmM),

        .hi_outM        (hi_outM),
        .lo_outM        (lo_outM),
        .jrM            (jrM),
        .waM            (waM),
        .jtaM           (jtaM),
        .jal_wd_muxM    (jal_wd_muxM),

        .jr_mux_ctrlW   (jr_mux_ctrlW),
        .jumpW          (jumpW),
        .hilo_mux_ctrlW (hilo_mux_ctrlW),
        .dm2regW        (dm2regW),
        .we_regW        (we_regW),

        .alu_outW       (alu_outW),
        .rd_dmW         (rd_dmW),
        .hi_outW        (hi_outW),
        .lo_outW        (lo_outW),

        .jrW            (jrW),
        .waW            (waW),
        .jtaW           (jtaW),
        .jal_wd_muxW     (jal_wd_muxW)
    );
    

/* WRITEBACK STAGE */
    
    mux2 #(32) rf_wd_mux (
        .sel            (dm2regW),
        .a              (alu_outW),
        .b              (rd_dmW),
        
        .y              (wd_rfW)
    );
    mux4 #(32) hilo_mux  (
        .sel            (hilo_mux_ctrlW),
        .a              (wd_rfW),
        .b              (lo_outW),
        .c              (hi_outW),
        .d              (32'd0),
        
        .y              (hilo_mux_outW)
    );
    
        
endmodule
