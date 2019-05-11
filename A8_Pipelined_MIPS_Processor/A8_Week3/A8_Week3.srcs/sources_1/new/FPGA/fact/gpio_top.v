module gpio_top#(parameter WIDTH=32)(
        input wire [1:0] A,
        input wire       WE,
        input wire [WIDTH -1:0] gpi1, //gpi1 not L or I
        input wire [WIDTH -1:0] gpi2,
        input wire [WIDTH -1:0] WD,
        input wire      RST,
        input wire      CLK,
        output wire [WIDTH -1:0] RD,
        output wire [WIDTH -1:0] gpo1,
        output wire [WIDTH -1:0] gpo2
    );
    
    wire WE1;
    wire WE2;
    wire [1:0] RdSel;
    
    
    gpio_ad  gpio_ad(
        .A (A),
        .WE (WE),
        .WE1 (WE1),
        .WE2 (WE2),
        .RdSel (RdSel)
    );
    //gpo1
    fact_reg #(32) gpo1_reg(
        .Clk(CLK),
        .Rst(RST),
        .D(WD),
        .Load_Reg(WE1),
        .Q(gpo1)
        );
        //gpo2
     fact_reg #(32) gpo2_reg(
            .Clk(CLK),
            .Rst(RST),
            .D(WD),
            .Load_Reg(WE2),
            .Q(gpo2)
      );
    mux4 #(32) mux_out(
        .sel(RdSel),
        .a  (gpi1),
        .b  (gpi2),
        .c  (gpo1),
        .d  (gpo2),
        .y  (RD)   
    );
    
    
    
    
endmodule
