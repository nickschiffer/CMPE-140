module DP#(parameter DATA_WIDTH = 32)(
   	input wire clk,
   	input wire load_cnt,
   	input wire en_cnt,
   	input wire sel_mux,
   	input wire load_reg,
   	input wire oe_buf,
   	output wire gt,
   	output wire ec,
    input wire [DATA_WIDTH-1:0] in,
    output wire [DATA_WIDTH-1:0] out);
    
	
    
	wire [DATA_WIDTH-1:0] mux_to_reg;
	wire [DATA_WIDTH-1:0] mul_to_mux;
	wire [DATA_WIDTH-1:0] cnt_to_cmp_and_mul;
    wire [DATA_WIDTH-1:0] reg_to_mul_and_buf;

	CNT #(DATA_WIDTH) down_counter(
	   .in(in),
	   .load_cnt(load_cnt),
	   .en(en_cnt),
	   .clk(clk),
	   .out(cnt_to_cmp_and_mul)
	   );

	Multiplexer #(DATA_WIDTH) product_multi(sel_mux, mul_to_mux, 1, mux_to_reg);
	
    Register #(DATA_WIDTH) product_reg(clk, load_reg, mux_to_reg, reg_to_mul_and_buf);
	
    Multiplexer #(DATA_WIDTH) product_buf(
        	oe_buf,
        	reg_to_mul_and_buf,
        	0,
        	out);

	CMP #(DATA_WIDTH) cmp_gt(
            cnt_to_cmp_and_mul, 1, gt);
	
    Multiplier #(DATA_WIDTH) multiply(
        	reg_to_mul_and_buf, cnt_to_cmp_and_mul, mul_to_mux);
    CMP #(DATA_WIDTH) cmp_ec(
            in, 12, ec);
    
endmodule
