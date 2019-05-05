module datapath (
        input  wire        clk,
        input  wire        rst,
        input  wire        branch,
        input  wire        jump,
        input  wire        reg_dst,
        input  wire        we_reg,
        input  wire        hilo_we,
        input  wire [1:0]  hilo_mux_ctrl,
        input  wire        jr_mux_ctrl,
        input  wire        alu_src,
        input  wire        dm2reg,
        input  wire [3:0]  alu_ctrl,
        input  wire [4:0]  ra3,
        input  wire [31:0] instr,
        input  wire [31:0] rd_dm,
        input  wire        jal_wd_mux_sel,
        input  wire        jal_wa_mux_sel,
        //input  wire [4:0]  shift_ammt,
        output wire [31:0] pc_current,
        output wire [31:0] alu_out,
        output wire [31:0] wd_dm,
        output wire [31:0] rd3
    );

    wire [4:0]  rf_wa;
    wire        pc_src;
    wire [31:0] pc_plus4;
    wire [31:0] pc_pre;
    wire [31:0] pc_next_1, pc_next_final;
    wire [31:0] sext_imm;
    wire [31:0] ba;
    wire [31:0] bta;
    wire [31:0] jta;
    wire [31:0] alu_pa;
    wire [31:0] alu_pb;
    wire [31:0] wd_rf_1, wd_rf_out;
    wire        zero;
    wire [31:0] pipeline_mult_hi, pipeline_mult_lo;
    wire [31:0] hi_out, lo_out;
    wire [31:0] rd1_out, rd2_out;
    
    wire [31:0] hilo_mux_out;
    wire [4:0]  rf_wa_mux_out;
    wire [31:0] jal_wd_mux_out;
    wire [4:0]  jal_wa_mux_out;  
    
    assign pc_src = branch & zero;
    assign ba     = {sext_imm[29:0], 2'b00};
    assign jta    = {pc_plus4[31:28], instr[25:0], 2'b00};
    
    assign wd_dm = rd2_out;
    
    // --- PC Logic --- //
    dreg pc_reg (
            .clk            (clk),
            .rst            (rst),
            .d              (pc_next_final),
            .q              (pc_current)
        );

    adder pc_plus_4 (
            .a              (pc_current),
            .b              (32'd4),
            .y              (pc_plus4)
        );

    adder pc_plus_br (
            .a              (pc_plus4),
            .b              (ba),
            .y              (bta)
        );

    mux2 #(32) pc_src_mux (
            .sel            (pc_src),
            .a              (pc_plus4),
            .b              (bta),
            .y              (pc_pre)
        );

    mux2 #(32) pc_jmp_mux (
            .sel            (jump),
            .a              (pc_pre),
            .b              (jta),
            .y              (pc_next_1)
        );

    // --- RF Logic --- //
    mux2 #(5) rf_wa_mux (
            .sel            (reg_dst),
            .a              (instr[20:16]),
            .b              (instr[15:11]),
            .y              (rf_wa_mux_out)
        );

    regfile rf (
            .clk            (clk),
            .we             (we_reg),
            .ra1            (instr[25:21]),
            .ra2            (instr[20:16]),
            .ra3            (ra3),
            .wa             (jal_wa_mux_out),
            //.wd             (wd_rf_out),
            .wd             (jal_wd_mux_out),
            //.rd1            (alu_pa),
            .rd1            (rd1_out),
            //.rd2            (wd_dm),
            .rd2            (rd2_out),
            .rd3            (rd3)
        );

    signext se (
            .a              (instr[15:0]),
            .y              (sext_imm)
        );

    // --- ALU Logic --- //
    mux2 #(32) alu_pb_mux (
            .sel            (alu_src),
            //.a              (wd_dm),
            .a              (rd2_out),
            .b              (sext_imm),
            .y              (alu_pb)
        );

    alu alu (
            .op             (alu_ctrl),
            //.a              (alu_pa),
            .a              (rd1_out),
            .b              (alu_pb),
            .zero           (zero),
            .y              (alu_out),
            //.hi             (alu_hi),
            //.lo             (alu_lo),
            .shamt          (instr[10:6])
        );

    // --- MEM Logic --- //
    mux2 #(32) rf_wd_mux (
            .sel            (dm2reg),
            .a              (alu_out),
            .b              (rd_dm),
            .y              (wd_rf_1)
        );
    // --- JR Logic --- //
    mux2 #(32) jr_mux (
            .sel            (jr_mux_ctrl),
            .a              (pc_next_1),
//            .b              (alu_pa),
            .b              (rd1_out),
            .y              (pc_next_final)
        );
    // --- HI/LO Mux --- //
    mux4 #(32) hilo_mux (
            .sel            (hilo_mux_ctrl),
            .a              (wd_rf_1),
            .b              (lo_out),
            .c              (hi_out),
            .y              (hilo_mux_out)
    );
    // --- Hi and Lo Registers --- //
    HiLo_reg #(32) hi_lo_reg (
            .clk            (clk),
            .hi             (pipeline_mult_hi),
            .lo             (pipeline_mult_lo),
            .rst            (rst),
            .we             (hilo_we),
            .hi_out         (hi_out),
            .lo_out         (lo_out)
    );
    
//    pipelined_multiplier #(32, 1) mult (
//            .a              (rd1_out),
//            .b              (rd2_out),
//            .clk            (clk),
//            .pdt            ({pipeline_mult_hi, pipeline_mult_lo})
//    );
    mult_inf #(32) mult (
            .a                (rd1_out),
            .b                (rd2_out),
            .out              ({pipeline_mult_hi, pipeline_mult_lo})
    );
    
    mux2 #(32) jal_wd_mux (
            .a              (hilo_mux_out),
            .b              (pc_plus4),
            .y              (jal_wd_mux_out),
            .sel            (jal_wd_mux_sel)
    );
    
    mux2 #(5) jal_wa_mux (
            .sel            (jal_wa_mux_sel),
            .a              (rf_wa_mux_out),
            .b              (5'd31),
            .y              (jal_wa_mux_out)
    
    );
     

endmodule