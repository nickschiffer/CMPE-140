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
    
/* FETCH STAGE */

    mux2 #(32) pc_src_mux ();
    mux2 #(32) jump_mux   ();
    mux2 #(32) jr_mux     ();
    
    dreg pc_reg           ();
    //imem
    adder pc_plus4        ();
    
    /* D Stage Reg Interface */
    D_Stage_Reg D_Stage_Reg ();   

/* DECODE STAGE */
    controlunit cu ();
    regfile rf     ();
    signext se     ();
    
    /* E Stage Reg Interface */
    E_Stage_Reg E_Stage_Reg ();

/* EXECUTE STAGE */
    mux2 #(32) alu_pb_mux ();
    alu alu               ();
    
    mux2 #(5)  rf_wa_mux  ();
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
