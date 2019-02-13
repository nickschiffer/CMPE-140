`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/29/2019 02:07:27 PM
// Design Name: 
// Module Name: Factorial_FPGA
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


module Factorial_FPGA(
    input go, clk100MHz, man_clk,
    input [3:0] n,
    output [7:0] LEDSEL, LEDOUT,
    output done, err,
    output [3:0] n_out
    );
    
    supply1 [7:0] vcc;
    wire DONT_USE, clk_5KHz;
    wire debounced_clk;
    wire [31:0] nf;
    wire dummy;
    assign dummy = 0;
    assign n_out = n;
    
//    reg  [7:0] LED0, LED1, LED2, LED3, LED4, LED5, LED6, LED7;
    wire [7:0] LED0, LED1, LED2, LED3, LED4, LED5, LED6, LED7;
    wire [3:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7;     
    
    Factorial_Top Top (
        .Go(go),
        .clk(debounced_clk),
        .Done(done),
        .Err(err),
        .n(n),
        .nf(nf)
     );
    
    button_debouncer DBNC (
        .clk(clk_5KHz),
        .button(man_clk),
        .debounced_button(debounced_clk)
    );
    
    led_mux LED (
        .clk(clk_5KHz),
        .rst(dummy),
        .LED0(LED0),
        .LED1(LED1),
        .LED2(LED2),
        .LED3(LED3),
        .LED4(LED4),
        .LED5(LED5),
        .LED6(LED6),
        .LED7(LED7),
        .LEDSEL(LEDSEL),
        .LEDOUT(LEDOUT)
    );
    
    clk_gen CLK (clk100MHz, dummy, DONT_USE, clk_5KHz);
    
    bin32_to_8hex B2HEX (
        .value(nf),
        .dig0(HEX0),
        .dig1(HEX1),
        .dig2(HEX2),
        .dig3(HEX3),
        .dig4(HEX4),
        .dig5(HEX5),
        .dig6(HEX6),
        .dig7(HEX7)
    );
    
    hex_to_7seg H2LED0 (
        .HEX(HEX0),
        .s(LED0)
    );

    hex_to_7seg H2LED1 (
        .HEX(HEX1),
        .s(LED1)
    );

    hex_to_7seg H2LED2 (
        .HEX(HEX2),
        .s(LED2)
    );

    hex_to_7seg H2LED3 (
        .HEX(HEX3),
        .s(LED3)
    );

    hex_to_7seg H2LED4 (
        .HEX(HEX4),
        .s(LED4)
    );

    hex_to_7seg H2LED5 (
        .HEX(HEX5),
        .s(LED5)
    );

    hex_to_7seg H2LED6 (
        .HEX(HEX6),
        .s(LED6)
    );

    hex_to_7seg H2LED7 (
        .HEX(HEX7),
        .s(LED7)
    );
    
    
    
    
    
    
endmodule
