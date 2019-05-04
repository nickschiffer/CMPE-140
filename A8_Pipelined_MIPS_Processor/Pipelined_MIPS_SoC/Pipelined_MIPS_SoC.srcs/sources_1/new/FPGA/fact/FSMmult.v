module FSMmult#(parameter DATA_WIDTH = 32)(
    input [DATA_WIDTH-1:0] D,
    input GO,
    input RST,
    input CLK,
    output wire doneF,
    output wire ERROR,
    output wire [DATA_WIDTH-1:0] out
    );
    
    wire load_cnt, cnt_en, mux_sel, load_reg, buf_oe, gt, ec;
    
    CU control(
        .GO(GO),
        .GT(gt),
        .CLK(CLK),
        .RST(RST),
        .EC(ec),
        .load_cnt(load_cnt),
        .cnt_en(cnt_en),
        .mux_sel(mux_sel),
        .load_reg(load_reg),
        .buf_oe(buf_oe),
        .done(doneF),
        .error(ERROR)
    );
    DP dataP(
        .clk(CLK),
        .load_cnt(load_cnt),
        .en_cnt(cnt_en),
        .sel_mux(mux_sel),
        .load_reg(load_reg),
        .oe_buf(buf_oe),
        .gt(gt),
        .ec(ec),
        .in(D),
        .out(out)
    );
    
    
endmodule
