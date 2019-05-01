module top#(parameter DATA_WIDTH = 4)(
    input  wire		  clk100MHz,
    input [DATA_WIDTH-1:0] d,
    input GO,
    input RST,
    input CLOCKK,
    input hilo_sel,
    output [3:0] LEDSEL, 
    output [7:0] LEDOUT,
    output  doneF,
    output  error
    //output  [DATA_WIDTH-1:0] out
    );
    
    wire [31:0] out_x;
    wire [3:0] hilo_out3, hilo_out2, hilo_out1, hilo_out0;
    wire [7:0] hex_seg3, hex_seg2, hex_seg1, hex_seg0;
    wire debounced_clock_push;
    wire DONT_USE;
    wire clk_5KHz;
    
    button_debouncer debounce(
        .clk                (clk_5KHz),
        .button             (CLOCKK),
        .debounced_button   (debounced_clock_push)
    );
    clk_gen internalCLK (
        .clk100MHz      (clk100MHz),
        .rst            (RST),
        .clk_4sec       (DONT_USE),
        .clk_5KHz       (clk_5KHz)
    );    

    
    FSMmult fsmtop(
        .D({28'b0,d}),
        .GO(GO),
        .RST(RST),
        .CLK(debounced_clock_push),
        .doneF(doneF),
        .ERROR(error),
        .out(out_x));
        
    HILO_MUX hilo_m(
        out_x[31:28],
        out_x[27:24], 
        out_x[23:20], 
        out_x[19:16], 
        out_x[15:12], 
        out_x[11:8],
        out_x[7:4],
        out_x[3:0],
        hilo_sel, 
        hilo_out3,
        hilo_out2, 
        hilo_out1, 
        hilo_out0);
        
    
                            
    hex_to_7seg hex_to_seg3(hilo_out3, hex_seg3);
    hex_to_7seg hex_to_seg2(hilo_out2, hex_seg2);
    hex_to_7seg hex_to_seg1(hilo_out1, hex_seg1);
    hex_to_7seg hex_to_seg0(hilo_out0, hex_seg0);
    
    led_mux l_mux4(
        .clk(clk_5KHz),
        .rst(RST),
        .LED3(hex_seg3), 
        .LED2(hex_seg2),
        .LED1(hex_seg1), 
        .LED0(hex_seg0),
        .LEDSEL(LEDSEL),
        .LEDOUT(LEDOUT)); 
        
    
endmodule
